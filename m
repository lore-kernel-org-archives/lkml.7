Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D794C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673112072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QOHQ0tG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLRKl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:41:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:41:26 -0500
Received: from zn.tnic (p200300EC2F0B8B0090A9FF3C00C5134F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8b00:90a9:ff3c:c5:134f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC5331EC05B5;
        Wed, 18 Dec 2019 11:41:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576665681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1QAly7HDvvdmf9snQkP9kjqwjPVc7Q2c/hdbLj1rJ0Y=;
        b=QOHQ0tG60MXWER7t66WOkqlmYh0Djyxyo4ooKQa0gBPJfJuv7EhLYP48Q6OHeBwOOaFWcD
        BQnJQ7TGFt8nirMRB3Aw1Xnt2xHFGdKKTKm7uRjL5pwt9L5djWT4Lh9/slfJwwVifEoudh
        bKEY9LfjBkYAZwI9B4uCJVzrE6CMCtI=
Date:   Wed, 18 Dec 2019 11:41:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: define arch_crash_save_vmcoreinfo() if
 CONFIG_CRASH_CORE=y
Message-ID: <20191218104113.GB24886@zn.tnic>
References: <9e9eb78c157d26d80f8781f8ce0e088fd12120b4.1575309711.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e9eb78c157d26d80f8781f8ce0e088fd12120b4.1575309711.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 10:02:29AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> kernel/crash_core.c calls arch_crash_save_vmcoreinfo() to get
> arch-specific bits for vmcoreinfo. If it is not defined, then it has a
> no-op fallback. kernel/crash_core.c is gated behind CONFIG_CRASH_CORE.
> However, x86 defines arch_crash_save_vmcoreinfo() in
> arch/x86/kernel/machine_kexec_*.c, which is gated behind
> CONFIG_KEXEC_CORE. So, a kernel with CONFIG_CRASH_CORE=y and
> CONFIG_KEXEC_CORE=n

How does that even happen?

Symbol: KEXEC_CORE [=y]
Type  : bool
  Defined at arch/Kconfig:17
  Selects: CRASH_CORE [=y]
  Selected by [y]:
  - KEXEC [=y]
  - KEXEC_FILE [=y] && X86_64 [=y] && CRYPTO [=y]=y && CRYPTO_SHA256 [=y]=y

In order to do crash dumps, you need to select KEXEC, which selects
KEXEC_CORE, which selects CRASH_CORE...

Or are you talking about the PROC_KCORE use angle where it selects
CRASH_CORE and the crash_save_vmcoreinfo_init() initcall is then
supposed to save arch-specific crash info?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
