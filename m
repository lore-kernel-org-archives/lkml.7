Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE613C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6E820879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=invensense.com header.i=@invensense.com header.b="k1JEZOEj";
	dkim=pass (1024-bit key) header.d=invensense.onmicrosoft.com header.i=@invensense.onmicrosoft.com header.b="g51YlHZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfDHOmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:42:05 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:42590 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbfDHOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:42:04 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 10:42:02 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38EUJev029788;
        Mon, 8 Apr 2019 07:32:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=IoekmvfWp/IUhV/eIBokzUqBssb/gYVzeVbhbMWSqec=;
 b=k1JEZOEjeEUPbu9p8i/GEssGyy+ktY/eOKA3vhkKya6EPuSFfhEyPBg2NxjOR61owlQH
 xy67MSXW9x8Q0zSVi5hQqT1o5L7zhbrf4pgUUOpd/lwVfWZBR96iOfMBANf2dWwn83rv
 Xv+GdX4SC6vptT9dhVwCyyckBkt7Voqa/uTLSPC9L36a2vuL6WlRMTf1gFvSZt8S9FLs
 YERJlFxJBVHtfs2g3pyHI7psosqRQr+hHrrVG6d0QmTWQKObpozDYkmhqPF38TIt9Ux4
 YNqj5ILg3sUB7jJgCjY6TOTaMxURGJcDRMQuV4SkBaDmy+eNt4FQ24J6jJepfOQwg+qU 3w== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2052.outbound.protection.outlook.com [104.47.33.52])
        by mx0a-00328301.pphosted.com with ESMTP id 2rr59bg2wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 07:32:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoekmvfWp/IUhV/eIBokzUqBssb/gYVzeVbhbMWSqec=;
 b=g51YlHZHiXNQBt5lqj5TyBCanIXSO+4BFITB2uVbZJF0EyRbXN7q+P/whY2AXC9iubQCzb1mSvHdE+PKALezY8iIou93uBP2ueTSpLIsav/le95nR1NBSiwyS1Z+iGiXDrRYz9VmZEQAERCh4t/Bya/WAvnI96syi6v5opWyn2A=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3024.namprd12.prod.outlook.com (20.178.242.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 14:32:01 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::8454:f13d:ad50:22d4]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::8454:f13d:ad50:22d4%4]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 14:32:01 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "stevemo@skydio.com" <stevemo@skydio.com>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        =?iso-8859-1?Q?Randolph_Maa=DFen?= <gaireg@gaireg.de>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Thread-Topic: [PATCH v2] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Thread-Index: AQHU6eagy7CSDjEgjUyjuT8Bi9h4JqYwmt2AgAHARI0=
Date:   Mon, 8 Apr 2019 14:32:00 +0000
Message-ID: <MN2PR12MB3373887FD2E7211E6AFB7F7DC42C0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190326090238.23651-1-stevemo@skydio.com>
        <20190403062910.5047-1-stevemo@skydio.com>,<20190407124501.1a8b21d8@archlinux>
In-Reply-To: <20190407124501.1a8b21d8@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6e10b4f-afe8-40cd-3e22-08d6bc2ef68f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3024;
x-ms-traffictypediagnostic: MN2PR12MB3024:
x-microsoft-antispam-prvs: <MN2PR12MB30247454142C17225B5C05AFC42C0@MN2PR12MB3024.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(366004)(136003)(376002)(199004)(189003)(86362001)(186003)(229853002)(446003)(476003)(81156014)(81166006)(72206003)(478600001)(11346002)(3846002)(52536014)(7416002)(102836004)(6116002)(6436002)(80792005)(305945005)(7736002)(76176011)(53546011)(486006)(26005)(6506007)(74316002)(66066001)(14454004)(33656002)(8676002)(8936002)(106356001)(110136005)(71200400001)(4326008)(316002)(2501003)(55016002)(9686003)(68736007)(5660300002)(54906003)(53936002)(6246003)(256004)(105586002)(99286004)(5024004)(7696005)(97736004)(2906002)(25786009)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3024;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FnJ0f6k8eptKtq5dC3ji4gvjNRsWyl/vd2/KXLFrqKJjtNiPQSsL6IFJMoRz9bTwx2KRaMwdVA27He/K1xrLZXqIBdgbbcvVpymcSUWhsYlDb+hWi+2z7be2i/HFPzVA6ZP99Vdl7UBMVRS4X3838esbPTN22zPUSORD+Fog4pMVmnDA33SarNXL5JbP54AjvtCiTkmQL4h2bR3MnKgXr6dLLSmpzWXc1wvVRyle5rSMZbaDUWRPpT4olyGYDxfASw6ZtVZAoJUe1j2PMieXhuTSQbXj8YWjDNF9fue2plgSf5/RsbAEaOoqw0nst9xglESz1gSPftQw6fje6+ybii7gjqOOyQ/zsUAZo7pQz7yN2jizwVZQliXVCuZ7/APW4+lpYQgDV+DRWVAh0idKZ+4kFx1RcyfTYyz1cxkbw4g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e10b4f-afe8-40cd-3e22-08d6bc2ef68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:32:00.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
overall looks good for me.=0A=
=0A=
I would just prefer to change the define name for temperature to INV_ICM206=
02_SCAN_TEMP. It is the chip temperature that can be used for temperature c=
ompensation for both accel and gyro data.=0A=
=0A=
But it is really just a details.=0A=
=0A=
Best regards,=0A=
Jean-Baptiste Maneyrol=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, April 7, 2019 13:45=0A=
To: stevemo@skydio.com=0A=
Cc: Jean-Baptiste Maneyrol; Hartmut Knaack; Lars-Peter Clausen; Peter Meerw=
ald-Stadler; Martin Kelly; Jonathan Marek; Brian Masney; Randolph Maa=DFen;=
 Douglas Fischer; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org=
=0A=
Subject: Re: [PATCH v2] iio: imu: mpu6050: Fix FIFO layout for ICM20602=0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Tue,=A0 2 Apr 2019 23:28:56 -0700=0A=
stevemo@skydio.com wrote:=0A=
=0A=
> From: Steve Moskovchenko <stevemo@skydio.com>=0A=
>=0A=
> The MPU6050 driver has recently gained support for the=0A=
> ICM20602 IMU, which is very similar to MPU6xxx. However,=0A=
> the ICM20602's FIFO data specifically includes temperature=0A=
> readings, which were not present on MPU6xxx parts. As a=0A=
> result, the driver will under-read the ICM20602's FIFO=0A=
> register, causing the same (partial) sample to be returned=0A=
> for all reads, until the FIFO overflows.=0A=
>=0A=
> Fix this by adding a table of scan elements specifically=0A=
> for the ICM20602, which takes the extra temperature data=0A=
> into consideration.=0A=
>=0A=
> While we're at it, fix the temperature offset and scaling=0A=
> on ICM20602, since it uses different scale/offset constants=0A=
> than the rest of the MPU6xxx devices.=0A=
>=0A=
> Signed-off-by: Steve Moskovchenko <stevemo@skydio.com>=0A=
I'd like a reviewed-by or acked-by from Jean-Baptiste on this before=0A=
I take it.=0A=
=0A=
thanks,=0A=
=0A=
Jonathan=0A=
=0A=
> ---=0A=
> v2: Read temperature when running in accel-only mode, too.=0A=
>=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 ++++++++++++++++++++--=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 | 20 +++++++++-=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |=A0 3 ++=0A=
>=A0 3 files changed, 64 insertions(+), 5 deletions(-)=0A=
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
> index 325afd9f5f61..2ed4b98e0cd7 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> @@ -208,6 +208,9 @@ struct inv_mpu6050_state {=0A=
>=A0 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR=A0=A0 6=0A=
>=A0 #define INV_MPU6050_FIFO_COUNT_BYTE=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=0A=
>=A0=0A=
> +/* ICM20602 FIFO samples include temperature readings */=0A=
> +#define INV_ICM20602_BYTES_PER_TEMP_SENSOR=A0=A0 2=0A=
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
> +/* scan element definition for ICM20602, which includes temperature */=
=0A=
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
> index 548e042f7b5b..57bd11bde56b 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> @@ -207,6 +207,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.gyro_fifo_enable)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU=
6050_BYTES_PER_3AXIS_SENSOR;=0A=
>=A0=0A=
> +=A0=A0=A0=A0 if (st->chip_type =3D=3D INV_ICM20602)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_ICM20602_B=
YTES_PER_TEMP_SENSOR;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 /*=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * read fifo_count register to know how many bytes=
 are inside the FIFO=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * right now=0A=
=0A=
