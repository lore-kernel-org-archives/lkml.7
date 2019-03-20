Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F792146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl32XMDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfCTO6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:58:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33542 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCTO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:58:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so2017195pgk.0;
        Wed, 20 Mar 2019 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHkQ8pRvpoFo4RQChFFu3tC+HH+rIROba4OSWsLJP1A=;
        b=rl32XMDZCyRZl0G/fSZwXv8o8ZmwF0/vxdQNe3kejHIEnBr8xxsyB2RQCRTcRuJf/a
         ClDw/stva9m8TzAqsjpZ0IJ902ZH6Knm6QGh0f+skIyL0wLFg+ARwarg7Uh/dew4tb+M
         a82JPpuZPokEwpl0MqLNCzdhdmPBWslEq6WrMR1Hefq3prxFNYVSVGFFVBh5uO8BWMGA
         zlUXkajFrY3/Ww9jLyEqTTlghusR7DFJWRtypkEKjNYK9Ey7Ut+VBIEAR5VNLS4jgrKr
         rvajjZ4wWMvZfN5uH8ijuqndZJzRNMoT2jWIZkokxBecvvHosJrkDWiyaE9oa6VTe+Do
         pAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHkQ8pRvpoFo4RQChFFu3tC+HH+rIROba4OSWsLJP1A=;
        b=PGk10R3jy4nqKwHXwf0uqP63yAX4lnd2kfYZjhjLSbnR57dXoIMLu2tpjbBsqU1z07
         y58vazSqFuIA8ECcoxx3DjfkarPaK4bJIlpE+sUQhuT2X1emVOa7mC1TpVTSVCj8+8hW
         X/AnDvya9Zuff+ePmBNWI1cO4xYFPGcT6wmDJpQB41CMN20l1UKTK5K360DgLApeWd+b
         foxMVwKz+fjlDCZO4yvwQkD6ZfrO9ZdrPK7onOzjL4yrUgqdGFZA4ydBWSvd0ZR/9ZPm
         UL42FMbj/PGu5J7j/+Rr1oySDffg6n4oUVdKDt25CSGR3n7O21dQ6QTBWh7fX0JC89OK
         vyEA==
X-Gm-Message-State: APjAAAXKn4yLtFIwbCHGKSQX7ICtdxAU+ebF7w5upra/OaU/Flr+nwCj
        cPkBrKAaEyrgUzO7lG5b5rpS546l
X-Google-Smtp-Source: APXvYqyX5X3jEwhow8CvVYvj26zIBgg0SAA6ITrznsgLoY1zl6T79CTep40ednBXSksoDgYNC/y8Jw==
X-Received: by 2002:a17:902:2bab:: with SMTP id l40mr8342742plb.273.1553093904333;
        Wed, 20 Mar 2019 07:58:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5sm7863564pgr.4.2019.03.20.07.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:58:23 -0700 (PDT)
Date:   Wed, 20 Mar 2019 07:58:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: fusb302: Make fusb302_irq_work static
Message-ID: <20190320145822.GB10980@roeck-us.net>
References: <20190320141202.19452-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320141202.19452-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:12:02PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/usb/typec/tcpm/fusb302.c:1454:6: warning:
>  symbol 'fusb302_irq_work' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 261b829..457fe7a 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1451,7 +1451,7 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -void fusb302_irq_work(struct work_struct *work)
> +static void fusb302_irq_work(struct work_struct *work)
>  {
>  	struct fusb302_chip *chip = container_of(work, struct fusb302_chip,
>  						 irq_work);
> -- 
> 2.7.0
> 
> 
