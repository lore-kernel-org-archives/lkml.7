Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879BFC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B2218CD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554632891;
	bh=8hD8WxkDAJm856q9Xl0cW+WxSrX0fTKFNfrBhRVZDak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ghpr3MgONvdji5znu921ukn73j1y/IQDjHRPWff/HfYhTIYx0KiZ8+xD4PVnJLK+E
	 UssRhxs8Usc+x7+PW4S8JdiAi+XrzUkOIb3q77qHKJvFiSUyylNMYb2J+hU3q8VsFq
	 3j2PlL+87RQqJxZs/RqjKswGARB3BgfgId4MymMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDGK2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDGK2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:28:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3CD213F2;
        Sun,  7 Apr 2019 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554632889;
        bh=8hD8WxkDAJm856q9Xl0cW+WxSrX0fTKFNfrBhRVZDak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDQWL8kBhhTHhj7rL4TSVPMI8N9g9kfPEUC7+QmJAeiSILfZXfgUXJoxFuX42MwzS
         /Yb1lN4MaqciG/rew2VXX58E+dw+ozaclmAeUAba/2M3V2Vqi/F+NJxak1ZDfnIzy9
         J8MuY3Z+CxQptDmddJDx84EhC9hqjL1qJIyttGNU=
Date:   Sun, 7 Apr 2019 11:28:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, yuenn@google.com, venture@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au,
        linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: modify NPCM ADC read reference voltage
Message-ID: <20190407112803.5de7b4c2@archlinux>
In-Reply-To: <20190407081928.72250-1-tmaimon77@gmail.com>
References: <20190407081928.72250-1-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Apr 2019 11:19:28 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Checking if regulator is valid before reading
> NPCM ADC regulator voltage to avoid system crash
> in a case the regulator is not valid.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Good catch.

Applied to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/npcm_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index 9e25bbec9c70..193b3b81de4d 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -149,7 +149,7 @@ static int npcm_adc_read_raw(struct iio_dev *indio_dev,
>  		}
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (info->vref) {
> +		if (!IS_ERR(info->vref)) {
>  			vref_uv = regulator_get_voltage(info->vref);
>  			*val = vref_uv / 1000;
>  		} else {

