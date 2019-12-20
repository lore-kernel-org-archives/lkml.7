Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAE2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1609B2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VN0SVFKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLTKwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:52:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42483 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLTKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:52:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so8940361wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zIL1GNLI3fK7aSg6DfMu511CTkd/o54Y5uOn48aAaYY=;
        b=VN0SVFKX5uXsOAdDBxENIoVCMPwSNHINlQXf4fLOv9KuypkjmPtussx6xMViQLfqy9
         eQM+h55AnlLGapsZK9XUa+GcXqT9hkHLAAFiNo6PKnPsB99EyOuwtY29Keo6cgzT3mkB
         NNcJL7GW1UF9oyp3VbqyDODc7lub/M6IYcgssUKjHCcT1DlYZXy1IAQZ6/iC39QTDQp9
         YSAYli2k6iA0mC6D6l7Ayv562uTmxR4B3azfmEt30AGJ/8W+wPLYopwPvHL3oxisjTSg
         1sTW+a2Zzd1hSC8B7QREXhVHm9yvawfae6yyArRiBXBC6JMOfnVScIctd8N7G53ihdNs
         j9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zIL1GNLI3fK7aSg6DfMu511CTkd/o54Y5uOn48aAaYY=;
        b=QlPHKzxg9XTwaXx1pkH+oQx38S7DNK4XzV1jb0It74J6H9GNqeqaQxJgCThzAR0Loi
         HYtqI0uQWUG7TENM2T4VumN1SEcjxbOuvuSd80eMXmVJpj4nlzydHE34Qj0efM/+aQWX
         oTmUO8eS+Yg45cJWKuEhzFLeuv2VvNOiMjPOXoDD0oZY2Js1QIpVYK/4dLN8qaFvrTvi
         u0BjRjPmntaa6cwpMRHLfLQW3EaMmbRLYIr93FFwrScaZaLePn4WOwp4EykH5PSwaddV
         GwBpvNUTJ6QuSV+Z/nZDAJopSG10Vk7VjBoj8kvxXjda1VctrDrs1kJfs2QEU5/Wceyu
         fNTw==
X-Gm-Message-State: APjAAAW535y3x4ThTiXoaj5i2PxU7AmF0iUgI+uZJWWucqAQv/zKcvqq
        AyWTZKYr/vtiFu4Sq5rkaCrPhg==
X-Google-Smtp-Source: APXvYqyTg/20mAwGx72lef4y8wVB4rf1GGq8qaOrVpqYfFM1xDKnaiTQiFAlYd8nPoEhrHgmv0LWZw==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr14929539wrn.239.1576839171568;
        Fri, 20 Dec 2019 02:52:51 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id e12sm9515113wrn.56.2019.12.20.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:52:51 -0800 (PST)
Date:   Fri, 20 Dec 2019 10:52:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Prashant Malani <pmalani@chromium.org>, groeck@chromium.org,
        bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
Message-ID: <20191220105252.GR18955@dell>
References: <20191219201340.196259-1-pmalani@chromium.org>
 <20191219201340.196259-2-pmalani@chromium.org>
 <f3d6267e-2429-e5a0-2a0e-60cab5bb1bb9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3d6267e-2429-e5a0-2a0e-60cab5bb1bb9@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019, Enric Balletbo i Serra wrote:

> Hi Prashant,
> 
> This should be [PATCH v3 2/2]. All the patches in the series should have the
> same version otherwise makes difficult to follow.
> 
> Thanks,
>  Enric
> 
> On 19/12/19 21:13, Prashant Malani wrote:
> > Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> > subdevice on non-ACPI platforms.
> > 
> > This driver allows other cros-ec devices to receive PD event
> > notifications from the Chrome OS Embedded Controller (EC) via a
> > notification chain.
> > 
> > Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/mfd/cros_ec_dev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index c4b977a5dd966..1dde480f35b93 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
> >  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> >  	{ .name = "cros-usbpd-charger", },
> >  	{ .name = "cros-usbpd-logger", },
> > +#ifndef CONFIG_ACPI
> > +	{ .name = "cros-usbpd-notify", },
> > +#endif

We don't want #iferry all over our c-files.  If you *have* to rely on
Kconfig configurations, split this out into a separate cell and use
IS_ENABLED().

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
