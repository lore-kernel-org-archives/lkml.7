Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD42C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A0420848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558084648;
	bh=x8xM42vRfxXpkjm9JoKWC83RWedLTJsZZqfbIa6ntcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sa0QDgf7Nmx6Gdqoqbvvi73/RLXrtRB2spdFNkaZNYrzOn1eI4ymJVyKuk2UDhzbW
	 Kb+BvZHbLXRkvY6A+MbeYGXopBP3IeTIPYJ1ghJqmx1LIM2EyuJRQTVdWEKbcs0rC8
	 Sz7sxe5yykuy8gglB53DfXt8XnuB9h6GgSazqXds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfEQJR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfEQJR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:17:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B695F20818;
        Fri, 17 May 2019 09:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558084646;
        bh=x8xM42vRfxXpkjm9JoKWC83RWedLTJsZZqfbIa6ntcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqqM1da66TINk7r17jzm+neh5fRW/d6kj1JI9lA5JEr27bv83rASrldtEkTaFsgBF
         0eXRbpsjJtUVNMq52+G9TFsnbAbevBdRFRLiJpbIN+3fkdqNAT+rDT65F9lk3gsjSL
         MKdAOfiLiC51PtmwNYYA86jBnfEGkIApOz8p+AKk=
Date:   Fri, 17 May 2019 11:17:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>
Subject: Re: [PATCH v3] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Message-ID: <20190517091723.GA4602@kroah.com>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
 <20190517075331.3658-1-quentin.deslandes@itdev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517075331.3658-1-quentin.deslandes@itdev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 07:53:49AM +0000, Quentin Deslandes wrote:
> Returns error code from 'vnt_int_start_interrupt()' so the device's private
> buffers will be correctly freed and 'struct ieee80211_hw' start function
> will return an error code.
> 
> Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> ---
> v2: returns 'status' value to caller instead of removing it.
> v3: add patch version details. Thanks to Greg K-H for his help.

Looking better!

But a few minor things below:

> 
>  drivers/staging/vt6656/int.c      |  4 +++-
>  drivers/staging/vt6656/int.h      |  2 +-
>  drivers/staging/vt6656/main_usb.c | 12 +++++++++---
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/int.c b/drivers/staging/vt6656/int.c
> index 504424b19fcf..f3ee2198e1b3 100644
> --- a/drivers/staging/vt6656/int.c
> +++ b/drivers/staging/vt6656/int.c
> @@ -39,7 +39,7 @@ static const u8 fallback_rate1[5][5] = {
>  	{RATE_54M, RATE_54M, RATE_36M, RATE_18M, RATE_18M}
>  };
>  
> -void vnt_int_start_interrupt(struct vnt_private *priv)
> +int vnt_int_start_interrupt(struct vnt_private *priv)
>  {
>  	unsigned long flags;
>  	int status;
> @@ -51,6 +51,8 @@ void vnt_int_start_interrupt(struct vnt_private *priv)
>  	status = vnt_start_interrupt_urb(priv);
>  
>  	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return status;
>  }
>  
>  static int vnt_int_report_rate(struct vnt_private *priv, u8 pkt_no, u8 tsr)
> diff --git a/drivers/staging/vt6656/int.h b/drivers/staging/vt6656/int.h
> index 987c454e99e9..8a6d60569ceb 100644
> --- a/drivers/staging/vt6656/int.h
> +++ b/drivers/staging/vt6656/int.h
> @@ -41,7 +41,7 @@ struct vnt_interrupt_data {
>  	u8 sw[2];
>  } __packed;
>  
> -void vnt_int_start_interrupt(struct vnt_private *priv);
> +int vnt_int_start_interrupt(struct vnt_private *priv);
>  void vnt_int_process_data(struct vnt_private *priv);
>  
>  #endif /* __INT_H__ */
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index ccafcc2c87ac..71e10b9ae253 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -483,6 +483,7 @@ static void vnt_tx_80211(struct ieee80211_hw *hw,
>  
>  static int vnt_start(struct ieee80211_hw *hw)
>  {
> +	int err = 0;
>  	struct vnt_private *priv = hw->priv;
>  
>  	priv->rx_buf_sz = MAX_TOTAL_SIZE_WITH_ALL_HEADERS;
> @@ -496,15 +497,20 @@ static int vnt_start(struct ieee80211_hw *hw)
>  
>  	if (vnt_init_registers(priv) == false) {
>  		dev_dbg(&priv->usb->dev, " init register fail\n");
> +		err = -ENOMEM;

Why ENOMEM?  vnt_init_registers() should return a proper error code,
based on what went wrong, not true/false.  So fix that up first, and
then you can do this patch.

See, your one tiny coding style fix is turning into real cleanups, nice!

>  		goto free_all;
>  	}
>  
> -	if (vnt_key_init_table(priv))
> +	if (vnt_key_init_table(priv)) {
> +		err = -ENOMEM;

Same here, vnt_key_init_table() should return a real error value, and
then just return that here.

>  		goto free_all;
> +	}
>  
>  	priv->int_interval = 1;  /* bInterval is set to 1 */
>  
> -	vnt_int_start_interrupt(priv);
> +	err = vnt_int_start_interrupt(priv);
> +	if (err)
> +		goto free_all;

Like this, that is the correct thing.

So, this is now going to be a patch series, fixing up those two
functions (and any functions they call possibly), and then this can be
the last patch of the series.

thanks,

greg k-h
