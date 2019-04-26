Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EDBC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF56206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556259973;
	bh=CFjGkaQsEoaiuvKTV58G1thTut4BSrQtRbpHNh4hcxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xOVkXqfyqXnYq92bIEd0OTqpq5zbcbeSL3QIAvKA6ZIkP4W3//3cY+tocEp883Zl0
	 qRWkB+lQzi/Ar5mBAZgS9fYISymfPMrjHN/S/A41/T8B+ZVBMPVLrm8eQPtL/l+NOe
	 R6mxAweHgztppy4O7dFpSpSB+QO3EtjD8Cu0L1mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDZG0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:26:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42232 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZG0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:26:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so1474956lfc.9;
        Thu, 25 Apr 2019 23:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdI3UOKM1gPsWsBd7nlkg/wn38GmZgSSZYPj8q0ITx0=;
        b=DTlfoQE4AnF7datD/tV7aq9h2G+cHWRQIZxY+0DeJAtmKEeXosUyLtZ8pVY5UjFCff
         +cTZpFEFq83j2kGnOp0X26yNbJRN55HmES8lcbWUcS2HK8+6ds/XbJ84heYVdQ9RX3vk
         +Y9tzZlVCBUQJ17DR7rm3DOgk0zQrYII0vKoOw7Q5nbCoyg1QkdSv/0r1o8aRZlQEVPv
         jXPeejlZKuYfOcDuPpCWQWq+B+d/nO/k1P9c5EmQv2m3po5bQjgBt1EKk2b1b8zo/FAB
         g+14bcFi4tgGLLQxjd20jmAalkb488OFCDcIp1GlqyZIgH+qZBhhFU8UQRcurWpM8ZkV
         nkWA==
X-Gm-Message-State: APjAAAU84ziuo3O9z6rwoc7ZrfT5TuxjnS7VTQuFii2c0EJ+LBUfbDGh
        mzCZBwiP/tufhoD1QiziH48=
X-Google-Smtp-Source: APXvYqw2W+n5eieopgmz40wjUfOYycrEdh+38XlNyrVcId6Ckm4HNzMNImRswRK4PKClQfc7e9a0dQ==
X-Received: by 2002:ac2:5928:: with SMTP id v8mr2773781lfi.157.1556259969701;
        Thu, 25 Apr 2019 23:26:09 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p19sm5322120lfc.48.2019.04.25.23.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 23:26:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hJuJE-0003lc-9E; Fri, 26 Apr 2019 08:26:08 +0200
Date:   Fri, 26 Apr 2019 08:26:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V8 2/4] USB: serial: f81232: fix interrupt worker not stop
Message-ID: <20190426062608.GC12280@localhost>
References: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1555641933-19336-2-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555641933-19336-2-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:45:31AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The F81232 will use LSR/Interrupt worker to handle LSR error & MSR
> change. This patch will fix the interrupt work should stop in close()
> and suspend().
> 
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> v8:
> 	1: no change
> 
> v7:
> 	1: first introduce to this series patch.
> 
>  drivers/usb/serial/f81232.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 1f0dd4087d79..25ec47d7f318 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -576,6 +576,7 @@ static void f81232_close(struct usb_serial_port *port)
>  	usb_serial_generic_close(port);
>  	usb_kill_urb(port->interrupt_in_urb);
>  	flush_work(&port_priv->lsr_work);
> +	flush_work(&port_priv->interrupt_work);
>  	port_priv->is_port_open = false;
>  
>  	mutex_unlock(&port_priv->lock);
> @@ -679,8 +680,10 @@ static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
>  
>  	usb_kill_urb(port->interrupt_in_urb);
>  
> -	if (port_priv)
> +	if (port_priv) {
>  		flush_work(&port_priv->lsr_work);
> +		flush_work(&port_priv->interrupt_work);
> +	}

I think this one should go before the lsr_work() patch as it's fixing
current functionality.

Johan
