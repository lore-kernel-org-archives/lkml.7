Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1417C282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE3720880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="r2LgSu01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDHGSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:18:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47417 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbfDHGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:18:50 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x386G164009219;
        Mon, 8 Apr 2019 08:17:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Qepr1H+2PqXw/9+d2YB+ngzYD8mH4kqCRPp4O88IH00=;
 b=r2LgSu01FsSLP6/J8ziYyo2uVhllmMrdpaXjPYa7d/H6DDaVyld0fmh9CJb+jEWA0RR5
 owVWqAN5Lpgippjz6GpUQXqGVWoENGvXTBrybQ8GYf6KsbtFNSLp27Czeopnjz2kTi+5
 Pm0eLNtdz8nbCstV6U/6Y7l6wuXVvSVXhugAwZSSFd2t3nxeJ2NfbvXkz9CRhh6KwNL1
 Kv02gv2GrpYK9RcGdu5WktB+RQkCISkn3shl5H6Rtb83KLn3Jr8sP1NVc2mAlWu73vDm
 9v61YRiG0L7py339LE2wDBH6cbBc3y3nTXwhPXekUsxH/ruVl7YVgUg90j4BNfpsdBTJ 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkd8g3y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Apr 2019 08:17:20 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82A5638;
        Mon,  8 Apr 2019 06:17:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E98A61122;
        Mon,  8 Apr 2019 06:17:18 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 8 Apr
 2019 08:17:18 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Mon, 8 Apr 2019 08:17:18 +0200
From:   Mickael GUENE <mickael.guene@st.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Hugues FRUCHET" <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Ben Kao" <ben.kao@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Todor Tomov" <todor.tomov@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        "Jacopo Mondi" <jacopo+renesas@jmondi.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Subject: Re: [PATCH v3 2/2] media:st-mipid02: MIPID02 CSI-2 to PARALLEL bridge
 driver
Thread-Topic: [PATCH v3 2/2] media:st-mipid02: MIPID02 CSI-2 to PARALLEL
 bridge driver
Thread-Index: AQHU47s4T23daefrHk6Z36vjlaOK2qYdtyWAgAAzRACAEPzMgIAC1TwA
Date:   Mon, 8 Apr 2019 06:17:18 +0000
Message-ID: <1c7e0b8a-7441-57eb-38c0-e951917637c6@st.com>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553594620-88280-1-git-send-email-mickael.guene@st.com>
 <1553594620-88280-3-git-send-email-mickael.guene@st.com>
 <20190326113308.mp5hqdw3ktbpcawu@paasikivi.fi.intel.com>
 <fb8bf371-6158-a9b8-0822-65bc5d6db536@st.com>
 <20190406110135.7l2m6hkmvwr33d7s@kekkonen.localdomain>
In-Reply-To: <20190406110135.7l2m6hkmvwr33d7s@kekkonen.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A78CF649F1F71F4BB477799F8C2C3814@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 4/6/19 13:01, Sakari Ailus wrote:
> On Tue, Mar 26, 2019 at 02:36:41PM +0000, Mickael GUENE wrote:
>> Sakari,
>>
>>>> +static int bpp_from_code(__u32 code)
>>>> +{
>>>> +	switch (code) {
>>>> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
>>>> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
>>>> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
>>>> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
>>>> +		return 8;
>>>> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
>>>> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
>>>> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
>>>> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
>>>> +		return 10;
>>>> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
>>>> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
>>>> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
>>>> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
>>>> +		return 12;
>>>> +	case MEDIA_BUS_FMT_UYVY8_2X8:
>>>
>>> This is good for the parallel bus, but on CSI-2 side you should have
>>> MEDIA_BUS_FMT_UYVY8_1X16 instead. This isn't technically correct for a
>>> serial bus, but the custom is to use the one sample / pixel formats on =
the
>>> serial busses.
>>>
>>  Should MEDIA_BUS_FMT_BGR888_1X24 be something like
>> MEDIA_BUS_FMT_BGR888_3X8 for parallel output bus ?
>=20
> Good point. Yes.
>=20
> Could you add that format to
> Documentation/media/uapi/v4l/subdev-formats.rst, please, in a separate
> patch?
>=20
 I also need to add it to include/uapi/linux/media-bus-format.h I
suppose ?
 I was also wondering if I should add MEDIA_BUS_FMT_BGR888_3X8_BE and
MEDIA_BUS_FMT_BGR888_3X8_LE instead ?

 So if you are ok with the above I will add MEDIA_BUS_FMT_BGR888_3X8 to
subdev-formats.rs and media-bus-format.h as a first parch of my serie.

Mickael=
