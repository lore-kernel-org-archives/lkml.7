Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ECBC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36C12195D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bz6rJuqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfKRRwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:52:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfKRRwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:52:33 -0500
Received: from zn.tnic (p200300EC2F27B500B4ECF45A19F4392B.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:b4ec:f45a:19f4:392b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F2F71EC05DE;
        Mon, 18 Nov 2019 18:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574099547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iPwPA4kAOvYxtc6qwVWrK8VMs7ifOI7h/WCSD5jVWg0=;
        b=bz6rJuqnrovakF9Z+eGLt3sQiqDxp1IIlYt+NtYgSD/dh24aFro0pAt/i71j/dwb8eT1/I
        A46PUo95WzjSxySG2bhhlK5ngbMnBcrKjoS+SZrfTK8F0R06ObyHsYuGjmekGh3xD8nEOM
        MR+wYNa00wAV3SY/YTlJfmr/lQWyJbY=
Date:   Mon, 18 Nov 2019 18:52:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V2] x86/boot: explicitly place .eh_frame after .rodata
Message-ID: <20191118175223.GM6363@zn.tnic>
References: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
 <20191106120629.28423-1-ilie.halip@gmail.com>
 <20191118143553.GD6363@zn.tnic>
 <CAKwvOdmWoHqrUyZ-_ino9z7KRzizpdoY2ZL5ngUzwGy55MuZ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmWoHqrUyZ-_ino9z7KRzizpdoY2ZL5ngUzwGy55MuZ4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:46:23AM -0800, Nick Desaulniers wrote:
> Yep. Looks like:
> - arch/x86/kernel/vmlinux.lds.S
> - arch/x86/realmode/rm/realmode.lds.S
> 
> discard .eh_frame, while
> - arch/x86/entry/vdso/vdso-layout.lds.S
> - arch/x86/um/vdso/vdso-layout.lds.S
> 
> keep it.  I assume then that just vdso code that get linked into
> userspace needs to preserve this.

Yap, that's what I think too. Lemme add Andy to Cc.

> This suggestion would be a functional change, which is why we pursued
> the conservative change preserving it.

Sure but what would be the purpose of preserving the section, especially
in the early boot code? At least I don't see one. And kernel-proper
kills it...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
