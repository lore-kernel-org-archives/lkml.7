Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0B524679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Ph++/qrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLSU2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:28:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33122 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:28:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so3092459pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYkVZqyXvPlx+fIEnulqGYvT8K8hQvvLGTRkxC+sfqQ=;
        b=Ph++/qrA450zlZKpiEEsHQkhDtqwSwglWc77UJZ8pmMlVmX1g5boEaiatKqfGfTfNn
         QYBFt9Shna2KWx0iLva3l99HN2xerVQP8pp1R2paOTl3f11LFpOaQlaKvYRgli3nA4wc
         1s/ZgEfSYOernV8HzkjcBOimOwQzM0ZgDSJlb42clm7HD5l60Fe4NfUcVEcBY3QBEVCF
         N8Ve/yIdVF4FxE+wWa3dHn+t3eWAXfLyz4yTAkDrFovRMWcFQpDnd3GHexeyL2tdaS7J
         pYpSzBcYjQjI2kLb6jvfaXb+0YQKblFtHdE8mScAerr7JSA3kRbHvnyKUXejwfXVJuvM
         0RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYkVZqyXvPlx+fIEnulqGYvT8K8hQvvLGTRkxC+sfqQ=;
        b=cZKLaFVuGp8OW2fmcZYtaoAZMT5j4Jxn1022rPMYax6/IfI4dT+8M1gwpMGwVOlWIp
         Nuc1uPxJitKzfruhR3BfGJzj7UZ4CNQk9bvGNtKe3mP9jPGeDT41gcsVlNBjrGyzUZ4T
         L2lxl2/5ldqn2SOX0T91x2FImYqA7+g95OFtY5kKlbo6Na6t+BT4m++3fCBM0gVOCrCZ
         pwOwWk8ytpbKyvajs4wGn32jRiCQQp0Dass6jD1rcLc/KuZmehDx0PyGka5Gujvh92gk
         soVgFkjLM9uyOM6U7Lbm12bW5jdE3i2UhLoYLqarC119SbPoeRz8UY0F/qMQbiaLLAv9
         HbvQ==
X-Gm-Message-State: APjAAAUamld5m71PRTo2zZ3JFgnCoFszzLoIj4QOU3VC64XpwEatBsoE
        swlsHqA4NEuZRf0+ADW8ZCO/IA==
X-Google-Smtp-Source: APXvYqxWN3nMJPaIxUx7KO54CeZUzmOoZKEHpsGfFpM1rL60SfgNFV//hbNSBGqBjXj6xvpy6pv3Yw==
X-Received: by 2002:a17:902:6544:: with SMTP id d4mr11307470pln.278.1576787288997;
        Thu, 19 Dec 2019 12:28:08 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id m3sm5321973pfh.116.2019.12.19.12.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:28:08 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:28:07 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: define arch_crash_save_vmcoreinfo() if
 CONFIG_CRASH_CORE=y
Message-ID: <20191219202807.GA826140@vader>
References: <9e9eb78c157d26d80f8781f8ce0e088fd12120b4.1575309711.git.osandov@fb.com>
 <20191218104113.GB24886@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218104113.GB24886@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:41:13AM +0100, Borislav Petkov wrote:
> On Mon, Dec 02, 2019 at 10:02:29AM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > kernel/crash_core.c calls arch_crash_save_vmcoreinfo() to get
> > arch-specific bits for vmcoreinfo. If it is not defined, then it has a
> > no-op fallback. kernel/crash_core.c is gated behind CONFIG_CRASH_CORE.
> > However, x86 defines arch_crash_save_vmcoreinfo() in
> > arch/x86/kernel/machine_kexec_*.c, which is gated behind
> > CONFIG_KEXEC_CORE. So, a kernel with CONFIG_CRASH_CORE=y and
> > CONFIG_KEXEC_CORE=n
> 
> How does that even happen?
> 
> Symbol: KEXEC_CORE [=y]
> Type  : bool
>   Defined at arch/Kconfig:17
>   Selects: CRASH_CORE [=y]
>   Selected by [y]:
>   - KEXEC [=y]
>   - KEXEC_FILE [=y] && X86_64 [=y] && CRYPTO [=y]=y && CRYPTO_SHA256 [=y]=y
> 
> In order to do crash dumps, you need to select KEXEC, which selects
> KEXEC_CORE, which selects CRASH_CORE...
> 
> Or are you talking about the PROC_KCORE use angle where it selects
> CRASH_CORE and the crash_save_vmcoreinfo_init() initcall is then
> supposed to save arch-specific crash info?

Yes, I'm talking about reading VMCOREINFO from /proc/kcore at runtime,
no kdump involved. crash [1] and my own tool, drgn [2], use this for
live debugging.

I can set CONFIG_PROC_KCORE=y, which selects CONFIG_CRASH_CORE=y, but if
CONFIG_KEXEC_CORE=n, the VMCOREINFO is incomplete.

1: https://github.com/crash-utility/crash/commit/60a42d709280cdf38ab06327a5b4fa9d9208ef86
2: https://github.com/osandov/drgn/blob/73dd7def1217e24cc83d8ca95c995decbd9ba24c/libdrgn/program.c#L385
