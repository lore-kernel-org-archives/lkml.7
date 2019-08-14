Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B24C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E5A2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4KtQxWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfHNNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:37:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39017 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfHNNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:37:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so49599562pfn.6;
        Wed, 14 Aug 2019 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Su1Oq1ulDQJCVp+MWgDxtieCOyT/2sRvhex5+9VZ9ko=;
        b=s4KtQxWR0eHrZwtZpKPaV65SW8z899V1VOw6j7W4jY9PBbhqGG8E9b4N6umSBx3BCO
         3X/oj+42W85A9DS8hDaseIktntnLP5DhIkz9j10N6Zk9tGJKrsc7V/3se3rCm4kyTF5z
         dyDBOZOf7pJCZkXWkV+UrT0Ste+e4tH8g1wy55BA3SJsW92mxI9hQbo+V1yAoQCdcXmB
         K1N57BMRNGMubSjJggwXEHk+OFefs8PMeAwVHYG4jY0alfkh7JQEUYq86DIGALMhwf3T
         ZodLKuiF/AdmgsLzJr0o3NFexK17G3llXEtKt6aICQCGlk9pcUenZPnjwIAf/EBwq/xa
         Nl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Su1Oq1ulDQJCVp+MWgDxtieCOyT/2sRvhex5+9VZ9ko=;
        b=ZvDDt0p5ptWdDcTfT7pBwk1cYXwpvZL6e7xHOHWu7m+E0+8BT80Q2/pGxCktzxabrF
         nQvPtPXudvr2lga9jwk+KZxTlrekk2BoM8a5Ucvkey4OVDROhfU9k8dZtC75SFGnC6Np
         ffWe981kyJzBBRA/BpXP12Q1kUed6mLGrQjmbVqtOwCt2TVZupAbLLoxLPlSFmoWPbnO
         fL8zCJfWEAKFXWKsckjfbGCOme0M+LdMTAoudJSq5mTgppQvS5jZzkkL8GBnwClkC/Ox
         I/GxWYlpuvGZkTsl+4YGL3HeURGJ093xZThCljKtBR2JwotSmKruPxtjxx55cKuS1Ioc
         oZXQ==
X-Gm-Message-State: APjAAAWdAomWCtUk6g9ID5ioS28SIO3zxGsn4zMFIceynoc3JS57PAOm
        CjlgqCe+gIKKKnVeHGWI4WE=
X-Google-Smtp-Source: APXvYqwcI28IPlS8di6JpJOVnwHAPkfTNUHR/BVOYmyVkriAUw0j1NedL6N9uqGjaCJknElTa5u7Xw==
X-Received: by 2002:a63:3dcd:: with SMTP id k196mr1477165pga.45.1565789843301;
        Wed, 14 Aug 2019 06:37:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dw7sm4853360pjb.21.2019.08.14.06.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:37:22 -0700 (PDT)
Date:   Wed, 14 Aug 2019 06:37:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: fusb302: Remove unused properties
Message-ID: <20190814133721.GB32629@roeck-us.net>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
 <20190814132419.39759-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814132419.39759-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:24:17PM +0300, Heikki Krogerus wrote:
> Removing the deprecated fusb302 specific properties. There
> are no more platforms using them.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 31 +++----------------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index c524088246ee..074fbb17fa8b 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1670,29 +1670,6 @@ static int init_gpio(struct fusb302_chip *chip)
>  	return 0;
>  }
>  
> -static int fusb302_composite_snk_pdo_array(struct fusb302_chip *chip)
> -{
> -	struct device *dev = chip->dev;
> -	u32 max_uv, max_ua;
> -
> -	chip->snk_pdo[0] = PDO_FIXED(5000, 400, PDO_FIXED_FLAGS);
> -
> -	/*
> -	 * As max_snk_ma/mv/mw is not needed for tcpc_config,
> -	 * those settings should be passed in via sink PDO, so
> -	 * "fcs, max-sink-*" properties will be deprecated, to
> -	 * perserve compatibility with existing users of them,
> -	 * we read those properties to convert them to be a var
> -	 * PDO.
> -	 */
> -	if (device_property_read_u32(dev, "fcs,max-sink-microvolt", &max_uv) ||
> -		device_property_read_u32(dev, "fcs,max-sink-microamp", &max_ua))
> -		return 1;
> -
> -	chip->snk_pdo[1] = PDO_VAR(5000, max_uv / 1000, max_ua / 1000);
> -	return 2;
> -}
> -
>  static int fusb302_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1701,7 +1678,6 @@ static int fusb302_probe(struct i2c_client *client,
>  	struct device *dev = &client->dev;
>  	const char *name;
>  	int ret = 0;
> -	u32 v;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
>  		dev_err(&client->dev,
> @@ -1721,11 +1697,10 @@ static int fusb302_probe(struct i2c_client *client,
>  	chip->tcpc_dev.fwnode =
>  		device_get_named_child_node(dev, "connector");
>  
> -	if (!device_property_read_u32(dev, "fcs,operating-sink-microwatt", &v))
> -		chip->tcpc_config.operating_snk_mw = v / 1000;
> -
>  	/* Composite sink PDO */
> -	chip->tcpc_config.nr_snk_pdo = fusb302_composite_snk_pdo_array(chip);
> +	chip->snk_pdo[0] = PDO_FIXED(5000, 400, PDO_FIXED_FLAGS);
> +
> +	chip->tcpc_config.nr_snk_pdo = 1;
>  	chip->tcpc_config.snk_pdo = chip->snk_pdo;
>  
>  	/*
> -- 
> 2.20.1
> 
