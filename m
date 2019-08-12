Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3895AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0624F2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzCOBffv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfHLHYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:24:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35030 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:24:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so10835467wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pwmkS7iU8MzN5slwyQaJSxZdr6GIAFN6W/sXjAIcU0E=;
        b=QzCOBffvYA4M4sQxKjmvWy5k2tl+iEivBNp2oh07KGvVKYytfsHKT7YyKz9ux9mHfP
         lNBb4BpjK13SQyZomtRPsS2ftG0a+jsDwDSpPtDb+5rqNkptMtP0SQaQz1oUHgr/JTgh
         TV4f5V10si/afJRpq3v29uzEePNjb2iNRTVpwkWHbsgatZaV+4ssIhz8c9PkEL4+4Ms+
         QdqYA56WGiDO08GbCA1natKJm1RJB2V2n3Hsl1gZ6QFcYAynU11HCQt/TvKj7EHbRgHy
         5sUaxl3s0hX6yWbJW+jGryDoz6gVH+ICu/o9AvNXVAz135Qw+9jOrk+/dpULDYUq/IBE
         GLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pwmkS7iU8MzN5slwyQaJSxZdr6GIAFN6W/sXjAIcU0E=;
        b=WHKxkd1/2jJOckMlnwz/BJXNjxYB2K0WoFFAjqDqlBtfdWiwH9SLm0Q77eF3nMumQA
         38+wKAC3NGDVYWRh/3vwuD6SDeH7UeHPX4bG8BbjLBLkN3pcJ/JEumk7hvhKnoNB348g
         121iZbhLwwEYfBwtGnc3HEfj/kxmzrTe2O9g+S0wWGJ1cxQqF8X42AivVhehCtDFSiYt
         jfe5yz5ZodnlZsZV//Wl2oG3OsxHnkd2uYhfadRuTHm6FsDvIfP1gxScyWqVpCUTErhR
         smD6ynwf6R8e9ObxShiy5unlN3K8Ys8FY7nptNi/7hfeTyu0E1UVFWQpUttBtX3Sfzf4
         wCdw==
X-Gm-Message-State: APjAAAXcUF3pP5cLIBPpDN65j99YK2RgBLj7hraYXRUTzLCzX6Sb5NQ8
        bU84sUVPSGxm3qcEbimd/NBwUw==
X-Google-Smtp-Source: APXvYqyNsmG7O/tFEv3dHk9dQ4P45YX8pR7VarVADvBbSodU53DtHEUZ+X47uLZr3XqRlm8fhmy96Q==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr27472604wmg.143.1565594649525;
        Mon, 12 Aug 2019 00:24:09 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id e10sm27225008wrn.33.2019.08.12.00.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:24:09 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:24:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 10/11] mfd: cros_ec: Use mfd_add_hotplug_devices()
 helper
Message-ID: <20190812072407.GD4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-11-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-11-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> Use mfd_add_hotplug_devices() helper to register the subdevices.

You need to state why this change is useful/required.

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Add a new patch to use mfd_add_hoplug_devices to register subdevices
> 
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
