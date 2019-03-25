Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73099C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OFeRfTYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfCYJyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:54:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33144 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbfCYJyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:54:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so9338689wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aIjqM24c2LO+vY7cm+Vdv0ng2cthwTTr3CbZK+Vjb4E=;
        b=OFeRfTYN8zmSc9/yXPtt3achkb22KSydKR0P+401Jxi5pyFw3BDQBTnZAH+3AG4LKF
         +wRCH0WaDitz4htAWPG28vMhVhlbvHDLCBQ+y24/5uxQlG6lF1b/NU/5KpTehMRsE28+
         RsBAW/AAlCuhmyW2mAr4XdTDuUq4woAWYmPdG21C+A/s32O87wGdz79DJymsS6FqqKZ4
         TbhB3zAoRK4ZZCc0A0JA1Ae5TZSjBoPc8QcnV5a9ZoNSRyJEGe2w1TXb6uaf4cQwOab1
         q+j/T+SdqzZkcImRHpcnJNlBOP6SY5/nkKAcvGTM67aSo3SULUg4yziiUXc8+SxPMKmP
         Mgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aIjqM24c2LO+vY7cm+Vdv0ng2cthwTTr3CbZK+Vjb4E=;
        b=eR7Gtb4Z8FPD2kFqgVMRScwWyEPCluAtvV954hWHQ9VwYRppb2N6bkYLbFzIBPfAGl
         hebUtKGJEzAr5b734iD4EMMSLPNYZoXUxWzOIrIum/H7YeDXjJivi3bxDOm55dKai7ld
         bpcH0UDa9VuCcXI9UgQBEktupvFffwGWDn+g150/BwuVJ1SybrH9wdW0tLJWsG1IknBe
         kxKSzWl7DDBAUFjqrP13T4slkOWhLOrMQnLNkdYvHwzBpRdMN3iDl8uxqh9qzUYs0nTm
         QrFQFE9ZuFhg6DB9Ii5S0bSYmMlXj6N/e3JqVB++8pPhSVL+3akTGQaXaLPkDpQqWBAs
         dC2Q==
X-Gm-Message-State: APjAAAXgM93WButqwvY+NfpttG5K0U8LkskBZAKRVb9iRdblE8YxqUVu
        zPGdDlbZhtHUaX0y/UPkD2uNPA==
X-Google-Smtp-Source: APXvYqwCctG5WqwtJOCuczYlgOhzvTAx5K7iS6oR8G78Hc8qzc66b0TY1jTBOZBV4UIhm2PZF84D+A==
X-Received: by 2002:adf:f451:: with SMTP id f17mr11398539wrp.272.1553507690860;
        Mon, 25 Mar 2019 02:54:50 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id f128sm29137484wme.28.2019.03.25.02.54.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 02:54:50 -0700 (PDT)
Message-ID: <2cdcecddbadc41f6e94876c519153f071738f272.camel@baylibre.com>
Subject: Re: [PATCH v2 0/4] clk: meson8b: add the VPU clock tree
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 10:54:48 +0100
In-Reply-To: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
References: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-03-24 at 16:11 +0100, Martin Blumenstingl wrote:
> This adds the VPU clock tree for Meson8, Meson8b and Meson8m2.
> The VPU clock tree is slightly different on all three SoCs. The details
> are explained in patch #4.
> 
> Meson8m2 requires the previously unsupported "gp_pll" PLL. This PLL only
> exists on Meson8m2 - Meson8 and Meson8b don't have it.
> A separate clk_hw_onecell_data is introduced for Meson8m2 (using the
> compatible string which is already available) to account for this SoC
> specific clock setup.
> 
> dependencies:
> This series is meant to be applied on top of my other patch from [0]:
>   dt-bindings: clock: meson8b: drop the "ABP" clock definition
> 
> changes since v1 at [1]:
> - fixed typo in the subject of patch #2 (spotted by Neil)
> - collected Reviewed-by tags from Neil (thank you!)
> 
> 
> [0] https://patchwork.kernel.org/patch/10860387/
> [1] https://patchwork.kernel.org/cover/10860401/
> 
> 
> Martin Blumenstingl (4):
>   dt-bindings: clock: meson8b: export the VPU clock
>   clk: meson: meson8b: use a separate clock table for Meson8m2
>   clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2
>   clk: meson: meson8b: add the VPU clock trees
> 
>  drivers/clk/meson/meson8b.c              | 422 ++++++++++++++++++++++-
>  drivers/clk/meson/meson8b.h              |  12 +-
>  include/dt-bindings/clock/meson8b-clkc.h |   1 +
>  3 files changed, 433 insertions(+), 2 deletions(-)
> 

Looks sane.

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

