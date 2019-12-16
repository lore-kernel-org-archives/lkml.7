Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAACC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20CF206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUl2wU8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPQlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:41:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33873 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfLPQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:41:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so8121280wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wad68DLaXUpd0xmHmGc4hyH7aNMrYmcFPI6lvzyrzXQ=;
        b=ZUl2wU8huzRepFCJe7yB6pF057RW3caVmmRvTKRDOdPECwbEIB0WefXqVHnVyANG51
         g5T22LDlh2yQLNAv708JsGohtDmViR8MgHBxQn/6No0xuswgQ4YrVXCmjytjX67eleE/
         Rp5jkygE9YLzltRq1VkqZtxx5kK4h//PSSw742m0L7HWFdlUHnuEIRaEcjkJ4raUcfEf
         HmrOkebAcd8HbWC4sFmTPedNt2WDm1JwiFfKxlJaij8xugE1B7IIRHaL6KnfDFYpeBgL
         qERcKs/N55IXPtvl60tG6bSo+GEcxPhvEHpnvh0EEp7lhMx+dCHIkAkrvVV+IB7cNeB+
         nl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wad68DLaXUpd0xmHmGc4hyH7aNMrYmcFPI6lvzyrzXQ=;
        b=VVwbpW0nrQ6WnBa5qB0DSKQcrKpJ5+Tm93VRdzVxtLdNeDsGhvgit9I7NYyv7B6HvN
         TilE1SLe9POS7ny0ufZ1996YgVCHHPh/8EzdObYUVvvhMQVTnTfE2gFMx3ea8GNQZwqM
         711fezVufEqwoeOENdaHArBeQmFv41s42IbCcI4qfLmIWEMuLV6d7rfdCiLo177n3uzm
         I4pSWna9OtnHfvWB7oYdRtTs7vK7g7Dk0hRjTKlAjp54hKhlndU1w8WZUqgRePuAceZx
         V8oap1e1oJOFrLNQO1tbH/rbxrTcP0gRNX3q3uBt/84DBwpks9JpbS/hf6n/i+lYUcAC
         xAtg==
X-Gm-Message-State: APjAAAWL8KS9X3Vj1trxsnkYo7uTKSKA5TLXzpJRaB3+/8E6tIvZOpc5
        nKrnaAZREDINjVLGF3q06WJVuw==
X-Google-Smtp-Source: APXvYqwzL/lxHeATvNiqlDcJrYl6wzPRCIG9ji/dIYZtc3SBOtEVGWzMvLG64qHY14Tril+j6sQMqA==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr15126699wro.279.1576514481576;
        Mon, 16 Dec 2019 08:41:21 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id z3sm22137942wrs.94.2019.12.16.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:41:20 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:41:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v6 04/15] mfd: rohm PMICs - use platform_device_id to
 match MFD sub-devices
Message-ID: <20191216164120.GB18955@dell>
References: <cover.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
 <e5998dff02b4e155059f38614191daf32a778a0a.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5998dff02b4e155059f38614191daf32a778a0a.1576054779.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Matti Vaittinen wrote:

> Thanks to Stephen Boyd I today learned we can use platform_device_id
> to do device and module matching for MFD sub-devices!
> 
> Do device matching using the platform_device_id instead of using
> explicit module_aliases to load modules and custom parent-data field
> to do module loading and sub-device matching.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> No changes since v5
> 
>  drivers/clk/clk-bd718x7.c             | 12 ++++++++-
>  drivers/regulator/bd718x7-regulator.c | 17 +++++++++---

>  drivers/mfd/rohm-bd70528.c            |  3 +--
>  drivers/mfd/rohm-bd718x7.c            | 39 ++++++++++++++++++++++-----
>  include/linux/mfd/rohm-generic.h      |  3 +--

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
