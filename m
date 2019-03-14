Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32120C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BF521872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyDVSQtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCNR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:28:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46352 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCNR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:28:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so5322140lja.13;
        Thu, 14 Mar 2019 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yNkhu7wQRrrfQjUMzR3a+KXYtbBsPQv+NyUMqWaaZAw=;
        b=HyDVSQtQQbGY3S/q3aa5Dv+PeIEhw83u/+dLqoTflHrG65G7ov/oxnOkL/Iw02cGSG
         RbJMBmaTZPH7XC7J/hfZEF20XtSy+yajte/qHRuMsqU+HkPWR374LV+qHYr7i+085nKU
         96G8G+HPgJR35sVX7RKhEhVY2oj8w8pieZSh7hUyb9ciNIt1Um6GCE3Ssyn7PUwwqPyP
         rTkfE9IeeCAi25Pq49+QZ01EKmWSbUy4tEd9ZBSE32UIygSB4x2qbyG0C7IY/GWh05wu
         FutLabTN+gH/7JvSoWQYZZyMK8lizh7p7ei+FFkgJGAvlW/fKlgu7Ra8QuSUGkCPmXGY
         WDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNkhu7wQRrrfQjUMzR3a+KXYtbBsPQv+NyUMqWaaZAw=;
        b=W/g9Ugwd0rWyXskVpRKKwsseOvMHbKXhrrhq5Y4LNAbcC0DsZWucul7uNggUPdBhEr
         mpJYlP22l/DXQig/Dv2fwyU3dtjSqwz7MPxqykIJhl3Ie+zF/fnrPIBQFuHlqIzm2ogA
         HDQi2na+P++LWdd2DB+K9k51s1PD1eUpaentp1ZtUP6Eua2foxeaT71Y61hqTUxMLF+L
         cymdIn+eetqL3VL6B+WVAbBEq3DCGZ/+D/YVTphybqApkk38pMayNVkKlH0Q9TAYppZo
         vpiwW628zpv51tEvbHHc4VKKiaYam/0mW4W88HoMACctiB1e+w0DboDVAv2sNDJ9s5TY
         VVTw==
X-Gm-Message-State: APjAAAVyTGcm3Wx6hDp+ftJtucAXtnxWF0Lq44KAtHeNd5s6gGJ+8ewQ
        o0ErFWD9gQTgqHKcf+UyBHc=
X-Google-Smtp-Source: APXvYqxqzjbMMKZWIuVETY8p4JZt91zHReLcs0LLo/ZNGkjpsaRl+49FymmbdRtZmU/duPBBPnL0Yw==
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr7667273ljj.128.1552584480870;
        Thu, 14 Mar 2019 10:28:00 -0700 (PDT)
Received: from localhost (89-64-61-106.dynamic.chello.pl. [89.64.61.106])
        by smtp.gmail.com with ESMTPSA id t11sm2519642ljj.92.2019.03.14.10.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 10:28:00 -0700 (PDT)
Date:   Thu, 14 Mar 2019 18:27:35 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pms7003: sleect IIO_TRIGGERED_BUFFER
Message-ID: <20190314172733.GA23693@arch>
References: <20190314090118.312040-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314090118.312040-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:00:52AM +0100, Arnd Bergmann wrote:
> Without IIO_TRIGGERED_BUFFER, this driver fails to link:

Good catch, thanks (btw, perhaps typo in subject can be fixed before
applying patch).

Acked-by: Tomasz Duszynski <tduszyns@gmail.com>

>
> drivers/iio/chemical/pms7003.o: In function `pms7003_probe':
> pms7003.c:(.text+0x21c): undefined reference to `devm_iio_triggered_buffer_setup'
> pms7003.c:(.text+0x21c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `devm_iio_triggered_buffer_setup'
>
> Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/chemical/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index d5d146e9e372..6f253092a523 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -64,6 +64,7 @@ config IAQCORE
>  config PMS7003
>  	tristate "Plantower PMS7003 particulate matter sensor"
>  	depends on SERIAL_DEV_BUS
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to build support for the Plantower PMS7003 particulate
>  	  matter sensor.
> --
> 2.20.0
>
