Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4121C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E2320820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsLIzWzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfFXN61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:58:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50290 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfFXN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:58:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so12930393wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dpx8eoth7x4E7nkBTHqR/s25K085a3E8QHOn27Jqw80=;
        b=JsLIzWzD6wkDp5TMTAUmAnHpY8eNIOl+XUOCLqavjXH5OVKh1XuMXekmger1K3gZ1K
         bdOOjrO37X5KPmOpWA0a+a0pEQiUVcmDhWSpd8Cgy19Jy13aJCAyiqxa03PHjtKVF2ks
         /syMmAmvIZcG4ORqXb5aqmKrOyd8gwYPSu5ITO7kpaR7TN5wflwzSc6IBPfutH9i9L6Y
         ZT63XBR+09iHJlAG/d+YjfXqtOuhUaIQLuXZKic10ywj/imx4ertPa79XnzJnkYwNxNz
         MMALXyGbN1cpi9tGPXHLk5+qO1FtUuC2DVL6OZz9QbBa5iVVrCJFMVXX0Y0IjTCTl0Mr
         eW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dpx8eoth7x4E7nkBTHqR/s25K085a3E8QHOn27Jqw80=;
        b=CCf0t8IwsTIRT07SXKKVSdV+HO07MWsBG8iV/eZ+HpWWn4jIfB9F4bHw4ToR8bYAF/
         fICZSUbMouvzJjBq0uaA+ol/zQWxH0g6nA6dBtA/PLXeZrmhLwtOpbfMgAs1H7O4/8Le
         +I6iifR9rBumZW5NcrSMPtaDFceYhASB0mxdzJrbS9GNiTaMAzMkGJQtjEhgkPAVVTGY
         HoIXjhT8Dw0N/Z8wlgJLQsOhS7tqTeM/8rmcdj9V85TvAdTzZtO7hrSsc94xdM8SnslV
         vT/AFxercKluk/ZNCapivGBn98qWTXqmqF/D4VyeYgbYgn66CfGJnMP2zFfF2u2tCA9a
         +h3A==
X-Gm-Message-State: APjAAAWr4ZpKnJd7puFkUFOXZBJjx+uiIH8MplmDBXeNmWqCuGg7J2r/
        AOU9Vh9jgux71pRXXQRedyjqqA==
X-Google-Smtp-Source: APXvYqyr1aVwE6ahr5d4wM6jmOAxIcqIWZ1NKs/ulfp1rdW/HdhuqnOJDo8LQ+XMLNkq9CDliY4ukg==
X-Received: by 2002:a1c:ca14:: with SMTP id a20mr15608501wmg.71.1561384704646;
        Mon, 24 Jun 2019 06:58:24 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id n14sm24974398wra.75.2019.06.24.06.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 06:58:24 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:58:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice
Message-ID: <20190624135822.GH4699@dell>
References: <20190611071236.171518-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611071236.171518-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019, Gwendal Grignou wrote:

> With this patch, the cros_ec_ctl driver will register the legacy
> accelerometer driver (named cros_ec_accel_legacy) if it fails to
> register sensors through the usual path cros_ec_sensors_register().
> This legacy device is present on Chromebook devices with older EC
> firmware only supporting deprecated EC commands:
> - Glimmer based devices [Intel SOC using LPC transport]
> - Veyron minnie devices [ARM SOC using SPI transport]
> 
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v6:
> - Remove .id field in mfd_cell, PLATFORM_DEVID_AUTO is set to auto
>   assign ids.
> - Add support for ARM devices with older EC.
> 
> Changes in v5:
> - Remove unnecessary white lines.
> 
> Changes in v4:
> - [5/8] Nit: EC -> ECs (Lee Jones)
> - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> 
> Changes in v3:
> - [5/8] Add the Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [5/8] Add the Reviewed-by Gwendal.
> 
>  drivers/mfd/cros_ec_dev.c | 69 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
