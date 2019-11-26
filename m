Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1F5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52FF20678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574760805;
	bh=U2TUuIsAgjY1zkd18O3yOzFhB3Br3tAvhXrL2fkiCAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gCSIlTpUCNrmvQ5IkNh+/K1YDKGSEp1cbTu0VjmZiN/hMMGFse5XY5I3Ji121rSOV
	 fNUuQHWp1sofkF59HuHuXQirfbjo7/jzTUzH2H7ciB7oexw5LohLT8AWWYjEj0EL8Y
	 HpHlCV1BCzCrqNFqOEIXX5YF2ivlTgJb2lfyQwe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKZJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:33:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKZJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:33:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so21510128wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGM4wS4irBq0S6zld4vb8xvQ2ohTky9b+k5RXHxB6oI=;
        b=e/9+QozrhU4d5FTiT1kIYZ0ZMiu+CzJqRtX0HFIJVvb63ESALvRLnrfZV825NHCUkg
         VuUmpFQfgBhDaqbPPS+4GR8+FHS3j8FNlcKGXqQYu+l7RotFd1ndqhTivkL/JZKQtu3l
         PXA+WmOQ9XNW/I1XS60E0cTZRgO+nTnLW8wahJbFUFDD5toLLhjRYyvnW/CxBsXTQJJV
         tXINZIxGZN5p94FOUbeMHfyRAMvBmIUu9sOVeYcOvFatM2wXU+i2r0jWu/csAhx0UzqW
         TlHx4jgVWmTM6HVMoAc5zYHOjAspXcY7x2xVALGVGSs7qBkoHDepvQ516nGVmDZPToQE
         j6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGM4wS4irBq0S6zld4vb8xvQ2ohTky9b+k5RXHxB6oI=;
        b=fLuCfs9uqRuacrG4iuyR/xtaBbBiiBTul5F6m86QwFavwDh9QPNqp+WE0HjrVt1Osc
         qhrB79cjhHJcfGVFvyTA+k1XzzgwS1OJ0/vPFXIDW/znIxDYLL5ujwxxf6R/gx/XmHO/
         BgTD3xgSzdi4PPmeUbf/fV1NGroKe98hT/nX5Nwcfx5vDFImFDkNfitoeGWZuPpXoF/+
         YTavzJ2gADfsZWNFdjq/O1q7hnrA64f6MzN96cB6V1o2PaWpSJKsKk2qxHBYbTNfamTC
         3itzEJlRw80aNXfLRmQ6zoL+QHnFbC6Q690ufY+dSpwfV6iarWD+ZwZbzMLEzff0b2sK
         nO7Q==
X-Gm-Message-State: APjAAAVrbPdiKwdg2SaJOrIaf5bZOjY714KAT+IsmR2IYhVg8866lrGg
        qIW8DINsRKMNPaTdg+VgAPI=
X-Google-Smtp-Source: APXvYqyC5PAg9HLogS8SOLs8dVXkT5vWwTFF69Z5JxryU51ldr8mXcAViMR3Ewz0WDVwRMxd/HGEvA==
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr35089430wrw.383.1574760802387;
        Tue, 26 Nov 2019 01:33:22 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u26sm2460841wmj.9.2019.11.26.01.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 01:33:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:33:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.5
Message-ID: <20191126093319.GA129234@gmail.com>
References: <20191125160821.GA42496@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125160821.GA42496@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest x86-asm-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
> 
>    # HEAD: f01ec4fca8207e31b59a010c3de679c833f3a877 Merge branch 'x86/build' into x86/asm, to pick up completed topic branch

> Unfortunately the symbol rework will generate conflicts with pending 
> changes to assembly files.

Here's a more detailed merge conflict note, the changes will create 
direct merge conflicts in these files:

  arch/x86/entry/entry_32.S
  arch/x86/kernel/head_32.S
  arch/x86/xen/xen-asm_32.S

These are straightforward to resolve, but there's a semantic conflict as 
well, due to this new commit you already merged via the crypto tree:

  ed0356eda153: ("crypto: blake2s - x86_64 SIMD implementation")

Which can be resolved via converting ENTRY/ENDPROC to 
SYM_FUNC_START/SYM_FUNC_END() pattern via the patch below.

Thanks,

	Ingo

====================>

 arch/x86/crypto/blake2s-core.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/blake2s-core.S b/arch/x86/crypto/blake2s-core.S
index 8591938eee26..24910b766bdd 100644
--- a/arch/x86/crypto/blake2s-core.S
+++ b/arch/x86/crypto/blake2s-core.S
@@ -47,7 +47,7 @@ SIGMA2:
 
 .text
 #ifdef CONFIG_AS_SSSE3
-ENTRY(blake2s_compress_ssse3)
+SYM_FUNC_START(blake2s_compress_ssse3)
 	testq		%rdx,%rdx
 	je		.Lendofloop
 	movdqu		(%rdi),%xmm0
@@ -173,11 +173,11 @@ ENTRY(blake2s_compress_ssse3)
 	movdqu		%xmm14,0x20(%rdi)
 .Lendofloop:
 	ret
-ENDPROC(blake2s_compress_ssse3)
+SYM_FUNC_END(blake2s_compress_ssse3)
 #endif /* CONFIG_AS_SSSE3 */
 
 #ifdef CONFIG_AS_AVX512
-ENTRY(blake2s_compress_avx512)
+SYM_FUNC_START(blake2s_compress_avx512)
 	vmovdqu		(%rdi),%xmm0
 	vmovdqu		0x10(%rdi),%xmm1
 	vmovdqu		0x20(%rdi),%xmm4
@@ -254,5 +254,5 @@ ENTRY(blake2s_compress_avx512)
 	vmovdqu		%xmm4,0x20(%rdi)
 	vzeroupper
 	retq
-ENDPROC(blake2s_compress_avx512)
+SYM_FUNC_END(blake2s_compress_avx512)
 #endif /* CONFIG_AS_AVX512 */
