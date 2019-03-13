Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC12177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OBPgaOmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCMINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:13:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45220 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfCMINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:13:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id f16so734463lfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OgaWnuLR8E36dS/DRH+8CFdnIpkBflC5UhM+d3H4xNw=;
        b=OBPgaOmofpeOhy9tbpvJleB1beNeOVqbvzcGOpdYvReRPJ+yq1QQc1TVPyg17MW2Ro
         fuLRYwN0ZiddHVPGT+vXQk93JBkfkZcS3w4VEp1nxBHrlDUQ8gOzy6muu+d82zLF+oYW
         6FSw/ZsteSM+ExTJgRBPUXHxccPPh7rLv1lh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OgaWnuLR8E36dS/DRH+8CFdnIpkBflC5UhM+d3H4xNw=;
        b=T6XSfbhWtomKreLLuLVyF5YqxUQ89Up+pXBzcfSzhk45eR+rUcCMZnr3M9IG2M1aHp
         2mG2dPqKnJDEh0taeRa3l6L3uAdl67Zvubj+gTURHMVxptF11smiCxuee4KRwnSpNc7x
         oncwSLCG/qBOeMBEdU+oigwDb24BeEJNUTMM+FU76kXlIEgQE2fFiYj9B20Vx37Bj0m5
         5wpfQmkZ/fJPk3nDoNRWPobyCvaWkTFuRUWb4slNm4U2DDZs0Vhwf6Zro+3t79/DxoYC
         6xccp9sLWU+EUb+gf4B3KHle2iy6dyfqdYJGnW5ZSNOWC83QbGcsx2K2Tp7Ch8blZa1u
         AuKA==
X-Gm-Message-State: APjAAAU0vHky59zQNn5+frrrcfY+2viJ7siLRwPbTqwKTpXr9LjpaYHe
        3PmAbTuqlBD0u6aDsrzjDslNPw==
X-Google-Smtp-Source: APXvYqzS1KWnD+XMTf+dawSpOwHfH4rv04X0Pez35SydVHOqnb5Jy2dYfjExMZ8QeDCKQXfeme9n4g==
X-Received: by 2002:ac2:54b6:: with SMTP id w22mr1565272lfk.132.1552464792857;
        Wed, 13 Mar 2019 01:13:12 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f78sm1690475lji.96.2019.03.13.01.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 01:13:12 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com, stable@vger.kernel.org
References: <20190312215203.27643-1-natechancellor@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk>
Date:   Wed, 13 Mar 2019 09:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190312215203.27643-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 22.52, Nathan Chancellor wrote:
> After LLVM revision r355672 [1], all known working kernel configurations
> fail to link [2]:
> 
> ld: init/do_mounts.o: in function `prepare_namespace':
> do_mounts.c:(.init.text+0x5ca): undefined reference to `bcmp'
> ld: do_mounts.c:(.init.text+0x5e6): undefined reference to `bcmp'
> ld: init/initramfs.o: in function `do_header':
> initramfs.c:(.init.text+0x6e0): undefined reference to `bcmp'
> ld: initramfs.c:(.init.text+0x6f8): undefined reference to `bcmp'
> ld: arch/x86/kernel/setup.o: in function `setup_arch':
> setup.c:(.init.text+0x21d): undefined reference to `bcmp'
> 
> Commit 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to
> builtin") removed '-ffreestanding' globally and the kernel doesn't
> provide a bcmp definition so the linker cannot find a reference to it.
>

> Fix this by explicitly telling LLVM through Clang not to emit bcmp
> references. This flag does not need to be behind 'cc-option' because all
> working versions of Clang support this flag.

Wouldn't it be better to just define bcmp as an alias for memcmp? They
seem to have compatible prototypes, and then somebody might someday sit
down and implement some word-at-a-time version of bcmp making use of the
weaker guarantees about the return value to gain some performance. But I
suppose that can also be done later.

Rasmus
