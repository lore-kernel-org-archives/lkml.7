Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A6C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B903A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O9UDoCee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEPE7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 00:59:50 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:25337 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 00:59:50 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x4G4xWoB014187
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 13:59:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4G4xWoB014187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557982773;
        bh=9Ph0k+grbv6JWNUv54NWUGkLMtwGfMJBcFTvjqQFPk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O9UDoCeeGS9Q8UGhX2a1LFreuputm3gZZRI4zDrwBkqGm4URrl6A0cfy5dariKJLf
         OcpMR2p+o13xSQoNX9D2eXZ9l0zepTXxs8KkSqweT3DvNxcJemxPD5Vbl2LbI6bVjG
         6nz1877AVC2WEdRhRU8c+Pxhz/ABe/0EPKwRW9GzhBjAU652H1vEiXsopme8SJFlSA
         J4juxwqhZt0PezcmtFi8utb86FiEtO8Rx4na+xjdO35PaMuj0ZyV57hPQfkVNLcjV3
         q+D4skKCIElOcf0BoQGTfvmzW5wnhhAAfgVY2kXYgMJIX1vzrziaqahW8Z9RR5WA3Q
         OnI85dG8aFX1w==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id p13so777453uaa.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 21:59:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUGPJS5T4zaqzVP4Yb95raj6L6rVZ6D+utTNjASmZ97Uh98bSeT
        CPK50ZDj4WeIFCLK2ZIshyHSKfAakjq1Eth1hXs=
X-Google-Smtp-Source: APXvYqwExr/4di8INLQkJrRDaQheWIP5t5xUKnGAEoIV0Jcz144JQr/bNNxhYM9Biw317JwRRcspl7XRbcwfoXMGDrw=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr19663232ual.95.1557982772314;
 Wed, 15 May 2019 21:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190515194824.5641-1-labbott@redhat.com>
In-Reply-To: <20190515194824.5641-1-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 16 May 2019 13:58:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZnRrSsZSrnw41kintGfmpyj3iz-Vjduk7w3k9iSih-w@mail.gmail.com>
Message-ID: <CAK7LNASZnRrSsZSrnw41kintGfmpyj3iz-Vjduk7w3k9iSih-w@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: Explicitly add build-id option
To:     Laura Abbott <labbott@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 4:51 AM Laura Abbott <labbott@redhat.com> wrote:
>
> Commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to
> link VDSO") switched to using LD explicitly. The --build-id option
> needs to be passed explicitly, similar to x86. Add this option.
>
> Fixes: 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm64/kernel/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 744b9dbaba03..ca209103cd06 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -13,6 +13,7 @@ targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>
>  ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> +               $(call ld-option, --build-id) \
>                 $(call ld-option, --hash-style=sysv) -n -T
>
>  # Disable gcov profiling for VDSO code


I missed that. Sorry.

You can add  --build-id without $(call ld-option,...)
because it is supported by our minimal version of toolchain.

See commit log of 1e0221374e for example.


Otherwise, looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


--
Best Regards

Masahiro Yamada
