Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70176C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6D4214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tG0A6dG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHLHZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:25:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33831 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHLHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:25:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so9962457wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tXk2RW16lQ2ByKWP571LcOH/rEVKPhvpFkOpaKcZwDQ=;
        b=tG0A6dG9qOdEGSl1oJwMiWG1aNxgFj5NfRvt2j61VyL1rtYkMWnXJQGI2qxLkY3zCa
         JOCjUgAxdBjQ8MkDVbQ7iM+5lMk/0gIEbEQ7vjw8cbiKb+5xqgRomEUKjjXAhmiSTIPt
         ZMePKlCMOg4LTLGtgfRpfOR3936CIRQHzcSYBGmYecjoMegi+5C8v4KjuXlnVSJsihCz
         mTfdgjikOMK2W+KULEIsO54AKWcgKWfN0Ya1VNWgcVKqufW46m64rzII3FSJfq/pg/3j
         0G6wL+VAdkFjt40PaykNwIIDnOgHOaiRR+imjya3As5+HNOlj88JeGfZI6OMfSDXX58G
         484Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tXk2RW16lQ2ByKWP571LcOH/rEVKPhvpFkOpaKcZwDQ=;
        b=riFrDEYXFFANJxLTONrf3PARF2m2WTv7YUDyzTEkXPxYNazIxx6AoFF9GIEm6IX+Wx
         V/PhU88UXjlsVD0qrWqdzhWfoe8JePgxJ4bjuqb5tDcjbPHRoPzw6no7NA0k2cJKsAMk
         P6RxqBj1WD4qoy8nucZk1M04PMfmVFVozAUcT4yTCnrON0j/l91btbTl7SoKJH9C84t/
         vthXifFKOs2JzAHt8sQYdSPRLB1xRLwxoHxIFRG8A0Y+rLu/K/amz46Xqu7lqQuXM4Ys
         8YSMyLNnmOFMPqKk3rFfDOn9pUKrzue47kAErCWv9IHfWMrSxXO5P8wAXBFZ+ntjKaKT
         Mhlw==
X-Gm-Message-State: APjAAAU8Nom4kEP99uRdxPGd9H429CYyS8uL6wgVWyR/5Y3cYBWkLtmg
        S1RxqvOVKbQuRIiDA2TdYUHa9w==
X-Google-Smtp-Source: APXvYqyye4ZANQ/TT7kn4h6lyWtqwqPX4Wr8h5VYWc/qTw4GvLTxaxVrK80w5k+/r+4R5ao2ZuI5rQ==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr1487403wmm.75.1565594742463;
        Mon, 12 Aug 2019 00:25:42 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id l62sm7118863wml.13.2019.08.12.00.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:25:41 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:25:40 +0100
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v5 09/11] mfd: cros_ec: Add convenience struct to define
 autodetectable CrOS EC subdevices
Message-ID: <20190812072540.GL4594@dell>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-10-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722133257.9336-10-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:

> The CrOS EC is gaining lots of subdevices that are autodetectable by
> sending the EC_FEATURE_GET_CMD, it takes fair amount of boiler plate
> code to add those devices. So, add a struct that can be used to quickly
> add new subdevices without having to duplicate code.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Use mfd_add_hotplug_devices helper (Gwendal)
> 
> Changes in v2: None
> 
>  drivers/mfd/cros_ec_dev.c | 131 +++++++++++++++++++++-----------------
>  1 file changed, 73 insertions(+), 58 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
