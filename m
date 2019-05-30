Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D14C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4525AE2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="ZieqnJ7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfE3Gpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:45:52 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:48386
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbfE3Gpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBrNGSgkZ21YD5Q63BnIjqJhWQk0lwUGyBgRz8fs5Lk=;
 b=ZieqnJ7QhyllSUrzGlD8db7O9JBYtkvBIKV6g/U7pqR4ymxz2HbMIZlWKb82O9PW7pbQY1Wmz4aEtohPi5PW1PBKyun0fE8F/LVlvSJFtHvQaembHw0tWnvN+gkXFYzpMQLfFiuDR+grYvdgqOIVOH8CZzOyiFmGkbGERKO65y4=
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com (10.170.223.150) by
 DB6PR07MB3368.eurprd07.prod.outlook.com (10.175.233.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Thu, 30 May 2019 06:45:48 +0000
Received: from DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9]) by DB6PR07MB3336.eurprd07.prod.outlook.com
 ([fe80::8c1c:dbc5:e07b:2cf9%6]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 06:45:48 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Thread-Topic: [PATCH] hwmon: pmbus: protect read-modify-write with lock
Thread-Index: AQHVFrNQ+99R7vZxXEmCmU50geAhdg==
Date:   Thu, 30 May 2019 06:45:48 +0000
Message-ID: <20190530064509.GA13789@localhost.localdomain>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0010.eurprd03.prod.outlook.com
 (2603:10a6:3:76::20) To DB6PR07MB3336.eurprd07.prod.outlook.com
 (2603:10a6:6:1f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf69563-b5c6-4e45-8567-08d6e4ca72af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR07MB3368;
x-ms-traffictypediagnostic: DB6PR07MB3368:
x-microsoft-antispam-prvs: <DB6PR07MB33687D572FBF5729D9FC1BB2EF180@DB6PR07MB3368.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(486006)(7736002)(73956011)(4326008)(305945005)(66446008)(66066001)(386003)(66476007)(508600001)(53936002)(6512007)(64756008)(9686003)(14454004)(6506007)(3846002)(8936002)(66556008)(6116002)(110136005)(102836004)(61506002)(8676002)(81156014)(81166006)(71200400001)(256004)(476003)(14444005)(71190400001)(54906003)(52116002)(66946007)(86362001)(33656002)(6486002)(5660300002)(68736007)(25786009)(186003)(316002)(2906002)(6436002)(1076003)(99286004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3368;H:DB6PR07MB3336.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TbQ5vX4AzRSFK3tDIkghpLR8bXo5eAxhoJneC/Yu73fgUyf8WV56c/jbNIIHj+HSHNa1mQkyKPXPVRb3+hOWJP4dWXptwUVE8m/gqRpi6VPTitSiGo8kDwakNtdpBQY2ADICB7dF0kdf6AQaN5m/ubUVVtUrcgkZrNlFmevEVmLFYsRyT/SplCOzLxgLBC8Hwb3tYypMNQyGQdHRFNsrlF82ZTlHmmK4CigSF7ELOf9xkN4750pSZUxCh0l8GBRe/mP1GOwKmQVAgICugHbX4cXqlhKWSOj56ZnJ/My3JC1Q7RJBJLOAmM1mc/XKJMHcuRPmeH/JhZ95PgoB4J8vTyCULtjuKXzJ3sazHjz3aGE96z60fjMHkpcuqRACOyCHeYJZ6IGjCTWsZGE9PtJegh5pCT4xGlWsBO0VX+4GC84=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51762DD8C076964D9B6394DE0B4DA36C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf69563-b5c6-4e45-8567-08d6e4ca72af
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 06:45:48.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krzysztof.adamski@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation done in the pmbus_update_fan() function is a
read-modify-write operation but it lacks any kind of lock protection
which may cause problems if run more than once simultaneously. This
patch uses an existing update_lock mutex to fix this problem.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---

I'm resending this patch to proper recipients this time. Sorry if the
previous submission confused anybody.

 drivers/hwmon/pmbus/pmbus_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index ef7ee90ee785..94adbede7912 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -268,6 +268,7 @@ int pmbus_update_fan(struct i2c_client *client, int pag=
e, int id,
 	int rv;
 	u8 to;
=20
+	mutex_lock(&data->update_lock);
 	from =3D pmbus_read_byte_data(client, page,
 				    pmbus_fan_config_registers[id]);
 	if (from < 0)
@@ -278,11 +279,15 @@ int pmbus_update_fan(struct i2c_client *client, int p=
age, int id,
 		rv =3D pmbus_write_byte_data(client, page,
 					   pmbus_fan_config_registers[id], to);
 		if (rv < 0)
-			return rv;
+			goto out;
 	}
=20
-	return _pmbus_write_word_data(client, page,
-				      pmbus_fan_command_registers[id], command);
+	rv =3D _pmbus_write_word_data(client, page,
+				    pmbus_fan_command_registers[id], command);
+
+out:
+	mutex_lock(&data->update_lock);
+	return rv;
 }
 EXPORT_SYMBOL_GPL(pmbus_update_fan);
=20
--=20
2.20.1

