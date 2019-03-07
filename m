Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CEE20449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/lMpw34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCGTJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:09:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43031 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfCGTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:09:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so12156247pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8V/DtAfCr273lL4v2BMkB1zIQ14ufepJqgsknHm2zr4=;
        b=B/lMpw34D/1hHDtuGxb84LSATqAG7RMBGOaGvc+PuuB+orD7B4ojGyg+7Ek1BdLAAn
         oAmGH4TTLwlcrflR1k7sCxYIgeTAPjBlr5iU+4xlz26Pke5sfJmrCUea8fenk5Nq8Sgw
         GnICSSbkC20LfsidUDsiA+WoS+DEBv3j/vth61nw0y8yxwkfMA/LrRve1Sf7Vv5tBxJk
         WLLYnK/hm9Eue/N65najcgFS+RXnCr7phEjwJNPncTlj70QPf2xGXbXNg7RNEnLrqJGO
         R/lUWNNGsryAb5uTI6hjoF1Irlf7goPcPfTuYsP/kSvxgsbd4LU0W7tg+VYuW43kcoac
         q0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8V/DtAfCr273lL4v2BMkB1zIQ14ufepJqgsknHm2zr4=;
        b=Y/Ik6DR2bWy2TEnzylE2HkV8ZxYzE7VDgDZlsdi4AzTpEvTVdcEo3e7/XvwzC4s2z9
         Jcd7FHI2yBF2yvFIDT6mg3llvKxj/BSp3KbTVpw7K4JDqj4NYAyuX1pHPBaHbh+DM8Rt
         rVvCXpvT5XsISzJTZMdpKn3HxLfzE7/NI5TXY6tSi+HF5NqPR8otruqRQcueYJgDlgEf
         sEbzJ0FT6wpK9GdrzIuQCLq2gxXm0jaWkyP9pPYCOFlmIEIEz74eK4kO+FPx1WnG2ddY
         TSxTDk7zLbfESZZMNjOrOJH+msrHpduAW5Xy5HfUnOCuG77qoOXYQ8m+0atNytfDaetQ
         iH1g==
X-Gm-Message-State: APjAAAV5WTHqmDs3bf2nLIe1x/jc+J9orn84W5qOsbReFlB5z8leO6+L
        o9v5K3lnrSnZrFO5aQ7auesPUg5XQjvyhJNWjsDmVg==
X-Google-Smtp-Source: APXvYqyQ5Sm4E2i8KdOxRvdOIH27KwmhC1MW5lxNPnT1pAC9sVMQrGOjANr/6grBETa0rpJhI6R2M52IcU86Ihi9lYc=
X-Received: by 2002:a63:5506:: with SMTP id j6mr12760318pgb.202.1551985792114;
 Thu, 07 Mar 2019 11:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20190307102630.1281128-1-arnd@arndb.de>
In-Reply-To: <20190307102630.1281128-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 11:09:41 -0800
Message-ID: <CAKwvOdmFOAGQrkbyd4yrywsUxKwRDTqQs+8n5gT8VFd8mux7eg@mail.gmail.com>
Subject: Re: [PATCH] regulator: da903x: don't build with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Axel Lin <axel.lin@ingics.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:26 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The da903x driver produces an annoying false-positive warning
> when built with clang:
>
> drivers/regulator/da903x.c:395:2: error: division by zero is undefined [-Werror,-Wdivision-by-zero]
>         DA9030_LDO(13, 2100, 2100, 0, INVAL, 0, 0, RCTL11, 3), /* fixed @2.1V */
>         ^                          ~
> drivers/regulator/da903x.c:359:2: note: expanded from macro 'DA9030_LDO'
>         DA903x_LDO(DA9030, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
>         ^                                 ~~~~
> drivers/regulator/da903x.c:320:39: note: expanded from macro 'DA903x_LDO'
>                 .n_voltages = (step) ? ((max - min) / step + 1) : 1,    \
>                                                     ^ ~~~~
> drivers/regulator/da903x.c:415:2: error: division by zero is undefined [-Werror,-Wdivision-by-zero]
>         DA9034_LDO(5, 3100, 3100, 0, INVAL, 0, 0, OVER3, 7), /* fixed @3.1V */
>         ^                         ~
> drivers/regulator/da903x.c:356:2: note: expanded from macro 'DA9034_LDO'
>         DA903x_LDO(DA9034, _id, min, max, step, vreg, shift, nbits, ereg, ebit)
>         ^                                 ~~~~
> drivers/regulator/da903x.c:320:39: note: expanded from macro 'DA903x_LDO'
>                 .n_voltages = (step) ? ((max - min) / step + 1) : 1,    \
>                                                     ^ ~~~~
>
> I already reported this as a bug in clang, but it may take a
> while to fix it. As I have not been able to come up with any
> reasonable workaround, I would just disable compilation here.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/regulator/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index b7f249ee5e68..6d2651cd9887 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -223,6 +223,7 @@ config REGULATOR_CPCAP
>  config REGULATOR_DA903X
>         tristate "Dialog Semiconductor DA9030/DA9034 regulators"
>         depends on PMIC_DA903X
> +       depends on !CC_IS_CLANG # https://bugs.llvm.org/show_bug.cgi?id=38789
>         help
>           Say y here to support the BUCKs and LDOs regulators found on
>           Dialog Semiconductor DA9030/DA9034 PMIC.
> --
> 2.20.0
>

Most pragmatic solution for now. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
