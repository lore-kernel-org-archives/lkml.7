Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B332133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz69a7hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfCRSSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:18:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38572 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:18:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id n125so11816200pfn.5;
        Mon, 18 Mar 2019 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=auAI3y57NmX9TgAjlaJ8XMOKsV/jS1yFTgPKQV+8Qzs=;
        b=Cz69a7hB8kv1uR7WDWYvO25sEy+AjzanRxF+EdO1G8axaHOm5m+EhbT1/RPhV3/Ogg
         f6vIVczJZUXLZUtmympcGrE83CvaA5guPxLpi4M6W+B/UR+u0+CG3YKGvCOPrxFjCGNv
         IcswIMHk61NQOHLbGQTzkxMRp0mjrrWZn0yR6XjdN+KDNEMvDzgMJQId6zXod3ZLMB1R
         Go1ZtrPFpImnbiD6miivC2UfxXYBLIOXU4uzTFTXYTWjPlV/QXPvLM4KCx/v2K7Qy1AX
         dfgK9RaBYbOi+3TU/Chorev2RAZBaacxoxRrAoP4002X1w1WGWWepvHcGzPytzW63UBY
         o9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=auAI3y57NmX9TgAjlaJ8XMOKsV/jS1yFTgPKQV+8Qzs=;
        b=tK+HmWvmJSlGZ9Q5p9g3W5aYWXJoZdVIWQnhXSAIxdhV7RBVocDfQwkAd8qy4rPk/A
         ZNLvDI3fQpj3kwr6s1X49J1Emu+718k7nxwjI1TuG49j4dmqYVjaJk3qggy671QFymG+
         7lI/caKnYwnfYmWygmm69NcUaSIcMIuMWietIrAAwhwOpuQowSv39u9rRko7syT7Qovs
         sGeRJbI1J4poLSdtdYe/atHvRSzuJIstNPt2RPo4VLiO0g1oFEst+rG7fevQ8ep3ov58
         k6Fs9t2D2MFA0JdA7Ijh6AYC0Hp5VkT2VmnDMG8sEXcaIaiTZlPCR+3y1goNq0+iXcDc
         V83g==
X-Gm-Message-State: APjAAAXSmdnEy0zxlwt+uQSRded3RhSgPLzW9eSE0BSHb9bhJ28ztXQ6
        QtWkvJbeNop5bHGjx791WHP/VbEN
X-Google-Smtp-Source: APXvYqxAjvOk+NDGXaZarQv6bXQo/o8O7YDJO4TF0yawGN30jdI6EC065lFId+D2vYrFBR2G8llOqw==
X-Received: by 2002:a63:4346:: with SMTP id q67mr18420734pga.92.1552933124625;
        Mon, 18 Mar 2019 11:18:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k75sm35865845pfj.46.2019.03.18.11.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:18:43 -0700 (PDT)
Date:   Mon, 18 Mar 2019 11:18:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix debugfs mutex initialisation
Message-ID: <20190318181841.GA25132@roeck-us.net>
References: <20190318174906.10429-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318174906.10429-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:49:06PM +0000, Marc Zyngier wrote:
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
> we can enjoy a working mutex. At Guenter's request, also add teardown
> of the debugfs facility on the error path.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index e9344997329c..76cb8be6f3eb 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1790,12 +1790,13 @@ static int fusb302_probe(struct i2c_client *client,
>  			goto destroy_workqueue;
>  	}
>  
> +	fusb302_debugfs_init(chip);
>  	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
>  	if (IS_ERR(chip->tcpm_port)) {
>  		ret = PTR_ERR(chip->tcpm_port);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "cannot register tcpm port, ret=%d", ret);
> -		goto destroy_workqueue;
> +		goto unregister_debugfs;
>  	}
>  
>  	ret = devm_request_threaded_irq(chip->dev, chip->gpio_int_n_irq,
> @@ -1807,13 +1808,14 @@ static int fusb302_probe(struct i2c_client *client,
>  		goto tcpm_unregister_port;
>  	}
>  	enable_irq_wake(chip->gpio_int_n_irq);
> -	fusb302_debugfs_init(chip);
>  	i2c_set_clientdata(client, chip);
>  
>  	return ret;
>  
>  tcpm_unregister_port:
>  	tcpm_unregister_port(chip->tcpm_port);
> +unregister_debugfs:
> +	fusb302_debugfs_exit(chip);
>  destroy_workqueue:
>  	destroy_workqueue(chip->wq);
>  
> -- 
> 2.20.1
> 
