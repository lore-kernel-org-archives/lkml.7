Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675AD2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCKQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:22:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42310 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:22:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id u7so5700151qtg.9;
        Mon, 11 Mar 2019 09:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve85xHaDm+JKbPQbqtfepcK+rnO+6Ikd52hFBQTzdQc=;
        b=j34wWTTZ49rV/tjhaAJc03KKHIQgSfZoC71EPaIBbQWNFhlz7nkoc70GkEdD6ROq7s
         cvTonuEO2+oVnu4ZoUeLypKUEs+XLI7V/ZDC/m982kIivqNaPz0xICpUeRqrYG+DiUEV
         HuMBI408ru8pHwd0zAJkKt3o+ccfPNo4TfnejojrX77s6Bm/+yZgF6kS5vu3gwsLiemc
         o6Ur32Ry6YIAOunwBGqtW1lm+RIbv9+V6H+cQRnEGSIFiq044dB88jmhrXnJnv8wVcJR
         fmw4h5tMJOecZE41zxSqFfoCfvM0lkS6z3KWWGsJrFLTayR3Lvs45Y2/+PrvWxVAoXAL
         Vddw==
X-Gm-Message-State: APjAAAWjnarEhUCKVzwkwDH06JM5kkflFDdMdnEMbbgxNo2pXUoTYgC5
        Znb6VwQCFH+FLi120uJo7xECO1o38OPFtFpUl8Y=
X-Google-Smtp-Source: APXvYqzogw3Q0KpovvrymQSFCLcF3Ho7aKgywlZZnz27NpbAGMPX/9YrifWPc80Ds/7JKVN581j3cZKE8jI+snW9ELA=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr26150579qtb.343.1552321333276;
 Mon, 11 Mar 2019 09:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181215212304.19390-1-natechancellor@gmail.com>
In-Reply-To: <20181215212304.19390-1-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 17:21:56 +0100
Message-ID: <CAK8P3a05QL855mx21R-Pr6c2WjhSoopdFk9z4HvKoeM19A5aSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Tri Vo <trong@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 10:24 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>  endif
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index a6741a895189..4600b62d845f 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,7 +14,7 @@
>  MODULE_LICENSE("GPL");
>
>  #ifndef __ARM_NEON__
> -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> +#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
>  #endif
>

I see this patch has made it in now, but I also see two other problems with the
same file that prevent it from working right with clang:

- it triggers #warning This code requires at least version 4.6 of GCC
- As I reported in https://bugs.llvm.org/show_bug.cgi?id=40976, even
  when it builds cleanly, it does not get vectorized.

Has anyone actually managed to get this to do the right thing?

       Arnd
