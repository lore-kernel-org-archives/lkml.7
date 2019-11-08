Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02803C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87DE214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXxGZ9oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfKHKFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:05:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfKHKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oiTbeK6eYUrr+dsT2CPZRIjLlIkfxPnfhik+CBbV954=; b=UXxGZ9oIjWYUYVhkVM6tzDLH5
        Zt8YIR9HOJXW4EQdziPFCXMmyFh8EIukaVo2Wht9FRfOxa14nVpUTNBKHK1lI6JHvZAbsIK21L+Cr
        ur9bToxM7E+SwG7YMmpEj5H4j6SxJwAJtxt2QGlMERo3bR2zkN0q1Yazjh+j6cvR4BMsgO0fA8JC3
        Gcm3I4VsUMZN1hYT3rSItEQ/Cpio6Hi/AKFl4+XSEaul4OTOWCu6dq0CpPA5S4ZJeOCWKUrI81XWW
        yQgoze/4qPHIwokzPfoMnRJBJbBsadU+pOP7aepXRxlGoRXRHL3G3MkCWg0AXxZl5yGoNDdtCGyM3
        HRp4HX3ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT18e-0000nK-V6; Fri, 08 Nov 2019 10:05:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4455930038D;
        Fri,  8 Nov 2019 11:04:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED864203C2B8B; Fri,  8 Nov 2019 11:05:06 +0100 (CET)
Date:   Fri, 8 Nov 2019 11:05:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jingfeng Xie <xiejingfeng@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
Message-ID: <20191108100506.GL4114@hirez.programming.kicks-ass.net>
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
 <20191108093136.GI4114@hirez.programming.kicks-ass.net>
 <4BB2BD4E-96A9-42C5-9EEC-115CF69A0C1D@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB2BD4E-96A9-42C5-9EEC-115CF69A0C1D@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


https://people.kernel.org/tglx/notes-about-netiquette-qw89

On Fri, Nov 08, 2019 at 05:49:01PM +0800, Jingfeng Xie wrote:
> It happens multiple times on our online machines, the crash call trace is like below:
> [58914.066423] divide error: 0000 [#1] SMP
> [58914.070416] Modules linked in: ipmi_poweroff ipmi_watchdog toa overlay fuse tcp_diag inet_diag binfmt_misc aisqos(O) aisqos_hotfixes(O)
> [58914.083158] CPU: 94 PID: 140364 Comm: kworker/94:2 Tainted: G W OE K 4.9.151-015.ali3000.alios7.x86_64 #1
> [58914.093722] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.23.34 02/14/2019
> [58914.102728] Workqueue: events psi_update_work
> [58914.107258] task: ffff8879da83c280 task.stack: ffffc90059dcc000
> [58914.113336] RIP: 0010:[] [] psi_update_stats+0x1c1/0x330
> [58914.122183] RSP: 0018:ffffc90059dcfd60 EFLAGS: 00010246
> [58914.127650] RAX: 0000000000000000 RBX: ffff8858fe98be50 RCX: 000000007744d640
> [58914.134947] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00003594f700648e
> [58914.142243] RBP: ffffc90059dcfdf8 R08: 0000359500000000 R09: 0000000000000000
> [58914.149538] R10: 0000000000000000 R11: 0000000000000000 R12: 0000359500000000
> [58914.156837] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8858fe98bd78
> [58914.164136] FS: 0000000000000000(0000) GS:ffff887f7f380000(0000) knlGS:0000000000000000
> [58914.172529] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [58914.178467] CR2: 00007f2240452090 CR3: 0000005d5d258000 CR4: 00000000007606f0
> [58914.185765] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [58914.193061] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [58914.200360] PKRU: 55555554
> [58914.203221] Stack:
> [58914.205383] ffff8858fe98bd48 00000000000002f0 0000002e81036d09 ffffc90059dcfde8
> [58914.213168] ffff8858fe98bec8 0000000000000000 0000000000000000 0000000000000000
> [58914.220951] 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [58914.228734] Call Trace:
> [58914.231337] [] psi_update_work+0x22/0x60
> [58914.237067] [] process_one_work+0x189/0x420
> [58914.243063] [] worker_thread+0x4e/0x4b0
> [58914.248701] [] ? process_one_work+0x420/0x420
> [58914.254869] [] kthread+0xe6/0x100
> [58914.259994] [] ? kthread_park+0x60/0x60
> [58914.265640] [] ret_from_fork+0x39/0x50
> [58914.271193] Code: 41 29 c3 4d 39 dc 4d 0f 42 dc <49> f7 f1 48 8b 13 48 89 c7 48 c1
> [58914.279691] RIP [] psi_update_stats+0x1c1/0x330
> [58914.286053] RSP
> 
> With full kdump vmcore analysis,  The R8 is period in psi_update_stats which results in the zero division error.

This does not answer either question I asked.

>     How can this happen? Is that a valid case or should we be avoiding that?

This does not explain how the period got so large, nor if that is a
valid/expected scenario.
