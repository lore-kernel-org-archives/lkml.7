Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529C5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B21B206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIGO+EWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfHNNhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:37:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41184 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfHNNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:37:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so50547094pls.8;
        Wed, 14 Aug 2019 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/IbKQFz9iEJ9QAG3H+pG4K1gLkKuiUxL+JncAuAkeYs=;
        b=pIGO+EWGOCwc+x6DFzehUEHLK7WZT1pjFMO8sik1waJVkpBX5AHyBYmSjiCjzD++dZ
         Q6nIMS7fQu9So1y4XcKP+djptwGLHRUGwvVUcTC8Rysh0bncJiixVla8VEVD9NG2jfI2
         tM0y9VndWxvmwI9ZporXulpoLw/X71dFAuR8jDqCREPKGeAxugHgavGuuhJB3KCYIOGr
         Czgn0Nk1G/afmroiEiLRjOWaDfombU5OJMu7NiKQq6/qYItRGJcMhGSGnZmXyvYztmf6
         tZSBz4lKyXFoUYXyVJyQnG2NYTanBaYcCTvRyISpcYEKRNvyYKSja4d/ZgESZYsdamjj
         Ofqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/IbKQFz9iEJ9QAG3H+pG4K1gLkKuiUxL+JncAuAkeYs=;
        b=ZqNBWPxUKqbPGcrIpA/iUjI1jYq+KE2N1Z4jLDuiTuEQUeLhcClclRYx66cPwsHVZH
         O4uPGKSMJ4jrcrywjoQchHHAxYrEztaWrANhS38yub5Z85XQk9J0ME440YA9s4h6TvMq
         TEABZlV7Pqg3HVWxc5Xm50Z4VJzT4KynAxubMXA1e3sPEamKZ9JCFTTZh97GDICwHYRT
         hZNAxH5zcBsC94VUdi8wJlldLwsIcmGtdn8BYbxYDuiJVcm7SRseGv9nobAi3SLFHkG0
         NeUtTGBtq0JQBEPtm2MsYJT2qNBtFbhfxh7Q5rnI2B7ihjbigykWSkI6yJtxTwbItREC
         Khhg==
X-Gm-Message-State: APjAAAXHpIbklR9NlLcfgh6lU2SBRMELrw8BSpwcgESLJRsMQiArh/Bj
        mRk9byXStwoTvGVkA2zlfpw=
X-Google-Smtp-Source: APXvYqyr6NLSOj1WuKaIT9ZeerPUtwIJdVGRvwbLNkk5rFryEPEuKHLUsJd0q5cTE9T1cIYNJ4A1MQ==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr6607981plr.269.1565789861950;
        Wed, 14 Aug 2019 06:37:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm5757861pjz.31.2019.08.14.06.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:37:41 -0700 (PDT)
Date:   Wed, 14 Aug 2019 06:37:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: typec: fusb302: Always provide fwnode for the
 port
Message-ID: <20190814133740.GD32629@roeck-us.net>
References: <20190814132419.39759-1-heikki.krogerus@linux.intel.com>
 <20190814132419.39759-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814132419.39759-4-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:24:19PM +0300, Heikki Krogerus wrote:
> By registering a software fwnode for the port when the
> firmware does not supply one, we can always provide tcpm the
> connector capabilities by using the common USB connector
> device properties instead of using tcpc_config platform data.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 70 +++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 074fbb17fa8b..93244d6c4bff 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -75,7 +75,6 @@ struct fusb302_chip {
>  	struct i2c_client *i2c_client;
>  	struct tcpm_port *tcpm_port;
>  	struct tcpc_dev tcpc_dev;
> -	struct tcpc_config tcpc_config;
>  
>  	struct regulator *vbus;
>  
> @@ -1110,23 +1109,6 @@ static void fusb302_bc_lvl_handler_work(struct work_struct *work)
>  	mutex_unlock(&chip->lock);
>  }
>  
> -#define PDO_FIXED_FLAGS \
> -	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
> -
> -static const u32 src_pdo[] = {
> -	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> -};
> -
> -static const struct tcpc_config fusb302_tcpc_config = {
> -	.src_pdo = src_pdo,
> -	.nr_src_pdo = ARRAY_SIZE(src_pdo),
> -	.operating_snk_mw = 2500,
> -	.type = TYPEC_PORT_DRP,
> -	.data = TYPEC_PORT_DRD,
> -	.default_role = TYPEC_SINK,
> -	.alt_modes = NULL,
> -};
> -
>  static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
>  {
>  	fusb302_tcpc_dev->init = tcpm_init;
> @@ -1670,6 +1652,38 @@ static int init_gpio(struct fusb302_chip *chip)
>  	return 0;
>  }
>  
> +#define PDO_FIXED_FLAGS \
> +	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
> +
> +static const u32 src_pdo[] = {
> +	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS)
> +};
> +
> +static const u32 snk_pdo[] = {
> +	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS)
> +};
> +
> +static const struct property_entry port_props[] = {
> +	PROPERTY_ENTRY_STRING("data-role", "dual"),
> +	PROPERTY_ENTRY_STRING("power-role", "dual"),
> +	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
> +	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
> +	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> +	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500),
> +	{ }
> +};
> +
> +static struct fwnode_handle *fusb302_fwnode_get(struct device *dev)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	fwnode = device_get_named_child_node(dev, "connector");
> +	if (!fwnode)
> +		fwnode = fwnode_create_software_node(port_props, NULL);
> +
> +	return fwnode;
> +}
> +
>  static int fusb302_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1690,19 +1704,8 @@ static int fusb302_probe(struct i2c_client *client,
>  
>  	chip->i2c_client = client;
>  	chip->dev = &client->dev;
> -	chip->tcpc_config = fusb302_tcpc_config;
> -	chip->tcpc_dev.config = &chip->tcpc_config;
>  	mutex_init(&chip->lock);
>  
> -	chip->tcpc_dev.fwnode =
> -		device_get_named_child_node(dev, "connector");
> -
> -	/* Composite sink PDO */
> -	chip->snk_pdo[0] = PDO_FIXED(5000, 400, PDO_FIXED_FLAGS);
> -
> -	chip->tcpc_config.nr_snk_pdo = 1;
> -	chip->tcpc_config.snk_pdo = chip->snk_pdo;
> -
>  	/*
>  	 * Devicetree platforms should get extcon via phandle (not yet
>  	 * supported). On ACPI platforms, we get the name from a device prop.
> @@ -1737,8 +1740,15 @@ static int fusb302_probe(struct i2c_client *client,
>  			goto destroy_workqueue;
>  	}
>  
> +	chip->tcpc_dev.fwnode = fusb302_fwnode_get(dev);
> +	if (IS_ERR(chip->tcpc_dev.fwnode)) {
> +		ret = PTR_ERR(chip->tcpc_dev.fwnode);
> +		goto destroy_workqueue;
> +	}
> +
>  	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
>  	if (IS_ERR(chip->tcpm_port)) {
> +		fwnode_handle_put(chip->tcpc_dev.fwnode);
>  		ret = PTR_ERR(chip->tcpm_port);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "cannot register tcpm port, ret=%d", ret);
> @@ -1760,6 +1770,7 @@ static int fusb302_probe(struct i2c_client *client,
>  
>  tcpm_unregister_port:
>  	tcpm_unregister_port(chip->tcpm_port);
> +	fwnode_handle_put(chip->tcpc_dev.fwnode);
>  destroy_workqueue:
>  	destroy_workqueue(chip->wq);
>  
> @@ -1775,6 +1786,7 @@ static int fusb302_remove(struct i2c_client *client)
>  	cancel_work_sync(&chip->irq_work);
>  	cancel_delayed_work_sync(&chip->bc_lvl_handler);
>  	tcpm_unregister_port(chip->tcpm_port);
> +	fwnode_handle_put(chip->tcpc_dev.fwnode);
>  	destroy_workqueue(chip->wq);
>  	fusb302_debugfs_exit(chip);
>  
> -- 
> 2.20.1
> 
