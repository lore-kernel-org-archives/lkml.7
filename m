Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76213C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBE522459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLfBrr5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfKMFlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:41:00 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41862 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKMFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:40:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id 94so584918oty.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 21:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NnKt4zvBKQ2t+5qhu+whaXwSdPkqbGUBXBvCo/qQj7s=;
        b=WLfBrr5Q2F7dldKkiy3bYGX7HyJObit2WZaxgQ2sgGns/u7Y/qS/JM+Yv3hpNrMdSR
         DGOmUHSWX65B+v7rkdAAO06OTsXl/ZNGY7MHpjqwSmpWbNHEnLeUd4+8F1wmzoGUyftf
         SeqTD+S6ftur4K5dNNMwN4OwuSioAV/JkO4LU7v+8aUwbATtSGQQg21iKgxJ1krYGmgt
         3rnCg2wRaITD3zjtCstVTdmufxswjNwgIvE8K/AvFqYQXRppzTFw/PWrlVuqlwhVkzH1
         i629aZhioSB16hpsxSe1592YM3HZwylpQrxS36Glei68RW8ZKnCdKxik5F0JNqbSbTHZ
         Zm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NnKt4zvBKQ2t+5qhu+whaXwSdPkqbGUBXBvCo/qQj7s=;
        b=i/9+jFUCOKjbB/RfQlrfjY7Y44Xy9ZdwJy7vK1oSCHeGI499S9JwUq8O9+X8E3W2H/
         KiJi6PkEfq/a5mhKx+D93mG+aJjBSTItKFLfTxa0a3iF7Iy+sFqH9/QWCfXM/ZWuIVXy
         cEy3dafQtKRHbxka4g+63CMzR0EIjbgWka4qz5DbdvFd0dyDD1DeKHflqKPij4ZBeH0b
         LFrjcFNahsnzQVPrgYWvz0BG/Nkyzm3yAjY82pFD9HbKkn926iWEg9t5ckhFCbWVBECk
         ng/ac6bA88ZnnyZG6J8JO8yx2kXBTF1e5QqCPipJRldoy5Z1aK5HuFRZP5qPdVjI6UA0
         p3/A==
X-Gm-Message-State: APjAAAUbmqV8LzNJDRAblW1FL3x5ggvogRMh4j1RbFvy5e/gJUvuhbJl
        YRhAqDkp8MuHE+OV2F1xy14=
X-Google-Smtp-Source: APXvYqyfUBaxAca41zSxpv8p+d0yz5n3tx3en6yq0tsa/ZT6LYSuua0UoLZjUpTwJx8Ss8OfUzaXLw==
X-Received: by 2002:a9d:5c83:: with SMTP id a3mr1305008oti.208.1573623658612;
        Tue, 12 Nov 2019 21:40:58 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m11sm408375otp.15.2019.11.12.21.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 21:40:58 -0800 (PST)
Date:   Tue, 12 Nov 2019 22:40:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Collingbourne <pcc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] scripts/tools-support-relr.sh: un-quote variables
Message-ID: <20191113054056.GB16066@ubuntu-m2-xlarge-x86>
References: <20191112134522.12177-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112134522.12177-1-ilie.halip@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:45:20PM +0200, Ilie Halip wrote:
> When the CC variable contains quotes, e.g. when using
> ccache (make CC="ccache <compiler>"), this script always
> fails, so CONFIG_RELR is never enabled, even when the
> toolchain supports this feature. Removing the /dev/null
> redirect and invoking the script manually shows the issue:
> 
>     $ CC='/usr/bin/ccache clang' ./scripts/tools-support-relr.sh
>     ./scripts/tools-support-relr.sh: 7: ./scripts/tools-support-relr.sh: /usr/bin/ccache clang: not found
> 
> Fix this by un-quoting the variables.
> 
> Before:
>     $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
>         NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
>     $ grep RELR .config
>     CONFIG_ARCH_HAS_RELR=y
> 
> With this change:
>     $ make ARCH=arm64 CC='/usr/bin/ccache clang' LD=ld.lld \
>         NM=llvm-nm OBJCOPY=llvm-objcopy defconfig
>     $ grep RELR .config
>     CONFIG_TOOLS_SUPPORT_RELR=y
>     CONFIG_ARCH_HAS_RELR=y
>     CONFIG_RELR=y
> 
> Fixes: 5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR relocations")
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Link: https://github.com/ClangBuiltLinux/linux/issues/769
> Cc: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
