Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C624C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAFD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FExPVgWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfKZMRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:17:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41119 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKZMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:17:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so19935160ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 04:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5QyhOqHcLHyB/soUlYt5FDv11OM5DdtmqTnCRv6jT4=;
        b=FExPVgWdtbMNIuXTPIXVc5qOikzvjSuB64a/ScIIZSKl19OwHNQKVYPtkkAlqMwZXP
         j5XDbE9V/3TX3K70QMYPlGQ8FupeV7rNuUDQLuk494Pg+0MILV7n2iCi2v6khecWN+T9
         a9JgwJPPFmXPInR15J9P66L8nnMYrm8uSxrfzVH3NA4poamD2ACpPi+SZ0jQ4lkTMc9E
         xY5tl3JicyvMNramXtTuIAiL72X12FecnsKqCpbKX3owxV3D2KhJOByg40sGlmxPoWQL
         vuwzzb/lR1c3hx9o9LfibGB/3z74EsRFvMeM0Da22dC7m0gNE3IofczV4Y731G2JOHYg
         vnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5QyhOqHcLHyB/soUlYt5FDv11OM5DdtmqTnCRv6jT4=;
        b=ahOD09Y/KdYQ6pVXxlaJKPhXJGYK4tpjOjWKludnyBZZNX5SZ8Ynx0ut84fJHWYqTv
         RFLtpa4nwD4C83GZcvHPxh0XI+1x1vgh42hnJQFGR0sYh9ki1zFg/uFLDXEOPotYZJST
         dZU/R6xHD+iamUxdMFH0CxPk9u5B6nejyMEOakTBSrN1rhZWkesdMVDzP6MCGoTtZK2x
         Fqic8rVR0iW0bAyoJFbizJamDmKZPHbflMycBNL4XlCXXkzs3hR1tMhlQTviTLj2xumb
         XhChXvlU+lv74ckilJV0ZpaqmL3+a/+6uHwuOePn2vWvViEpptFDf++fy9aI4PBBKy/J
         xIsQ==
X-Gm-Message-State: APjAAAX5IK63xWpa/faTR8dPSBCpY8WcgivgLL7x/jh5xeOfoKWbd/Na
        W/VhOzNb2PqSzRt/96Gcqa2uULY8L+yHLhh0VGv4Xg==
X-Google-Smtp-Source: APXvYqyUvqGJTGlKL4forstKqT+EkT3JZiUWQ8b6UX/M2Coqf+nunSw34Afbi8voYdN3pSylpBVhvtHtd41ceJu+itg=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr13958204ljm.218.1574770658404;
 Tue, 26 Nov 2019 04:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20191125170428.76069-1-stephan@gerhold.net>
In-Reply-To: <20191125170428.76069-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Nov 2019 13:17:26 +0100
Message-ID: <CACRpkdZMQft4oY+jrJ1Y8aNm9RSjr_B9dC5ScKbST-vi1ZZ4CQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: ux500: Disable I2C/SPI buses by default
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 6:05 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> At the moment, all 5 I2C and 6 SPI buses are probed and exposed
> to user-space by default - even if they are not muxed to any pins
> on the board. This means that user-space sees an I2C/SPI bus that
> cannot be actually used properly.
>
> In some cases this was used to put the corresponding pins into
> a low power sleep mode - but even then the pins first need to be
> configured by the board-specific device tree part.
>
> Avoid exposing unconfigured devices to user-space by disabling
> the I2C/SPI buses by default. Enable them in the board device trees
> when needed.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

All 4 patches applied and pushed to ux500-dts for v5.6!

Yours,
Linus Walleij
