Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213DE2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaP4sqjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDCJeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:34:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41118 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:34:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id 10so11184712lfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prPszsBbmwx/bxg7QJVv8SOuvVz8wCiO3hqr7mFKha0=;
        b=FaP4sqjVPCf19RWOvn8rzpVad3wejKpMjWkUK4GBAYd/ZJrg8O1K9mXTfRS7xZ5yqy
         ZBqFpuBXgbDGM3MBtxDGF5pFOwJxUbGgTlNfpaWIqVN1XtzJCAHBwWGjEeq0QingUJ7+
         W7pTTQOqRskl7nlgCu1a/7twa2YxYzu3SpDdOi6oKaHDNtEGpYA3BI8mPDSWoXfbgLUl
         /iy6c7721nTLp6wZXhTRrcGudOp6khqIEl9siywwfp1aP6pdVALKOPjvMmFUj8/JUWu9
         nWo7WIUSnKZpY5Bq+KH7/LbUtHBJUbCPw7WOOscjlxJ9ix8DvekXa7cx4m1S5wptuHF2
         vEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prPszsBbmwx/bxg7QJVv8SOuvVz8wCiO3hqr7mFKha0=;
        b=Kej+44BnjUVt6IaF6Xn63P0CYkhY0J4lS60Iclx1ji01jSo+3ePpx8vW5Lgol1Chl4
         CrFg0W2V9sTZ2QfFguk3i7TYRUI91SBTPqE8VLA4Mk6FxAqc32c9FN4Mk3zDY833Izvl
         APiW44mGcDvvynQPg2k2bwlE3BmqyH9UrfJgWCsVKWa8vSVsFaATkFiUs9cFf2n5RXj9
         /HeoiEB8Kk9Mkbko9k/IjcO8d8oPO61RPLzgnk0Vh5j5hXID96g44NQukEHJED4lvDet
         kI3MKclmDeHw6X3QOZIW3LE6Bnc9JyXiFoeMX7egJ4BRq3/5byoU2Xt5tFdUpChF3N5Q
         ZShA==
X-Gm-Message-State: APjAAAWBVMML1Vj5xD80JgObqjHKAYFOk3jjFlk1ttOgELw+GnV9zy35
        UKK46AmmE8WaMlv+QE0RFEwOjwIlVomCAjdYIcehDQ==
X-Google-Smtp-Source: APXvYqz3A2w81l3tWDl41mv0bzAPQFKTn1VRyJj9013G1Vm/llF1IZXBelE287BZCVtMD38Skp1c/NMa/0em8yBd4e8=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr5401278lfk.138.1554284057234;
 Wed, 03 Apr 2019 02:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190312152256.35574-1-icenowy@aosc.io>
In-Reply-To: <20190312152256.35574-1-icenowy@aosc.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 16:34:04 +0700
Message-ID: <CACRpkdY5m1vuJKGJxFhPKyi-h_7F4O32oWuobf51x+=gkSp2cA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Support for Allwinner V3/S3L and Sochip S3
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:24 PM Icenowy Zheng <icenowy@aosc.io> wrote:

> This patchset tries to add support for Allwinner V3/S3L and Sochip S3.

I see there is some review comments on this patch set so I am waiting
for v2.

When we have something Maxime, Rob etc has ACKed, I suggest I merge
the pinctrl stuff into an immutable branch in the pinctrl tree so that it can
be pulled in to ARM SoC if need be (for DTS files to compile for example).

Yours,
Linus Walleij
