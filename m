Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED018C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3452214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568554031;
	bh=kl00ageN6kCZz7MMtaCvKQM5LKvEsc6XqVXiC96l9mI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vcoeyT/7lb0ae+TLBK3yhYxW6u3Wo9/oQyTYzAYHQ+d6neOAHj4c20mutB8CJ4BqJ
	 xprZP5U30IXkgc2d8+TQurg/5PcyMK+SQTYs0qjmbXVTHMj0kOQISIMOgLkuA2HeWP
	 xh2VNQVDSzc0k1+rkoBAl9z3Y466Vx6kDw+TKqJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfION1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfION1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:27:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4B8214C6;
        Sun, 15 Sep 2019 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554030;
        bh=kl00ageN6kCZz7MMtaCvKQM5LKvEsc6XqVXiC96l9mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EhzYCi/iqYzwBGe7UQlBtS+jONXcuLZETdKfOpf2eAG0vR+pc0IPIiUm7zTqmIf8r
         +hRwditoB4ZX6WDRYzT6TuBJuWwSakA3RLl2u6CqNmtSf7px4DcEd0Q/5U6j2FcSX+
         /JzLID+8PHzuXzi2wuS/ht9NPGBf+2zmpmIzvGw4=
Date:   Sun, 15 Sep 2019 14:27:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: accel: adxl372: Fix/remove limitation for
 FIFO samples
Message-ID: <20190915142705.028cb015@archlinux>
In-Reply-To: <1568126612-13134-1-git-send-email-stefan.popa@analog.com>
References: <1568126612-13134-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 17:43:32 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> Currently, the driver sets the FIFO_SAMPLES register with the number of
> sample sets (maximum of 170 for 3 axis data, 256 for 2-axis and 512 for
> single axis). However, the FIFO_SAMPLES register should store the number
> of samples, regardless of how the FIFO format is configured.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Fixes tags? I think it's 
Fixes: f4f55ce38e5f ("iio:adxl372: Add FIFO and interrupts support")

Check I got that right though.

One trivial inline that I have tidied up whilst applying.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan


> ---
> Changes in v2:
> 	- st->watermark needs to store the number of sample sets, 
> 	  the total number of samples is computed in
> 	  adxl372_configure_fifo() func.
> 
>  drivers/iio/accel/adxl372.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 055227cb..7de5e1b 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -474,12 +474,17 @@ static int adxl372_configure_fifo(struct adxl372_state *st)
>  	if (ret < 0)
>  		return ret;
>  
> -	fifo_samples = st->watermark & 0xFF;
> +	/*
> +	 * watermak stores the number of sets; we need to write the FIFO

watermark

> +	 * registers with the number of samples
> +	 */
> +	fifo_samples = (st->watermark * st->fifo_set_size);
>  	fifo_ctl = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
>  		   ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
> -		   ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
> +		   ADXL372_FIFO_CTL_SAMPLES_MODE(fifo_samples);
>  
> -	ret = regmap_write(st->regmap, ADXL372_FIFO_SAMPLES, fifo_samples);
> +	ret = regmap_write(st->regmap,
> +			   ADXL372_FIFO_SAMPLES, fifo_samples & 0xFF);
>  	if (ret < 0)
>  		return ret;
>  

