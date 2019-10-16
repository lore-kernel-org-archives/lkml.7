Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5021EFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2806521925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFoZ+P9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbfJPM16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:27:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37550 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbfJPM15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:27:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id n17so16398020qtr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiitUgtPHWYB471TBDHiVHPPALR+DVcpaO06JHpx/Ks=;
        b=YFoZ+P9HHoSoLVHZecxRW+Z7+f5LggWJqYiP/+udF6k8cZBRCQRsm8W8AwvIMcyD6J
         zTw6j4UEPKQKVMpk2gJnDJoOksG/VEM42AGDsdK/YZyvHpkkYyC8SKShI7Agk6xfypfJ
         k0nLAPhKyNxQWeYBhOEk7LuzIHr8mqN/lTDSJFSLPoXiSfAlJVCewPyLfZD8+7j+5AAN
         FEY34BuDnOTiVkBk1hYZCoocdavCaQCeBlt8eW+zStBLnFGieKwX13ennTtwM4s0iYje
         F3DBnl5Fg6qyga8kRN1/JGplByRpdSwo3UHi51A8RpphiOx14cymS/FA0PVlTS33uYb9
         KGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiitUgtPHWYB471TBDHiVHPPALR+DVcpaO06JHpx/Ks=;
        b=GYUebov9JiK+ye7bZSwhtnSwtV3hV71H2nhC7O5xHTTqoA5NlX+cSdcN3WHUKkIpMZ
         a5w+ZJMhWgRtVfFFmS/s5/flkF7sn+dbTRy51aGDPWGba2EjmMJNy0td/3wMK0ZJlsR1
         reDZkdqSkZeTC6cxrZ9EfSJgVQIC5QAKBfWfRHkVBNSR3FT9kxBklDKilxXEJ13SKT7s
         LLOk1foLccO/NhI9Qu+wX0KbPVOepZftbhpvpT5Qa0HF+OoFXWjmCq9u0LBPHEMaSPlD
         qcOQt1CCvXIVeNMMSuQxa34xHJmWSgInZyuVCNWF27DpH+SqCkTV4RyGWg7PwdRxq/zC
         OWcA==
X-Gm-Message-State: APjAAAU9IukFqIoCpsdQ85A0SinP2DSDJiulw4Fyx5Dim5UGWZX80blX
        YtlKFLISwXqUkaCO/bub0uypwcER9X8FQOaTXvGbDw==
X-Google-Smtp-Source: APXvYqzDHm0kSmPDqed4NoHcllkNpwqptCmh2deQ0fBpLLPQJG+ftMU1r99mU527MOglkMOMQ/pVQl9DwOdDGZP4UzM=
X-Received: by 2002:aed:2462:: with SMTP id s31mr45321050qtc.40.1571228876746;
 Wed, 16 Oct 2019 05:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org> <20191015173026.9962-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191015173026.9962-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:27:44 +0200
Message-ID: <CACRpkdY3OC675EjZ4PYhYxnk1XWh4EO-a3JJBha2rdBttySUNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: gpio: Add devicetree binding for RDA
 Micro GPIO controller
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 7:30 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add YAML devicetree binding for RDA Micro GPIO controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

First: this looks awesome to me,

Second: since this is kind of a first... could we move the standard GPIOchip
YAML business into a generic gpiochip .yaml file?

We currently only have pl061-gpio.yaml and this would duplicate a lot
of the stuff from that yaml file.

If you look at how
display/panel/panel-common.yaml
is used from say
display/panel/ti,nspire.yaml

Could we do something similar and lift out all the generics from
gpio-pl061.yaml to
gpio-common.yaml
and reference that also in the new binding?

If it seems hard, tell me and I can take a stab at it.

Yours,
Linus Walleij
