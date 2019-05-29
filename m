Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E711C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCA721019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="rrC618nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE2HLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:11:10 -0400
Received: from mail-eopbgr60135.outbound.protection.outlook.com ([40.107.6.135]:50291
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfE2HLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJnliBRO9I4mSK36ZQtZlhOpJEyIJVTc4d9GFu0z+5Y=;
 b=rrC618nutsbjVNXZcA7iVlCTUR+HBHZqaoJIAPC80Kihfyq8A4ePM1wccS1aHzxlXr+0Y6cUAhQXzKWtA89hxKdVdA442pRVPjNK/L0sq0CAFmXut9AgCjCMI+A91GtEOXPHCVi+mgEhbsM9t2NpY3E9bptqpkWSfzZKqEfU3C0=
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com (10.170.223.150) by
 DB6PR07MB4405.eurprd07.prod.outlook.com (10.168.20.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Wed, 29 May 2019 07:11:04 +0000
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9]) by DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9%6]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 07:11:04 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Thread-Topic: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Thread-Index: AQHVEi8WZbhhz1TyCEmlx6WeByshdKaA99MAgAC+/YA=
Date:   Wed, 29 May 2019 07:11:04 +0000
Message-ID: <20190529071027.GA6524@localhost.localdomain>
References: <20190524124841.GA25728@localhost.localdomain>
 <20190528194652.GE24853@roeck-us.net>
In-Reply-To: <20190528194652.GE24853@roeck-us.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0093.eurprd02.prod.outlook.com
 (2603:10a6:7:29::22) To DB6PR07MB3336.eurprd07.prod.outlook.com
 (2603:10a6:6:1f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 598c6991-a97e-402c-4efc-08d6e404cfee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR07MB4405;
x-ms-traffictypediagnostic: DB6PR07MB4405:
x-microsoft-antispam-prvs: <DB6PR07MB4405FDAE10D5AB2295AC10FBEF1F0@DB6PR07MB4405.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(61506002)(71200400001)(53936002)(305945005)(107886003)(71190400001)(99286004)(186003)(7736002)(9686003)(6246003)(6116002)(3846002)(68736007)(66066001)(6512007)(229853002)(6436002)(33656002)(86362001)(6486002)(25786009)(2906002)(54906003)(4326008)(26005)(1076003)(6506007)(386003)(5660300002)(66446008)(508600001)(73956011)(64756008)(76176011)(66946007)(102836004)(66476007)(66556008)(52116002)(6916009)(81156014)(81166006)(476003)(446003)(8676002)(11346002)(8936002)(14454004)(316002)(256004)(486006)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB4405;H:DB6PR07MB3336.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qdF9vy9e0RBhMf9nuhgmZgEO+FNaW/0/qVXYbqLpTpELpakp7RotnRZ9Qp3o8zl9t71Ei3wz+Bc5rIdbkzjdHDe7W9vC1KHfen9E6N5i+BZgrx8ks/INgMKQ+aULH1nmIflQC8o2Qai/Z6u+MXoIFxCQH8PXORDejdicP1VC79sPMMumpSuUFoGrwuQuSQM9thS1+wRa57VWrnaNjK1sJpn5bAHcfspNzf7MDJHxvl5mMqjQxCFECrEcGgeZpkTj+X4iZHiH6H2+V6I7lG9jUkgLm9nMAwYuSUNu4EZAkCu2S2WKTCdAymlpi49Yfhq1mS/L0NpoyIku4a0lTITgKhj+CIp9VzToRud4g1veVKbpFguDDPQN4lgBZaQsQIvdK+pn0zygminwfjWGqMaNMpoyN1MsUcJChQuaxOkh1rU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C8465224E3D544586C30C0BAC02A224@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598c6991-a97e-402c-4efc-08d6e404cfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 07:11:04.7202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krzysztof.adamski@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:46:52PM -0700, Guenter Roeck wrote:
>On Fri, May 24, 2019 at 12:49:13PM +0000, Adamski, Krzysztof (Nokia - PL/W=
roclaw) wrote:
>> The device supports setting the number of samples for averaging the
>> measurements. There are two separate settings - PWR_AVG for averaging
>> PIN and VI_AVG for averaging VIN/VAUX/IOUT, both being part of
>> PMON_CONFIG register. The values are stored as exponent of base 2 of the
>> actual number of samples that will be taken.
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> ---
>>  drivers/hwmon/pmbus/adm1275.c | 68 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275=
.c
>> index f569372c9204..4efe1a9df563 100644
>> --- a/drivers/hwmon/pmbus/adm1275.c
>> +++ b/drivers/hwmon/pmbus/adm1275.c
>> @@ -23,6 +23,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/i2c.h>
>>  #include <linux/bitops.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/log2.h>
>>  #include "pmbus.h"
>>
>>  enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1=
294 };
>> @@ -78,6 +80,10 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1=
278, adm1293, adm1294 };
>>  #define ADM1075_VAUX_OV_WARN		BIT(7)
>>  #define ADM1075_VAUX_UV_WARN		BIT(6)
>>
>> +#define ADM1275_PWR_AVG_MASK		GENMASK(13, 11)
>> +#define ADM1275_VI_AVG_MASK		GENMASK(10, 8)
>> +#define ADM1275_SAMPLES_AVG_MAX	128
>> +
>>  struct adm1275_data {
>>  	int id;
>>  	bool have_oc_fault;
>> @@ -90,6 +96,7 @@ struct adm1275_data {
>>  	bool have_pin_max;
>>  	bool have_temp_max;
>>  	struct pmbus_driver_info info;
>> +	struct mutex lock;
>>  };
>>
>>  #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
>> @@ -164,6 +171,38 @@ static const struct coefficients adm1293_coefficien=
ts[] =3D {
>>  	[18] =3D { 7658, 0, -3 },		/* power, 21V, irange200 */
>>  };
>>
>> +static inline int adm1275_read_pmon_config(struct i2c_client *client, u=
64 mask)
>
>Why is the mask passed through as u64 ?

Good point. I used u64 as this is the type used by bitfield machinery
under the hood but I agree it doesn't make sense and is even confusing
to have this in the function prototype as we are using this to mask 16
bit word anyways. I will fix that in v2. I am gonna have to cast the ret
to u16 when passing to FIELD_GET() to make sure the __BF_FIELD_CHECK is
not complaining (since it is signed right now), though.

>
>> +{
>> +	int ret;
>> +
>> +	ret =3D i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return FIELD_GET(mask, ret);
>> +}
>> +
>> +static inline int adm1275_write_pmon_config(struct i2c_client *client, =
u64 mask,
>> +					    u16 word)
>> +{
>> +	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client)=
;
>> +	struct adm1275_data *data =3D to_adm1275_data(info);
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>
>Why is another lock on top of the lock provided by the pmbus core required=
 ?
>

Good point, I was considering if I should instead add mutex_lock on
update_lock in the pmbus_set_samples() function inside of pmbus_core.c
instead (as this function is missing it) but figured that not all
devices will need that (lm25066 didn't) so it might be a waste in most
cases. But this may be cleaner approach indeed.

Is this what you mean or there is some other lock I missed?

>> +	ret =3D i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>> +	if (ret < 0) {
>> +		mutex_unlock(&data->lock);
>> +		return ret;
>> +	}
>> +
>> +	word =3D FIELD_PREP(mask, word) | (ret & ~mask);
>> +	ret =3D i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, word);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>>  static int adm1275_read_word_data(struct i2c_client *client, int page, =
int reg)
>>  {
>>  	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client)=
;
>> @@ -242,6 +281,19 @@ static int adm1275_read_word_data(struct i2c_client=
 *client, int page, int reg)
>>  		if (!data->have_temp_max)
>>  			return -ENXIO;
>>  		break;
>> +	case PMBUS_VIRT_POWER_SAMPLES:
>> +		ret =3D adm1275_read_pmon_config(client, ADM1275_PWR_AVG_MASK);
>> +		if (ret < 0)
>> +			break;
>> +		ret =3D 1 << ret;
>
>		ret =3D BIT(ret);
>

I intentionally used the "raw" left shift to make it more obvious this
is pow2 arithmetic operation and an direct inverse to the ilog2() used
on write counterpart. This is also consistent with what I used in
lm25066.c driver not long time ago.

I don't have strong preference but this is my reasoning. So do you still
think it is better to use BIT() macro instead?

>> +		break;
>> +	case PMBUS_VIRT_IN_SAMPLES:
>> +	case PMBUS_VIRT_CURR_SAMPLES:
>> +		ret =3D adm1275_read_pmon_config(client, ADM1275_VI_AVG_MASK);
>> +		if (ret < 0)
>> +			break;
>> +		ret =3D 1 << ret;
>
>		ret =3D BIT(ret);
>
>> +		break;
>>  	default:
>>  		ret =3D -ENODATA;
>>  		break;
>> @@ -286,6 +338,17 @@ static int adm1275_write_word_data(struct i2c_clien=
t *client, int page, int reg,
>>  	case PMBUS_VIRT_RESET_TEMP_HISTORY:
>>  		ret =3D pmbus_write_word_data(client, 0, ADM1278_PEAK_TEMP, 0);
>>  		break;
>> +	case PMBUS_VIRT_POWER_SAMPLES:
>> +		word =3D clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
>> +		ret =3D adm1275_write_pmon_config(client, ADM1275_PWR_AVG_MASK,
>> +						ilog2(word));
>> +		break;
>> +	case PMBUS_VIRT_IN_SAMPLES:
>> +	case PMBUS_VIRT_CURR_SAMPLES:
>> +		word =3D clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
>> +		ret =3D adm1275_write_pmon_config(client, ADM1275_VI_AVG_MASK,
>> +						ilog2(word));
>> +		break;
>>  	default:
>>  		ret =3D -ENODATA;
>>  		break;
>> @@ -422,6 +485,8 @@ static int adm1275_probe(struct i2c_client *client,
>>  	if (!data)
>>  		return -ENOMEM;
>>
>> +	mutex_init(&data->lock);
>> +
>>  	if (of_property_read_u32(client->dev.of_node,
>>  				 "shunt-resistor-micro-ohms", &shunt))
>>  		shunt =3D 1000; /* 1 mOhm if not set via DT */
>> @@ -439,7 +504,8 @@ static int adm1275_probe(struct i2c_client *client,
>>  	info->format[PSC_CURRENT_OUT] =3D direct;
>>  	info->format[PSC_POWER] =3D direct;
>>  	info->format[PSC_TEMPERATURE] =3D direct;
>> -	info->func[0] =3D PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
>> +	info->func[0] =3D PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
>> +			PMBUS_HAVE_SAMPLES;
>>
>>  	info->read_word_data =3D adm1275_read_word_data;
>>  	info->read_byte_data =3D adm1275_read_byte_data;
>> --
>> 2.20.1
>>
