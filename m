Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E23C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4445218AD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrY8nsGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfEQX6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 19:58:03 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37397 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfEQX6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 19:58:02 -0400
Received: by mail-vs1-f66.google.com with SMTP id o5so5713727vsq.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eU8u53UhGSiSMje2IyjSxqc78UCrxRNCDadIMBeoHNs=;
        b=XrY8nsGDvXJXyRC700yrc0hjfACIdkpMyCBQSK7uMnG5V42FIsUwH7x+Eh7nvTae7p
         e6Qq4CCb4WDoqohJMQccu+Wiu7PJRl/+l3upzZafEKz+yVdsl2xQlB9TePygNV2WRG6b
         67Q0Bbq7el6nkWMdzq1/ATAvrS9ORek0PlUcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eU8u53UhGSiSMje2IyjSxqc78UCrxRNCDadIMBeoHNs=;
        b=MFzykCEhDjO3lhIMZXxm2/j3WkAnbZm8zxJCsPjZOMBwWMlY8gGBXMQHwGynwjUfUg
         kWN8vylX5DpiDRX5Y7ZZVY7041iP9exCwDLvMRDVDUANwJpXmdvoCsIysxnDPHg6zt0g
         vb739deBE0KU3A9PTTJz+OqgYASZ9bjdE1cPsBVkpSyp+0L8paJ34JD3vfbJGV7rh0Xz
         jXw6CAjWyB9nhVcwZeYQmT4noClvc0p5hZorR0NOxNCmUb1gRwKv2tXtm7fGfSdM91vz
         qlqwOaIWIpZLXVVwVcL62VIQvJ5/eJ85IT5HWsMX9R+Q+wvVRzITkns/iXYG/02VmNe1
         B+qw==
X-Gm-Message-State: APjAAAWGV6Lac0uce9YZOR/HfV/I921RuvSF0den7kkIXkiRI9yYnPpp
        tNVJK6nrpI/9QWfDPE1y4ln0MopT2Xs=
X-Google-Smtp-Source: APXvYqwT8QduER8Faz+inmL7EKiQp9lO5F/3e+5jwEvLUZZxQyr3R4SifC89CPihWxeXtqhkUXWadw==
X-Received: by 2002:a67:e8c8:: with SMTP id y8mr18058556vsn.124.1558137481465;
        Fri, 17 May 2019 16:58:01 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id d133sm4682015vke.19.2019.05.17.16.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 16:58:00 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id l199so2494502vke.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 16:58:00 -0700 (PDT)
X-Received: by 2002:a1f:d884:: with SMTP id p126mr1000822vkg.70.1558137479874;
 Fri, 17 May 2019 16:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190507234857.81414-1-dianders@chromium.org>
In-Reply-To: <20190507234857.81414-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 May 2019 16:57:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcF688tSArf5gu0sV5oKVgFEvPBxXm7j-5GXXMP_CYRw@mail.gmail.com>
Message-ID: <CAD=FV=VcF688tSArf5gu0sV5oKVgFEvPBxXm7j-5GXXMP_CYRw@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY
 power on
To:     Elaine Zhang <zhangqing@rock-chips.com>,
        Caesar <wxt@rock-chips.com>
Cc:     Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elaine and Caesar,

On Tue, May 7, 2019 at 4:50 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> While testing a newer kernel on rk3288-based Chromebooks I found that
> the power draw in suspend was higher on newer kernels compared to the
> downstream Chrome OS 3.14 kernel.  Specifically the power of an
> rk3288-veyron-jerry board that I tested (as measured by the smart
> battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
>
> I tracked the regression down to the fact that the "DP PHY" driver
> didn't exist in our downstream 3.14.  We relied on the eDP driver to
> turn on the clock and relied on the fact that the power for the PHY
> was default turned on.
>
> Specifically the thing that caused the power regression was turning
> the eDP PHY _off_.  Presumably there is some sort of power leak in the
> system and when we turn the PHY off something is leaching power from
> something else and causing excessive power draw.
>
> Doing a search through device trees shows that this PHY is only ever
> used on rk3288.  Presumably this power leak is present on all
> rk3288-SoCs running upstream Linux so let's just whack the driver to
> make sure we never turn off power.  We'll still leave the parts that
> turn _on_ the power and grab the clock, though.
>
> NOTES:
> A) If someone can identify what this power leak is and fix it in some
>    other way we can revert this patch.
> B) If someone can show that their particular board doesn't have this
>    power leak (maybe they have rails hooked up differently?) we can
>    perhaps add a device tree property indicating that for some boards
>    it's OK to turn this rail off.  I don't want to add this property
>    until I know of a board that needs it.
>
> Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> As far as I know Yakir (the original author) is no longer at Rockchip.
> I've added a few other Rockchip people and hopefully one of them can
> help direct even if they're not directly responsible.
>
>  drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Can you help direct this to the right person?  ...or should we just
land it and assume it's fine?

-Doug
