Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE3C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868B8206E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vXOnQFA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfFFK7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:59:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60549 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfFFK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:59:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190606105928euoutp01b388cc1b9a2ec560c76f0634500fd814~llufdCmQD0167201672euoutp01B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 10:59:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190606105928euoutp01b388cc1b9a2ec560c76f0634500fd814~llufdCmQD0167201672euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559818768;
        bh=v865NwK69lmWWiFDGUwndz3M24HjP/DKAiXeTb9R+XY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vXOnQFA6eivxdFqvIdMpY2L9vdZR0latyl4V5W2qLPKTLtil6U9q3OvLyz5D84mdu
         LjaDwmK3spZp1mSeSVi9k7U+SgAfHmUTI9D8APG3CA+cMj7KGchGWv0OgxSdNJtRd4
         iqVcGedVchJCuioVdyM9izcWDbp3UrUBUZTRBuSs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190606105927eucas1p207368fec01de0de674da641c99c17c43~lluedOQor1211012110eucas1p2D;
        Thu,  6 Jun 2019 10:59:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C9.06.04325.F02F8FC5; Thu,  6
        Jun 2019 11:59:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190606105926eucas1p2e613ca3e2c9c6537877273c2cca2c3fd~lluduH-sm1527315273eucas1p2e;
        Thu,  6 Jun 2019 10:59:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606105926eusmtrp24bf3dc59fa000e86ce44dd1d377cc89e~lludejPW10645406454eusmtrp2D;
        Thu,  6 Jun 2019 10:59:26 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-87-5cf8f20f72b7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.69.04140.E02F8FC5; Thu,  6
        Jun 2019 11:59:26 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606105925eusmtip20b1887ab1b662bf9c2940fda64356a1d~lluctXinr2753927539eusmtip2H;
        Thu,  6 Jun 2019 10:59:25 +0000 (GMT)
Subject: Re: [PATCH v3 06/15] drm/bridge: tc358767: Simplify AUX data read
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
Message-ID: <28ddfb42-db9a-f095-9230-d324db5ee483@samsung.com>
Date:   Thu, 6 Jun 2019 12:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-7-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjtvffu7jqbXaflg0XSMEjLL4q6ZIlBxC36EQUSNbCll6m5GZuu
        LKg5JaeVtlKW07JAaVSizY+cpOUEV+h0+VEm2STsh8WIMlMxM7er5L/DOc95zznwUrjEJQil
        0lXZnFolz5SSIqKle64/at3PWVmsftKfyTfsZ/R2nYDRGzwCZnaoi2A6XzgwZmj6O8mM3/uA
        MUXGGiEz2FZFMmOfXhNMffUomejPDpbcxNjx8kWMtZnHhGyloULAuq87MLZ0IZZ1jDzH2Cnr
        Zrav3Ikd8zsl2pfKZaZrOXVMwhlR2tjUADo/tuGi8dUkrkPfAouRHwX0LtC/a8OLkYiS0BYE
        rSUWzCtI6F8I7swn88IUggLTALHiqHeWIV54hKDR04d4hweB6ckhLw6ij4AzbxD34mD6GPzU
        20ivAaenMXg1YPRFkHQELDR+IL1YTCdAo+uez0DQ4TD8vt3Hr6dPgru7QcDfBMKbiglfC7+l
        +6df6nzBOB0G+c2VOI9DYHSiGvOGAe0RQvvdESFf+yAMzxsRj4Pgq6Npmd8Ei7ZqjMdXwW0p
        wHmzAUFzgw3nhXjocrxdakEtJURAfVsMTx+A3uFewksDHQAjnkC+QwDcbjHhPC0GwzUJf70F
        3M7m5QdDoNY1Td5CUvOqZeZVa8yr1pj/5z5AxGMUwuVolApOs1PFXYjWyJWaHJUiOiVLaUVL
        /6znr2O6FXX8OWtHNIWka8XwbEYmEci1mlylHQGFS4PFWtesTCJOlede4tRZyeqcTE5jRxsp
        Qhoivrxm/LSEVsizuXMcd55Tr6gY5ReqQ8qy2B7X7tGo43ZhylY6+eHLxJqmz1Ym+ejej7dO
        DJknf2dHBmzQKV7Gb2oLcxzd06es7evstZWJeoocdVr068rWOpupoSljW1IVXlQVPZ/ExFp2
        lFqCreE3avDCH8Thwjpth4nhVD8i+pnteXFm0czc0ykh2e2uyLjfIouPkxKaNHlcJK7WyP8B
        yolaOWMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7p8n37EGNydLW7R3GFr0XSogdWi
        qeMtq8WPK4dZLA7uOc5kceXrezaLB3NvMll0TlzCbnF51xw2i7v3TrBYrJ9/i82B2+NyXy+T
        x4Op/5k8ds66y+4xu2Mmq8f97uNMHv1/DTyO39jO5PF5k5zHualnmQI4o/RsivJLS1IVMvKL
        S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy7n6+xFhwV6xi4oGXzA2M
        rwW7GDk5JARMJNafncLYxcjFISSwlFFix7bpTBAJcYnd898yQ9jCEn+udbFBFL0GKtq+lxUk
        ISzgJXG28TJYkYiAn0TXvANMIEXMAt+ZJCYu38sC0XGUUWL/5V0sIFVsApoSfzffZAOxeQXs
        JDZfmAvWzSKgInH1+l6wuKhAhMSZ9ytYIGoEJU7OfAJmcwLVr3m6lhHEZhZQl/gz7xIzhC0v
        0bx1NpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefn
        bmIERvG2Yz+37GDsehd8iFGAg1GJh1di4/cYIdbEsuLK3EOMEhzMSiK8ZRd+xAjxpiRWVqUW
        5ccXleakFh9iNAV6biKzlGhyPjDB5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYDyiLF0p0BnsedB3e6nnnu8TlSqjkj55zNYSYJG5FK3JdeD9lWyW2S8feK2I
        Xly8oKR+n/jFnz/VxY/xxqcdDts949B+5le7a/4GGR/l254S4/b81zaRq8lBC6zLfzQ6eagd
        3SkR1Xyd4/y2nfc4npbcdL+8MMi0i5VT5tmeTl/JR+vnqa038lBiKc5INNRiLipOBACvrHZ6
        +AIAAA==
X-CMS-MailID: 20190606105926eucas1p2e613ca3e2c9c6537877273c2cca2c3fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070535epcas2p36fee13315966e45d425c073162aa1aae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070535epcas2p36fee13315966e45d425c073162aa1aae
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070535epcas2p36fee13315966e45d425c073162aa1aae@epcas2p3.samsung.com>
        <20190605070507.11417-7-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:04, Andrey Smirnov wrote:
> Simplify AUX data read by removing index arithmetic and shifting with
> a helper functions that does three things:
>
>     1. Fetch data from up to 4 32-bit registers from the chip
>     2. Optionally fix data endianness (not needed on LE hosts)
>     3. Copy read data into user provided array.
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
>  drivers/gpu/drm/bridge/tc358767.c | 40 +++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index e197ce0fb166..da47d81e7109 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -321,6 +321,29 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
>  	return 0;
>  }
>  
> +static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
> +{
> +	u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
> +	int ret, i, count = DIV_ROUND_UP(size, sizeof(u32));
> +
> +	ret = regmap_bulk_read(tc->regmap, DP0_AUXRDATA(0), auxrdata, count);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < count; i++) {
> +		/*
> +		 * Our regmap is configured as LE for register data,
> +		 * so we need undo any byte swapping that might have
> +		 * happened to preserve original byte order.
> +		 */
> +		le32_to_cpus(&auxrdata[i]);
> +	}
> +
> +	memcpy(data, auxrdata, size);
> +
> +	return size;
> +}
> +


Hmm, cannot we just use regmap_raw_read?

Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej



>  static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  			       struct drm_dp_aux_msg *msg)
>  {
> @@ -379,19 +402,10 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	if (ret)
>  		return ret;
>  
> -	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
> -		/* Read data */
> -		while (i < size) {
> -			if ((i % 4) == 0) {
> -				ret = regmap_read(tc->regmap,
> -						  DP0_AUXRDATA(i >> 2), &tmp);
> -				if (ret)
> -					return ret;
> -			}
> -			buf[i] = tmp & 0xff;
> -			tmp = tmp >> 8;
> -			i++;
> -		}
> +	switch (request) {
> +	case DP_AUX_NATIVE_READ:
> +	case DP_AUX_I2C_READ:
> +		return tc_aux_read_data(tc, msg->buffer, size);
>  	}
>  
>  	return size;


