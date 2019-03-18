Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F713C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9E420854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtpvYmu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCRPj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:39:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36803 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfCRPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:39:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so11665798pgr.3;
        Mon, 18 Mar 2019 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YhM1Hm94ygsMJd+2bU8kYCsdok0Ku9O9l/AY7S7rhME=;
        b=VtpvYmu0cIa7Yi5Hy8cWC2QpBAMWXkG2MtQc7fHefgwQYa5oSyGcChPTrLn2RKMwKz
         5Pl2zREzuFAeW5Vqc7XGF/8Brqz8PTQ0nolT5PYBiNq76R7tdlo6IFnnH03rDuVFeU7c
         xcM/+47YrpdCt70RXvcQ4Irlzkmj3IE5rgHKVXsA/pSYQs0CwVPz36miDPcG9YhOZ41X
         o1c+r/FbgICkkE7KTAeFcBD94RxXx25Zo8ikMnD5v0P+yQkmGNif77sifMSXtyjH/Jpp
         j0upmwIqVCIuQQB6iS1CudyO5QIgk1HBIcfh9nqMZLpU5Id0doawPulVXwKKk3N6SHG6
         UPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhM1Hm94ygsMJd+2bU8kYCsdok0Ku9O9l/AY7S7rhME=;
        b=Gi67r7ey5dvY9zNcCIFvNIhEnatIKoOreAkAj+x1xoLDhJylzIl5XwMK2yGKNTeTee
         tUWybFhDvuYDaEnb3J+oUs+WuUs+6phW5oVfJVwaqPVkBJHd7GCzzHQY5kp8m/tUN/Lj
         HIllcuBbY0PMaJUnT2uBRVE7kPxRbxR4bk/0R6wbVsOO7cTnlcbuTw6A2ltwLbxwmQBj
         fV/cA0h40trFhllIrqO/xhZRh5WdvWtxVl09p8RzKJNZCiuvzYiZ6Q4XhvGPw7yEKQmp
         IJOemt3rlJt9FivsVgWBSGhbv05DeDSovKwelCN6zzIe2DyBk8ALVZiP0xBYuB6MTTMm
         RLaA==
X-Gm-Message-State: APjAAAXRUb54lFNdCgbQspAKo44DDas52F2HgesRQjPCVLT8e9z8GuU/
        1UeDvZNFJZLAzI6DoqgDuDw=
X-Google-Smtp-Source: APXvYqyjreAqtRWnHT9XuZ1BCIOUFhXvnwBhuARA7yWJknA75DXDOqtwojZZ9OGk/b4KhCeXs/m4xw==
X-Received: by 2002:a63:d509:: with SMTP id c9mr18464337pgg.2.1552923564823;
        Mon, 18 Mar 2019 08:39:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20sm21049217pfs.182.2019.03.18.08.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 08:39:23 -0700 (PDT)
Date:   Mon, 18 Mar 2019 08:39:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Fix debugfs mutex initialisation
Message-ID: <20190318153922.GA16173@roeck-us.net>
References: <20190318150600.23417-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318150600.23417-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 03:06:00PM +0000, Marc Zyngier wrote:
> Running a kernel with the fusb302 driver and lockdep enabled
> leads to an unpleasant warning:
> 
> [    4.617477] INFO: trying to register non-static key.
> [    4.617930] the code is fine but needs lockdep annotation.
> [    4.618418] turning off the locking correctness validator.
> [    4.618913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc1-00007-g3542533f3fc9 #13
> [    4.619620] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2019.04-rc3-00124-g2feec69fb1 03/15/2019
> [    4.620454] Call trace:
> [    4.620693]  dump_backtrace+0x0/0x138
> [    4.621028]  show_stack+0x24/0x30
> [    4.621336]  dump_stack+0xbc/0x104
> [    4.621649]  register_lock_class+0x594/0x598
> [    4.622036]  __lock_acquire+0x80/0x11b8
> [    4.622384]  lock_acquire+0xdc/0x260
> [    4.622711]  __mutex_lock+0x90/0x8a0
> [    4.623037]  mutex_lock_nested+0x3c/0x50
> [    4.623394]  _fusb302_log+0x88/0x1f0
> [    4.623721]  fusb302_log+0x7c/0xa0
> [    4.624033]  tcpm_init+0x5c/0x190
> [    4.624336]  tcpm_init+0x3c/0x130
> [    4.624640]  tcpm_register_port+0x574/0x878
> [    4.625019]  fusb302_probe+0x2c8/0x590
> 
> Despite what the message says, the code isn't fine, as it tries to
> make use of the fusb302_log facility pretty early. This requires the
> logbuffer_lock mutex to be initialised, but that only happens much
> later. Boo.
> 
> Hoist the fusb302_debugfs_init call before tcpm_register_port so that
> we can enjoy a working mutex.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index e9344997329c..7e3f8901daf6 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1790,6 +1790,7 @@ static int fusb302_probe(struct i2c_client *client,
>  			goto destroy_workqueue;
>  	}
>  
> +	fusb302_debugfs_init(chip);

This needs another error exit label right after destroy_workqueue,
and an added call to fusb302_debugfs_exit() after that label.

>  	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
>  	if (IS_ERR(chip->tcpm_port)) {
>  		ret = PTR_ERR(chip->tcpm_port);
> @@ -1807,7 +1808,6 @@ static int fusb302_probe(struct i2c_client *client,
>  		goto tcpm_unregister_port;
>  	}
>  	enable_irq_wake(chip->gpio_int_n_irq);
> -	fusb302_debugfs_init(chip);
>  	i2c_set_clientdata(client, chip);
>  
>  	return ret;
> -- 
> 2.20.1
> 
