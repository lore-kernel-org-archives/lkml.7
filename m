Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D73C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F67621874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwA9kUL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfIBJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:40:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfIBJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:40:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so13787921wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iifGZMpQV6Q3Nf2FisGpoD7UwukxL/0AVB68SuFmS0Q=;
        b=bwA9kUL60mjWtPOOWDrB79uuGqR9VnOx5Yr9aCS44l66Uk/PU4luTGcMgX2j+KMwL9
         8Cic5YpYp5busLyPMqZkUBYjfRGw+exRs5PZJfsvu/rWyc9tN9LOHeMBXvjwJy85mBji
         VkydsaCO809MVfGAeYcvB18PU0WlY2gNMHxLl7KaolxXWlkrGpxEnhA8wpBcEnBXSKCF
         k9qWp5VQQ5qpimO8EnZpBEN4wzYxIQKQmBvNUud8RwQObFJYkJdNpVzLrA+8OWpvFKlm
         MDipgDzjbhnEwJD2nRoH20SuYf7dfmzFNJVPivn3dtvMzhN4dQJjoHJxKkKLgBlbUtSP
         RkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iifGZMpQV6Q3Nf2FisGpoD7UwukxL/0AVB68SuFmS0Q=;
        b=KyA7KFxqRXH0u2YA6SLbpaLTQLeX0INRL/gtOB1qiifFsQTrijQVrOaNKRHl23i6IE
         CqZcTPd8XH2I1q7smZgOVaDisa03RkGDZv1tbOErsCcU+M4+V0lJVwE7k/uhOK57OuBS
         +XkFc8g9cJrmzatq19R7KOaKKdcU9uBUEl+VPLlitohFWR125TNTaCqvZXSzFEI2nfgh
         hrXM30U2K8lM06SiSajP+DFIDlLr99tCODCQYBF0TeZXFIRQlxmKtoRsDak1F3KSJpqF
         qOOhf50PVMAQhOWOCa2Mm/UU0/upsAiKUtY9m9aelvmXV5irhmaeQ/uQTKCxnYEOhLAB
         PBNQ==
X-Gm-Message-State: APjAAAUir5/nZ6V3Cy1hRhWpPw9JolZi2lEqA3X37x8doxAd+YTtV6Vl
        QF4MzTPKY0CstqBeLNJh5qJbJA==
X-Google-Smtp-Source: APXvYqxSOUGY9E1wZpKgjkViI6t3D6h4EFwO07OwMRVO+Sk6d4PG7Uu11p4XzMynDLxDlAkEP41+QA==
X-Received: by 2002:a7b:ca50:: with SMTP id m16mr8080701wml.158.1567417225074;
        Mon, 02 Sep 2019 02:40:25 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id c6sm17020244wrb.60.2019.09.02.02.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:40:24 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:40:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
Message-ID: <20190902094022.GK32232@dell>
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
 <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019, Fabien Lahoudere wrote:

> From: Gwendal Grignou <gwendal@chromium.org>
> 
> EC returns a counter when there is an event on camera vsync.
> This patch comes from chromeos kernel 4.4
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> 
> CROS EC sync sensor was originally designed as an IIO device.
> Now that the counter subsystem will replace IIO_COUNTER, we
> have to implement a new way to get sync count.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> ---
>  Documentation/driver-api/generic-counter.rst  |   3 +
>  MAINTAINERS                                   |   7 +
>  drivers/counter/Kconfig                       |   9 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/counter.c                     |   2 +
>  drivers/counter/cros_ec_sensors_sync.c        | 208 ++++++++++++++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +

>  drivers/mfd/cros_ec_dev.c                     |   3 +

I can't see any reason for this change to be squashed into this patch.

Please separate it out.

>  include/linux/counter.h                       |   1 +
>  9 files changed, 235 insertions(+)
>  create mode 100644 drivers/counter/cros_ec_sensors_sync.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
