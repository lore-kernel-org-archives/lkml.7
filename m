Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72530C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3979A222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553430901;
	bh=veioUJlORlYBTD0o78zA7HRfOnNX8Cm8kLcrUfsYtD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Am0UnuMT98UQStabUksQcsTyiK/IRjYvBOnUZHlSfwm5H1OcEosTIbUqqwgOka2Oe
	 GfLSdkMYi8MuUec+ve24YIPPni//gMdJtdWLaRONxDpobbN+9G2GSNDKsncuJeWeU/
	 OWHJPEh/aTXmPKiq/J9vNiufcXz0PBUIn9CzxgmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfCXMe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfCXMe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:34:59 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF19222D0;
        Sun, 24 Mar 2019 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553430898;
        bh=veioUJlORlYBTD0o78zA7HRfOnNX8Cm8kLcrUfsYtD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HJJB0NAHSx6ijrqAY2K4y+cwOeuyB3IX/ASm2ytXDH3qdJ7K3HJ4S9VZya9AQFQBC
         FRR9H5FGqKfEPwXX9Gx9W1NFmOUNFnYYGsnLn6oSGrHyA+2x7v1s2egm5+5T4HK4aj
         2FBzM40yfDhcmD16zp8xYK6iMXLiCXhF/wY8RAcU=
Date:   Sun, 24 Mar 2019 12:34:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] staging: iio: adc: Converted bool to bitfield
 format
Message-ID: <20190324123452.66b81183@archlinux>
In-Reply-To: <93b82557f3610f4bf4d09d0556e502b418376420.1553366098.git.sicilia.cristian@gmail.com>
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
        <cover.1553366098.git.sicilia.cristian@gmail.com>
        <93b82557f3610f4bf4d09d0556e502b418376420.1553366098.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019 20:21:39 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Changed bool format to bitfield format to save space.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> 
> ---
> The strange thing is that this struct seems not populated
> using a DTS binding function.
Indeed and that should have definitely been a warning sign ;)
We are looking at traditional platform data here (pre device
tree) and generally we will want to drop it entirely for old
drivers that we are looking to move out of staging.

I don't mind improving it prior to dropping (as it avoids
setting bad precedence in the code base in the meantime) but
one comment inline...

> ---
>  drivers/staging/iio/adc/ad7192.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43..87891ba 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -35,13 +35,13 @@ struct ad7192_platform_data {
>  	u16		vref_mv;
>  	u8		clock_source_sel;
>  	u32		ext_clk_hz;
> -	bool		refin2_en;
> -	bool		rej60_en;
> -	bool		sinc3_en;
> -	bool		chop_en;
> -	bool		buf_en;
> -	bool		unipolar_en;
> -	bool		burnout_curr_en;
> -};
> +	u8		refin2_en:1;
> +	u8		rej60_en:1;
> +	u8		sinc3_en:1;
> +	u8		chop_en:1;
> +	u8		buf_en:1;
> +	u8		unipolar_en:1;
> +	u8		burnout_curr_en:1;
> +} __attribute__((__packed__));
Please don't use packed for anything without a very very good reason.
it may result in data layouts that are much harder to read from.
That obviously doesn't matter here as I doubt it's read in a fast path.

>  
>  #endif /* IIO_ADC_AD7192_H_ */

