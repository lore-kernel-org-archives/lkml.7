Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D66C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2952820857
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551627017;
	bh=R9PHUsibk37ktvFzG2+GTjffZ4eq4jELKz4oa9HP+90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jF0mxKWKLQT2EG6zb5JDGo4YPME68piYNqbIAOyFOnv9XxNy5vfRa8MaHR/nR0uTN
	 hDu+/q2j+kJePm/CmhGfGFMNF1ayYRc7Ur2nIPRO3TM8WE+aIrjanCyeYzXd0sIlmY
	 D/F87bSI+Nz3gTe+KajvHvV2dV68MINRieAjYBd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCCPaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfCCPaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:30:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D57E20835;
        Sun,  3 Mar 2019 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551627014;
        bh=R9PHUsibk37ktvFzG2+GTjffZ4eq4jELKz4oa9HP+90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xVt+kNziAC94xIKnvZAyCi/Jv2IZw66pT5YnN99BBTNyrR1iAQHYBOBDp78fQ18tl
         lIvD4EGwEaugv5BHVT5OIs5fBSrSHKIuYEyX/Etuscx+lWOpZYfGS08RXC4Qr6rXxy
         B99HATIUEriWtOxjt2q9/5cLLszkBJAKMHCgdOvE=
Date:   Sun, 3 Mar 2019 15:30:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: mpu6050: improve code readability
Message-ID: <20190303153007.643fe422@archlinux>
In-Reply-To: <1493d22e5c0710a4ced34bf3bc714d367bdf58a3.1550768574.git.hns@goldelico.com>
References: <cover.1550768574.git.hns@goldelico.com>
        <1493d22e5c0710a4ced34bf3bc714d367bdf58a3.1550768574.git.hns@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 18:02:54 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> - use temporary variable in get_mount_matrix()
> - remove , after { }
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 533d1f8321ac..e7721b6fb441 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -765,12 +765,14 @@ static const struct iio_mount_matrix *
>  inv_get_mount_matrix(const struct iio_dev *indio_dev,
>  		     const struct iio_chan_spec *chan)
>  {
> -	return &((struct inv_mpu6050_state *)iio_priv(indio_dev))->orientation;
> +	struct inv_mpu6050_state *data = iio_priv(indio_dev);
> +
> +	return &data->orientation;
>  }
>  
>  static const struct iio_chan_spec_ext_info inv_ext_info[] = {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, inv_get_mount_matrix),
> -	{ },
> +	{ }
>  };
>  
>  #define INV_MPU6050_CHAN(_type, _channel2, _index)                    \

