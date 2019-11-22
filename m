Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97942C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2072068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSzmnfAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKVMzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:55:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44275 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKVMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:55:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so4389352lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 04:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wk6tt4pvu+ZfbWYu/PVVeu0E+OQ4R1/xSNXMM/bU9Lw=;
        b=aSzmnfAjW/Sld1A8GmaY9ft05mnl46eBHazEo0IxNFXbfqSoHtzJAqR/KjWfUJTOZT
         63vNmiQEJCiTbYwkMMnapQZ0CWRn1/ZBioLILPzwXpwo+KJU1BdbU5Guu17ED/RbO91Y
         ZrIDQ9/tCxEJLPj9pN2EBouj1rjVXn1M3Yx3hJxKCsQrsYZ6syipL3Gt0tOCLjyhEekU
         VDsvbCQpdzdTiK+XrpO64rZKfv5/Waa9bVEIanN6lpwDIFXdW1hqIU9UShZyjzqJG696
         GxvlR3Qb6tW0rclsJfPIZk+iVoe850/pWaIvV7pl/JWquPXliXkEdJTCCBI2+vfI6Jik
         S06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wk6tt4pvu+ZfbWYu/PVVeu0E+OQ4R1/xSNXMM/bU9Lw=;
        b=Nz8G8uQzaw8lTNls9PgOL9a+w0/E1ipUeYPCN2UCkJKdI/5owtIfJqWxe/bjixarMa
         DDck2xptuJQTxcN35BV2Qwz+iJGOI/o2LPtjldHGGskA3Ij2aC1AJpme+la9js2oVGFz
         jnxWKKa6tIzIMBhfEyTeltN3gg+whiBmRmcVTwioFjHN1/9DPsycM1r1tmIheg9Yrl9q
         mE0lxPKd0nTLI6ank3t4extSCmMF8Ixr3nNfwMCCs4fnWfjcUp5I6m+ziXSn9rL1wLXm
         i6grLooyzf755kE6oY+KfhlH1QbrseQjyR+2I/2U5LrGrdzZBZ3UKIPdlIeHgvCjM+cH
         oG3A==
X-Gm-Message-State: APjAAAVJBluKRGmE77muVJm/w5mDdl6eNFSaFFJ0NMlKxpX6BXC5vJCj
        +Qu9270P/oMjcBB9M5b2Vj5ly4fbjee4mLtj4+kqhQ==
X-Google-Smtp-Source: APXvYqyLBqx9aJEJZHJrOVeWIjfpxknwTpqU3jqLGVpk8q264VK7YTN0bIpi+Gk/YANI17fLVJDi0jHVKVodRmu7na4=
X-Received: by 2002:ac2:44d2:: with SMTP id d18mr2251137lfm.5.1574427346899;
 Fri, 22 Nov 2019 04:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20191120154521.16273-1-geert+renesas@glider.be>
In-Reply-To: <20191120154521.16273-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 13:55:34 +0100
Message-ID: <CACRpkdb7Fkrbr=Zu0HPPWmDx4uPPvog7edzddZ2Z7g1E7srYdA@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: Fix bogus reference to gpiod_get_count()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 4:45 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The recommended function is called gpiod_count(), not gpiod_get_count().
>
> Fixes: f626d6dfb7098525 ("gpio: of: Break out OF-only code")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied!

Yours,
Linus Walleij
