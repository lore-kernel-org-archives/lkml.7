Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7232204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Imf+11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfCRWhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:37:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42951 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCRWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:37:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so9497134pfn.9;
        Mon, 18 Mar 2019 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hsJzU0D8FqNFtLMIiin71SHhAOUZksdWU9BAl3b8llg=;
        b=V9Imf+112nmeuvigRTEKiOe3ML5c39Hwcj/ysl+OQhI5ruFX7f7wsg/IIjt1BJqfQw
         ct4uSxTCPhHZVfA926VmYpk8T80cSrQODX/l0/vNGtttFZnDTdJSnAL4Ml5brvVrA3HA
         QPWANdHMbu+B1S2BTwzcXSfwzftGgprBiuvSfOAFRZmXuljPanV+w87+ieVmNfr1yMhi
         mJl0mIHiFKxj54OSp1Lt89JFBqRjfvOfIzbxsZXM9A4UTEONINe5Mc1HMZy9qhp2rfCF
         aYH5JO+yJgRxDSbrGgZJKX+/Q3SPfY/4R1hFn+YHlbD+WpZBTzcLBsnj7c1eoArVxq1f
         emlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hsJzU0D8FqNFtLMIiin71SHhAOUZksdWU9BAl3b8llg=;
        b=mnRfYdFk64MPI2PWyoIp7xxZnpTuOVc1oY7P/LGiZdn8rJurQN2lReIWfdbLRDH1M3
         wr6tCuzGlfO3feop//ltca62IPgI+XPAz+yWMagS0/PR+j+JeEyINxb1sx1kR1ay67LS
         Bi9O7x/4sY4PQ+Pi+9W5JYZnXxxjgq0QAMouBsjlWi5bLKsHQAJSnN1a5Cm7lFOgOvHh
         ss8T1bkYqmOb6Ra2WJERdzXM229Kzju5etJzf0GjTwCyAHvrG9y72/y5GS32iyrud8Tq
         hRd7ZFcH/dflhEgTlE7NMABb+Vzn2+pv2oT1Ovf06uzwJSsO5LEyS2FepXqndK6z56ms
         yyjg==
X-Gm-Message-State: APjAAAV5k+0056QxYeyC8aE/7z4GYfeJROJvy0e/AB3UluOzRRnh56oj
        6Feh2HgEvx1uWyB4LQ5pbwo=
X-Google-Smtp-Source: APXvYqzX/6tr4/1CYXobd9GPigCu7MofDrUEWh1tCE5uN/dwP2b+mQdyHWM+UJg27IGGY/wk6pCSUg==
X-Received: by 2002:a17:902:e5:: with SMTP id a92mr21873886pla.326.1552948665474;
        Mon, 18 Mar 2019 15:37:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 138sm9642506pfa.25.2019.03.18.15.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:37:44 -0700 (PDT)
Date:   Mon, 18 Mar 2019 15:37:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Fix unchecked return value
Message-ID: <20190318223743.GA18557@roeck-us.net>
References: <20190318211830.GA29785@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318211830.GA29785@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:18:30PM -0500, Gustavo A. R. Silva wrote:
> Currently there is no check on platform_get_irq() return value
> in case it fails, hence never actually reporting any errors and
> causing unexpected behavior when using such value as argument
> for function regmap_irq_get_virq().
> 
> Fix this by adding a proper check, a message error and return
> *irq* in case platform_get_irq() fails.
> 
> Addresses-Coverity-ID: 1443899 ("Improper use of negative value")
> Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/wcove.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 423208e19383..6770afd40765 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -615,8 +615,13 @@ static int wcove_typec_probe(struct platform_device *pdev)
>  	wcove->dev = &pdev->dev;
>  	wcove->regmap = pmic->regmap;
>  
> -	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr,
> -				  platform_get_irq(pdev, 0));
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> +		return irq;
> +	}
> +
> +	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
>  	if (irq < 0)
>  		return irq;
>  
> -- 
> 2.21.0
> 
