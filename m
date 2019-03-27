Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A185B206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sJ9CwUKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfC0PRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:17:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53276 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbfC0PRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:17:25 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 67ACC1EC0428;
        Wed, 27 Mar 2019 16:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553699843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CU+B6PsqdrqEsLobDZDiDjjSAi1E64ge9M7NNZW5d1U=;
        b=sJ9CwUKuooyIV3Epg01FFrF3Tt8lzdbRI/EgUfaaamunh6VhMfNup+355zfK+ydX6skR2G
        2zbdYEXkz+yoat2KIFOWsnOEfxWehb1K0vFzl6VGZtgxK9Weu4LYa0hPY/OGmBO7FwHPYn
        5yW+NibnKBgYM113uxsXQE3vhaN+i/M=
Date:   Wed, 27 Mar 2019 16:17:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <20190327151725.GH32571@zn.tnic>
References: <000000000000639f6a0584d11b82@google.com>
 <20190327132805.GG32571@zn.tnic>
 <CACT4Y+bHd938t-w++LBO-yHMWP1cXpn+U=AVL+8mMfTBYk86=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bHd938t-w++LBO-yHMWP1cXpn+U=AVL+8mMfTBYk86=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:45:24PM +0100, Dmitry Vyukov wrote:
> And run this program:
> https://syzkaller.appspot.com/text?tag=ReproC&x=15439f27200000

Yap, that worked in my guest, after segfaulting a lot first:

[  101.600512][ T7333] Code: Bad RIP value.
[  101.606103][ T7337] repro[7337]: segfault at 155555585 ip 0000000155555585 sp 00007ffff7fdaf10 error 14 in repro[555555554000+1000]
[  101.606248][ T7338] repro[7338]: segfault at 25555554e ip 000000025555554e sp 00007ffff7fdaf10 error 14 in repro[555555554000+1000]
[  101.608498][ T7337] Code: Bad RIP value.
[  101.610442][ T7338] Code: Bad RIP value.
[  101.611417][ T7341] repro[7341]: segfault at 0 ip 0000000000000000 sp 00000000200002c8 error 14
[  101.613342][ T7341] Code: Bad RIP value.
[  101.613798][ T7345] repro[7345]: segfault at 0 ip 0000000000000000 sp 00000000200002c8 error 14
[  101.614292][ T7342] repro[7342]: segfault at 45555554e ip 000000045555554e sp 00007ffff7f98f10 error 14 in repro[555555554000+1000]
[  101.615809][ T7345] Code: Bad RIP value.
[  101.616777][ T7348] repro[7348]: segfault at 155555585 ip 0000000155555585 sp 00007ffff7fdaf10 error 14 in repro[555555554000+1000]
[  101.616802][ T7348] Code: Bad RIP value.
[  101.617733][ T7342] Code: Bad RIP value.
[  105.321676][T11024] ------------[ cut here ]------------
[  105.324183][T11024] Can't find any breakpoint slot
[  105.324229][T11024] WARNING: CPU: 0 PID: 11024 at arch/x86/kernel/hw_breakpoint.c:121 arch_install_hw_breakpoint+0x2d1/0x3a0
...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
