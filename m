Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390CEC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10774213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjRocc0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfFYM07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:26:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41038 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfFYM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:26:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id 205so7256137ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkM0/+Y2mDTWRWvyb1EfYEosGBa2XCe1MpHMrOCqACs=;
        b=gjRocc0M0csOsxcltg1nkQWWzkjs3PSER+yR2O1GOwKo2FVeeoBS8PgxAD1E6mjPxY
         LLT3xmGdPMDMbbTnk6hBta7ypvxPkY6YPvTpZ+01Z0y098PfPKQ/+49XGlm2WDmMh5tl
         D1coqelf7c3PUCElzY3sJ9LOc4F3XRV8vFhFCXIBISTf3Zg5DyOBweRq306XDmxj3zbr
         QFf+mbnJOyKWRpw7ox/wP9s7TnI3bxPYYM/t6l1xHEx/ARZvPVDZZXiS28HhVjokMT8L
         C/AmhzogK4YVADlvOLp6zZpxSrK0oXTk2Wyo8ngs/zRfpv9qxe/Ofch61mG2cQ8oZDX6
         ZJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkM0/+Y2mDTWRWvyb1EfYEosGBa2XCe1MpHMrOCqACs=;
        b=pv9gKvB1DLdr1PU8WI3wJqqCXGNmdvR6SaTRHtjBWA0rgBV7cTFa5bUc1UEnizLUB7
         BfgUCy7fQv6z9pzRU5hGYAyAdzRpjwDJIeccsXRDKO/HjKAVyk1LNt263+MKvWHJ9l1d
         PFlbN1kY1i8/PNZx81OAEiBnOJr5HLy2U836+oNiJx0hF+YNEQJMOuFP8akvc2h8p6JB
         +moBSsoI0/LlJVJdqG2sIGsfiHM6BFvBTtbcI/3twwtxlKjbO58+dL8NfnEm2B8qGgRg
         WeRf1+kw33v4EF8QHgY0nKjKrYCBR8y2Qi0zdBC52eBp5iqD6AATfvdSweZkjPpfOTdO
         yNJg==
X-Gm-Message-State: APjAAAUAQykhknJpQucGfCUNxTa21b3BIbGfQum+l7Hv6D6aDIXe8l1p
        v5NGBdr2Lw3SjCVviGFaLHcM6rSe4rU81ET3vG9jvw==
X-Google-Smtp-Source: APXvYqwqmW7K+YRAv/jeZfMAYfAGHtHSP+nnNJ4VnkYeEMfCpom4R1Lx1FjpN+hjQApZV+HFHvgf/yn0v6vmuNYbGmo=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr9060553ljm.180.1561465617100;
 Tue, 25 Jun 2019 05:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190617215458.32688-1-chris.packham@alliedtelesis.co.nz> <20190617215458.32688-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190617215458.32688-4-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 14:26:45 +0200
Message-ID: <CACRpkdbSS18us3o=v7ki_=8cLXYjfDd8q321xMCounXPh11GAQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pinctrl: mvebu: Add support for MV98DX1135
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:55 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> The 98DX1135 is a switch chip with an integrated CPU. This is similar to
> the 98DX4122 except the MPP assignments differ.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Patch applied.
I just assume this one has no dependency on the clock patches
so I can merge it separately.

Yours,
Linus Walleij
