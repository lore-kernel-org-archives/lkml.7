Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D679C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3C82173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0wLmu+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfEUVe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:34:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37210 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:34:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id p15so9046663pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9ODtUCTlf7QzMg+EFi0fhULa1Hv1bN8saGVoynBnt8=;
        b=Y0wLmu+PpiLo7vUy+T1dLKysSylXSg7NwAOmGwX9MPYG07Y+1uOVcznI5UzVOu0hCF
         p2wF+V53lMgvx/uZ2rLt/OkiKtI0zDZRIR8kqkWYxre5gGeEgxBkUU0sFg0V0dkCJFmA
         Lu3AzdAwwDLllUxNxExJGK/YFL3iCRzH90A5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9ODtUCTlf7QzMg+EFi0fhULa1Hv1bN8saGVoynBnt8=;
        b=RIrfRQLv1ZR1/GMItLDULWwoNKwYjUaq4fvn0XEm3qGkUkV+d+l8ADGrIF63TZOBLI
         W8wf3owdg8ziMiYxJ/HAbkfHJ8KW/TUQjdj8w1+7tbgIXUrj5mwOSps8jfo+zxGG0no6
         gw2QmuRPoX7F6WptplNx8J7Ul/n5rixTKenLJsm8ZrOhuc0b0PyuZjKPsjRtM+aMwqG2
         DA2CvbunCzAPjP8JsKqjFTOxxaGD5ATjBx+pmrikO1x+QzmNJkbnI8HU5nLdD0UgiJkH
         iu+WRfs49PonGS7ayNAhoEV1x/ABZBBM2rzgxgtVoG9mMe+IdxPJNpMNe5fcHBg4T8ae
         3aJQ==
X-Gm-Message-State: APjAAAWK0WgPmPdeOePjuBXMWuOQdm7IFi5Uh+whwH0Rhi4/jzJU4FzF
        S9VKyxfa4xDp7gXowZ/mL0bMBg==
X-Google-Smtp-Source: APXvYqzihHia+iUnsOd86KRdycld+FsIGTxqXQCnCFsb55jp0SddgA52ec+bov96FU2MF9EkB9uLWQ==
X-Received: by 2002:a17:902:21:: with SMTP id 30mr69540871pla.302.1558474466758;
        Tue, 21 May 2019 14:34:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 1sm24868945pfn.165.2019.05.21.14.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 14:34:26 -0700 (PDT)
Date:   Tue, 21 May 2019 14:34:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        ryandcase@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: Add pin names for
 rk3288-veyron-minnie
Message-ID: <20190521213425.GJ40515@google.com>
References: <20190521203215.234898-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190521203215.234898-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:32:14PM -0700, Douglas Anderson wrote:
> We can now use the "gpio-line-names" property to provide the names for
> all the pins on a board.  Let's use this to provide the names for all
> the pins on rk3288-veyron-minnie.
> 
> In general the names here come straight from the schematic.  That
> means even if the schematic name is weird / doesn't have consistent
> naming conventions / has typos I still haven't made any changes.
> 
> The exception here is for two pins: the recovery switch and the write
> protect detection pin.  These two pins need to have standardized names
> since crossystem (a Chrome OS tool) uses these names to query the
> pins.  In downstream kernels crossystem used an out-of-tree driver to
> do this but it has now been moved to the gpiod API and needs the
> standardized names.
> 
> It's expected that other rk3288-veyron boards will get similar patches
> shortly.
> 
> NOTE: I have sorted the "gpio" section to be next to the "pinctrl"
> section since it seems to logically make the most sense there.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
