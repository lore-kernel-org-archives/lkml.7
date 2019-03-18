Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FE020989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seMz9hP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCRRkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:40:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34397 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:40:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id v64so11756830pfb.1;
        Mon, 18 Mar 2019 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sf+7E6Gd3VrsNyOhawpPALrkawzeZoSHVlD2ddXxdjQ=;
        b=seMz9hP7WjhwrEB8X7l9AIIYKw949omclsKCensN7laNiyqKZtObicwQbfYEPSEg1l
         DVIB5V5VtUIPccQ5DFPPRQRJpne1MDuHess87o7wlUsUhqgFUwGg6cok0oCgi3K5NuXr
         Hv9cwgiZmppJgkolNCdnV4nvm7eaYSd6X1CrkLqqQRsH5pRuZH0QsTrrBsKtuDcZIQ4E
         T4xQbUbmzVh7zvtnM1f8A9FMMJNX1h237iVXy3u6UPdd36k7qHYUYAc38qbvH/IaBoW3
         ZJCmLaiIogncwsfsLMNnNXhdhAha3Lf0d3aJpj+9HCSRlBqlyNLrNr78NcTPdU7tYQyv
         LE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sf+7E6Gd3VrsNyOhawpPALrkawzeZoSHVlD2ddXxdjQ=;
        b=ANeaIsd4BDRYcZnfpfab2ESl5SD75KLw1aQyPewqwD46oFHgtGxVPfCIPrIkAuIu2T
         JHGoM5k7jl37sm/l0DGCqvMwjNZOl6uF8b6f1OES1z280aEl5Mmz/q+AEIiwBmtaIEFb
         3Iaa6OgMHDoFNMoia7MeFqyn4UN7Uosuhf0a+nKbQ1PnnMkbmgtyn5N6kTOYEX3Zqhxa
         hgxTXBuP7u+BotPG4yMttJJkdUSElGO1qDlx51s+M/ti5EhEkrqLau1Cp/lBB2Clsk2a
         4xFxbkF0HGhxgni9HZekCqwmIEcbdOCGHC79SecY/Ar/5YLEGzSw8A5tKOg9qAX7s16g
         zJLg==
X-Gm-Message-State: APjAAAUfRVEj6hEb+QKjs73YOnO55YzenfP/KNxoD5OslwV2Q0Fur4lk
        4aWeX7ksDzTExU0eWUTIhK9VEslY
X-Google-Smtp-Source: APXvYqwLEt1Vr3iH5rOg/AxcdFsX855g4ol+ZoVTJ4iGJkKxXEg9O7irhS/P2Nx8p75QubA9QNvT3g==
X-Received: by 2002:a17:902:4301:: with SMTP id i1mr20153771pld.307.1552930840149;
        Mon, 18 Mar 2019 10:40:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f65sm19092613pff.21.2019.03.18.10.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:40:38 -0700 (PDT)
Date:   Mon, 18 Mar 2019 10:40:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Fix debugfs mutex initialisation
Message-ID: <20190318174037.GA22794@roeck-us.net>
References: <20190318150600.23417-1-marc.zyngier@arm.com>
 <20190318153922.GA16173@roeck-us.net>
 <20190318173256.012fca06@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318173256.012fca06@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:32:56PM +0000, Marc Zyngier wrote:
> On Mon, 18 Mar 2019 08:39:22 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Mon, Mar 18, 2019 at 03:06:00PM +0000, Marc Zyngier wrote:
> > > Running a kernel with the fusb302 driver and lockdep enabled
> > > leads to an unpleasant warning:
> > > 
> > > [    4.617477] INFO: trying to register non-static key.
> > > [    4.617930] the code is fine but needs lockdep annotation.
> > > [    4.618418] turning off the locking correctness validator.
> > > [    4.618913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc1-00007-g3542533f3fc9 #13
> > > [    4.619620] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2019.04-rc3-00124-g2feec69fb1 03/15/2019
> > > [    4.620454] Call trace:
> > > [    4.620693]  dump_backtrace+0x0/0x138
> > > [    4.621028]  show_stack+0x24/0x30
> > > [    4.621336]  dump_stack+0xbc/0x104
> > > [    4.621649]  register_lock_class+0x594/0x598
> > > [    4.622036]  __lock_acquire+0x80/0x11b8
> > > [    4.622384]  lock_acquire+0xdc/0x260
> > > [    4.622711]  __mutex_lock+0x90/0x8a0
> > > [    4.623037]  mutex_lock_nested+0x3c/0x50
> > > [    4.623394]  _fusb302_log+0x88/0x1f0
> > > [    4.623721]  fusb302_log+0x7c/0xa0
> > > [    4.624033]  tcpm_init+0x5c/0x190
> > > [    4.624336]  tcpm_init+0x3c/0x130
> > > [    4.624640]  tcpm_register_port+0x574/0x878
> > > [    4.625019]  fusb302_probe+0x2c8/0x590
> > > 
> > > Despite what the message says, the code isn't fine, as it tries to
> > > make use of the fusb302_log facility pretty early. This requires the
> > > logbuffer_lock mutex to be initialised, but that only happens much
> > > later. Boo.
> > > 
> > > Hoist the fusb302_debugfs_init call before tcpm_register_port so that
> > > we can enjoy a working mutex.
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > ---
> > >  drivers/usb/typec/tcpm/fusb302.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > > index e9344997329c..7e3f8901daf6 100644
> > > --- a/drivers/usb/typec/tcpm/fusb302.c
> > > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > > @@ -1790,6 +1790,7 @@ static int fusb302_probe(struct i2c_client *client,
> > >  			goto destroy_workqueue;
> > >  	}
> > >  
> > > +	fusb302_debugfs_init(chip);  
> > 
> > This needs another error exit label right after destroy_workqueue,
> > and an added call to fusb302_debugfs_exit() after that label.
> 
> You do mean before destroy_workqueue, right? Otherwise, the error
> handling doesn't nest properly... Something like this:
> 
Yes, you are correct. Sorry for the confusion.

Guenter

> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 7e3f8901daf6..76cb8be6f3eb 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1796,7 +1796,7 @@ static int fusb302_probe(struct i2c_client *client,
>  		ret = PTR_ERR(chip->tcpm_port);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "cannot register tcpm port, ret=%d", ret);
> -		goto destroy_workqueue;
> +		goto unregister_debugfs;
>  	}
>  
>  	ret = devm_request_threaded_irq(chip->dev, chip->gpio_int_n_irq,
> @@ -1814,6 +1814,8 @@ static int fusb302_probe(struct i2c_client *client,
>  
>  tcpm_unregister_port:
>  	tcpm_unregister_port(chip->tcpm_port);
> +unregister_debugfs:
> +	fusb302_debugfs_exit(chip);
>  destroy_workqueue:
>  	destroy_workqueue(chip->wq);
>  
> Thanks,
> 
> 	M.
> -- 
> Without deviation from the norm, progress is not possible.
