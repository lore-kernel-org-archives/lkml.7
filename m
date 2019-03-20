Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11598C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF028213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7LZhMHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfCTN3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:29:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40208 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:29:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so1940368pfc.7;
        Wed, 20 Mar 2019 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rIn5p3GkCYhQqMyd+q2w1iqSjOTya0OWOf72gUDz9TY=;
        b=S7LZhMHeTqA1jtBouQw9kJ92x41agkviA9dKaxd0Vzj/Vdi9RMd1UQucz5yKTa/8G9
         rFjAoLgPidgA0PWBZx7lAHRbqo7M3UzjT4+ZydxY008FFOKRm71qBxtV3xY6xZEv0vIF
         oVj5X7/MwkkJsatvqZNnTUN8B4nlFoiBfJNfLUt7GMvh3oH/LqmNvGijJ0AMyifJymSS
         lbaw1UYvhF0VReQ7myyP0xaEV71B6BM9Lwsn+QGENZWJJTF1lD5YS/m24kNy1wmHcYmM
         cfC89vB0gzSqHReujIIlZSRpp2PLww3/PPs5Xtc5oIGguEhEO8xiL7irGbC0TQRI3jou
         fWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rIn5p3GkCYhQqMyd+q2w1iqSjOTya0OWOf72gUDz9TY=;
        b=ojCrceT8qS2nXcxjtPHARGQ9XdMJ9EBRU7Xa/ONpIiNijz0P6btnfeXOzo/WIsum/g
         jjSKE2fd9W03+axFwTtn6r8bcaEgW641ee/Hq+2aKjuapYpffKkjL6qyxbjvEUw+pBLl
         yCbc6eGLnSJSK/uyYvfKZS0IhVJeyeIc0rXIrww4zQxb5xD3fwHGEM3FKLSdG6BLSE8L
         b8RqaiZ3jn0jyFZgnpQ7Tk3v1/vvUE5JI5UZzMij4jklHn5hqNZJb6v5q7leEz7ILHkZ
         UXlEmapn6PHPXzOU9FkA5IXYwDyRPxcyBI6rEmUazp88JIFUpI8lgoHzZnGUinkXPPDW
         9z0Q==
X-Gm-Message-State: APjAAAVgdOJUxT+3GrJJGdfmOYvFAfPM0cJP7mvJzpT4bK/b45Pdwz85
        T7sDaot3d9LtsJLYes10ihKHQGHB
X-Google-Smtp-Source: APXvYqxxXrzkotS+vWcvCsyoPnXWdeoWwMK1u8VM3SdULnqlwjGvkUbAFctdYDNOQIPg9UYFyY7bzg==
X-Received: by 2002:a17:902:1002:: with SMTP id b2mr7812218pla.248.1553088572160;
        Wed, 20 Mar 2019 06:29:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f192sm5563621pfc.180.2019.03.20.06.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 06:29:31 -0700 (PDT)
Date:   Wed, 20 Mar 2019 06:29:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: occ: Fix power sensor indexing
Message-ID: <20190320132930.GA8011@roeck-us.net>
References: <1553029318-31703-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553029318-31703-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:01:58PM -0500, Eddie James wrote:
> In the case of power sensor version 0xA0, the sensor indexing overlapped
> with the "caps" power sensors, resulting in probe failure and kernel
> warnings. Fix this by specifying the next index for each power sensor
> version.
> 
> Fixes: 54076cb ("hwmon (occ): Add sensor attributes and register ...")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Tested-by: Joel Stanley <joel@jms.id.au>

Applied.

Side note: There is no v4.21.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 391118c..c888f4a 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -889,6 +889,8 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  				s++;
>  			}
>  		}
> +
> +		s = (sensors->power.num_sensors * 4) + 1;
>  	} else {
>  		for (i = 0; i < sensors->power.num_sensors; ++i) {
>  			s = i + 1;
> @@ -917,11 +919,11 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>  						     show_power, NULL, 3, i);
>  			attr++;
>  		}
> -	}
>  
> -	if (sensors->caps.num_sensors >= 1) {
>  		s = sensors->power.num_sensors + 1;
> +	}
>  
> +	if (sensors->caps.num_sensors >= 1) {
>  		snprintf(attr->name, sizeof(attr->name), "power%d_label", s);
>  		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
>  					     0, 0);
