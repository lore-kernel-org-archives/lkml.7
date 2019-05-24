Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A2C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202872133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC0DnxCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfEXR42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:56:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45009 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEXR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:56:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so4452446pll.11;
        Fri, 24 May 2019 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4dUJ/hnokGjsx8/lVgqKqVKEuRSybVsaRBnvdF4Ydg=;
        b=PC0DnxCHpyrvI07oguIz4W11H2VDPektdbmFePYqnjzMliY0lltRJdJSzJGNLoxp/r
         RZM/1MDsMz1LfbTV5sYnoUjwkX82g18a8OFj+EiJZJswueh4vKKyiwrSAoD58NrReBiG
         Zrs6JhXhwwnCO5sHvhbRj2HN6thomEdazjjlPAhWdo67k5rcqiqL8k3/uaUBL8TEr3+B
         DuFbbcA5dhzncKSiWHjKGGjQzXxjtySena2FWmhyO2ftN8Cg1BZIVinsN3Ne2YpJwIbz
         7acpfnI4XCuRg1C/PZJ0R8EVtvDHR+c49+COWujXiJKsn+Hsy+2mGWJu6a/zL3HnXlIv
         BWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4dUJ/hnokGjsx8/lVgqKqVKEuRSybVsaRBnvdF4Ydg=;
        b=SR0fUTkAGelmj170fwOJqOPqIDcxtoGRboT1uC7qiqUbctOM6zKOscXpBZDZKJRcd9
         ufC+S3Cd98xOTGbrZu9LoRNoQbhGoTbjFwFC5Uj1wAAAEMIhVhvJr6gNDmQ/lFo9uuiU
         aO/iy5H7X8S534s05qXGlXxzDoTrUF1sw01uJNLhRQrGs/6Lnu46Z8XIIHMc8npC76B+
         RauLzML4fsaGvKJVxF7P1tOScBM+I7s/9mXqKsZskFQV2E+XGaUiZH3UDhOFXQovEQSk
         UJirmUEH0W/jpTDkWsX3AapPkmc2kO5eps8N1T0bUwPKkkHGUoyi/TEkD289MChXwviJ
         uqxg==
X-Gm-Message-State: APjAAAUBwdt/kbiXCjmsAHr/jksDoDJ7DHlkzNzoDIvl4+JO+IF0vRc5
        207HxcNfFIzzNg9lXOyoKvc=
X-Google-Smtp-Source: APXvYqwzVVKjKnOJmUq2+WW5KCVQvlDb85InX65Q39KvGOBxb4ZTvqsmrD/jrcKi/v0YIbrwiVPJLw==
X-Received: by 2002:a17:902:f081:: with SMTP id go1mr60870708plb.211.1558720587159;
        Fri, 24 May 2019 10:56:27 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f2sm2631944pgs.83.2019.05.24.10.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:56:26 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] of/platform: Speed up of_find_device_by_node()
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190524010117.225219-1-saravanak@google.com>
 <20190524010117.225219-2-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6f4ca588-106f-93d1-8579-9e8d32c8031d@gmail.com>
Date:   Fri, 24 May 2019 10:56:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524010117.225219-2-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarvana,

I'm not reviewing patches 1-5 in any detail, given my reply to patch 0.

But I had already skimmed through this patch before I received the
email for patch 0, so I want to make one generic comment below,
to give some feedback as you continue thinking through possible
implementations to solve the underlying problems.


On 5/23/19 6:01 PM, Saravana Kannan wrote:
> Add a pointer from device tree node to the device created from it.
> This allows us to find the device corresponding to a device tree node
> without having to loop through all the platform devices.
> 
> However, fallback to looping through the platform devices to handle
> any devices that might set their own of_node.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 20 +++++++++++++++++++-
>  include/linux/of.h    |  3 +++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312fd85b..1115a8d80a33 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -42,6 +42,8 @@ static int of_dev_node_match(struct device *dev, void *data)
>  	return dev->of_node == data;
>  }
>  
> +static DEFINE_SPINLOCK(of_dev_lock);
> +
>  /**
>   * of_find_device_by_node - Find the platform_device associated with a node
>   * @np: Pointer to device tree node
> @@ -55,7 +57,18 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
>  {
>  	struct device *dev;
>  
> -	dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
> +	/*
> +	 * Spinlock needed to make sure np->dev doesn't get freed between NULL
> +	 * check inside and kref count increment inside get_device(). This is
> +	 * achieved by grabbing the spinlock before setting np->dev = NULL in
> +	 * of_platform_device_destroy().
> +	 */
> +	spin_lock(&of_dev_lock);
> +	dev = get_device(np->dev);
> +	spin_unlock(&of_dev_lock);
> +	if (!dev)
> +		dev = bus_find_device(&platform_bus_type, NULL, np,
> +				      of_dev_node_match);
>  	return dev ? to_platform_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(of_find_device_by_node);
> @@ -196,6 +209,7 @@ static struct platform_device *of_platform_device_create_pdata(
>  		platform_device_put(dev);
>  		goto err_clear_flag;
>  	}
> +	np->dev = &dev->dev;
>  
>  	return dev;
>  
> @@ -556,6 +570,10 @@ int of_platform_device_destroy(struct device *dev, void *data)
>  	if (of_node_check_flag(dev->of_node, OF_POPULATED_BUS))
>  		device_for_each_child(dev, NULL, of_platform_device_destroy);
>  
> +	/* Spinlock is needed for of_find_device_by_node() to work */
> +	spin_lock(&of_dev_lock);
> +	dev->of_node->dev = NULL;
> +	spin_unlock(&of_dev_lock);
>  	of_node_clear_flag(dev->of_node, OF_POPULATED);
>  	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>  
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0cf857012f11..f2b4912cbca1 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -48,6 +48,8 @@ struct property {
>  struct of_irq_controller;
>  #endif
>  
> +struct device;
> +
>  struct device_node {
>  	const char *name;
>  	phandle phandle;
> @@ -68,6 +70,7 @@ struct device_node {
>  	unsigned int unique_id;
>  	struct of_irq_controller *irq_trans;
>  #endif
> +	struct device *dev;		/* Device created from this node */

We have actively been working on shrinking the size of struct device_node,
as part of reducing the devicetree memory usage.  As such, we need strong
justification for adding anything to this struct.  For example, proof that
there is a performance problem that can only be solved by increasing the
memory usage.

-Frank


>  };
>  
>  #define MAX_PHANDLE_ARGS 16
> 

