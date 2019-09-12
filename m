Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D16C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C286E214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7ayBP5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfILJT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:19:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40038 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfILJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:19:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so22854971ljw.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XH1GfjgGx1T+lc8m5zbu9NzNgidrGg/qrkIcskPP3lg=;
        b=T7ayBP5Vg3v9cuGFY1vpXWdl1so9yzOWC4+NdMgT1Yyof6I60HEplDj+h14Dompc/R
         cYcNBYxpxhSi8OrjNPzMjqO2/zOmOWCpTkUp30qeG7/7dQkMPGzH1xjs/26WLVuazOxo
         IPNhsUEXA/4UnYjEBblr59PoK7VzRkxl2A4SIsOs2+aZESpbonNU+BiRQkbb9elPif7e
         +wtdeAnl8SbqPqIh9lSCPs0olpnwAFmcIFXbNJrBTLfNlxW9mX4xFL9K8TRIhT69omCG
         6NEN9Qvgwun9a6PEoEx7ohPPmxYN+6xvqyTH36HUprKEwgvCh+zgHk7KWP3+H/Ueub+o
         Bfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XH1GfjgGx1T+lc8m5zbu9NzNgidrGg/qrkIcskPP3lg=;
        b=YGtfUMkMAvmkLV2d1WDF0im2uE6li4TBNmIoQEuteMXq9ZwPjq2zoMtXT5W+Rix2em
         DRn36wLsqnX3RURXkZyBnWXlgqhAXULacPL6VlCmeWPt+6TRpWSeDF5piPMf/1NNZ+VP
         TQr8p4OdWXrJFMVMo01gPBvrXurHg3jH5ohI81OANXzy7aoNkzxy/jWRjSJ6sdiyxYzA
         ct7Ong8BvuHS7CTuvcvHpPBUuymXeq21gO1XA+ZrAY4603U5UtqC3coclxmauJnXmYlf
         SMHoRsv2NZETJSdnglclEoAGhNDq6/SM96StsN73w3qCTSEjx6Fzy0pFDDWIkiLFbBIz
         uM/g==
X-Gm-Message-State: APjAAAWINXjNyBV2ncZuMsTC+65TXylbktKScGQ0ZkMyOATbBnbM2yxY
        OV3dG3QDqE6mRCRB5RR8l5UyixiLCyjSKZI0AoFB1Q==
X-Google-Smtp-Source: APXvYqxhJXi/F3ipLiFiLbE8vRwdOajqhxR1cdEYstacX/ZQq77w/50Qgi/Gz2Y6qQIGp2R8NpUOibqCti14EmnW6H8=
X-Received: by 2002:a2e:7d15:: with SMTP id y21mr18815651ljc.28.1568279993947;
 Thu, 12 Sep 2019 02:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190910152855.111588-1-paul.kocialkowski@bootlin.com> <20190910152855.111588-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190910152855.111588-2-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:19:42 +0100
Message-ID: <CACRpkdYrTCnrW6-28+RhdMZ4cB5VcqG6T-5aABvvEgiZ3iri2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: gpio: Add binding document for xylon logicvc-gpio
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

> The Xylon LogiCVC display controller exports some GPIOs, which are
> exposed as a dedicated driver.
>
> This introduces the associated device-tree bindings documentation.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
(...)
> +The controller exposes GPIOs from the display and power control registers,
> +which are mapped by the driver as follows:
> +- GPIO[4:0] (display control) mapped to index 0-4
> +- EN_BLIGHT (power control) mapped to index 5
> +- EN_VDD (power control) mapped to index 6
> +- EN_VEE (power control) mapped to index 7
> +- V_EN (power control) mapped to index 8

This should be reflected in the gpio-line-names in the example
and in your device trees.

Yours,
Linus Walleij
