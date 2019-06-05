Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE8C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEFA20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnC7DlOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfFEHbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:31:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36707 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:31:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so1138952wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IWnG5mk+FSYYj2lHa0zQw85I3E1T6olPRsvdmWWZtDA=;
        b=LnC7DlOAeqIU6jCar36+vJfnaBNJe7XDi+C9PTCBaCI6KbsqmLbikd0R4ff2IsEJrd
         KXDU+/9i/2/3H1156mWXbRspGIKTixZGHqqBSfwvQSbknV1dXCvlxMJcXa0bwG95q18r
         Dvn1fLNcMEz8cnM83vCka5cC2NsTRflgoRIxCS58wYgGh6EIKIFolkHw6lC0zeqHhwoZ
         C5WhuwIxioR/vJCvvBa8ptAsN2IQYEGK+45vS1tGxq2gI3LCo/PkEGHyPvTx+LBX3umY
         i8BcoGDi3C3mbCMjmj75qj+L1JYcTf2IkZtDp57NqjuyLaG2qdUm2YtKhyXE/eHv5cxy
         4zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IWnG5mk+FSYYj2lHa0zQw85I3E1T6olPRsvdmWWZtDA=;
        b=YEnPU263w+kpBJrnqqAjF3quJQUW10+BGcC7s+OADBggmeZZlHrlLap7X33LwK4MG4
         KyrgfVbkBVOXqMpEC5prgMYAj3xSi2bhgcaSJND3v1wmzHI9sGioGFzyccOGacuCKE2j
         s9STZhvlWfHWzG7536UIvOl7Zwhj9EgpY+0MgH7z4YiTUpG/Qti3BUyDId5FvK6YY2pc
         rZcloa/bHgYdPbof/0qIu7x5L7zUeslLRawWVEDJlV2yBfec+KTd1LSDhjuYJU6o9FC9
         aPtnJJR60DlR3cbtR5pj872m34ubGQTNEChKZTiKiqk2ZCXhgzE6CEbe7nnbc2IhCVco
         UKWA==
X-Gm-Message-State: APjAAAX8Yvdu3m67nRLmakaUzNach84Ef+/h+a1UEqxO9/E5xJsQWWTf
        sdKcKO5hbaxcy75n9P021YUKHQ==
X-Google-Smtp-Source: APXvYqyCnKW0jfvwBVA6aJcAK6VfcLrnJuvLPQVDIWk0oxlDsnBP0uEq+gISa827spE4AsPpgFfkTQ==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr14401084wmc.62.1559719896073;
        Wed, 05 Jun 2019 00:31:36 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id u11sm13722491wrn.1.2019.06.05.00.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:31:35 -0700 (PDT)
Date:   Wed, 5 Jun 2019 08:31:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     alokc@codeaurora.org, kramasub@codeaurora.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Message-ID: <20190605073133.GL4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-4-lee.jones@linaro.org>
 <20190605061721.GK22737@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605061721.GK22737@tuxbook-pro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Bjorn Andersson wrote:

> On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> 
> > This patch provides basic support for booting with ACPI instead
> > of the currently supported Device Tree.  When doing so there are a
> > couple of differences which we need to taken into consideration.
> > 
> > Firstly, the SDM850 ACPI tables omit information pertaining to the
> > 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> > initialise any of these lines, the firmware will restart the
> > platform.
> > 
> > Secondly, when booting with ACPI, it is expected that the firmware
> > will set-up things like; Regulators, Clocks, Pin Functions, etc in
> > their ideal configuration.  Thus, the possible Pin Functions
> > available to this platform are not advertised when providing the
> > higher GPIOD/Pinctrl APIs with pin information.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pinctrl/qcom/Kconfig          |  2 +-
> >  drivers/pinctrl/qcom/pinctrl-sdm845.c | 35 ++++++++++++++++++++++++++-
> >  2 files changed, 35 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> > index 2e66ab72c10b..aafbe932424f 100644
> > --- a/drivers/pinctrl/qcom/Kconfig
> > +++ b/drivers/pinctrl/qcom/Kconfig
> > @@ -168,7 +168,7 @@ config PINCTRL_SDM660
> >  
> >  config PINCTRL_SDM845
> >         tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> > -       depends on GPIOLIB && OF
> > +       depends on GPIOLIB && (OF || ACPI)
> >         select PINCTRL_MSM
> >         help
> >           This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > index c97f20fca5fd..7188bee3cf3e 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > @@ -1277,6 +1278,10 @@ static const struct msm_pingroup sdm845_groups[] = {
> >  	UFS_RESET(ufs_reset, 0x99f000),
> >  };
> >  
> > +static const int sdm845_acpi_reserved_gpios[] = {
> > +	0, 1, 2, 3, 81, 82, 83, 84, -1
> > +};
> > +
> >  static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> >  	.pins = sdm845_pins,
> >  	.npins = ARRAY_SIZE(sdm845_pins),
> > @@ -1284,14 +1289,41 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> >  	.nfunctions = ARRAY_SIZE(sdm845_functions),
> >  	.groups = sdm845_groups,
> >  	.ngroups = ARRAY_SIZE(sdm845_groups),
> > +	.reserved_gpios = sdm845_acpi_reserved_gpios,
> 
> The reason why put these in DT is because the list is board/firmware
> dependent. E.g. the firmware on db845c does not support the peripherals
> that sits on these 8 pins and as such these are not reserved.

If we need to be more particular about which platform(s) this affects,
we could add matching based on their differences (some ACPI HID or F/W
version/descriptor, etc) as and when we enable them for booting with
ACPI.

> But given that the two structs looks identical now, did you perhaps not
> intend to add.reserved_gpios for the non-ACPI case?

Given your example above, I think it's best that we let the
configuration tables advertise these in the first instance.  I only
add them here because it is not possible to obtain them from
elsewhere.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
