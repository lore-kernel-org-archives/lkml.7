Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B6FC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04AB20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 19:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGNQhr7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFETGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 15:06:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33068 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFETGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:06:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so12939542pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6BGDN2AyVfgjLFK/UIuQsI5QieCC/mU2xEW0eQBY6c=;
        b=NGNQhr7s+dSXGA0agT49GCRMN5IBD59uXz3hQDX1aXq4lMe5N67yu52ciH/CgRwHUP
         oaU5ZJ03dVccEINZLKm3W1zobHhPMqR//HHdjiAQd1g8hmh0CtDIW5Y1pTk1IbY2IaO1
         B/VPli8Q2TMnY+VKcvSXoK9/vA/peszAGu4EYmGzokB+0Rl+59FpTDynelw9pT15L2jK
         5YCE0Ph6aJcwVoI4t3kz8ujggXCUBpUiYs69ebmhnQtTVw6y9DWv7/bp2SoKFq5ORurU
         jdB4W+mLQDd8lH8tQIlNHznVWVhnupC3IELyc2LldxJmHthhy8vWRQMMGjYpHQ8rWlau
         Y+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6BGDN2AyVfgjLFK/UIuQsI5QieCC/mU2xEW0eQBY6c=;
        b=JwaUTbni5+cKuKv0ICU9aLuDpHTcuyxdBThMrEt3sikDtX2Nr+bPhmaICSlAZ0y9Fe
         DQN2oJ4glBcv7n/Bg+n/I0Q0vAkFZodzCKe/xk/q2fRVsfG0EJStFS4L6FDrZg6lngbi
         EmJ2OdGs9n2R0BvHbBZJsxZcZHm9ZUjt6OZgeBzfF8PBvU2wDhxXdrZmgIa6BTu9zGoY
         4RU0RHLx23Jczo6f1DZSJBPDKAHe+FopUw/x5Fx2MBIJcVh+MR+7qcf33z96TaXQc6eH
         ZnHaT1XZgJ4JqIz0FbnITP8iWhv/4mEfP6e5/e96upLQMCWzUi3JpuKaIMMeo46mn2Mb
         5o5A==
X-Gm-Message-State: APjAAAXfvSgCskJAoiS02RZ2Z609OJgLQkav5Ry9fjyVHrqplF2qXas8
        pWZDE5q/E6wuCDOYlbWYsk59yw==
X-Google-Smtp-Source: APXvYqzlT/XPvgcF1v+ffkfX/JPoo7GvSAjnePPEFFPhNx56Xy63K3pCAsqBkSIncUTmupa3p3kRtw==
X-Received: by 2002:a17:90a:9308:: with SMTP id p8mr44957549pjo.12.1559761577409;
        Wed, 05 Jun 2019 12:06:17 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q4sm19489811pgb.39.2019.06.05.12.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 12:06:16 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:06:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, kramasub@codeaurora.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Message-ID: <20190605190614.GI4814@minitux>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-4-lee.jones@linaro.org>
 <20190605061721.GK22737@tuxbook-pro>
 <20190605073133.GL4797@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605073133.GL4797@dell>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jun 00:31 PDT 2019, Lee Jones wrote:

> On Tue, 04 Jun 2019, Bjorn Andersson wrote:
> 
> > On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> > 
> > > This patch provides basic support for booting with ACPI instead
> > > of the currently supported Device Tree.  When doing so there are a
> > > couple of differences which we need to taken into consideration.
> > > 
> > > Firstly, the SDM850 ACPI tables omit information pertaining to the
> > > 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> > > initialise any of these lines, the firmware will restart the
> > > platform.
> > > 
> > > Secondly, when booting with ACPI, it is expected that the firmware
> > > will set-up things like; Regulators, Clocks, Pin Functions, etc in
> > > their ideal configuration.  Thus, the possible Pin Functions
> > > available to this platform are not advertised when providing the
> > > higher GPIOD/Pinctrl APIs with pin information.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/pinctrl/qcom/Kconfig          |  2 +-
> > >  drivers/pinctrl/qcom/pinctrl-sdm845.c | 35 ++++++++++++++++++++++++++-
> > >  2 files changed, 35 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> > > index 2e66ab72c10b..aafbe932424f 100644
> > > --- a/drivers/pinctrl/qcom/Kconfig
> > > +++ b/drivers/pinctrl/qcom/Kconfig
> > > @@ -168,7 +168,7 @@ config PINCTRL_SDM660
> > >  
> > >  config PINCTRL_SDM845
> > >         tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> > > -       depends on GPIOLIB && OF
> > > +       depends on GPIOLIB && (OF || ACPI)
> > >         select PINCTRL_MSM
> > >         help
> > >           This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> > > diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > > index c97f20fca5fd..7188bee3cf3e 100644
> > > --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > > +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > > @@ -3,6 +3,7 @@
> > >   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > > @@ -1277,6 +1278,10 @@ static const struct msm_pingroup sdm845_groups[] = {
> > >  	UFS_RESET(ufs_reset, 0x99f000),
> > >  };
> > >  
> > > +static const int sdm845_acpi_reserved_gpios[] = {
> > > +	0, 1, 2, 3, 81, 82, 83, 84, -1
> > > +};
> > > +
> > >  static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> > >  	.pins = sdm845_pins,
> > >  	.npins = ARRAY_SIZE(sdm845_pins),
> > > @@ -1284,14 +1289,41 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> > >  	.nfunctions = ARRAY_SIZE(sdm845_functions),
> > >  	.groups = sdm845_groups,
> > >  	.ngroups = ARRAY_SIZE(sdm845_groups),
> > > +	.reserved_gpios = sdm845_acpi_reserved_gpios,
> > 
> > The reason why put these in DT is because the list is board/firmware
> > dependent. E.g. the firmware on db845c does not support the peripherals
> > that sits on these 8 pins and as such these are not reserved.
> 
> If we need to be more particular about which platform(s) this affects,
> we could add matching based on their differences (some ACPI HID or F/W
> version/descriptor, etc) as and when we enable them for booting with
> ACPI.
> 

You're making an assumption that all SDM845 (the platform) devices using
ACPI will have this list of GPIOs reserved for secure firmware to use,
this is questionable but I don't have any better suggestion.

But you do this by adding a new struct msm_pinctrl_soc_data
sdm845_acpi_pinctrl, specifically for the ACPI case. And then, on the
line I object to here, you add this list as the list of reserved GPIOs
for the DT case as well.

> > But given that the two structs looks identical now, did you perhaps not
> > intend to add.reserved_gpios for the non-ACPI case?
> 
> Given your example above, I think it's best that we let the
> configuration tables advertise these in the first instance.  I only
> add them here because it is not possible to obtain them from
> elsewhere.
> 

Then add it for ACPI only - which I still presume you intended to do by
adding sdm845_acpi_pinctrl (which is now identical to sdm845_pinctrl).

Regards,
Bjorn
