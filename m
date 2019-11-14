Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B35BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C4B2068D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="h+gRlHXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKNOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:16:42 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:57996
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfKNOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQUJAERYPFReQKHKQQFerN1A3lN5NS3UPupTy9GC4vWNrux63XJ6SpSoESDpke33Zoe8nUd8bnKHbwLTfD+Em8ZldB1S7jWMkAJ/wF/v2rSHqm5LoIyoYrIRie9cuk7KqQzXInNXrVLNaT8OsPR9M5KaPjsUTFatqzhtZ6uYWREONzb2X49NuvAm87ZS+w3AgGlSy3fOOCnwVsb2ahvQvHfJLO/agaLCnIDSa4JY0pzOkAW+uofar3FJIvAtb9KTLad7bMxqWxf7IROfzXZkZVDyUGbZ7jj9XjWC6cNO6S3qisD3GQBxO6VxGiwp6FJ8ed4UZELWGQ1krua0ABtvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzkG/kKQlobcXM0xApI4jfRZhS2DhZ39rNCDCYo8L9g=;
 b=kKRR6E+zHSWjgN8DvCXJ4M4CK3ZbuuVjlsQZhk26W9M0bviLgTe9vVkfws80YRd16NkWsLm3vLJa5TnYF78jyw1iPT+7o9UFlAUBJOCuPJucWV9oA4+iz7GJBPFfzynzQWGAvoKkftBb8RB4MRtsNbtAY/KNX3sfbCGHIuD+7RLIOYlMv0mqeeDIqwCVDPdHWbUgWDYkHzuK+FabBuhOVfqofqmWKpk/qyWSI4GETQ+DyHP6Ia0FUmA6tHp7oWj4kXg7Q0fxuNiKTNcvR+HyD0ezkZsLu7bjV2yn8HJbl+zhj7RvWX3DmxF9Udi9cRHPbBfvjMnfYrViXce9kkpjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzkG/kKQlobcXM0xApI4jfRZhS2DhZ39rNCDCYo8L9g=;
 b=h+gRlHXw0IXl+1lWmfYFyE10UBVK6G09Tux6iKuz6vj1HeUvsvKm/27f5R9faxZCfmG8t/+ljbrV4/JlR4tx3myR1aD4aqSeSvbzABVxmVQVHpcQjvxZuhBN591vTUXUSz3Z2AV/z8wAqASsl8Q1KovTRQqXC+HQg5YwJYsh36w=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2664.eurprd05.prod.outlook.com (10.172.230.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 14:16:38 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2451.027; Thu, 14 Nov
 2019 14:16:38 +0000
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
Subject: RE: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmnw2jQvA7h95R066pXtlC6V86aeKtSxg
Date:   Thu, 14 Nov 2019 14:16:38 +0000
Message-ID: <DB6PR0501MB2712658DD269E4B22A327A2DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191113234133.3790374-1-vijaykhemka@fb.com>
In-Reply-To: <20191113234133.3790374-1-vijaykhemka@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62ed0658-f045-400c-b62a-08d7690d4392
x-ms-traffictypediagnostic: DB6PR0501MB2664:
x-microsoft-antispam-prvs: <DB6PR0501MB2664A49B68FE9A1B4383F64ADA710@DB6PR0501MB2664.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(13464003)(52536014)(14444005)(6246003)(256004)(478600001)(305945005)(9686003)(86362001)(66946007)(6506007)(53546011)(6436002)(66556008)(64756008)(66446008)(2906002)(80792005)(55016002)(7736002)(66476007)(7696005)(25786009)(74316002)(5660300002)(2501003)(2201001)(76176011)(81166006)(81156014)(8676002)(186003)(446003)(11346002)(476003)(6116002)(14454004)(110136005)(54906003)(33656002)(229853002)(486006)(66066001)(3846002)(316002)(99286004)(26005)(71190400001)(7416002)(71200400001)(102836004)(8936002)(76116006)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2664;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gmt2q9j48u0aistliTOoX9Fi7dhvg9y+uemO+DjhIgKTBejNIpH5uGuPfMMW44RH7wNL7t0Gs3hlCnU261MtRfYtX1tozYgoaY8pM3iG7PXsRFV9d8Jo64c+qsiwvuVgBXBdJPXkOUNWe66ZFaKWXz66J3fMLEr2GXO8VFjYIVXLz3BQN9BWUUCp86Yndq1Zfa225IA4YcQlSd8T9OpqNCnJLrZsmAdUO3MbmXb98UPmq+t+iDS7V5DcU8vhUxcvIgpMmW6FMJyRNW49k/i8cX/NuB1eMJwgCSs2AzHmp/eYKsnpRYPQZxKXvS1CZAkmGudyyZEXNs4mGd8cQiYKM8iOUnwOB2llFE1z2zN0uGLxPPnofpjT6K61vpo0c4ZevkBWYdlX6r0fP53xLZqPOChHRYm9kc/uY3DRvTlGyiRVnPmz4yN9JHGKUA8RigIb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ed0658-f045-400c-b62a-08d7690d4392
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 14:16:38.3874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OUwh2qkGlN4fdtc2cKsC0CyXjG3vqfKeSpY7oQPav7xpeGSlcoA1xvB/OcitCTPuMOKroCUYfytuMA2meJyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

You haven't addressed some of my comments.

-----Original Message-----
From: Vijay Khemka <vijaykhemka@fb.com>=20
Sent: Wednesday, November 13, 2019 6:42 PM
To: Corey Minyard <minyard@acm.org>; Arnd Bergmann <arnd@arndb.de>; Greg Kr=
oah-Hartman <gregkh@linuxfoundation.org>; openipmi-developer@lists.sourcefo=
rge.net; linux-kernel@vger.kernel.org
Cc: vijaykhemka@fb.com; cminyard@mvista.com; Asmaa Mnebhi <Asmaa@mellanox.c=
om>; joel@jms.id.au; linux-aspeed@lists.ozlabs.org; sdasari@fb.com
Subject: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB

Many IPMB devices doesn't support smbus protocol and current driver support=
 only smbus devices. Added support for raw i2c packets.

User can define i2c-protocol in device tree to use i2c raw transfer.

A>> Please fix the description as suggested in previous comments

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_=
int.c
index ae3bfba27526..10904bec1de0 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -63,6 +63,7 @@ struct ipmb_dev {
 	spinlock_t lock;
 	wait_queue_head_t wait_queue;
 	struct mutex file_mutex;
+	bool is_i2c_protocol;
 };
=20
 static inline struct ipmb_dev *to_ipmb_dev(struct file *file) @@ -112,6 +1=
13,25 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size=
_t count,
 	return ret < 0 ? ret : count;
 }
=20
+static int ipmb_i2c_write(struct i2c_client *client, u8 *msg) {
+	struct i2c_msg i2c_msg;
+
+	/*
+	 * subtract 1 byte (rq_sa) from the length of the msg passed to
+	 * raw i2c_transfer
+	 */
+	i2c_msg.len =3D msg[IPMB_MSG_LEN_IDX] - 1;
+
+	/* Assign message to buffer except first 2 bytes (length and address) */
+	i2c_msg.buf =3D msg + 2;
+
+	i2c_msg.addr =3D GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);

You can have:
i2c_msg.flags =3D addr;
addr being an argument of the ipmb_i2c_write function and passed in ipmb_wr=
ite. We already define it.

+	i2c_msg.flags =3D client->flags & I2C_CLIENT_PEC;
+
+	return i2c_transfer(client->adapter, &i2c_msg, 1); }
+
 static ssize_t ipmb_write(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
@@ -133,6 +153,12 @@ static ssize_t ipmb_write(struct file *file, const cha=
r __user *buf,
 	rq_sa =3D GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
 	netf_rq_lun =3D msg[NETFN_LUN_IDX];
=20
+	/* Check i2c block transfer vs smbus */
+	if (ipmb_dev->is_i2c_protocol) {
+		ret =3D ipmb_i2c_write(ipmb_dev->client, msg);
+		return (ret =3D=3D 1) ? count : ret;
+	}
+
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
 	 * i2c_smbus_xfer
@@ -277,6 +303,7 @@ static int ipmb_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ipmb_dev *ipmb_dev;
+	struct device_node *np;
 	int ret;
=20
 	ipmb_dev =3D devm_kzalloc(&client->dev, sizeof(*ipmb_dev), @@ -302,6 +329=
,11 @@ static int ipmb_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
=20
+	/* Check if i2c block xmit needs to use instead of smbus */
+	np =3D client->dev.of_node;
+	if (np && of_get_property(np, "i2c-protocol", NULL))
+		ipmb_dev->is_i2c_protocol =3D true;

I know Corey said that ACPI is not a priority but many companies (including=
 mine) use ACPI and I would prefer if we implement it. All you need to do i=
s use
device_property_read_u32 function instead of of_get_property:
ret =3D device_property_read_u32(&client->dev, "i2c-protocol", &ipmb_dev->i=
s_i2c_protocol);
This function does the job for both dt and acpi.

+
 	ipmb_dev->client =3D client;
 	i2c_set_clientdata(client, ipmb_dev);
 	ret =3D i2c_slave_register(client, ipmb_slave_cb);
--
2.17.1

