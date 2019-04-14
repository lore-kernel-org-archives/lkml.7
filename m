Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D391FC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA2020870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555246443;
	bh=fGYAc5s/L9I+iX52OrGsXITNDAJhs/DkqTwoEKEHvi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aOfcXkNm8it4rWobc6PGZgQAlWi8yjphfV7nY5NYZq5UVTvUT5EhRhoEOX2HjJ0JI
	 vm6htDKFZpsrtf6W9FWZhKqTWakO0IVjTf2DC8GtwQl2edoPcpXILCJmk+hoIVYVCV
	 XQqYzfNA3d/k7ng0XyAmjf3kIAICDedCStTZyTdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfDNMyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfDNMyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:54:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31A12084E;
        Sun, 14 Apr 2019 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555246440;
        bh=fGYAc5s/L9I+iX52OrGsXITNDAJhs/DkqTwoEKEHvi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=evDeUttvrzb5X5TeSw4SnRytp8HjdHpBKUTsG+xrLuX6LqXEeYYzMQyG9cpq7LxLs
         IreN92Jn0aU4BUeafbd4lPPqN/yjll59vcV6gkLuU33i/P/1Nwclb0wpId9zxLKV4z
         RhIL3JZDcbWB9fjxK+LTmoCZ7DT3klC4OBV4lEAs=
Date:   Sun, 14 Apr 2019 13:53:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: temperature: max31856: fix uninitialized
 error return
Message-ID: <20190414135354.0d3a462e@archlinux>
In-Reply-To: <20190410182351.18352-1-colin.king@canonical.com>
References: <20190410182351.18352-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 19:23:51 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if mask is neither CHAN_INFO_RAW or CHAN_INFO_SCALE then
> then an uninitialized error return 'ret' is returned. Fix this by
> adding a default case that ensures -EINVAL is returned for this
> specific case.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks Colin,

Dan / smatch caught this one as well, but as you sent a patch
yours gets applied.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index 6b67d6b95cf9..f184ba5601d9 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -210,6 +210,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		}
>  		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
>  	}
>  
>  	return ret;

