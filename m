Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE498C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CE320663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sA7zUsLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfILJR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:17:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33317 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbfILJR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:17:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so22906181ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szvOgaSKQHuR91dwCdpTxKgQS8xunWLLdcGGO0krnL4=;
        b=sA7zUsLieMzsUVFjX2+urBr0+1oZ9bvhGRHA4G0cboyuuO3Y0mq+djLeDOwM0jAPY4
         /QNlB9igugVuoWRXJRNqk4JkA9GyMlt0oRVwCZo+/fm0cn6IFuMcU30YnHCJLopTFQqP
         EW8b1fGL078UUPetpRD6ZnYfylArrpW1c6mqvxdiMyE+k1g1tk6KPkC11hwPTtzJ9WsU
         Cg9K08Wep9/wMuKC5cmgo0iE0qOqEnvACztRLP90QbET4V/YHOZeiJvgxXL+TDeQYoHd
         C/sGr9e//liFGE+rDfKNa0KlqNI808auphGPLR8RhaQFbgU3KGv8Yv+BC1uVses4g8xU
         t7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szvOgaSKQHuR91dwCdpTxKgQS8xunWLLdcGGO0krnL4=;
        b=fPc/Yr8/8IKQZyhHnTRX3a/4o/wfJWxUo7xtLxA8VuOnAzjGsID6AjDACGt1uutAPO
         //F+6AW8zqTh7BglOOCpRcjEXUTj3FrtEpw2Ai+EZgjJKS4//hl2vZgooboKAmulPERI
         r96sXjy9Eu7iMfCexbR3/sRBzO4V8mGOlIXjGd6icJoaj5xoLNOCfo2vbAetMbxxG12Y
         rQUx8NwHUNAMfsIBmNMBc8DErWWKL2MG1dEP8FTkMk55z2zBuzKWtaKeUNaJUg3JBYby
         zRpQP8hE5TWKp+52cAn7T21yis2uBBJVslUOdyWCHyVaFi8bW4ark1v2srrbfek8DcZb
         e/ZA==
X-Gm-Message-State: APjAAAW5dxR7zFMhIdu9gxlK2o5/XpS4a9TCGupefYDDqUi+GPe35t2b
        4WU6ovpLYQ8Gl9CPfE0O8+tNEb2ZmM3hht5MWUDlvA==
X-Google-Smtp-Source: APXvYqxL+8XFoDpn8Dd9sc3WWzP6/eBNJgZM935Fj7SoXm0Pq+8cYMp8gFoV2ij+afLEJn83FenUjyZivw8vujXDIuM=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr22302607ljj.108.1568279846715;
 Thu, 12 Sep 2019 02:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190910152855.111588-1-paul.kocialkowski@bootlin.com> <20190910152855.111588-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190910152855.111588-3-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:17:15 +0100
Message-ID: <CACRpkdY40PZc9R-yFwooR4-WMgn3LH7K+yTx00ZNxyq6OOnw6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: syscon: Add support for the Xylon LogiCVC GPIOs
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 4:29 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> The LogiCVC display hardware block comes with GPIO capabilities
> that must be exposed separately from the main driver (as GPIOs) for
> use with regulators and panels. A syscon is used to share the same
> regmap across the two drivers.
>
> Since the GPIO capabilities are pretty simple, add them to the syscon
> GPIO driver.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

I'm fine with this for now, but the gpio-syscon driver is now growing
big and when you use it you are getting support for a whole bunch
of systems you're not running on included in your binary.

We need to think about possibly creating drivers/gpio/syscon
and split subdrivers into separate files and config options
so that people can slim down to what they actually need.

> +       *bit = 1 << offset;

Please do this:

#include <linux/bits.h>

*bit = BIT(offset);

Yours,
Linus Walleij
