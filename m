Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B04C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F0720848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfCEPRn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:17:43 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:58116 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfCEPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:17:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 93AA5608A395;
        Tue,  5 Mar 2019 16:17:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id weM5cc1tbIqW; Tue,  5 Mar 2019 16:17:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F3CCA608A39B;
        Tue,  5 Mar 2019 16:17:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1kRNNjbrG4SH; Tue,  5 Mar 2019 16:17:37 +0100 (CET)
Received: from blindfold.localnet (089144192209.atnat0001.highway.a1.net [89.144.192.209])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id E07F2608A395;
        Tue,  5 Mar 2019 16:17:36 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
Date:   Tue, 05 Mar 2019 16:17:35 +0100
Message-ID: <9780784.9EOYMQBb1X@blindfold>
In-Reply-To: <20190305145717.GD8256@zn.tnic>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com> <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. März 2019, 15:59:52 CET schrieb Borislav Petkov:
> + akpm and Linus.
> 
> On Tue, Mar 05, 2019 at 01:43:47PM +0000, Alan Cox wrote:
> > > It's been 25 years since Linux added support for ELF.  Can we just
> > > delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> > > support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> > > at this point.
> > 
> > In the unlikely event that someone actually has an a.out binary they
> > can't live with they can also just write an a.out loader as an ELF
> > program entirely in userspace.
> > 
> > I'd vote for giving it the boot unless there are any architectures that
> > kept using a.out far longer due to tool chain issues ?
> 
> We can at least deprecate it on x86...
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Tue, 5 Mar 2019 15:47:51 +0100
> Subject: [PATCH] x86: Deprecate a.out support
> 
> Linux supports ELF binaries for ~25 years now. a.out coredumping has
> bitrotten quite significantly and would need some fixing to get it into
> shape again but considering how even the toolchains cannot create a.out
> executables in its default configuration, let's deprecate a.out support
> and remove it a couple of releases later, instead.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: <linux-api@vger.kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: lkml <linux-kernel@vger.kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/Kconfig    | 2 +-
>  arch/x86/um/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 68261430fe6e..ade12ec4224b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -14,7 +14,6 @@ config X86_32
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select CLKSRC_I8253
>  	select CLONE_BACKWARDS
> -	select HAVE_AOUT
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select MODULES_USE_ELF_REL
>  	select OLD_SIGACTION
> @@ -2843,6 +2842,7 @@ config IA32_EMULATION
>  config IA32_AOUT
>  	tristate "IA32 a.out support"
>  	depends on IA32_EMULATION
> +	depends on BROKEN
>  	---help---
>  	  Support old a.out binaries in the 32bit emulation.
>  
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index f518b4744ff8..494eeb51e4e1 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -16,7 +16,6 @@ config 64BIT
>  
>  config X86_32
>  	def_bool !64BIT
> -	select HAVE_AOUT
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select MODULES_USE_ELF_REL
>  	select CLONE_BACKWARDS
> 

For UML,

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


