Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80704C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5359F21739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8Ir1Y+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLQIFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:05:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45689 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:05:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so6003019wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fxAZfC9vmolZiVlLpMvcqpScZw+v0UnXZ2/3gdD1PQU=;
        b=P8Ir1Y+sa+9qizCrqZ9njBGtZhOlAxadSDlDWqoVv7majgjwz4KLATGq1ypY8Xadx8
         6AvVDfimq5rweOvMWz5Rk9RVH7vyBtxaWMhteVEWZ5XDqguzvk9qEG/+aa6/mEt5wpsZ
         G9OEqbh+GNCSd20GHTQ2L/41fdh6Sv5J9D58dwsMJh5d/5RmJHsNtTzzcJdK592Yul9a
         48K8pY4RgPCGuXdLxq8JFqE/bZXUz1V3qILJdoPmlcATjCAR20tF+YwRhEMBoFf/ACBy
         vQQXkpZM+Oitb5xp1XYO0RcX0+jG0Lm8xKVspfxrifwq7iGKvSGd1KtENhSJARdfLUOg
         Xpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fxAZfC9vmolZiVlLpMvcqpScZw+v0UnXZ2/3gdD1PQU=;
        b=IzJPs/Pfg/DkuABcp5+/JCgXoW8zdanDMUElFXKivXUL2wU+Tsn+cBfhDbe2a8HKGx
         LDdfxgUiX/cKF20WUn4eYpb9VtPA/0H3peXe0YQsM5vmaznIVepYX4gSjxqVFCkWFz3h
         TnMpv2sOs1cinqerCCg2OKI0ubwaTBy4D8nDJx6on9/IDhbV5m4bqm4+b/BExj3TfmZr
         s0RDq8vitOqie8ZyGFQ9adbQFfdPA9Ayu7wLnLp/y43Kyd+KpJBQXl6vWXZv1QLGvVKQ
         Ajek0jAyF7im0utWJ4+hrcBGpXNNOQuOAcd1/qrPZQ+7oWO5mR9KJov4PGLxyRAXnAVM
         OIXA==
X-Gm-Message-State: APjAAAVnkwvbKdwDnnUcUnzJvydyjhSjVGHJ3sDy3YbuvxCaeN1kveEN
        t9+zMYfcZsOdakpBrf1eOo0ZNQ==
X-Google-Smtp-Source: APXvYqzdM1IU1Znt+UOIvBqM1ONjsi0UnVLRZGI/dQjTYSpWTXPuvwYov3WaFnfb+CyufHv8opBDnA==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr4406380wrt.136.1576569909844;
        Tue, 17 Dec 2019 00:05:09 -0800 (PST)
Received: from dell (h185-20-99-142.host.redstation.co.uk. [185.20.99.142])
        by smtp.gmail.com with ESMTPSA id z11sm24880779wrt.82.2019.12.17.00.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:05:09 -0800 (PST)
Date:   Tue, 17 Dec 2019 08:05:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 4/5] drm/i915/dsi: Move Crystal Cove PMIC panel GPIO
 lookup from mfd to the i915 driver
Message-ID: <20191217080509.GH18955@dell>
References: <20191216205122.1850923-1-hdegoede@redhat.com>
 <20191216205122.1850923-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216205122.1850923-5-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Hans de Goede wrote:

> Move the Crystal Cove PMIC panel GPIO lookup-table from
> drivers/mfd/intel_soc_pmic_core.c to the i915 driver.
> 
> The moved looked-up table is adding a GPIO lookup to the i915 PCI
> device and the GPIO subsys allows only one lookup table per device,
> 
> The intel_soc_pmic_core.c code only adds lookup-table entries for the
> PMIC panel GPIO (as it deals only with the PMIC), but we also need to be
> able to access some GPIOs on the SoC itself, which requires entries for
> these GPIOs in the lookup-table.
> 
> Since the lookup-table is attached to the i915 PCI device it really
> should be part of the i915 driver, this will also allow us to extend
> it with GPIOs from other sources when necessary.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 23 +++++++++++++++++++-
>  drivers/mfd/intel_soc_pmic_core.c            | 19 ----------------
>  2 files changed, 22 insertions(+), 20 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
