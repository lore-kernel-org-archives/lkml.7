Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F449C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23281217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557569758;
	bh=GVjvzUgaZO5L08Vrif/Gj4NVQZ3V+nUBXORBy/xPtl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QIGpLhnH5PAYoCTQVLw8A/6zJF4KWVJ+tbfHCsQk5sRs/z5fTh2pIeBWouF/jDPeF
	 5t9BUz33kR6Sp31Ku01tkTYNZEq13ySRvUkmY4Ef84SmqKKFXYSzUcelaAHSpyy0DF
	 ZtUkaCHmXZUn5Vl85RhMHTf9RPOa9FIu/CW+kMtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfEKKP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 06:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfEKKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 06:15:57 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7916D208C0;
        Sat, 11 May 2019 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569755;
        bh=GVjvzUgaZO5L08Vrif/Gj4NVQZ3V+nUBXORBy/xPtl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGf7UATU+wbNMZj8Vn2IfAkAO93ECqaYnkNM0nI0ktDg20F/OWYS4d5STB4IPid8V
         bJwGWBld4bljFXZoG2vYlPdfr6JILEOLGCkmixATxgCYkevjNLgQrSVoWQqRtQa9mJ
         m7Z56V8aACpmRetJEsb5WCM9t/TRbG56GmxM5S4k=
Date:   Sat, 11 May 2019 11:15:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] iio: stmpe-adc: Use wait_for_completion_timeout
Message-ID: <20190511111548.504948ae@archlinux>
In-Reply-To: <20190507143615.28477-4-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
        <20190507143615.28477-4-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 May 2019 16:36:14 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Use wait_for_completion_timeout instead of
> wait_for_completion_interuptible_timeout.
> 
> The interruptible variant gets constantly interrupted if a user
> program is compiled with the -pg option.
> The killable variant was not used due to the fact that a second
> program, reading on this device, that gets killed is then also killing
> that wait.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Hi Phillippe

This one clashed a little bit with our earlier patch to remove the
unnecessary assignment.  I've applied it by hand but please check it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index 82b43e4522b6..cc752a47444c 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -77,17 +77,11 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
>  	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
>  			STMPE_ADC_CH(info->channel));
>  
> -	*val = info->value;
> -
> -	ret = wait_for_completion_interruptible_timeout
> -		(&info->completion, STMPE_ADC_TIMEOUT);
> +	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
>  
>  	if (ret <= 0) {
>  		mutex_unlock(&info->lock);
> -		if (ret == 0)
> -			return -ETIMEDOUT;
> -		else
> -			return ret;
> +		return -ETIMEDOUT;
>  	}
>  
>  	*val = info->value;
> @@ -116,15 +110,11 @@ static int stmpe_read_temp(struct stmpe_adc *info,
>  	stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
>  			STMPE_START_ONE_TEMP_CONV);
>  
> -	ret = wait_for_completion_interruptible_timeout
> -		(&info->completion, STMPE_ADC_TIMEOUT);
> +	ret = wait_for_completion_timeout(&info->completion, STMPE_ADC_TIMEOUT);
>  
>  	if (ret <= 0) {
>  		mutex_unlock(&info->lock);
> -		if (ret == 0)
> -			return -ETIMEDOUT;
> -		else
> -			return ret;
> +		return -ETIMEDOUT;
>  	}
>  
>  	/*

