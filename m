Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A98C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53E0206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Xau+qgSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKMUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:33:02 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:33630
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfKMUdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:33:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ski7WenfhqOJZQz52QrXRe86LEUOuGxTWkpBSnnaQdtWl0RdK/qM09QSFMNxqrvoJ3Eu0lHhuCY8wOcUSehmRlT29f/AZ+b7H2z098LmVFTbob6AzJEi1rzqWw5BEsB487GkBsabbH0g7HxqG8BumFNDzwHMM5TNTL9dnUjYKo0/PlKirgJM6tvYuaO/DM/NmwPV04HOJPnaP9ec+OD8NeepoLDQqyS/C6HfDkp1Iusqzw1DN+86W5zpiAHsD+ieqjU++DgL6HsZkNU40IlxDB7oZUY27+OLbHqbeut0VMBFnWIfGHSrRNauLw1KOGG7gFyvNXI6zZeGDUv+qKRczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1isM0vHCvgwocFX9Dz123HMiWNwj84fZ21Xj+npaHuA=;
 b=IEjo+Qjz+cmr/rSB+25bIvz+lrt2RfQvGie56jGOf6fnjXtRlvw0+PjMgOG3DaUdsnocsFtvn5DdQd1R5ZMqorBGHvv+EafOxTURDZkyikZcHlZFELo1rGQA1QSa/tX18T/SjwfZNn+zn6OLEMzypbToTNJrjXDBCMq7ZKtMpdrwNSvXaMgo5X5/UolpYdkpnZZRjGm9xnEUq/dLV//tLGUTV+IkOFOc0LCXElGrk4Retl90NBH5p3dD1HHKwiAdivNTOH/3Nv1lMCujTJWYrs9EB0F/bZ2gkCRGc0A7liWd8ZZikO/8R6MDfi9B6vf/Z58YIooPz+yNf4alg4qQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1isM0vHCvgwocFX9Dz123HMiWNwj84fZ21Xj+npaHuA=;
 b=Xau+qgSzBAZrdLoBzIcvoAlqO8LXj+wf0uJaM8HwxRm7TLaigIzHj5BAGIrCPTdZFs0cvLxzlH2/nGm86f92qHJmOikYZiaqDhkUCZ6HUD7/ohx5DCxNyRhuXh1ryVZ1moy/+WMl6em5JW44fHSqybihuf3kYuM/Qn9saSHe25w=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2616.eurprd05.prod.outlook.com (10.172.230.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 20:32:58 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2430.028; Wed, 13 Nov
 2019 20:32:57 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     Vijay Khemka <vijaykhemka@fb.com>, Corey Minyard <minyard@acm.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "sdasari@fb.com" <sdasari@fb.com>
Subject: RE: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmlgl1O96SHtmeUyoyP3vT4129aeJh9MQ
Date:   Wed, 13 Nov 2019 20:32:57 +0000
Message-ID: <DB6PR0501MB2712FAF45EE8CB2D513465A9DA760@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191113192325.2821207-1-vijaykhemka@fb.com>
In-Reply-To: <20191113192325.2821207-1-vijaykhemka@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bef2e555-82d9-4217-d319-08d76878ab88
x-ms-traffictypediagnostic: DB6PR0501MB2616:
x-microsoft-antispam-prvs: <DB6PR0501MB26169F7BB501E69EA19A5AABDA760@DB6PR0501MB2616.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(189003)(199004)(13464003)(6506007)(53546011)(102836004)(76176011)(486006)(446003)(11346002)(476003)(33656002)(186003)(99286004)(26005)(80792005)(8676002)(7416002)(76116006)(7736002)(7696005)(305945005)(8936002)(74316002)(256004)(81166006)(81156014)(14444005)(66066001)(3846002)(6116002)(14454004)(6246003)(9686003)(2501003)(4326008)(2906002)(478600001)(25786009)(5660300002)(71190400001)(71200400001)(110136005)(66476007)(54906003)(229853002)(66556008)(64756008)(66446008)(66946007)(6436002)(55016002)(316002)(86362001)(52536014)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2616;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KOqFfxyVaxSBz4NnFDPUj7yHbj8UfBfgtBjTdohSYIYskRTxYg4R0qumf51Nvlsntj1rotjgE7Bvd8pZeJQIHBYQegVx/AUn+SlAXQxYKi42OsVR7muJ4avk4bc55zJ9aEbbbH1KHhzHGEzpWVuBU4+wAFuRFFCiE8OcAdZ31nnr0eH/O0Kd4YXIhuI3qmuWC0mJKqMzffrDQm6yVORKV0RL4C65YMoUmIppqeR8OT3CtjiCn3SA6ndzYxZBf9ZI8CaEkCHnFvBwU/bD6w0cmk0phkpGEmAm+FhoR+0f3WNG+Y8Jd58KxXwtOFuMsPjD/h+XUkBgEl5JFlQlvnAS80hl7wuN5kWV4awYhveWUeatGBESXGUUdu2hJLbs5FegtJfvEzmVzuk3hCwhsaZppH2IOGF9zgB73JDeUJSscYX/1TKsbCQvEc6vCd+S91K
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef2e555-82d9-4217-d319-08d76878ab88
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 20:32:57.8909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VQ2MyFr/CGf4+jzOxAxtWZfkQa3z9n1a/O5QoO4/iLRKAC7qEd2t062xVJ2GlbV1HT88QRFoXdYtYhMP9vyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline response:

-----Original Message-----
From: Vijay Khemka <vijaykhemka@fb.com>=20
Sent: Wednesday, November 13, 2019 2:23 PM
To: Corey Minyard <minyard@acm.org>; Arnd Bergmann <arnd@arndb.de>; Greg Kr=
oah-Hartman <gregkh@linuxfoundation.org>; openipmi-developer@lists.sourcefo=
rge.net; linux-kernel@vger.kernel.org
Cc: vijaykhemka@fb.com; cminyard@mvista.com; Asmaa Mnebhi <Asmaa@mellanox.c=
om>; joel@jms.id.au; linux-aspeed@lists.ozlabs.org; sdasari@fb.com
Subject: [PATCH v3] drivers: ipmi: Support raw i2c packet in IPMB

Many IPMB devices doesn't support smbus protocol and current driver support=
 only smbus devices. Added support for raw i2c packets.

User can define use-i2c-block in device tree to use i2c raw transfer.

Asmaa>> Fix the description: "The ipmb_dev_int driver only supports the smb=
us protocol at the moment. Add support for the i2c protocol as well. There =
will be a variable passed by though the device tree or ACPI table which set=
s the configures the protocol as either i2c or smbus."

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_=
int.c
index ae3bfba27526..16d5d4b636a9 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -63,6 +63,7 @@ struct ipmb_dev {
 	spinlock_t lock;
 	wait_queue_head_t wait_queue;
 	struct mutex file_mutex;
+	bool use_i2c;
 };
=20
Asmaa>> rename this variable : is_i2c_protocol

 static inline struct ipmb_dev *to_ipmb_dev(struct file *file) @@ -112,6 +1=
13,39 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size=
_t count,
 	return ret < 0 ? ret : count;
 }
=20
+static int ipmb_i2c_write(struct i2c_client *client, u8 *msg) {
+	unsigned char *i2c_buf;
+	struct i2c_msg i2c_msg;
+	ssize_t ret;
+	u8 msg_len;
+
+	/*
+	 * subtract 1 byte (rq_sa) from the length of the msg passed to
+	 * raw i2c_transfer
+	 */
+	msg_len =3D msg[IPMB_MSG_LEN_IDX] - 1;
+
+	i2c_buf =3D kzalloc(msg_len, GFP_KERNEL);

Asmaa >> We do not want to use kzalloc every time you execute this write fu=
nction. It would create so much fragmentation.
You don't really need to use kzalloc anyways.=20

Also, this code chunk is short, so you can call it directly from the write =
function. I don't think you need a separate function for it.

+	if (!i2c_buf)
+		return -EFAULT;
+
+	/* Copy message to buffer except first 2 bytes (length and address) */
+	memcpy(i2c_buf, msg+2, msg_len);
+
+	i2c_msg.addr =3D GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
+	i2c_msg.flags =3D client->flags &
+			(I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB);
Asmaa>> I don't think ipmb supports 10 bit addresses. The max number of bit=
s in the IPMB address field is 8.

+	i2c_msg.len =3D msg_len;
+	i2c_msg.buf =3D i2c_buf;
+
+	ret =3D i2c_transfer(client->adapter, &i2c_msg, 1);
+	kfree(i2c_buf);
+
+	return ret;
+
+}
+
 static ssize_t ipmb_write(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
@@ -133,6 +167,12 @@ static ssize_t ipmb_write(struct file *file, const cha=
r __user *buf,
 	rq_sa =3D GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
 	netf_rq_lun =3D msg[NETFN_LUN_IDX];
=20
+	/* Check i2c block transfer vs smbus */
+	if (ipmb_dev->use_i2c) {
+		ret =3D ipmb_i2c_write(ipmb_dev->client, msg);
+		return (ret =3D=3D 1) ? count : ret;
+	}
+
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
 	 * i2c_smbus_xfer
@@ -277,6 +317,7 @@ static int ipmb_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ipmb_dev *ipmb_dev;
+	struct device_node *np;
 	int ret;
=20
 	ipmb_dev =3D devm_kzalloc(&client->dev, sizeof(*ipmb_dev), @@ -302,6 +343=
,13 @@ static int ipmb_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
=20
+	/* Check if i2c block xmit needs to use instead of smbus */
+	np =3D client->dev.of_node;
+	if (np && of_get_property(np, "use-i2c-block", NULL))
Asmaa>> Rename this variable i2c-protocol. And also, apply this to ACPI as =
well.
+		ipmb_dev->use_i2c =3D true;
+	else
+		ipmb_dev->use_i2c =3D false;
+
 	ipmb_dev->client =3D client;
 	i2c_set_clientdata(client, ipmb_dev);
 	ret =3D i2c_slave_register(client, ipmb_slave_cb);
--
2.17.1

