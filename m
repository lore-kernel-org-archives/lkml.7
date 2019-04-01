Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35239C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00B520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=invensense.com header.i=@invensense.com header.b="LI+K3vWX";
	dkim=pass (1024-bit key) header.d=invensense.onmicrosoft.com header.i=@invensense.onmicrosoft.com header.b="YHEICBXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfDAOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:01:44 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:47938 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfDAOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:01:43 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 10:01:41 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31Doto7015624;
        Mon, 1 Apr 2019 06:51:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=M9g9lqj1oLIouTo2T2q6uM2I+H7n8RISzgatIREuRoo=;
 b=LI+K3vWXsl216H+nj9NAiCrgF7gGGhzqlaM/3mjNJceHORzocPI5mvNv19j37EP9Lk/e
 gIp00KkdTjaKFFnsRs1efZZdBtl/ebJCv7IREmz69jsIGR3bDt4k+K2Pc5qRN3rIlvDH
 9LXb4sATVGUCwG4bjhJk7fMEBFSV++o5p1q6PbZo9W1VWqMjxlTz9E11Kc28OQUYzQid
 rk4WFjsRxr4bpowyFL4B/7t7sPJ5+iJK67OP8MHdfFpgE3P5/g5fz6b4AyBITDoA85rB
 OSTjVfObprA5cknOU8iTOdyNoh4KhWhnnyQT4Rh5IZGq08XU6BuXawqNqKTdfyuqQlqy nQ== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2053.outbound.protection.outlook.com [104.47.42.53])
        by mx0a-00328301.pphosted.com with ESMTP id 2rjjjkgr2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 06:51:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9g9lqj1oLIouTo2T2q6uM2I+H7n8RISzgatIREuRoo=;
 b=YHEICBXfemF93L7hiqLjZR7Zo+jHq8Udof1NhpVjOrAl7Cd1wXs61Qx9RDJeRJgfSNOHb7eLmwiKPQ8ZLCOXNqr2043WrYSMFrrttpmTOQlowaq9zbNp5jfTOgpmM97iBSb4FZS1GxG9tCw+SGsAAztL8emtVZdvG7rWl1dLxDQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3102.namprd12.prod.outlook.com (20.178.241.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 13:51:20 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::8454:f13d:ad50:22d4]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::8454:f13d:ad50:22d4%4]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 13:51:20 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "stevemo@skydio.com" <stevemo@skydio.com>
CC:     =?iso-8859-1?Q?Randolph_Maa=DFen?= <gaireg@gaireg.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Thread-Topic: [PATCH] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Thread-Index: AQHU47MLLn2ny7kCw0qT2r4ovD55E6YkhZiAgALKIiA=
Date:   Mon, 1 Apr 2019 13:51:20 +0000
Message-ID: <MN2PR12MB3373F83DB5A56BEECCF29A67C4550@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190326090238.23651-1-stevemo@skydio.com>,<20190330182923.549949d5@archlinux>
In-Reply-To: <20190330182923.549949d5@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ad31c8-55c3-4622-b519-08d6b6a91f16
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3102;
x-ms-traffictypediagnostic: MN2PR12MB3102:
x-microsoft-antispam-prvs: <MN2PR12MB31022A3023E8FDA55C592B6BC4550@MN2PR12MB3102.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39850400004)(366004)(346002)(189003)(199004)(7696005)(256004)(14444005)(105586002)(71190400001)(25786009)(478600001)(106356001)(52536014)(6436002)(5660300002)(229853002)(71200400001)(11346002)(33656002)(55016002)(476003)(68736007)(486006)(14454004)(66574012)(446003)(8676002)(2501003)(7736002)(86362001)(26005)(305945005)(76176011)(72206003)(97736004)(316002)(80792005)(81166006)(9686003)(99286004)(81156014)(8936002)(66066001)(2906002)(53936002)(74316002)(102836004)(54906003)(7416002)(186003)(6506007)(5024004)(53546011)(6246003)(6116002)(4326008)(110136005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3102;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GmsVmVCsDbh8zkAB7/0eMjz5JsDampyoLhFg4G3cS1YpcWLZ/sED4hs18Rgq8BbbBvYcFQLZCSY3nN+Bn+A2RLn0z8Rjzio5WYbHt1KnoaDhuQldjJiDpnK6D2amfE8Pp5qfFouiw2FVxr6fkBgKJOj3N927qoSjVcE6pxNPnwIedtkZlnxcwbsXKZiV1E4z6oqRID5p+yFkVyr10Sny5Nxnc9l0um005FymvtIL2DMIMwSew6OCqKKqeD9eg0PmTO5b+I4FpkQU5o/F2Zf5ZIl0kZwx7vzVgS02w8Q6G1Ngds0/DY0P7jltlIW2Bcq0PR929aRtVWG4cAX6gy31e4foc/3csrhQSsXzy14+oUdI6iBYnpZsNj+2vVxKZor8T/QutcEAYlHdJqcTcOy7GyXt/rp33B7cNCG9grPLegw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ad31c8-55c3-4622-b519-08d6b6a91f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 13:51:20.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
it is right that temperature is always put inside the FIFO with this chip.=
=0A=
=0A=
But beware that it should also be the case when accelerometer only is enabl=
ed. The FIFO should contain accel data + temp. You can easily verify that b=
y looking at the size of a sample inside the FIFO when only accelerometer i=
s enabled (should be 8 instead of 6).=0A=
=0A=
If this is confirmed, you need to modify your code to handle this case corr=
ectly.=0A=
=0A=
Best regards,=0A=
Jean-Baptiste Maneyrol=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, March 30, 2019 19:29=0A=
To: stevemo@skydio.com=0A=
Cc: gaireg@gaireg.de; Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald-St=
adler; Jean-Baptiste Maneyrol; Martin Kelly; Jonathan Marek; Brian Masney; =
Rob Herring; Douglas Fischer; linux-iio@vger.kernel.org; linux-kernel@vger.=
kernel.org; Randolph Maa=DFen=0A=
Subject: Re: [PATCH] iio: imu: mpu6050: Fix FIFO layout for ICM20602=0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Tue, 26 Mar 2019 02:01:45 -0700=0A=
stevemo@skydio.com wrote:=0A=
+CC Randolph, who I think introduced the support.=0A=
=0A=
> From: Steve Moskovchenko <stevemo@skydio.com>=0A=
>=0A=
> The MPU6050 driver has recently gained support for the=0A=
> ICM20602 IMU, which is very similar to MPU6xxx. However,=0A=
> the ICM20602's Gyro data specifically includes temperature=0A=
> readings, which were not present on MPU6xxx parts. As a=0A=
> result, the driver will under-read the ICM20602's FIFO=0A=
> register, causing the same (partial) sample to be returned=0A=
> for all reads, until the FIFO overflows.=0A=
>=0A=
> Fix this by adding a table of scan elements speciically for=0A=
> the ICM20602, which takes the extra temperature data into=0A=
> consideration.=0A=
>=0A=
> While we're at it, fix the temperature offset and scaling=0A=
> on ICM20602, since it uses different scale/offset constants=0A=
> than the rest of the MPU6xxx devices.=0A=
>=0A=
> Signed-off-by: Steve Moskovchenko <stevemo@skydio.com>=0A=
Hi Steve=0A=
=0A=
This all looks sensible to me.=A0 Ideally should have had a fixes tag.=0A=
=0A=
If no one shouts in the next few days I'll pick this up and add one.=0A=
Give me a poke if I seem to have forgotten it in a week or so.=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 ++++++++++++++++++++--=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 | 20 +++++++++-=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |=A0 8 +++-=0A=
>=A0 3 files changed, 67 insertions(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
> index 650de0fefb7b..fedd3f2b0135 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
> @@ -471,7 +471,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn IIO_VAL_INT_PLUS_MICRO;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val=
 =3D 0;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val2 =3D I=
NV_MPU6050_TEMP_SCALE;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->chi=
p_type =3D=3D INV_ICM20602)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 *val2 =3D INV_ICM20602_TEMP_SCALE;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 *val2 =3D INV_MPU6050_TEMP_SCALE;=0A=
>=A0=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn IIO_VAL_INT_PLUS_MICRO;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
> @@ -480,7 +483,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0 case IIO_CHAN_INFO_OFFSET:=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (chan->type) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_TEMP:=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D IN=
V_MPU6050_TEMP_OFFSET;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->chi=
p_type =3D=3D INV_ICM20602)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 *val =3D INV_ICM20602_TEMP_OFFSET;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 *val =3D INV_MPU6050_TEMP_OFFSET;=0A=
>=A0=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn IIO_VAL_INT;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
> @@ -845,6 +851,32 @@ static const struct iio_chan_spec inv_mpu_channels[]=
 =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_S=
CAN_ACCL_Z),=0A=
>=A0 };=0A=
>=A0=0A=
> +static const struct iio_chan_spec inv_icm20602_channels[] =3D {=0A=
> +=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),=0A=
> +=A0=A0=A0=A0 {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D INV_ICM20602_SCAN_G=
YRO_TEMP,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .sign =3D 's',=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .realbits =3D 16,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .storagebits =3D 16,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .shift =3D 0,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 .endianness =3D IIO_BE,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 },=0A=
> +=A0=A0=A0=A0 },=0A=
> +=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SCAN=
_GYRO_X),=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SCAN=
_GYRO_Y),=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SCAN=
_GYRO_Z),=0A=
> +=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_AC=
CL_Y),=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_AC=
CL_X),=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_AC=
CL_Z),=0A=
> +};=0A=
> +=0A=
>=A0 /*=0A=
>=A0=A0 * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RA=
TE and=0A=
>=A0=A0 * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched=
 by the=0A=
> @@ -1100,8 +1132,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->name =3D name;=0A=
>=A0=A0=A0=A0=A0=A0=A0 else=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->name =3D dev_name=
(dev);=0A=
> -=A0=A0=A0=A0 indio_dev->channels =3D inv_mpu_channels;=0A=
> -=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu_channels);=
=0A=
> +=0A=
> +=A0=A0=A0=A0 if (chip_type =3D=3D INV_ICM20602) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm2060=
2_channels;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_S=
IZE(inv_icm20602_channels);=0A=
> +=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_mpu_cha=
nnels;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_S=
IZE(inv_mpu_channels);=0A=
> +=A0=A0=A0=A0 }=0A=
>=A0=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &mpu_info;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->modes =3D INDIO_BUFFER_TRIGGERED;=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
> index 325afd9f5f61..eb04391feaa8 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> @@ -208,6 +208,9 @@ struct inv_mpu6050_state {=0A=
>=A0 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR=A0=A0 6=0A=
>=A0 #define INV_MPU6050_FIFO_COUNT_BYTE=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=0A=
>=A0=0A=
> +/* ICM20602 gyro data includes temperature */=0A=
> +#define INV_ICM20602_BYTES_PER_GYRO_SENSOR=A0=A0 8=0A=
> +=0A=
>=A0 /* mpu6500 registers */=0A=
>=A0 #define INV_MPU6500_REG_ACCEL_CONFIG_2=A0=A0=A0=A0=A0 0x1D=0A=
>=A0 #define INV_MPU6500_REG_ACCEL_OFFSET=A0=A0=A0=A0=A0=A0=A0 0x77=0A=
> @@ -229,6 +232,9 @@ struct inv_mpu6050_state {=0A=
>=A0 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT=A0=A0=A0 3=0A=
>=A0 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT=A0=A0=A0 3=0A=
>=A0=0A=
> +#define INV_ICM20602_TEMP_OFFSET=A0=A0=A0=A0=A0=A0=A0=A0=A0 8170=0A=
> +#define INV_ICM20602_TEMP_SCALE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 3060=0A=
> +=0A=
>=A0 /* 6 + 6 round up and plus 8 */=0A=
>=A0 #define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0=A0=A0=A0=A0 24=0A=
>=A0=0A=
> @@ -270,7 +276,7 @@ struct inv_mpu6050_state {=0A=
>=A0 #define INV_ICM20608_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xA=
F=0A=
>=A0 #define INV_ICM20602_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1=
2=0A=
>=A0=0A=
> -/* scan element definition */=0A=
> +/* scan element definition for generic MPU6xxx devices */=0A=
>=A0 enum inv_mpu6050_scan {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_X,=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_Y,=0A=
> @@ -281,6 +287,18 @@ enum inv_mpu6050_scan {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_TIMESTAMP,=0A=
>=A0 };=0A=
>=A0=0A=
> +/* scan element definition for ICM20602, which includes gyro temp */=0A=
> +enum inv_icm20602_scan {=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_X,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_Y,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_Z,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_TEMP,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_X,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_Y,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_Z,=0A=
> +=A0=A0=A0=A0 INV_ICM20602_SCAN_TIMESTAMP,=0A=
> +};=0A=
> +=0A=
>=A0 enum inv_mpu6050_filter_e {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FILTER_256HZ_NOLPF2 =3D 0,=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FILTER_188HZ,=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c=0A=
> index 548e042f7b5b..20828d6a13f9 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> @@ -204,8 +204,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.accl_fifo_enable)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU=
6050_BYTES_PER_3AXIS_SENSOR;=0A=
>=A0=0A=
> -=A0=A0=A0=A0 if (st->chip_config.gyro_fifo_enable)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU6050_BY=
TES_PER_3AXIS_SENSOR;=0A=
> +=A0=A0=A0=A0 if (st->chip_config.gyro_fifo_enable) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->chip_type =3D=3D INV_ICM206=
02)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_d=
atum +=3D INV_ICM20602_BYTES_PER_GYRO_SENSOR;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_d=
atum +=3D INV_MPU6050_BYTES_PER_3AXIS_SENSOR;=0A=
> +=A0=A0=A0=A0 }=0A=
>=A0=0A=
>=A0=A0=A0=A0=A0=A0=A0 /*=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * read fifo_count register to know how many bytes=
 are inside the FIFO=0A=
=0A=
