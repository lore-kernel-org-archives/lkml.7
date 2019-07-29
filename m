Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2D6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA2F21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfG2Qe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:34:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45910 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfG2Qe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so59152062lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG3D/SqCJj11xnk2S6pE/fAYr6pWtAvwmUTxug894eQ=;
        b=CYZL5Yth2mCbIS0Ce/2FGCmgoeOEqbEgX6Iy9SEALcR962gz9599OFbnmQuQeCS1O/
         YrxhJS+djrVGT4J8VD6EgL4GdaIjY7qe5c8wGyltD+7oqeA146xHoO0tJlE4BHN1xPom
         vzPusjs8CuOieJU80TJwl2hY4EoasWNAW460yVZ+Gt/t7boqbxYgZnkc3My2j2OkiWj6
         akyPmBrqzdZqQEhpHFMb21Lhz0029AeKmB+qZ1XjYW99Gpy1lKgs2BSwhfeBzBrB6A4+
         1wy3VcXAlGngQZgb4ttOHJ6EQxbGfP4KXmRATiPmlXfVMYhNVY42Nw0l+//bDqHnV64z
         xW1w==
X-Gm-Message-State: APjAAAUe+iZjuGXUKMeRwTI3SPU40iYAh4Wqn00KagUZ5LeheMAyo8um
        ELIinaD6uMFCSctObISA7iPS1P2TAlBDKtvdG6/ufA==
X-Google-Smtp-Source: APXvYqwaWzM1hn/JYuWG8xIWCCoQc0juPndzV2AWEI2sZ0zbeHQbhgIVf3GM5tGdjfmKdC05eoQItiSu7YXZ4SX7s6Q=
X-Received: by 2002:a2e:2b01:: with SMTP id q1mr57284489lje.27.1564418064609;
 Mon, 29 Jul 2019 09:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
 <20190729125421.32482-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190729125421.32482-1-vincenzo.frascino@arm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 18:33:48 +0200
Message-ID: <CAGnkfhw+=+50P=uaWsjZrtt_BuwJjXKZ_DSTjuJ8mzW4_kbu-w@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: Fix Makefile regression
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, salyzyn@android.com,
        pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        sthotton@marvell.com, andre.przywara@arm.com,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:54 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Using an old .config in combination with "make oldconfig" can cause
> an incorrect detection of the compat compiler:
>
> $ grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
>
> $ make oldconfig && make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
> Stop.
>
> Accordingly to the section 7.2 of the GNU Make manual "Syntax of
> Conditionals", "When the value results from complex expansions of
> variables and functions, expansions you would consider empty may
> actually contain whitespace characters and thus are not seen as
> empty. However, you can use the strip function to avoid interpreting
> whitespace as a non-empty value."
>
> Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
> evaluation.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Matteo Croce <mcroce@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index bb1f1dbb34e8..61de992bbea3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
>
>    ifeq ($(CONFIG_CC_IS_CLANG), y)
>      $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
> -  else ifeq ($(CROSS_COMPILE_COMPAT),)
> +  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
>      $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
>    else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
>      $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
> --
> 2.22.0
>

Tested-by: Matteo Croce <mcroce@redhat.com>

-- 
Matteo Croce
per aspera ad upstream
