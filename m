Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A1EC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DD22080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrjgJBGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgAGJnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:43:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46094 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:43:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id f15so38373769lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3KYUHqjbV/la2pQs13q7xW2zW1+aOUSJ/ItOMkEioA=;
        b=UrjgJBGylGsxt2O/37GXsCrU80X3acd5iK9tF8j3b+FFY6/zrEKHNEHxExKwF2XBjo
         Eutk1xAIMJpAuDwWUe66mKIU89kY/4y/G+yYX++jtMSPLmIFPhuBkhTS+cgBPwhRqObf
         EsJA7DVWNM3UW5nR1ALsyiekYnLeNaj2z9l84Sdxr88nXQ5ymB+KH1+s+APM1ihCFHka
         QCY2yelgoalwPQcc1yyFY1Jh1S3ipyxEfNoDmU3Xri6ikRV+tkGtsMZYlneuZ96P8PRi
         AEr9BYeZKPxqSoVNPIDJJnLMPVtH3suNFxg6DazjcZz79CVwmPOG1dXrZCKt9Wud0fcN
         qU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3KYUHqjbV/la2pQs13q7xW2zW1+aOUSJ/ItOMkEioA=;
        b=r12z+7bWpVMKpQMzUPIK75emZ+zfqyC20p67TZD+Pwu0o3NDVSVxHCvQNCGZn4Sk7t
         nO/ez7ZInSaMppd6F4GO6Eui7btc3bbfdylP8RfRWHMg8M7sNIsvOhn8AiIRK6Yqt21j
         qkb6gLmofBG0xaPWW6BN+UbTbejbPNGhvFPLdF04h5f8YY9DHZeKHSGsLFELUAWrBHrx
         n9Hzwd9b8BtzQtdKdNYmjv02z3EUE88kuD0RdhB1nZgdi0v3reCFk+aH2zjCINNDrt1K
         FWCE+a3dmp/dSLFqW5m9/i4BG3EYkG5tmyh7hoMwwrVdEnuNSbQZ4teTvisZkkn2Ntyg
         NkRw==
X-Gm-Message-State: APjAAAWTwlCe6DvqXn7Wg3oZyLdQkvcjtaPMGlZZfTXp9v+DVCpvu/wG
        n+Q3A+5ctDIaV9kfonm5oSF21LVSDeMAoGmtz39n9Kqy3TQ=
X-Google-Smtp-Source: APXvYqwlnUnUD6Pz4nc1kPRcSvnFa6RimACaHIJvGNUu2qiaTC1sqx9RJ3urXdFSnyhcPkKPss4GSSAD5kvOk3IkGKI=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr58874379lfd.5.1578390196075;
 Tue, 07 Jan 2020 01:43:16 -0800 (PST)
MIME-Version: 1.0
References: <1576723865-111331-1-git-send-email-mafeng.ma@huawei.com>
In-Reply-To: <1576723865-111331-1-git-send-email-mafeng.ma@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 10:43:05 +0100
Message-ID: <CACRpkdakKeOhuOY_amLVbf61jQsMLfxRjWE_J-4Zqr2wrQGuNQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: armada-37xx: Remove unneeded semicolon
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 3:50 AM Ma Feng <mafeng.ma@huawei.com> wrote:

> Fixes coccicheck warning:
>
> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:736:2-3: Unneeded semicolon
> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:803:2-3: Unneeded semicolon
>
> Fixes: commit 5715092a458c ("pinctrl: armada-37xx: Add gpio support")
>        commit 2f227605394b ("pinctrl: armada-37xx: Add irqchip support")
>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>

Patch applied.

Yours,
Linus Walleij
