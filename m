Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54905C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213F420815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155040;
	bh=CaMC2DJDmBfWLVtkXS4epxapMalx5iPByCLZzKkKSU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y9bbOvZDS9hM1I+pnloliBiBDGC9j5ufjs0TbS2QhouhWZo7AfWwVlMiPQbS2AzWb
	 td6lUs5dF1fVL8r0Rq/4GnUekvqkC7bwwAb1F02YvHcd2W6QQJsiNGhn2JDEoJESkG
	 H21w5Um2ZlG0Js69F5mpVqJQcXwOMwnA/SDSaKw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfCISKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCISKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:10:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE4020657;
        Sat,  9 Mar 2019 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155037;
        bh=CaMC2DJDmBfWLVtkXS4epxapMalx5iPByCLZzKkKSU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4g6+pG/jfrYWQil8YjFRTfM79WFC5abr5shN3hJGDAjOz5K1RP8ZKQXHiC/rhlKl
         9I1fgodEfVk6zRzLRyPUj3kCU0zn4O7+3wNaRw2JrWMCe2u7SLvIcgQlrq+hK/WAn5
         PtVM3lHOCMpJwHjT2l/h/hA23DCF4oPxF8XNYg7M=
Date:   Sat, 9 Mar 2019 18:10:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fix uninitialized variable warning
Message-ID: <20190309181029.5bd79468@archlinux>
In-Reply-To: <20190304200317.1229196-1-arnd@arndb.de>
References: <20190304200317.1229196-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 21:03:07 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> The pm8xxx_xoadc_probe() function triggers a bogus warning
> about an uninitialized variable:
> 
> drivers/iio/adc/qcom-pm8xxx-xoadc.c: In function 'pm8xxx_xoadc_probe':
> drivers/iio/adc/qcom-pm8xxx-xoadc.c:633:8: error: 'ch' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Reword the function so the compiler can see more easily that it
> is always initialized.
> 
> Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Thanks.

For anyone seeing this here, Linus also picked up on it and
applied a similar fix, so no need for this one.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio?id=e0f0ae838a25464179d37f355d763f9ec139fc15

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index c30c002f1fef..7939238001c8 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -423,7 +423,7 @@ static irqreturn_t pm8xxx_eoc_irq(int irq, void *d)
>  static struct pm8xxx_chan_info *
>  pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
>  {
> -	struct pm8xxx_chan_info *ch;
> +	struct pm8xxx_chan_info *ch = NULL;
>  	int i;
>  
>  	for (i = 0; i < adc->nchans; i++) {
> @@ -431,8 +431,6 @@ pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
>  		if (ch->hwchan->amux_channel == chan)
>  			break;
>  	}
> -	if (i == adc->nchans)
> -		return NULL;
>  
>  	return ch;
>  }

