Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223DECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1A02089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blO4zlD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfIKJ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:29:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39866 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfIKJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:29:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id l11so15867601lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meoyF5qnG1EbOZhPqlVN2+IiExXsiF/sJ/BQgZ1twjI=;
        b=blO4zlD2kpj/8/v83jVkDYzwy/DXX2v+pWYr4ZysLvhmiPcDuXpCjOELy0K6cPbbn9
         PiJe1ObQU3MpmlNHhUm1/2yhq/++D7dAEH1evQfJ/NXRSYeMG74G+yHOJEivgjVKBR/g
         9VbTPqwbXk+V6n/gJ6fSbWfWvquIaEIzWeOlEaF2kAIeIJSklsoktwxpBHncLz+Flb0X
         DXOj0b7DdhqyW++P/hbwgvrE3+4tNpTftDM1ffmOOspcPY5QRQPG6Bl8TlP/8UbMHdfn
         LkshNjdIwBAxjKNDblUx0ex684BdzoLtfsOyaqHRxOP5WFspRavgJ+4pIDoOT1Delae7
         W0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meoyF5qnG1EbOZhPqlVN2+IiExXsiF/sJ/BQgZ1twjI=;
        b=fNI1t7rt8iYDy/tO4LH6zTFPYmoIetD3oPaa0M01KRYNtkt2Q7bXGRwRa6VJR+xgi+
         RBguOQrb95IWSW2o9bzoUaKJSXcG3sepRCv8VOxxg5jjgu4XlxEFfcyxhP5Ukri9k37Z
         k31lbF9Qrf9Y1WTjAfNGTeRq8/V3t8e0A8TTfyUgcZm6u8h8/vC/jKlpT33kOVba0zdO
         HXYWwNjKg8Hv3cTQWpJSriGSjvztvVIOSWY4K8aFivBNn0GmIKjDIcnV53cOfPJYmmTy
         rmpYzCAB7X8B/HGBGXJLFNSa7OHAL1/+51b6wP5egVFLGoNNbtpujM1/EgCvytjAl6D/
         trig==
X-Gm-Message-State: APjAAAX0CW7kV8ZTK2NEmCBuJh/Qkfn1GwReydS4r4sPdu3QfT1QyBnI
        /AJnSHx2TxTFCJkjhlXD9R67NkqlXg1CjELjb1f7sQ==
X-Google-Smtp-Source: APXvYqzOYZehJ5Xw3MxFgYRqFUIZbXMNBMiPJdnrux4Wxk8zVbXjZTviaBEscQ9wTzhD2drdfEvrsRgqL7YT5XRozlU=
X-Received: by 2002:a05:6512:25b:: with SMTP id b27mr24506530lfo.60.1568194164645;
 Wed, 11 Sep 2019 02:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <1567662796-25508-1-git-send-email-light.hsieh@mediatek.com> <1567663210.1324.3.camel@mtkswgap22>
In-Reply-To: <1567663210.1324.3.camel@mtkswgap22>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 10:29:12 +0100
Message-ID: <CACRpkdY7Vpy-fBHSXnjby0kK_tDWBtZaCwjCGxFy4HWeJ1FgEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pinctrl: mediatek: Check gpio pin number and use
 binary search in mtk_hw_pin_field_lookup()
To:     Light Hsieh <light.hsieh@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 7:00 AM Light Hsieh <light.hsieh@mediatek.com> wrote:

> v2 is the same as v1 except that commit message is corrected according
> to Linus' comment for v1:
>
> 1. remove Change-Id lines
> 2. correct sysfs as debugfs

Looks OK to me, but i need Sean's review on this, Sean?

Yours,
Linus Walleij
