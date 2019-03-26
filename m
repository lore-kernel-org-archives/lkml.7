Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E2C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723DD2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfCZQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:40:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48829 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbfCZQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:39:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8p7C-0001bI-7X; Tue, 26 Mar 2019 17:39:54 +0100
Message-Id: <20190326163604.348882514@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 26 Mar 2019 17:36:04 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Micheal Kelley <michael.h.kelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: [patch 0/2] cpu/hotplug: Prevent damage with SMP=y and HOTPLUG_CPU=n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu reported a crash with SMP=y and HOTPLUG_CPU=n plus 'nosmt' on the
kernel command line.

  https://lkml.kernel.org/r/1553521883-20868-1-git-send-email-Tianyu.Lan@microsoft.com

The reason is a bug in the hotplug code which does not handle the fact,
that HOTPLUG_CPU=n cannot tear down a CPU completely.

Unfortunately HOTPLUG_CPU cannot be enforced as some architectures do not
support it at all.

The fix is only a workaround because a full solution is not possible due to
the limitations of HOTPLUG_CPU=n. So the CPU stays around in an undead state.

As 'nosmt' has become popular recently, the proper solution for X86 is to
enforce HOTPLUG_CPU when SMP is enabled.

Thanks,

	tglx
----
 arch/x86/Kconfig |    8 +-------
 kernel/cpu.c     |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 9 deletions(-)



