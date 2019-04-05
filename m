Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F19121850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfDENM5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:12:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49149 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbfDENM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:12:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-6vYh5p5rN3el28GcHaPjhQ-1; Fri, 05 Apr 2019 14:12:53 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 14:14:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Apr 2019 14:14:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sai Prakash Ranjan' <saiprakash.ranjan@codeaurora.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mulu He <muluhe@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>
CC:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] stm class: Fix out of bound access from bitmap allocation
Thread-Topic: [PATCH] stm class: Fix out of bound access from bitmap
 allocation
Thread-Index: AQHU66qDw2WxOhX8lUugt3I8pBQU16YtixUw
Date:   Fri, 5 Apr 2019 13:14:00 +0000
Message-ID: <fe3a301b03b84761a08d5b15962b8110@AcuMS.aculab.com>
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 6vYh5p5rN3el28GcHaPjhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan
> Sent: 05 April 2019 13:23
> 
> From: Mulu He <muluhe@codeaurora.org>
> 
> Bitmap allocation works on array of unsigned longs and
> for stm master allocation when the number of software
> channels is 32, 4 bytes are allocated and there is a out of
> bound access at the first 8 bytes access of bitmap region.
> 
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
> Signed-off-by: Mulu He <muluhe@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/hwtracing/stm/core.c | 2 +-
>  drivers/hwtracing/stm/stm.h  | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index 93ce3aa740a9..21a5838f6e67 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -168,7 +168,7 @@ static int stp_master_alloc(struct stm_device *stm, unsigned int idx)
>  	struct stp_master *master;
>  	size_t size;
> 
> -	size = ALIGN(stm->data->sw_nchannels, 8) / 8;
> +	size = ALIGN(stm->data->sw_nchannels, STM_MASTER_SZ) / STM_MASTER_SZ;

I'm not sure that using STP_MASTER_SZ improves readability at all.

Is there something that gives the size of a bitmap for 'n' items?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

