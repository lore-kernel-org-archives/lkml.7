Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51233C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CC920854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCRMZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfCRMZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C7EB3091782;
        Mon, 18 Mar 2019 12:25:34 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD31E5D9E2;
        Mon, 18 Mar 2019 12:25:33 +0000 (UTC)
Subject: x86: Complete data loss during NMI lockup
To:     pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, Don Zickus <dzickus@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <8ac97a4a-619a-1c50-c290-3a4fc4693d00@redhat.com>
Date:   Mon, 18 Mar 2019 08:25:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 18 Mar 2019 12:25:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 4.18.0 has a partial data loss when an NMI occurs but 5.0.0 has
complete data loss.

I tested with this simple kernel lockup code on kernels 4.18.0 through
5.0.0.  On 4.18.0 (and after) the expected lockup messages

 Uhhuh. NMI received for unknown reason 25 on CPU 0.
 Do you have a strange power saving mode enabled?
 Kernel panic - not syncing: NMI: Not continuing

and other debug messages are no longer printed to any console after commit
719f6a7040f1 ("printk: Use the main logbuf in NMI when logbuf_lock is available").

Things get worse with commit 03fc7f9c99c1 ("printk/nmi: Prevent deadlock when
accessing the main log buffer in NMI") after which *NO* messages (including the
important stack trace) are output to the console at all.  There is a 100% data
loss with no clue as to what happened.

You can reproduce with a very simple spinlock lockup module:

static DEFINE_SPINLOCK(prarit_lock);

static void take_lock(void *data)
{
       unsigned long flags;

       pr_emerg("Taking lock on cpu %d\n", smp_processor_id());
       spin_lock_irqsave(&prarit_lock, flags);
}

static int init_dummy(void)
{
       on_each_cpu(take_lock, NULL, 0);
       return 0;
}

and the simple patch (sorry for the cut-and-paste)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 18bc9b51ac9b..d1800ecc16fc 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -312,6 +312,7 @@ static void default_do_nmi(struct pt_regs *regs)
        int handled;
        bool b2b = false;

+       pr_emerg("NMI on CPU %d.\n", smp_processor_id());
        /*
         * CPU-specific NMI must be processed before non-CPU-specific
         * NMI, otherwise we may lose it, because the CPU-specific

During run-time a few NMIs happen, which result in

[  683.127105] NMI on CPU 0.
[  689.502992] NMI on CPU 91.
[  713.586459] NMI on CPU 92.
[  719.708041] NMI on CPU 3.
[ 1428.664558] NMI on CPU 95.
[ 2646.795310] NMI on CPU 87.

but nothing is output during the actual kernel lockup itself.  If I revert back
to the pre-719f6a7040f1 behaviour I do see the messages
on the console as well as the stack trace.

The call sequence is 5.0.0 is

nmi_enter()
	-> printk_nmi_enter()
		-> this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
		-> printk()
		-> vprintk_func()
			-> vprintk_nmi()
				-> printk_safe_log_store()

P.
