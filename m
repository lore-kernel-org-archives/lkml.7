Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C270C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE17A214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568552289;
	bh=LSBxVcneOfUhNHi/n1dyGze982/VrrywLYPhfUHCG1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FVI9WJLY4FK+E8TswrXdv9UZiTKCuUOc1hJfS9RF8+W75EU6C2/A0WPC6ZtmuHLL+
	 BqOOotBXAQCVulrdKGmWX8NE50BO1p2CCW8pVssPwtUmGuCLZ7JHjbqYt2xg0uNiCw
	 uHI5NyEZ8wamz8h0R7v0MqIjXGNlWDe5LC2S4f84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfIOM6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 08:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfIOM6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 08:58:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD33B21479;
        Sun, 15 Sep 2019 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568552287;
        bh=LSBxVcneOfUhNHi/n1dyGze982/VrrywLYPhfUHCG1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pUKG436FQ5b5Cr84YnEmIU+IostRdypdKGW6RUxCZUcSYwcl7DR9Whd3kPTc4k7O6
         k0Bpd0kNULNQVdV7sVJQPR2amnt45CAnajzEs8myKQXhfg2U+ru69DPWPu0Sgzz4/Y
         +SjBJyqFrzi03u3JMjkh2DOs8wdoDdLAiIgdHulY=
Date:   Sun, 15 Sep 2019 13:58:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: hx711: remove unnecessary returns
Message-ID: <20190915135802.4051574e@archlinux>
In-Reply-To: <20190909123806.ewrxc7y5gmh5plmk@arbad>
References: <20190909123806.ewrxc7y5gmh5plmk@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 14:38:08 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Optimize use of return in hx711_set_gain_for_channel().
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

I agree with Joe on this.  Minor reduction in code, but hurts
readability so a no on this one.

thanks,

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index c8686558429b..20c249f502c0 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -213,7 +213,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
>  
>  static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  	if (chan == 0) {
>  		if (hx711_data->gain_set == 32) {
> @@ -224,8 +224,6 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  				return ret;
>  
>  			ret = hx711_wait_for_ready(hx711_data);
> -			if (ret)
> -				return ret;
>  		}
>  	} else {
>  		if (hx711_data->gain_set != 32) {
> @@ -236,12 +234,10 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  				return ret;
>  
>  			ret = hx711_wait_for_ready(hx711_data);
> -			if (ret)
> -				return ret;
>  		}
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int hx711_reset_read(struct hx711_data *hx711_data, int chan)

