Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FD2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQ2fpU2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfFXH3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:29:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfFXH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uGTfk2MZqnV1h8cqP0BiyMCPA5BgEGZVqlqHVJi8+YY=; b=DQ2fpU2IIQH/C2TzC4LYgFhKw
        mdanMGxbHMxvKg82o1nlhutLDxbOSBcVrXH7YP55ovmYdTO3UdgrcmJLqunnbQK5w2yGTdmuOgQAt
        ifxIEV5Tqc6o1xZk20pgN1z71Q7DQYiq441bxpv3eL/Jx0y/FLkaj7xPmTqUBluL4wTV0PkMGxGp0
        7YjKZaRYD//7hRPP/gFZgltMqh6w85mp9pKMsS/YRtuB06/RWdbiBf6lSIjommqgCCA552sEGxLEY
        WbspNerkQKgsbG4cdG6kJDIPYY1nXvJ+1EYEmPSlTKn3+V206+aERgxogS3RzgiSHb3YbGgf1ad4O
        RBRFiL4og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJPz-0001Y8-3m; Mon, 24 Jun 2019 07:29:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F34720A021EC; Mon, 24 Jun 2019 09:29:33 +0200 (CEST)
Date:   Mon, 24 Jun 2019 09:29:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [kernel/isolation] c427534e48:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20190624072933.GO3436@hirez.programming.kicks-ass.net>
References: <20190621082027.GS7221@shao2-debian>
 <1561160086.rsh9p04w45.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561160086.rsh9p04w45.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 09:43:42AM +1000, Nicholas Piggin wrote:
> kernel test robot's on June 21, 2019 6:20 pm:

> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > [    0.562433] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [    0.562994] #PF: supervisor read access in kernel mode
> > [    0.562994] #PF: error_code(0x0000) - not-present page
> > [    0.562994] PGD 0 P4D 0 
> > [    0.562994] Oops: 0000 [#1] SMP PTI
> > [    0.562994] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5-00015-gc427534 #1
> > [    0.562994] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [    0.562994] RIP: 0010:housekeeping_verify_smp+0x2b/0x41
> > [    0.562994] Code: 66 66 66 90 53 83 c8 ff 48 c7 c3 c0 e2 e3 84 48 89 de 89 c7 e8 94 d4 d7 fe 3b 05 22 77 b8 ff 73 13 89 c2 48 8b 0d db eb 28 00 <48> 0f a3 11 73 df 31 c0 5b c3 48 c7 c7 f0 0e 8d 84 e8 1b 84 3e fe
> > [    0.562994] RSP: 0000:ffffabda00327e18 EFLAGS: 00010293
> > [    0.562994] RAX: 0000000000000000 RBX: ffffffff84e3e2c0 RCX: 0000000000000000
> > [    0.562994] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff84e3e2c0
> > [    0.562994] RBP: ffffffff852b7572 R08: 0000000000000044 R09: 0000000000000228
> > [    0.562994] R10: 0000000000000000 R11: ffff892f4f817e10 R12: ffffffff854a0938
> > [    0.562994] R13: 0000000000000002 R14: ffffffff852898d9 R15: 0000000000000000
> > [    0.562994] FS:  0000000000000000(0000) GS:ffff892fa1e00000(0000) knlGS:0000000000000000
> > [    0.562994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.562994] CR2: 0000000000000000 CR3: 000000001ec0a000 CR4: 00000000000406f0
> > [    0.562994] Call Trace:
> > [    0.562994]  do_one_initcall+0x46/0x214
> > [    0.562994]  kernel_init_freeable+0x1c7/0x272
> > [    0.562994]  ? rest_init+0xd0/0xd0
> > [    0.562994]  kernel_init+0xa/0x110
> > [    0.562994]  ret_from_fork+0x35/0x40
> > [    0.562994] Modules linked in:
> > [    0.562994] CR2: 0000000000000000
> > [    0.562994] ---[ end trace 1c0ad476e5b7f021 ]---
> 
> Oops, housekeeping_verify_smp needs to needs to check
> housekeeping_overidden before testing housekeeping_mask.
> 
> You want me to resend with a fix?

That'd be great.
