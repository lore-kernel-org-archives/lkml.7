Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C012087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553511230;
	bh=2RRPeX8pUj0Mm1sBCtxVC8d0iPHMz5jaJuVESbYH9Ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WEhtEaqCwh2vHubRPJQE4Z40w43Kj6yzpvowGytVJ5ZFcaPp+lacIoaEY9j4U4rXD
	 1O7vQu9YZgOff6Jry+wBCiYEU+ptdciu46lB6QNyR1z/R+6hq5UgnOu9kotDVhBJ8j
	 S6RA2j9ApTF42IJryFy7P+wuh8b7WX4nzU+uhVEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfCYKxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfCYKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:53:48 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8C920896
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553511227;
        bh=2RRPeX8pUj0Mm1sBCtxVC8d0iPHMz5jaJuVESbYH9Ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RbS7YgPXs0oqKlskGZ6t2tpQAZBhxaLLjULIyoNdC6WQL3DWfkFseWvitc7vGt2/Q
         sv3fMyWOXdOLIDqlJwG2Qs/CbTSpx2uJI5Fz6vOvj73/FRMc2dDaEPF2VzMfDJZAZL
         pfRtVCfg2z07YJZBKyOwR8JnfFfbvLiCjOfccFEk=
Received: by mail-lj1-f171.google.com with SMTP id p14so6386820ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:53:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWizIekuiJSNcqqsmpXITBcGSZDKN42dGk084wp0BhBaUnn2Dbt
        oib86v8rgRUo8u2C6l2Z/GtzIZ4cTWintQoO99U=
X-Google-Smtp-Source: APXvYqyykv60YomVXBH+PnHtz8k8RZkkExJ4ADZg7tNQutXnum8f3jaLSQixMv77y377Kc7VOoZNalFuMjGtPNp5FDU=
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr13006497ljh.184.1553511225259;
 Mon, 25 Mar 2019 03:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
In-Reply-To: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 25 Mar 2019 11:53:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe7h6DCSAyQ9v-UkyMnUXnYhop_HCwLKM-B=+tPJpRrrA@mail.gmail.com>
Message-ID: <CAJKOXPe7h6DCSAyQ9v-UkyMnUXnYhop_HCwLKM-B=+tPJpRrrA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: use arch_extension directive instead of arch argument
To:     Stefan Agner <stefan@agner.ch>
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nicolas.pitre@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        robh@kernel.org, ssantosh@kernel.org, jason@lakedaemon.net,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019 at 16:52, Stefan Agner <stefan@agner.ch> wrote:
>
> The LLVM Target parser currently does not allow to specify the security
> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> to use Clang with LLVM's integrated assembler, this leads to a build
> errors such as this:
>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
>
> Use ".arch_extension sec" to enable the security extension in a more
> portable fasion.
>
> Note that this is technically not exactly the same as the old code
> checked for availabilty of the security extension by calling as-instr.
> However, there are already other sites which use ".arch_extension sec"
> unconditionally, hence de-facto we need an assembler capable of
> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> arch extension "sec" is available since binutils 2.21 according to
> its documentation [1].
>
> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/mach-bcm/Makefile         | 3 ---
>  arch/arm/mach-bcm/bcm_kona_smc.c   | 2 --
>  arch/arm/mach-exynos/Makefile      | 4 ----
>  arch/arm/mach-exynos/exynos-smc.S  | 2 +-
>  arch/arm/mach-exynos/sleep.S       | 2 +-

for Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
