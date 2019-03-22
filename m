Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB80C218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCVN7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:59:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44123 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCVN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:59:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id y5so1229030qkc.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJDxHNaqkaKZ9MORW/0o5+vv/jLbHGCobfTlqfu+2pM=;
        b=UCJgC/5LLFnQsi5gknY3LhazPCQpaYfQJfgKHPYZ63RLV2tDKccZILaiy9TXdp5COk
         1jELeciXMnUP7ECEa0lLR+NNtusuJwTjOQXAWUnoufHePYJiytNGBVfb/3glBDKLxQwb
         +WYF+On6QtJE8kvtxATvOOkpzNADE/CsZXeNfQVsaxEWCHlSxspiu4PxpZTYihDRn/OB
         zPP+We3GiyC/F+pdYHcBPMimqxUHRs3fzR8vuaTkv+ad4eMCAo/4JjVK4o5yq0Lp7nrr
         SghTSjUwObk7UozDUB8LJTKV/mttS2oG1jwQzxpTomHj99lzH8yJLKBHcr1Fw/GjgaVG
         ae5g==
X-Gm-Message-State: APjAAAVkgxN5faVQeo0o+NGn4CMrHDTXk/zHwR7coRvzW1MySraWAjCM
        S+I5Z4y6LiwiP8KVGwTgcwzXbrWE2+d9pvkz+mk=
X-Google-Smtp-Source: APXvYqwl4R/1EXf6esmN2Pj77u1U+Y3gF9A9Xrg0V96xBISoEl6CtSyHauYmr9wmaJBA3Dqveuuu7X+dLPBMzEhOIho=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr7341041qkf.107.1553263149203;
 Fri, 22 Mar 2019 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-2-andi@firstfloor.org>
In-Reply-To: <20190321220009.29334-2-andi@firstfloor.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Mar 2019 14:58:51 +0100
Message-ID: <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
Subject: Re: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc 9
To:     Andi Kleen <andi@firstfloor.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:00 PM Andi Kleen <andi@firstfloor.org> wrote:
>
> From: Andi Kleen <ak@linux.intel.com>
>
> This warning is very noisy in a default build with gcc 9.
> Move it into W=2 only.
>
> Cc: arnd@arndb.de
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

I think W=2 is too aggressive. On many architectures, this finds
real bugs and the false positives tend to be trivial to fix
(by removing the bogus __packed annotation), which improves
the generated code in the process.

Moving it to W=1 for the moment is probably fine, but ideally
I think we should fix the kernel to behave according to the
C standard.

      Arnd

> ---
>  Makefile                   | 1 +
>  scripts/Makefile.extrawarn | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 71c2c482e2a2..78efbb172991 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -676,6 +676,7 @@ KBUILD_CFLAGS       += $(call cc-disable-warning,frame-address,)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, format-truncation)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, format-overflow)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
> +KBUILD_CFLAGS  += $(call cc-disable-warning, address-of-packed-member)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 768306add591..ed974a0f4a47 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -43,6 +43,7 @@ warning-2 += $(call cc-option, -Wmissing-field-initializers)
>  warning-2 += $(call cc-option, -Wsign-compare)
>  warning-2 += $(call cc-option, -Wmaybe-uninitialized)
>  warning-2 += $(call cc-option, -Wunused-macros)
> +warning-2 += $(call cc-option, -Waddress-of-packed-member)
>
>  warning-3 := -Wbad-function-cast
>  warning-3 += -Wcast-qual
> --
> 2.20.1
>
