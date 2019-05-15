Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A8C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E509520881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEOIXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:23:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35916 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:23:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id a17so2301513qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP615H84n6IE6Q6FG1U3STZfOB3R7X3FbHAi0MN0jTk=;
        b=GkjffArLH9p+1rrCmOme8YPTp4xbJb9PHREloGK58mD+3rD/PdSblsaqzryxkN3CHP
         8ySdGj1iS19kZK3r2wdkcTsvETWBHqYK49O13mNuwuzivKBMXFF02Iw7PfuLxEODj1od
         27/4nJDYalhRtxDEyJw6hj48cb4mqghNe1ScDvAN9gehE5IzPxkOGBf4SvQ0vUAdiHnv
         /N061Pg6DaN1zDBoI/zO+SgToqM6wy36DhMold8PNLkpSfKUm/bJTHONMja/fBY0otxD
         zFTgaLDzV8ExeuzkxPfPCFkagBs6gR2Zu7TwSl8Ji5UPBr+8llbtCwQDWNdYetJRFT56
         I3aQ==
X-Gm-Message-State: APjAAAWTX/WDu39DSDUEdPyNGjwRTeKtxiaUNK2YQHQ3WCxMPFmejid6
        LryeHnKLjUjdSKOOz08/84z28kP4oknsRkoO8JA=
X-Google-Smtp-Source: APXvYqyK2NypWZDZDuqy4iCQfrPIXC0KSagXHDpQjtsbfvdzRNiEUASPWZcKyvBfhFfSJq94bJ+87EODjf30UrRXJt4=
X-Received: by 2002:ac8:390e:: with SMTP id s14mr11359780qtb.343.1557908612560;
 Wed, 15 May 2019 01:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-19-elder@linaro.org>
In-Reply-To: <20190512012508.10608-19-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 10:23:16 +0200
Message-ID: <CAK8P3a3f++abVkXo3eEky5+xx+Jpp3ApFbWfwvh4rekQzpmepw@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: defconfig: enable build of IPA code
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2d9c39033c1a..4f4d803e563d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -268,6 +268,7 @@ CONFIG_SMSC911X=y
>  CONFIG_SNI_AVE=y
>  CONFIG_SNI_NETSEC=y
>  CONFIG_STMMAC_ETH=m
> +CONFIG_IPA=y
>  CONFIG_MDIO_BUS_MUX_MMIOREG=y
>  CONFIG_AT803X_PHY=m
>  CONFIG_MARVELL_PHY=m

Since the device is not needed for booting, please make this
CONFIG_IPA=m instead to keep the kernel image a little smaller.

     Arnd
