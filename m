Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A4CC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2829620673
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="CO6HLstl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfE2MyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:54:00 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com ([40.107.1.108]:14082
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfE2MyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPx0Psfl0t1pr/cRmYitT8URn9If9ETtTeQUVRG98iI=;
 b=CO6HLstlrE0dscDNawMR4Iza1vgQB/C1aJr8BtGu9YGHhSmE/moWQZ7GS2bcTAucTc1KC8Ud2fsb2JtIVtGD57HED+XNBILqP1arJBZ9F8oVVGA2gWYKn86FEzOK1F9IoTdIUhgYueYXvw9Ne1AazoZSXuAECtt4rfi80wlSm50=
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com (10.170.223.150) by
 DB6PR07MB3173.eurprd07.prod.outlook.com (10.170.220.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Wed, 29 May 2019 12:53:52 +0000
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9]) by DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9%6]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 12:53:52 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Thread-Topic: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Thread-Index: AQHVEi8WZbhhz1TyCEmlx6WeByshdKaA99MAgAC+/YCAAFXegIAACegA
Date:   Wed, 29 May 2019 12:53:51 +0000
Message-ID: <20190529125314.GA30959@localhost.localdomain>
References: <20190524124841.GA25728@localhost.localdomain>
 <20190528194652.GE24853@roeck-us.net>
 <20190529071027.GA6524@localhost.localdomain>
 <d5a651f2-93ba-f966-1a5c-52b09ccb7d12@roeck-us.net>
In-Reply-To: <d5a651f2-93ba-f966-1a5c-52b09ccb7d12@roeck-us.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0050.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::39)
 To DB6PR07MB3336.eurprd07.prod.outlook.com (2603:10a6:6:1f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 851d74f5-f692-49e1-3c2e-08d6e434b330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR07MB3173;
x-ms-traffictypediagnostic: DB6PR07MB3173:
x-microsoft-antispam-prvs: <DB6PR07MB317322A92065773CB05A9D0AEF1F0@DB6PR07MB3173.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(73956011)(68736007)(66946007)(66476007)(7736002)(14444005)(64756008)(2906002)(66556008)(229853002)(6486002)(316002)(256004)(9686003)(53936002)(6246003)(107886003)(6512007)(54906003)(102836004)(26005)(6916009)(66446008)(61506002)(186003)(1076003)(71200400001)(71190400001)(99286004)(14454004)(5660300002)(52116002)(25786009)(476003)(81156014)(486006)(11346002)(33656002)(508600001)(446003)(6506007)(305945005)(66066001)(386003)(8676002)(6436002)(86362001)(76176011)(81166006)(4326008)(6116002)(8936002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3173;H:DB6PR07MB3336.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3wRlvXEPsavlc+NhBWrVts2u8vdYv+nWP69JUhgQyeLp6YJOkhJoIueVqBZ8yPLh7nMEetujsSUhAKDQK4xSCHQ4jSkYaCa6kYgBoaE3p+eZvTptlc5by81sQA+TcHcwMXdaQ3Pbcpb0IYHK+SxQdT6UP5WanVunFqF6wgXPKRNnQYYRB0Ilo5A+zrkpwMcPd3LOeXQOX1MnNfuA2D6NVmznZNEUZw2V3VdRTkirkBWjdGWUefzqldI/YqVPMHpyDYA+pc4APJwzMdNFGS6Jt2FRFZnB1UJ/J/8KvoKiJr9U/A+XDcc65p516pq3hvKca9b6DLPinKigWq0mPqMXdNB775c1FMp0tgGCTIiIrYzmTAbr2qJAHojQ+UHbH4yKFPDiesxVHx2MSmuEe8l52oP/n6IvJd684X2b9qoa1U8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EA18BEFA9F08B498750224F98BBA145@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851d74f5-f692-49e1-3c2e-08d6e434b330
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:53:52.1235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krzysztof.adamski@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:17:47AM -0700, Guenter Roeck wrote:
>On 5/29/19 12:11 AM, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:
>>On Tue, May 28, 2019 at 12:46:52PM -0700, Guenter Roeck wrote:
>>>On Fri, May 24, 2019 at 12:49:13PM +0000, Adamski, Krzysztof (Nokia - PL=
/Wroclaw) wrote:
>>>>The device supports setting the number of samples for averaging the
>>>>measurements. There are two separate settings - PWR_AVG for averaging
>>>>PIN and VI_AVG for averaging VIN/VAUX/IOUT, both being part of
>>>>PMON_CONFIG register. The values are stored as exponent of base 2 of th=
e
>>>>actual number of samples that will be taken.
>>>>
>>>>Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>>>>---
>>>>  drivers/hwmon/pmbus/adm1275.c | 68 ++++++++++++++++++++++++++++++++++=
-
>>>>  1 file changed, 67 insertions(+), 1 deletion(-)
>>>>
>>>>diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm127=
5.c
>>>>index f569372c9204..4efe1a9df563 100644
>>>>--- a/drivers/hwmon/pmbus/adm1275.c
>>>>+++ b/drivers/hwmon/pmbus/adm1275.c
>>>>@@ -23,6 +23,8 @@
>>>>  #include <linux/slab.h>
>>>>  #include <linux/i2c.h>
>>>>  #include <linux/bitops.h>
>>>>+#include <linux/bitfield.h>
>>>>+#include <linux/log2.h>
>>>>  #include "pmbus.h"
>>>>
>>>>  enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, ad=
m1294 };
>>>>@@ -78,6 +80,10 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm=
1278, adm1293, adm1294 };
>>>>  #define ADM1075_VAUX_OV_WARN		BIT(7)
>>>>  #define ADM1075_VAUX_UV_WARN		BIT(6)
>>>>
>>>>+#define ADM1275_PWR_AVG_MASK		GENMASK(13, 11)
>>>>+#define ADM1275_VI_AVG_MASK		GENMASK(10, 8)
>>>>+#define ADM1275_SAMPLES_AVG_MAX	128
>>>>+
>>>>  struct adm1275_data {
>>>>  	int id;
>>>>  	bool have_oc_fault;
>>>>@@ -90,6 +96,7 @@ struct adm1275_data {
>>>>  	bool have_pin_max;
>>>>  	bool have_temp_max;
>>>>  	struct pmbus_driver_info info;
>>>>+	struct mutex lock;
>>>>  };
>>>>
>>>>  #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info=
)
>>>>@@ -164,6 +171,38 @@ static const struct coefficients adm1293_coefficie=
nts[] =3D {
>>>>  	[18] =3D { 7658, 0, -3 },		/* power, 21V, irange200 */
>>>>  };
>>>>
>>>>+static inline int adm1275_read_pmon_config(struct i2c_client *client, =
u64 mask)
>>>
>>>Why is the mask passed through as u64 ?
>>
>>Good point. I used u64 as this is the type used by bitfield machinery
>>under the hood but I agree it doesn't make sense and is even confusing
>>to have this in the function prototype as we are using this to mask 16
>>bit word anyways. I will fix that in v2. I am gonna have to cast the ret
>>to u16 when passing to FIELD_GET() to make sure the __BF_FIELD_CHECK is
>>not complaining (since it is signed right now), though.
>>
>
>Not sure I understand what you are talking about. FIELD_GET() uses typeof(=
).
>FIELD_GET() is used by other callers even with u8 and without any typecast=
s.
>Why would it be a problem here ?

So I basically agree with you but just wanted to note why there will be
additional cast needed in my code. The:
   return FIELD_GET(mask, ret);
will be changed to:
   return FIELD_GET(mask, (u16)ret);

And the reason for that is that the __BF_FIELD_CHECK does this check at
compile time (and breaks if this is true)
   (_mask) > (typeof(_reg))~0ull

In my case typeof(_reg) is int, so (typeof(_reg))~0ull =3D -1 which is
signed. _mask is unsigned. Depending on the type promotion, this might
or might not be true depending on the size of _mask. When _mask was u64,
it always worked. For _mask being u16, it will fail. For u32, this will
fail depending on if we are compiling for 32 or 64 bit architecture.

All this might be obvious to you but it wasn't to me, thus this note.

>>>
>>>>+{
>>>>+	int ret;
>>>>+
>>>>+	ret =3D i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>>>>+	if (ret < 0)
>>>>+		return ret;
>>>>+
>>>>+	return FIELD_GET(mask, ret);
>>>>+}
>>>>+
>>>>+static inline int adm1275_write_pmon_config(struct i2c_client *client,=
 u64 mask,
>>>>+					    u16 word)
>>>>+{
>>>>+	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client=
);
>>>>+	struct adm1275_data *data =3D to_adm1275_data(info);
>>>>+	int ret;
>>>>+
>>>>+	mutex_lock(&data->lock);
>>>
>>>Why is another lock on top of the lock provided by the pmbus core requir=
ed ?
>>>
>>
>>Good point, I was considering if I should instead add mutex_lock on
>>update_lock in the pmbus_set_samples() function inside of pmbus_core.c
>>instead (as this function is missing it) but figured that not all
>>devices will need that (lm25066 didn't) so it might be a waste in most
>>cases. But this may be cleaner approach indeed.
>>
>>Is this what you mean or there is some other lock I missed?
>>
>pmbus_set_samples() should set the pmbus lock. That was missed when
>the function was added.

And by pmbus lock you mean the update_lock from the pmbus_data
structure? I didn't see any other lock but wanted to double check my
understanding.

>>>>+	ret =3D i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
>>>>+	if (ret < 0) {
>>>>+		mutex_unlock(&data->lock);
>>>>+		return ret;
>>>>+	}
>>>>+
>>>>+	word =3D FIELD_PREP(mask, word) | (ret & ~mask);
>>>>+	ret =3D i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, word);
>>>>+	mutex_unlock(&data->lock);
>>>>+
>>>>+	return ret;
>>>>+}
>>>>+
>>>>  static int adm1275_read_word_data(struct i2c_client *client, int page=
, int reg)
>>>>  {
>>>>  	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(clien=
t);
>>>>@@ -242,6 +281,19 @@ static int adm1275_read_word_data(struct i2c_clien=
t *client, int page, int reg)
>>>>  		if (!data->have_temp_max)
>>>>  			return -ENXIO;
>>>>  		break;
>>>>+	case PMBUS_VIRT_POWER_SAMPLES:
>>>>+		ret =3D adm1275_read_pmon_config(client, ADM1275_PWR_AVG_MASK);
>>>>+		if (ret < 0)
>>>>+			break;
>>>>+		ret =3D 1 << ret;
>>>
>>>		ret =3D BIT(ret);
>>>
>>
>>I intentionally used the "raw" left shift to make it more obvious this
>>is pow2 arithmetic operation and an direct inverse to the ilog2() used
>>on write counterpart. This is also consistent with what I used in
>>lm25066.c driver not long time ago.
>>
>>I don't have strong preference but this is my reasoning. So do you still
>>think it is better to use BIT() macro instead?
>>
>
>I don't think that is a good rationale, but I'll let it go.
>

If you don't think so, I'll change it in v2. As I said, I don't have a
strong opinion on that.

Krzysztof
