Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45238C28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCE9207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KBjaYjkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfFFLIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:08:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54218 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfFFLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:08:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190606110834euoutp024d3ad77a29e6be2f88d62acdbcc392f3~ll2byNuDI0619406194euoutp02P
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 11:08:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190606110834euoutp024d3ad77a29e6be2f88d62acdbcc392f3~ll2byNuDI0619406194euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559819314;
        bh=rhqtQjSLn9ZOKMPyqoRAwDb+U3jeju4MQFsqLD59loc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KBjaYjkQBpu7MGit2kB0PczY4+omnROfsp/GMw+CxksvdDrNQCCvJe5APVuIkQI6A
         mTPy7wVfKNDGpVZzMSPgBwKUNBk9x8FFOmIFYbV6XdcLx1AD0KkYZHPwTu2KypN0/Z
         niTQBdo61IB2l93z9Zpi+rHWY8n1UJHSRVV9b1E4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190606110833eucas1p14261cff40a9ea8b17ece7bb2aad331c2~ll2bJYPzm1644516445eucas1p1P;
        Thu,  6 Jun 2019 11:08:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B6.27.04325.134F8FC5; Thu,  6
        Jun 2019 12:08:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190606110832eucas1p1d91a91b5912445ba0aa069aa98143562~ll2aWZ5Dj1245712457eucas1p1Z;
        Thu,  6 Jun 2019 11:08:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606110832eusmtrp2ce0e1d235625a1dc85f6250094eb6eae~ll2aGtCoy1204512045eusmtrp2R;
        Thu,  6 Jun 2019 11:08:32 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-98-5cf8f4311526
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.7F.04146.034F8FC5; Thu,  6
        Jun 2019 12:08:32 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606110831eusmtip2abc37508db1e5793a4a99f12d917eaac~ll2ZZU3_o0457604576eusmtip2H;
        Thu,  6 Jun 2019 11:08:31 +0000 (GMT)
Subject: Re: [PATCH v3 07/15] drm/bridge: tc358767: Simplify AUX data write
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6b99c3e4-5d46-22a2-7bc4-e6e3a0ded5e1@samsung.com>
Date:   Thu, 6 Jun 2019 13:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-8-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvbO002LJUMAexGAo+oAJ4orjRjQxZhIT5RGRBEcZKwoFO4Di
        RsOiFaKICUGKBIIYERcQWaQhhC0UgyCKG1UEDL6ouEFtUUFpr0bevnPOf5b/5jKk+hG9kInT
        J4sGvRCvlSmphq6pvpCVk87oFV+dvlymaTOX0W6kuQzTOM05n3ZQXFuzleCe2j/LuJGSQYI7
        l18h5wYsV2Tc0Jtuiqsutcm2ePADF84T/EjBb4JvMg/J+WJTEc0P51oJPm96BW992UjwE7UB
        fF9BLxGhiFJuihXj41JFQ2j4XuXBTz2QlBV0rKGljTSiM/45SMEAuwbyz96W5yAlo2YrEZRP
        TiEcTCKwfMmkcDCBoGW6mc5BjLul66oO568jeHbjE4mDcQSO7ju0a643uwOqMi5SLvZhI+Bb
        RpPMJSJZOwGtT/IJV0HGBsP0vUGZi1VsODx3ON0NFLsE7n3IkrvYl42E4a4aGmu84EHRmFuj
        mNXbbna5e0l2MWTWF5OYNWAbKyVcy4Adl0Oms43GTrdBZ182wuwN7611csyL4HdTKYE5HYYr
        s0jcbEJQX9NE4sJG6LA+dvsnZ6+utoTip9gKth+xGD3h5bgXPsETLjUUkjitAtMZNZ4RCMO9
        9X/naeBav112EWnNc4yZ55gxzzFj/r+2DFFVSCOmSAk6UVqtF48ul4QEKUWvW74/MaEWzX6z
        nhmr/T5q+bWvHbEM0s5XwV1HtJoWUqW0hHYEDKn1UaX2O6PVqlgh7bhoSIwxpMSLUjvyZyit
        RnVi3sgeNasTksXDopgkGv5VCUax0IhOWWyNawPO53YeRfSvoIDybJ/R4+GONmpd1sOPYbsq
        /erKKlYt1XyJzPYzxq2Pch6KeX361bL0YhOhrC0JuZ+3k+t+965uQeOBvOAZ347WVovuZMHu
        sFu3twQnRb/YWzhzy6M54qe/x9vver/RDZcDU08J4d+/lSSN+ee2bh/tNx25oKWkg8LKZaRB
        Ev4AzD73XWIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7oGX37EGPx/qWDR3GFr0XSogdWi
        qeMtq8WPK4dZLA7uOc5kceXrezaLB3NvMll0TlzCbnF51xw2i7v3TrBYrJ9/i82B2+NyXy+T
        x4Op/5k8ds66y+4xu2Mmq8f97uNMHv1/DTyO39jO5PF5k5zHualnmQI4o/RsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy3p2WKGhRrti27yBzA2Ob
        dBcjB4eEgInEscXpXYxcHEICSxklHvw8xt7FyAkUF5fYPf8tM4QtLPHnWhcbiC0k8JpRon1N
        MYgtLOAtsappAguILSLgJ9E17wATyCBmge9MEhOX72WBmHqUUWLulY2sIFVsApoSfzffBJvE
        K2Ance37D7BuFgEVic2vW8A2iwpESJx5v4IFokZQ4uTMJ2A2J1D9rdXHwHqZBdQl/sy7xAxh
        y0s0b50NZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ
        +bmbGIHxu+3Yz807GC9tDD7EKMDBqMTDK7Hxe4wQa2JZcWXuIUYJDmYlEd6yCz9ihHhTEiur
        Uovy44tKc1KLDzGaAj03kVlKNDkfmFrySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGan
        phakFsH0MXFwSjUw1sk9njqVdfHmX5c0rV1uqNQktHTbhHovs2R58T1QOmHJxPlcxZEP5N/0
        XmiZLGrqbjzr4+EczrsVixiu5tnJy/ssrTyySEXiB5uOxX2ZppIpjIXX3U9uFjKY7e7Z+2rJ
        JLukyveL3qu6pruzOq4x1Z6gZVX1ledc7x2h+zx7NRceXcnbG71ZiaU4I9FQi7moOBEA4RSt
        IfUCAAA=
X-CMS-MailID: 20190606110832eucas1p1d91a91b5912445ba0aa069aa98143562
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070536epcas2p2b59f0225754f0fb59488d61b7183da45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070536epcas2p2b59f0225754f0fb59488d61b7183da45
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070536epcas2p2b59f0225754f0fb59488d61b7183da45@epcas2p2.samsung.com>
        <20190605070507.11417-8-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:04, Andrey Smirnov wrote:
> Simplify AUX data write by dropping index arithmetic and shifting and
> replacing it with a call to a helper function that does three things:
>
>     1. Copies user-provided data into a write buffer
>     2. Optionally fixes the endianness of the write buffer (not needed
>        on LE hosts)
>     3. Transfers contenst of the write buffer to up to 4 32-bit
>        registers on the chip
>
> Note that separate data endianness fix:
>
>     tmp = (tmp << 8) | buf[i];
>
> that was reserved for DP_AUX_I2C_WRITE looks really strange, since it
> will place data differently depending on the passed user-data
> size. E.g. for a write of 1 byte, data transferred to the chip would
> look like:
>
> [byte0] [dummy1] [dummy2] [dummy3]
>
> whereas for a write of 4 bytes we'd get:
>
> [byte3] [byte2] [byte1] [byte0]
>
> Since there's no indication in the datasheet that I2C write buffer
> should be treated differently than AUX write buffer and no comment in
> the original code explaining why it was done this way, that special
> I2C write buffer transformation was dropped in this patch.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 59 +++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index da47d81e7109..260fbcd0271e 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -321,6 +321,32 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
>  	return 0;
>  }
>  
> +static int tc_aux_write_data(struct tc_data *tc, const void *data,
> +			     size_t size)
> +{
> +	u32 auxwdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)] = { 0 };
> +	int ret, i, count = DIV_ROUND_UP(size, sizeof(u32));
> +
> +	memcpy(auxwdata, data, size);
> +
> +	for (i = 0; i < count; i++) {
> +		/*
> +		 * Our regmap is configured as LE
> +		 * for register data, so we need
> +		 * undo any byte swapping that will
> +		 * happened to preserve original
> +		 * byte order.
> +		 */
> +		cpu_to_le32s(&auxwdata[i]);
> +	}
> +
> +	ret = regmap_bulk_write(tc->regmap, DP0_AUXWDATA(0), auxwdata, count);
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}


As prevoiusly maybe regmap_raw_write.

Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> +
>  static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
>  {
>  	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
> @@ -350,9 +376,6 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	struct tc_data *tc = aux_to_tc(aux);
>  	size_t size = min_t(size_t, 8, msg->size);
>  	u8 request = msg->request & ~DP_AUX_I2C_MOT;
> -	u8 *buf = msg->buffer;
> -	u32 tmp = 0;
> -	int i = 0;
>  	int ret;
>  
>  	if (size == 0)
> @@ -362,25 +385,17 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	if (ret)
>  		return ret;
>  
> -	if (request == DP_AUX_I2C_WRITE || request == DP_AUX_NATIVE_WRITE) {
> -		/* Store data */
> -		while (i < size) {
> -			if (request == DP_AUX_NATIVE_WRITE)
> -				tmp = tmp | (buf[i] << (8 * (i & 0x3)));
> -			else
> -				tmp = (tmp << 8) | buf[i];
> -			i++;
> -			if (((i % 4) == 0) || (i == size)) {
> -				ret = regmap_write(tc->regmap,
> -						   DP0_AUXWDATA((i - 1) >> 2),
> -						   tmp);
> -				if (ret)
> -					return ret;
> -				tmp = 0;
> -			}
> -		}
> -	} else if (request != DP_AUX_I2C_READ &&
> -		   request != DP_AUX_NATIVE_READ) {
> +	switch (request) {
> +	case DP_AUX_NATIVE_READ:
> +	case DP_AUX_I2C_READ:
> +		break;
> +	case DP_AUX_NATIVE_WRITE:
> +	case DP_AUX_I2C_WRITE:
> +		ret = tc_aux_write_data(tc, msg->buffer, size);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
>  		return -EINVAL;
>  	}
>  


