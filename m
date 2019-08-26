Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD63C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593CC217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="g+9gji3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfHZKCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:02:30 -0400
Received: from mail-eopbgr760049.outbound.protection.outlook.com ([40.107.76.49]:13919
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbfHZKC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:02:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AydWuuczw65STyoW5dHAsOC6khDUeW3GZac/5i1zY4rDMsycer48vHyLheo8eiuVnygc836oNVpM8qsWZj9iLBnsFgXJUTV0YDcd2TtfyOG1OVDXj4nc3aXCtD11gdKPaZhj0k3xovYEQJlAaVzkrq8oPz3NuuQg9nrdpAj8t6ze8n0oy8de4Fv3aBrqm1IGfTHeo3vYB5+V+nT/QsIGUVeMQNfMLEELuxXn7M2ZnBQ/1HUDvzsURE2giRLhjvRbJHH3ZNs//AHr2kPcB9BeEXArdvwJZzNv7j2bn3+v6p87+KrFx4wZ7CtujsvY8MztwHxX1GDL7fTUa2JOydn1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccqz7W9lHpMSEfVMqMuvBMBPZov8vGKI3pvRoOSrANo=;
 b=CSUx2HJ5zqlkv24p1ZwzR3/u8p+9p7+xfrBHU5nx0to3CepkQ6tO3PcYE1DE+jvEBVzRKM3hCofCR0AzrK4oHe9ohQcBH2yl/3hzYJngHSFBFOmuxaINziR7SqKNQCTvwXg+dBrnvdiyijof5HxqFyqv/py5/9uhKLs1f4NhKQa/+65dvmEnISNioHqvD02Qsot/2wEMTL01jIvXf3DfWGAh8LjXwSHW9apBvC3A+0Nq+48DBfjiJg+FRhSv1lM1I9bPpv+R5r44gp7AKjcbb9FNjTMl5n5gDRwDgKxKFlh6AUFC3qo/7cRefamTk1Jv/Yh3y19SNdNozbZ7CE5CJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccqz7W9lHpMSEfVMqMuvBMBPZov8vGKI3pvRoOSrANo=;
 b=g+9gji3qVFMUZlqWBHzisbWAbUgNC6aLW0AlG6DWZdmHa1mLCL1DNHd82CnL5dp0J3ORI846aSJ73GO6m5X0aWOPlDjJ7rJxbAbJpaiCLNvpj6TEbLrElda0+wEcRP2miTE6b7rkdFLa95UUGPuVzBfov0cYiNYAf3vgm9T2iiU=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4135.namprd03.prod.outlook.com (20.177.184.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Mon, 26 Aug 2019 10:02:27 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 10:02:27 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: (as370-hwmon) Add DT bindings for Synaptics AS370
 PVT
Thread-Topic: [PATCH 2/2] hwmon: (as370-hwmon) Add DT bindings for Synaptics
 AS370 PVT
Thread-Index: AQHVW/VdbV2LB6M7uUCh+nMeq42XPA==
Date:   Mon, 26 Aug 2019 10:02:27 +0000
Message-ID: <20190826175113.74be0368@xhacker.debian>
References: <20190826174942.2b28ff05@xhacker.debian>
In-Reply-To: <20190826174942.2b28ff05@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYXPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:403:a::28) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 843419ce-c95d-4272-2969-08d72a0c7fd4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4135;
x-ms-traffictypediagnostic: BYAPR03MB4135:
x-microsoft-antispam-prvs: <BYAPR03MB4135276277929292F33A774BEDA10@BYAPR03MB4135.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(189003)(386003)(2906002)(186003)(25786009)(6506007)(50226002)(4326008)(53936002)(102836004)(26005)(305945005)(6512007)(446003)(9686003)(11346002)(8936002)(14454004)(66066001)(66446008)(478600001)(99286004)(7736002)(6486002)(81156014)(76176011)(6436002)(64756008)(81166006)(66556008)(54906003)(5660300002)(86362001)(486006)(8676002)(256004)(4744005)(3846002)(6116002)(66946007)(71190400001)(71200400001)(110136005)(66476007)(1076003)(52116002)(476003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4135;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nVfvPwtdyg6nySqzn9bz/STT0yCHeZ3As9IyuCgIq+NXDkOE2z58ZV9HpjaazefK2mvaT/zcHicEVfM0bZz/ocqMAqn3q0nPvrCzfjYxf/221hgfl0JT+vP+3Yezffvj+IOjrb5EdN729fwPnaxrbMHYl3wNlNhsJLS1NM1brptK6IOpvHSPk+chgcEi4ltlwJ2qnZKPcSeNxPRswil17Wpj0T6Y2xN676YjrQ23vS6vg/cKfuCVpmfyA5+39mGikDDYdw7mFfPuvPhcqvqLNJjRURciDEwW7x+6qXe3QnYQSCusoyjrRFGVuHy0/Pe3rm5zKK47yo7o8kQHdJuqXw6qGoR9AFNYZgNGRTgkOHiBnKA2xhsEitCPRBNKboxVb6oSqLZ2lseli2lomBR2bxa1ft6/GXYW3dls9LRYKy0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <252215FE06C11B46B99BDE304DC6DA60@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843419ce-c95d-4272-2969-08d72a0c7fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 10:02:27.1847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxbR/YSUN+Ba2mwJm7l80FaKJ54iD6Q3+KgAyv24eO3wUKl5HdPFRSW+uxlG+3+/rD07QyrJ1aHDN0D6wz36iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Synaptics AS370 PVT sensors.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/hwmon/as370.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt

diff --git a/Documentation/devicetree/bindings/hwmon/as370.txt b/Documentat=
ion/devicetree/bindings/hwmon/as370.txt
new file mode 100644
index 000000000000..d102fe765124
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/as370.txt
@@ -0,0 +1,11 @@
+Bindings for Synaptics AS370 PVT sensors
+
+Required properties:
+- compatible : "syna,as370-hwmon"
+- reg        : address and length of the register set.
+
+Example:
+	hwmon@ea0810 {
+		compatible =3D "syna,as370-hwmon";
+		reg =3D <0xea0810 0xc>;
+	};
--=20
2.23.0.rc1

