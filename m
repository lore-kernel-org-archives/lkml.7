Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6AC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C16E2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCSEdeAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFYNnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:43:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43854 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfFYNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:43:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so12654367lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mouyUCijCL0qaXgD+khfJSX4dSqV3MXsNvU/q7OjoAo=;
        b=qCSEdeAMP1sIwlguOGRG+Qsdia7kp2b8qGsMUU4xlun0eAZSyCEmhXYCVuHgvaMjI2
         8C3dzpordUFcSQYrc1jzhemxVSWjvcAu/vA6XhWLbdlV3dPMDoVzv51D+eKpcrcXu+RW
         vNUduaqe+bhcZRp2V1dGBmVSigH5LtcenKIoTmJioMoYZDDHPEtHHB1eAarOZ4Uivgtd
         mkpDOGwFIrpfl8BlRs5WS/ebRelPxb/LPb0xs/c34QZnKMVrZ4wClccGWUnlwZsEpidI
         68sC4SHCBn3x8oYsdMqWBQbVGSPU9/YkGAr6zrUkn3/8Hda5mnPOacnDvD2VtXmrdyjO
         wGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mouyUCijCL0qaXgD+khfJSX4dSqV3MXsNvU/q7OjoAo=;
        b=RA9wAl9b6uUHPLt6l+mBT/fs19glLVNIpo+yLenWX7KLVCYemU4RGSaMJdylLOYu8k
         p+tGcJR8nBGZuiG+476jrlYog5ScOMGPaJhssOkFWupmTqQkpsZ0WKUu5t8fdR+oLqH/
         zZEZLy+jMKD+2P3ZJpsTpzN//Bsv9F5M4okqeNJG1IemmRidgYZYHPon+Oe3dvLYFKqr
         kgh2FjxfRrsE1cPyBWK9VDF5JpLDOj7FYr6JO3Z70fwL9OlKSo/ll9FdmNoRZeYLH5YZ
         8QHxlrE/am1vWNJkYX+5yIy7ObXghj0YacYY4Fcz55Az2jKRHizvOOEhdc2TasLDqNTv
         JBQQ==
X-Gm-Message-State: APjAAAXCAQj9ZipCrV7iDnsC4FYfKtVV82nqmA+W/ecWLLSUCZBu1HoC
        Hr+cfPWtku5+LKFAu3UNoAbPpbJVw/HWvrsaR5319A==
X-Google-Smtp-Source: APXvYqy0OxjHtBjby60RKNT2mppx7IQj99qwo5vUrxXCVqpZ9vVC9kx8mcvbkSQbadmIjLPI9EicniZ5HrnXpHS6BFI=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr29353055lfc.60.1561470197405;
 Tue, 25 Jun 2019 06:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190620183037.29652-1-alexandre.belloni@bootlin.com> <20190620183037.29652-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190620183037.29652-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:43:06 +0200
Message-ID: <CACRpkdb1AzgUf0go=q9uDN2QdH6Gs-K-CT9h=y1T4YZgqKrF8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: fix pinmuxing for pins after 31
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 8:30 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The actual layout for OCELOT_GPIO_ALT[01] when there are more than 32 pins
> is interleaved, i.e. OCELOT_GPIO_ALT0[0], OCELOT_GPIO_ALT1[0],
> OCELOT_GPIO_ALT0[1], OCELOT_GPIO_ALT1[1]. Introduce a new REG_ALT macro to
> facilitate the register offset calculation and use it where necessary.
>
> Fixes: da801ab56ad8 pinctrl: ocelot: add MSCC Jaguar2 support
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied for fixes.

Yours,
Linus Walleij
