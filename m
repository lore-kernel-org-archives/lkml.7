Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313AC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B1F2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="OW+OUXy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHSHZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:25:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45731 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:25:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so669533pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=tBCDDckHGkeN1/u6Pg4KXWwPQu/0aeVQyazu3cqADzM=;
        b=OW+OUXy8CbHbV/AWwDUODfleUSqXNyGAeVqjVPoRVoktYhx9is8LLhuekhZrlcmPFj
         4jua09y6zynMFgrtaRAC7PaKmjJOHvWNPLb1e4aaO1lOfaPoCbTy2DGXpmgNirmnNIoo
         BzF7j+8BDsDrw1uDMKVIhxBZgJj3mk37a+Uao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tBCDDckHGkeN1/u6Pg4KXWwPQu/0aeVQyazu3cqADzM=;
        b=AnvDrQQ6cCMQCNmzfNlldChqo36cpie8FR3+PqYUH8CXcS93EkKBn4H4XdH/D2Sb8d
         qeYaljNXYJTTh11Ht1LYLNi9SJBTG1WlDhi8KNPXMxo+erq61t83zcpZZa6gW4ISspks
         WvOzAINfMXsUOfX9fwf6BuSX8hJO0EkrLBCg4AYQx3c9H1qPTpheQLNtg1YSd50jcwr3
         Nqgf9Af6ATFfVw3u41AmVN/8x4Vpd3O5JLRqZPs6nnnIfHawy0nxO2gDkFVkXmxn4t/E
         NSHjDCYraSAU+zcosl7fRTWuzBltKgmCqFykuhPpECkcqT5euyp2KMie7ho06oh6Knjn
         rjlQ==
X-Gm-Message-State: APjAAAUul9MqpnfPevbw9nrDJ5GK207JAL7vlNiLW9RbI1gp4b9sdkpz
        R2gd4JNdgBuHyMwFs9p3AkvHXw==
X-Google-Smtp-Source: APXvYqyE0+/G6CjuRC7+RgCdSFcnoCjABHXxER97QNWzacHAx9sLw8VrM5nHRZxCLiq+PRXiPJjhbg==
X-Received: by 2002:aa7:9191:: with SMTP id x17mr22772954pfa.23.1566199552574;
        Mon, 19 Aug 2019 00:25:52 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id c199sm17606492pfb.28.2019.08.19.00.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 00:25:51 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] powerpc: Don't add -mabi= flags when building with Clang
In-Reply-To: <20190818191321.58185-1-natechancellor@gmail.com>
References: <20190818191321.58185-1-natechancellor@gmail.com>
Date:   Mon, 19 Aug 2019 17:25:47 +1000
Message-ID: <87ftlxty4k.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> When building pseries_defconfig, building vdso32 errors out:
>
>   error: unknown target ABI 'elfv1'
>
> Commit 4dc831aa8813 ("powerpc: Fix compiling a BE kernel with a
> powerpc64le toolchain") added these flags to fix building GCC but
> clang is multitargeted and does not need these flags. The ABI is
> properly set based on the target triple, which is derived from
> CROSS_COMPILE.
>
> https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0-rc2/clang/lib/Driver/ToolChains/Clang.cpp#L1782-L1804
>
> -mcall-aixdesc is not an implemented flag in clang so it can be
> safely excluded as well, see commit 238abecde8ad ("powerpc: Don't
> use gcc specific options on clang").
>

This all looks good to me, thanks for picking it up, and sorry I hadn't
got around to it!

The makefile is a bit messy and there are a few ways it could probably
be reorganised to reduce ifdefs. But I don't think this is the right
place to do that. With that in mind,

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

> pseries_defconfig successfully builds after this patch and
> powernv_defconfig and ppc44x_defconfig don't regress.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/240
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/powerpc/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index c345b79414a9..971b04bc753d 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -93,11 +93,13 @@ MULTIPLEWORD	:= -mmultiple
>  endif
>  
>  ifdef CONFIG_PPC64
> +ifndef CONFIG_CC_IS_CLANG
>  cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
>  cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
>  aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
>  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
>  endif
> +endif
>  
>  ifndef CONFIG_CC_IS_CLANG
>    cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
> @@ -144,6 +146,7 @@ endif
>  endif
>  
>  CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
> +ifndef CONFIG_CC_IS_CLANG
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
>  AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
> @@ -152,6 +155,7 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
>  AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
>  endif
> +endif
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
>  CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
>  
> -- 
> 2.23.0
