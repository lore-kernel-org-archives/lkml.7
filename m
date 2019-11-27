Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B33BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D290020665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnaRLqub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfK0FFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:05:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33636 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfK0FFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:05:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so1598035pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 21:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sViBFOECCP081rRjgLL4aJh++GhBtQgv0rGQRJMbdcw=;
        b=lnaRLqub2Df5JW9fegAH26ADKSj7HeTbWONK60QrSf4TDkTeWBYJPC+P/x1/RbZvvU
         c7OXfRHFMueRi/sxSrgt0RpAnFzCUE7GQcexcL5FlzC+V8OPvG7uH1Exom4rppTWPBO5
         b8SLhmznynqvjWx13NXQEqWm4mGMv5QYhFR2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sViBFOECCP081rRjgLL4aJh++GhBtQgv0rGQRJMbdcw=;
        b=ryTI86o5UUeFF8jXKIlFlCA8rFu+QxXqPFhe0Ci1dFUJhVrXHbsJTKEJPvWcPNApvh
         W4V3glWQT02AmLAGFIxNuyR6M3OzaNy3wTHL5Yt5fKp3VMAilVoulfbzayfHxs3cVDpa
         PQzWwl4/A3C0DavqvrlgXa2pq0QU6dFndMHNr703ZMwEOlu0hw5AVI7Nzct2DVh9OBH6
         v1xiZDzk97LtrDO4QEZwERd6ddG6M65IMAmYy11HYBZr7f/rrbJgp07G6MvHxBxUfoiL
         tHdtBT2gggFkOJrlhpIpADcwgOwkCSeZlDsd6XXh0i1jOAEW2rDeOTQ/UyMx+GGpSTNt
         xOVg==
X-Gm-Message-State: APjAAAXIIuJbJ9hFqXEC4/H8OXFn3Jr/GexOJTsE+4jlqHVnS4rcuwll
        ItN9TQZcCwOHO5mM7ec0JWjSpw==
X-Google-Smtp-Source: APXvYqyFEZIZWE+794O50kaWD9xTgidGuvtgEmJvV1slR+EM6BsMWlqZ8q4XMptXCPRG7GRYUFl7Tg==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr2144598plr.257.1574831145792;
        Tue, 26 Nov 2019 21:05:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm14877156pff.69.2019.11.26.21.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:05:44 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:05:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Larry.Finger@lwfinger.net, jakub.kicinski@netronome.com,
        kvalo@codeaurora.org, Wright.Feng@cypress.com,
        arend.vanspriel@broadcom.com, davem@davemloft.net,
        emmanuel.grumbach@intel.com, franky.lin@broadcom.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, luciano.coelho@intel.com,
        netdev@vger.kernel.org, p.figiel@camlintechnologies.com,
        pieter-paul.giesberts@broadcom.com, pkshih@realtek.com,
        rafal@milecki.pl, sara.sharon@intel.com,
        shahar.s.matityahu@intel.com, yhchuang@realtek.com,
        yuehaibing@huawei.com
Subject: Re: [Patch v2 2/4] ipw2x00: Fix -Wcast-function-type
Message-ID: <201911262105.5AE5669F9E@keescook>
References: <20191125150215.29263-1-tranmanphong@gmail.com>
 <20191126175529.10909-1-tranmanphong@gmail.com>
 <20191126175529.10909-3-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126175529.10909-3-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 12:55:27AM +0700, Phong Tran wrote:
> correct usage prototype of callback in tasklet_init().
> Report by https://github.com/KSPP/linux/issues/20
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 7 ++++---
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c | 5 +++--
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
> index 8dfbaff2d1fe..a162146a43a7 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
> @@ -3206,8 +3206,9 @@ static void ipw2100_tx_send_data(struct ipw2100_priv *priv)
>  	}
>  }
>  
> -static void ipw2100_irq_tasklet(struct ipw2100_priv *priv)
> +static void ipw2100_irq_tasklet(unsigned long data)
>  {
> +	struct ipw2100_priv *priv = (struct ipw2100_priv *)data;
>  	struct net_device *dev = priv->net_dev;
>  	unsigned long flags;
>  	u32 inta, tmp;
> @@ -6007,7 +6008,7 @@ static void ipw2100_rf_kill(struct work_struct *work)
>  	spin_unlock_irqrestore(&priv->low_lock, flags);
>  }
>  
> -static void ipw2100_irq_tasklet(struct ipw2100_priv *priv);
> +static void ipw2100_irq_tasklet(unsigned long data);
>  
>  static const struct net_device_ops ipw2100_netdev_ops = {
>  	.ndo_open		= ipw2100_open,
> @@ -6137,7 +6138,7 @@ static struct net_device *ipw2100_alloc_device(struct pci_dev *pci_dev,
>  	INIT_DELAYED_WORK(&priv->rf_kill, ipw2100_rf_kill);
>  	INIT_DELAYED_WORK(&priv->scan_event, ipw2100_scan_event);
>  
> -	tasklet_init(&priv->irq_tasklet, (void (*)(unsigned long))
> +	tasklet_init(&priv->irq_tasklet,
>  		     ipw2100_irq_tasklet, (unsigned long)priv);
>  
>  	/* NOTE:  We do not start the deferred work for status checks yet */
> diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> index ed0f06532d5e..ac5f797fb1ad 100644
> --- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> +++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
> @@ -1945,8 +1945,9 @@ static void notify_wx_assoc_event(struct ipw_priv *priv)
>  	wireless_send_event(priv->net_dev, SIOCGIWAP, &wrqu, NULL);
>  }
>  
> -static void ipw_irq_tasklet(struct ipw_priv *priv)
> +static void ipw_irq_tasklet(unsigned long data)
>  {
> +	struct ipw_priv *priv = (struct ipw_priv *)data;
>  	u32 inta, inta_mask, handled = 0;
>  	unsigned long flags;
>  	int rc = 0;
> @@ -10680,7 +10681,7 @@ static int ipw_setup_deferred_work(struct ipw_priv *priv)
>  	INIT_WORK(&priv->qos_activate, ipw_bg_qos_activate);
>  #endif				/* CONFIG_IPW2200_QOS */
>  
> -	tasklet_init(&priv->irq_tasklet, (void (*)(unsigned long))
> +	tasklet_init(&priv->irq_tasklet,
>  		     ipw_irq_tasklet, (unsigned long)priv);
>  
>  	return ret;
> -- 
> 2.20.1
> 

-- 
Kees Cook
