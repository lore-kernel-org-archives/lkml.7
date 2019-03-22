Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EB0218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MQsNkDmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfCVKvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:51:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49560 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:51:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MApZPB084941;
        Fri, 22 Mar 2019 05:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553251895;
        bh=/POeD1m7a78bLS0yZL6B9ecWLAZek+uRKDLJ97Y5P64=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MQsNkDmf118P8YKdSwq+BINvhwXx8Qki5cKIvIvGZPOY5sd92vdI87vDGDrwAD4Jo
         fti55haMXiCsADc5dPds9MPYoyCldLSQf7+uSha+hL8dtAKzH4tDnb4cOrQ0bZ4VBB
         SOwWvV1FSJYRNtfqjOOBDxKayC3XjEZyC5HPiCR8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MApZNW086033
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 05:51:35 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 05:51:34 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 05:51:34 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MApVq4003504;
        Fri, 22 Mar 2019 05:51:32 -0500
Subject: Re: [PATCH v2 07/15] drm/bridge: tc358767: Simplify AUX data write
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-8-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <25d95ed0-4dba-09d5-87ec-57c5e763beb4@ti.com>
Date:   Fri, 22 Mar 2019 12:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322032901.12045-8-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 05:28, Andrey Smirnov wrote:
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
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 58 +++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 81c10a5d8106..21374565585d 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -307,6 +307,31 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
>  	return 0;
>  }
>  
> +static int tc_aux_write_data(struct tc_data *tc, const void *data,
> +			     size_t size)
> +{
> +	u32 auxwdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)] = { 0 };
> +	int ret, i, count = DIV_ROUND_UP(size, 4);

Should 4 there be sizeof(u32)?

> +
> +	memcpy(auxwdata, data, size);
> +
> +	for (i = 0; i < count; i++) {
> +		ret = regmap_write(tc->regmap, DP0_AUXWDATA(i),
> +				   /*
> +				    * Our regmap is configured as LE
> +				    * for register data, so we need
> +				    * undo any byte swapping that will
> +				    * happened to preserve original
> +				    * byte order.
> +				    */
> +				   cpu_to_le32(auxwdata[i]));

Can regmap_bulk_write or regmap_raw_write be used here?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
