Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6956C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54C2206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pYiORcp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfC0Rsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:48:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbfC0Rsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:48:41 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26C101EC023E;
        Wed, 27 Mar 2019 18:48:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553708920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g2YdIQv/hQoChlCSzcNe/bLUtkhiY13PPEnV3MCGJeA=;
        b=pYiORcp/pNttOn7hSNxJ8iglDuquP0pRijP2OkKdyYONVPoLV8xaZF4FVTLEHV9lyc3IXK
        vsP3OWo7Pj/2SB5PESDpMpb301OMDvIFuIGzSxnVwmWH3bmIjNouiWyugtud8bQ7w4MCcI
        kmqaoouzPitE/SJxLk94szUCiUyRC3k=
Date:   Wed, 27 Mar 2019 18:48:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <20190327174841.GI32571@zn.tnic>
References: <000000000000639f6a0584d11b82@google.com>
 <20190327132805.GG32571@zn.tnic>
 <CACT4Y+bHd938t-w++LBO-yHMWP1cXpn+U=AVL+8mMfTBYk86=g@mail.gmail.com>
 <20190327151725.GH32571@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327151725.GH32571@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 04:17:25PM +0100, Borislav Petkov wrote:
> On Wed, Mar 27, 2019 at 02:45:24PM +0100, Dmitry Vyukov wrote:
> > And run this program:
> > https://syzkaller.appspot.com/text?tag=ReproC&x=15439f27200000
> 
> Yap, that worked in my guest, after segfaulting a lot first:
> 
> [  101.600512][ T7333] Code: Bad RIP value.
> [  101.606103][ T7337] repro[7337]: segfault at 155555585 ip 0000000155555585 sp 00007ffff7fdaf10 error 14 in repro[555555554000+1000]
> [  101.606248][ T7338] repro[7338]: segfault at 25555554e ip 000000025555554e sp 00007ffff7fdaf10 error 14 in repro[555555554000+1000]
> [  101.608498][ T7337] Code: Bad RIP value.
> [  101.610442][ T7338] Code: Bad RIP value.
> [  101.611417][ T7341] repro[7341]: segfault at 0 ip 0000000000000000 sp 00000000200002c8 error 14
> [  101.613342][ T7341] Code: Bad RIP value.
> [  101.613798][ T7345] repro[7345]: segfault at 0 ip 0000000000000000 sp 00000000200002c8 error 14
> [  101.614292][ T7342] repro[7342]: segfault at 45555554e ip 000000045555554e sp 00007ffff7f98f10 error 14 in repro[555555554000+1000]
> [  101.615809][ T7345] Code: Bad RIP value.
> [  101.616777][ T7348] repro[7348]: segfault at 155555585 ip 0000000155555585 sp 00007ffff7fdaf10 error 14 in repro[555555554000+1000]
> [  101.616802][ T7348] Code: Bad RIP value.
> [  101.617733][ T7342] Code: Bad RIP value.
> [  105.321676][T11024] ------------[ cut here ]------------
> [  105.324183][T11024] Can't find any breakpoint slot
> [  105.324229][T11024] WARNING: CPU: 0 PID: 11024 at arch/x86/kernel/hw_breakpoint.c:121 arch_install_hw_breakpoint+0x2d1/0x3a0

Ok, after adding some debug output, it looks like this (newlines mine):

[  200.921625][ T8029]    repro-8029    0d..4 200923254us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080

[  200.922507][ T8029]    repro-8029    0d..4 200923257us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
[  200.923397][ T8029]    repro-8029    0d..4 200923259us : arch_install_hw_breakpoint: i: 1, slot: ffff888060200d40

[  200.924294][ T8029]    repro-8029    0d..4 200923262us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
[  200.925175][ T8029]    repro-8029    0d..4 200923264us : arch_install_hw_breakpoint: i: 1, slot: ffff888060200d40
[  200.926054][ T8029]    repro-8029    0d..4 200923266us : arch_install_hw_breakpoint: i: 2, slot: ffff8880602004c0

[  200.926933][ T8029]    repro-8029    0d..4 200923270us : arch_install_hw_breakpoint: i: 0, slot: ffff888069668080
[  200.927816][ T8029]    repro-8029    0d..4 200923271us : arch_install_hw_breakpoint: i: 1, slot: ffff888060200d40
[  200.928695][ T8029]    repro-8029    0d..4 200923273us : arch_install_hw_breakpoint: i: 2, slot: ffff8880602004c0
[  200.929573][ T8029]    repro-8029    0d..4 200923275us : arch_install_hw_breakpoint: i: 3, slot: ffff88806991ed00

which basically shows how this thread adds 4 breakpoints and hits the
warn on on the 5th.

Now, that code I've seen only once or twice so I don't have a very smart
guess but it looks to me like arch_install_hw_breakpoint() or something
scheduling the events above that, should check HBP_NUM and not schedule
more than 4 hw breakpoints. Or..?

Frederic, I know you know this code... :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
