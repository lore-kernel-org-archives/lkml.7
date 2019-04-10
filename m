Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F186C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A37204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBWBEGBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDJU7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:59:33 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44714 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfDJU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:59:33 -0400
Received: by mail-vk1-f196.google.com with SMTP id q189so884060vkq.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCbUlbyNjpLsWgLDZUmY8PW7tadTt3ndE3roPVa7Pxg=;
        b=QBWBEGBFLbQDOYfdsycEuQgirVeHWl1KpyMEKG+G5GR6s2Eb2+1DLozlR9HKREM4Lv
         CHWAIM1N7WGTHxsDBAXX/SkWQOt4rdE6vnmUGfKmVMSM71MhUw3MNksVwGAEDUAjVtNw
         vC35Q5/RLlEPFBiXgpI+ZoYvVV5vyfCRu/4kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCbUlbyNjpLsWgLDZUmY8PW7tadTt3ndE3roPVa7Pxg=;
        b=RzEc2bHtMKmkhCH7ImKxILmQPh1zHyRGaGZdyiNtKKO+8JlJCUK9cf7OHX/rM4+uAb
         jnbxCsUwL6L7uJ9HnThTvev+8ULKpB57IW1XWBkKMXotQ0JowiYuVnC7VIv2boWWyAo7
         FmMbukB3QOM8yGrJXanzDv4N8NFVOTRXRfv273ftHrU3INGskPXPrKoEOw+AYqVmatWY
         BCCkBKJqBMl2o0uPCNxtGDb68qLjncnpJAQ36DYK+RQbpKvXYTr2djaovSN+ePO/iPNg
         U4y+iM6JOTqehNEsbRWnUq5VQ+Ac3pPBzdFKJ0mIMvRTJVkc3ANu5M+F7RKhNBrT5hVM
         OJMA==
X-Gm-Message-State: APjAAAVc3iLI71ExB39gi2pKip82TCNWy+baEM6b5ByXgxAt738LtPG2
        BiGqUFFRQ4m0WLZiFslEfY8JNnNEK1c=
X-Google-Smtp-Source: APXvYqzWjD38ASMrtYDpO7df+c210wXke8pumLnGIcbzyAPI58ROw6nkleEjt8ruORkvXFOxMHgASg==
X-Received: by 2002:a1f:9b55:: with SMTP id d82mr25720649vke.9.1554929971442;
        Wed, 10 Apr 2019 13:59:31 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id v22sm1968232vkd.44.2019.04.10.13.59.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:59:30 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id w13so2219147vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 13:59:30 -0700 (PDT)
X-Received: by 2002:a67:1603:: with SMTP id 3mr23862560vsw.13.1554929969566;
 Wed, 10 Apr 2019 13:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190409231405.189335-1-mka@chromium.org>
In-Reply-To: <20190409231405.189335-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Apr 2019 13:59:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U531pq__emY9nXm1hZF3Hp3tGFQQTn0eX17rHYp5nH1Q@mail.gmail.com>
Message-ID: <CAD=FV=U531pq__emY9nXm1hZF3Hp3tGFQQTn0eX17rHYp5nH1Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Add BT_EN to the power sequence for veyron
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 9, 2019 at 4:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add GPIO D5 (BT_ENABLE_L) as reset-GPIO to the power sequence for the
> Bluetooth/WiFi module. On devices with a Broadcom module the signal
> needs to be asserted to use Bluetooth.
>
> Note that BT_ENABLE_L is a misnomer in the schematics, the signal
> actually is active-high.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Looks right to me.  Thanks!

Note that this might enable the signals in a different order than in
the downstream Chrome OS kernel, but it looks like it doesn't matter
in this case since the datasheet for the AzureWave module talks about
enabling / disabling these pins in either order.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
