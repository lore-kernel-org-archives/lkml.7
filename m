Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE965C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE002182B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EOyMivXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfFSNjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:39:25 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:40313
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730389AbfFSNjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsjJ0XI2c9TL20rAgEVRx6je+eKBuW33uCFRUeRQMck=;
 b=EOyMivXirduLwsBL9zBkar/78808ci0UkV2QtqH32q6Tvv+jJs7Ll5a38gApzYZfUNUBGq4RIk/2X3wlOsGpvIwI3CUDEextGwIA8mqbGAsWWPQydlQ9D8HsVsxGJ51qoRKCJwS3ZIkG19NjI5fswdWLFCCKdFsD3V79BTW3EvY=
Received: from VI1PR05MB6239.eurprd05.prod.outlook.com (20.178.124.30) by
 VI1PR05MB5407.eurprd05.prod.outlook.com (20.177.63.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 13:39:20 +0000
Received: from VI1PR05MB6239.eurprd05.prod.outlook.com
 ([fe80::9db8:5404:48e4:d7f2]) by VI1PR05MB6239.eurprd05.prod.outlook.com
 ([fe80::9db8:5404:48e4:d7f2%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 13:39:20 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>, Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vadim Pasternak <vadimp@mellanox.com>,
        Corey Minyard <cminyard@mvista.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ipmi: ipmb: don't allocate i2c_client on stack
Thread-Topic: [PATCH] ipmi: ipmb: don't allocate i2c_client on stack
Thread-Index: AQHVJp2fQC/TzrHQG025Fo3gniO4X6ai+YIA
Date:   Wed, 19 Jun 2019 13:39:20 +0000
Message-ID: <VI1PR05MB623982A86E259CE5F9E5A771DAE50@VI1PR05MB6239.eurprd05.prod.outlook.com>
References: <20190619125045.918700-1-arnd@arndb.de>
In-Reply-To: <20190619125045.918700-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc7a073-119c-4ffe-4f61-08d6f4bb889a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5407;
x-ms-traffictypediagnostic: VI1PR05MB5407:
x-microsoft-antispam-prvs: <VI1PR05MB540744B6E629BE1D426314ECDAE50@VI1PR05MB5407.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(13464003)(189003)(199004)(52536014)(66066001)(76116006)(81156014)(81166006)(55016002)(7696005)(68736007)(102836004)(71200400001)(26005)(71190400001)(7736002)(2906002)(8676002)(6246003)(14454004)(3846002)(6116002)(5660300002)(66946007)(476003)(8936002)(229853002)(73956011)(76176011)(316002)(256004)(14444005)(66446008)(446003)(4326008)(486006)(25786009)(6436002)(99286004)(64756008)(110136005)(11346002)(9686003)(33656002)(305945005)(74316002)(54906003)(186003)(72206003)(53936002)(86362001)(478600001)(66476007)(53546011)(6506007)(80792005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5407;H:VI1PR05MB6239.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fqJjyHUA7dXWBb1bhqNftVk/bHP0hOFk5Rz6yGnektZZuag5gLbZu9kQrT9MmoDsPqRQrRnk3cFw80cjGuN+YkAztOcGJBKPTJk4BHUrhSDeClvbU4VPBxf4BEsPhbm2O26fUm13NADJIMGdY6esmvUg6eqENs1hXL6nFZ9b+TUDQXhZvaT9FLKUv4/7BEzaiRST6lCvqTM5gUTAZFhZxXkgHOeGoCN/iXUSN4vaFAo4cnh8qDJfAKsRw7ihJkAuJ2pebAr2TKXIBFiy60q5E0hhXBQxhjtiUsM55eVA3sDjySd3llOcLcKH5EyIWrBuMX0lX+ZbkQoM/1U1l2efJ0cAgjN7Iepo5oo0dpuwqnKjW82t7kn71e3Mg2L+WI3BcxhEj4ovBjbFRaxs08PJfkTiFkzWQr0dESkDxChWK8c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc7a073-119c-4ffe-4f61-08d6f4bb889a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 13:39:20.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Asmaa@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

LGTM.=20

-----Original Message-----
From: Arnd Bergmann <arnd@arndb.de>=20
Sent: Wednesday, June 19, 2019 8:51 AM
To: Corey Minyard <minyard@acm.org>; Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org>
Cc: Arnd Bergmann <arnd@arndb.de>; Asmaa Mnebhi <Asmaa@mellanox.com>; Vadim=
 Pasternak <vadimp@mellanox.com>; Corey Minyard <cminyard@mvista.com>; open=
ipmi-developer@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: ipmb: don't allocate i2c_client on stack

The i2c_client structure can be fairly large, which leads to a warning abou=
t possible kernel stack overflow in some
configurations:

drivers/char/ipmi/ipmb_dev_int.c:115:16: error: stack frame size of 1032 by=
tes in function 'ipmb_write' [-Werror,-Wframe-larger-than=3D]

There is no real reason to even declare an i2c_client, as we can simply cal=
l i2c_smbus_xfer() directly instead of the i2c_smbus_write_block_data() wra=
pper.

Convert the ipmb_write() to use an open-coded i2c_smbus_write_block_data() =
here, without changing the behavior.

It seems that there is another problem with this implementation; when user =
space passes a length of more than I2C_SMBUS_BLOCK_MAX bytes, all the rest =
is silently ignored. This should probably be addressed in a separate patch,=
 but I don't know what the intended behavior is here.

Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ipmi/ipmb_dev_int.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_=
int.c
index 2895abf72e61..c9724f6cf32d 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -117,7 +117,7 @@ static ssize_t ipmb_write(struct file *file, const char=
 __user *buf,  {
 	struct ipmb_dev *ipmb_dev =3D to_ipmb_dev(file);
 	u8 rq_sa, netf_rq_lun, msg_len;
-	struct i2c_client rq_client;
+	union i2c_smbus_data data;
 	u8 msg[MAX_MSG_LEN];
 	ssize_t ret;
=20
@@ -138,17 +138,17 @@ static ssize_t ipmb_write(struct file *file, const ch=
ar __user *buf,
=20
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
-	 * i2c_smbus_write_block_data_local
+	 * i2c_smbus_xfer
 	 */
 	msg_len =3D msg[IPMB_MSG_LEN_IDX] - SMBUS_MSG_HEADER_LENGTH;
-
-	strcpy(rq_client.name, "ipmb_requester");
-	rq_client.adapter =3D ipmb_dev->client->adapter;
-	rq_client.flags =3D ipmb_dev->client->flags;
-	rq_client.addr =3D rq_sa;
-
-	ret =3D i2c_smbus_write_block_data(&rq_client, netf_rq_lun, msg_len,
-					msg + SMBUS_MSG_IDX_OFFSET);
+	if (msg_len > I2C_SMBUS_BLOCK_MAX)
+		msg_len =3D I2C_SMBUS_BLOCK_MAX;
+
+	data.block[0] =3D msg_len;
+	memcpy(&data.block[1], msg + SMBUS_MSG_IDX_OFFSET, msg_len);
+	ret =3D i2c_smbus_xfer(ipmb_dev->client->adapter, rq_sa, ipmb_dev->client=
->flags,
+			     I2C_SMBUS_WRITE, netf_rq_lun,
+			     I2C_SMBUS_BLOCK_DATA, &data);
=20
 	return ret ? : count;
 }
--
2.20.0

