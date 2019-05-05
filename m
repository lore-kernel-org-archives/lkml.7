Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EAC04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C36208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557070750;
	bh=x5pvTT0YfjwpIeJljFGVaOyqST+4wd9cZ02Kih+mMgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CwhgKKZl03k/y8Ey+wOD38lTU9eRB2+4ghp3/devlF6p3m3Tm/P5Bl29gVQ7PsZCo
	 JnhZIUJJ6ao9j8Vj53HnuGA7yMRoKXTxik3Oo6oz215U9GZWGp8sP6hTUUAC3Zc7XR
	 PXdqXS3Sl8ZVpy9N9jVN8zl4Q+5NPI1WhPm1QqSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfEEPjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEEPjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:39:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88997206DF;
        Sun,  5 May 2019 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557070748;
        bh=x5pvTT0YfjwpIeJljFGVaOyqST+4wd9cZ02Kih+mMgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cbbgoCrc1p21k3S4ympnovRb9UwA9gY2sKrCeLJ6naLJ46AhAAb9UbespVun4u4PJ
         i9Q5TwAyWOZ3JjTn0uh6TmU//BuFLoKDtNweNjN7s6ghGW+IZceJJ8YLKGlEkgndBW
         k1fuib3ycTjNlO5AXIrNicND8WcvnkLAIChiCUsM=
Date:   Sun, 5 May 2019 16:39:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] iio: stmpe-adc: Remove unnecessary assignment
Message-ID: <20190505163901.2cc9dec9@archlinux>
In-Reply-To: <20190503135725.9959-1-dev@pschenker.ch>
References: <20190503135725.9959-1-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 May 2019 15:57:23 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Remove unnecessary assignment. This could potentially cause an issue, if
> the wait function runs into a timeout. Furthermore is this assignment also
> not there in stmpe_read_temp()
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
This would probably have benefited from a statement that *val is set
twice currently. Good find.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index 37f4b74a5d32..87141177fbda 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -78,8 +78,6 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
>  	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
>  			STMPE_ADC_CH(info->channel));
>  
> -	*val = info->value;
> -
>  	ret = wait_for_completion_interruptible_timeout
>  		(&info->completion, STMPE_ADC_TIMEOUT);
>  

