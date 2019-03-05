Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3588205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dHL4nYBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfCEO75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:59:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbfCEO74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:59:56 -0500
Received: from zn.tnic (p200300EC2BCD6B004025952DC1DD1BBA.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:4025:952d:c1dd:1bba])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C60C21EC014B;
        Tue,  5 Mar 2019 15:59:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551797994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6yxVokxuAk1/iVTWrYvHBu5kvuQwX2bliTePdb2BbAM=;
        b=dHL4nYBzI7CsqWu0mL5QiiwRbvlUxOovp4fbB5OFlRk9zZPCNDZLV8BLcxyH0MQrhtImQA
        0RPA2IE1ayuk07aNJemZZWPL2o/beb3ovHRPUjSl0/hQGgms3+RnZ3xATk8cmf5SO//8zf
        wx9fTFad5jSKJwpl/cpo0q7SM1KLZH8=
Date:   Tue, 5 Mar 2019 15:59:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] x86: Deprecate a.out support
Message-ID: <20190305145717.GD8256@zn.tnic>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
 <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305134347.4be2449c@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ akpm and Linus.

On Tue, Mar 05, 2019 at 01:43:47PM +0000, Alan Cox wrote:
> > It's been 25 years since Linux added support for ELF.  Can we just
> > delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> > support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> > at this point.
> 
> In the unlikely event that someone actually has an a.out binary they
> can't live with they can also just write an a.out loader as an ELF
> program entirely in userspace.
> 
> I'd vote for giving it the boot unless there are any architectures that
> kept using a.out far longer due to tool chain issues ?

We can at least deprecate it on x86...

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 5 Mar 2019 15:47:51 +0100
Subject: [PATCH] x86: Deprecate a.out support

Linux supports ELF binaries for ~25 years now. a.out coredumping has
bitrotten quite significantly and would need some fixing to get it into
shape again but considering how even the toolchains cannot create a.out
executables in its default configuration, let's deprecate a.out support
and remove it a couple of releases later, instead.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jann Horn <jannh@google.com>
Cc: <linux-api@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <x86@kernel.org>
---
 arch/x86/Kconfig    | 2 +-
 arch/x86/um/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..ade12ec4224b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,7 +14,6 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
-	select HAVE_AOUT
 	select HAVE_GENERIC_DMA_COHERENT
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
@@ -2843,6 +2842,7 @@ config IA32_EMULATION
 config IA32_AOUT
 	tristate "IA32 a.out support"
 	depends on IA32_EMULATION
+	depends on BROKEN
 	---help---
 	  Support old a.out binaries in the 32bit emulation.
 
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index f518b4744ff8..494eeb51e4e1 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -16,7 +16,6 @@ config 64BIT
 
 config X86_32
 	def_bool !64BIT
-	select HAVE_AOUT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
