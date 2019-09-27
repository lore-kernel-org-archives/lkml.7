Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02123C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D394020665
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfI0XwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 19:52:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfI0XwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:52:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D3E918C426D;
        Fri, 27 Sep 2019 23:52:03 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 002EF1EC;
        Fri, 27 Sep 2019 23:51:59 +0000 (UTC)
Date:   Sat, 28 Sep 2019 07:51:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
Message-ID: <20190927235156.GI31919@MiWiFi-R3L-srv>
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
 <87r241piqg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r241piqg.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 27 Sep 2019 23:52:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/19 at 03:49pm, Eric W. Biederman wrote:
> >> In order to avoid such problem, lets occupy the first 640k region when
> >> SME is active, which will ensure that the allocated memory does not fall
> >> into the first 640k area. So, no need to worry about whether kernel can
> >> correctly copy the contents of the first 640K area to a backup region in
> >> purgatory().
> 
> We must occupy part of the first 640k so that we can start up secondary
> cpus unless someone has added another way to do that in recent years on
> SME capable cpus.
> 
> Further there is Fimware/BIOS interaction that happens within those
> first 640K.
> 
> Furthermore the kdump kernel needs to be able to read all of the memory
> that the previous kernel could read.  Otherwise we can't get a crash
> dump.
> 
> So I do not think ignoring the first 640K is the correct resolution
> here.

We discussed and tried many ways to copy the first 640K of 1st kernel
out since kernel data may be allocated there, then crash need it to
parse. But SME makes the copy very difficult to do, because the first
640K is encrypted in 1st kernel, but the copy is done in purgatory with
1:1 ident-mapping and unencrypted.

Finally we decided this way as patch does. Reserving it in memblock is
not ignoring the first 640K, but lock it down to avoid any later kernel
data allocated in this area. The first 640K will be taken as system RAM
of kdump kernel as is. Like this, no available kernel information
could be located in this area, then we don't care if the copy is correct
or not.

One word, what the patch is doing is locking down the first 640K after 
reserve_real_mode() invocation. Putting it after reserve_real_mode() is
because reserve_real_mode() may put real mode trampoline inside first
640K. Surely the real mode trampoline will be discarded too in kdump
kernel, since it's not important and unnecessary for crash parsing.

I think Lianbo need rewrite this patch log to make it clearer.


diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..5bfb2c83bb6c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1148,6 +1148,9 @@ void __init setup_arch(char **cmdline_p)

        reserve_real_mode();

+       if (sme_active())
+               memblock_reserve(0, 640*1024);
+
        trim_platform_memory_ranges();
        trim_low_memory_range();


> 
> > The log is too simple,  I know you did some other tries to fix this, but
> > the patch log does not show why you can not correctly copy the 640k in
> > current kdump code, in purgatory here.
> >
> > Also this patch seems works in your test, but still to see if other
> > people can comment and see if it is safe or not, if any other risks
> > other than waste the small chunk of memory.  If it is safe then kdump
> > can just drop the backup logic and use this in common code instead of
> > only do it for SME.
> 
> Exactly.
> 
> I think at best this avoids the symptoms, but does not give a reliable
> crash dump.
> 
> Eric
