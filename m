Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B1C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DCD2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="c2IU8i+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfH0DpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:45:01 -0400
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:51842
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728345AbfH0DpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwjyZQB703kIBNttqnaWdAOaHtOvlXWquHFA8OU3PUJfvfBUTfyQUVLekjpzxXjVBfhYNiquRg0FSmeDasbP5MClLxlYHCt5r/0+XV4uld5V95s1ZF2FkcigzQNJlAzGQ29tnzC9Frzw9kcKh502BLeoEhyeKOMTqU2ZIFHK4v7RHITWMjiUTxt4UjEJDTbqeXvzhDdr75BBsKjlNgaTvcihZEF1ysrWZdfbi8O24ZkIB5nKjfotDsDif8oJpzgzinBCVg6nTFfpBDwEHJwRXYrIPjZ4czuEvlt/nQAAeo47f0SjIU+8J7zOhQ4EYimlvubMNK9a6nvmScN37eVD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccqz7W9lHpMSEfVMqMuvBMBPZov8vGKI3pvRoOSrANo=;
 b=MemUtu1Os2EzwDsuG3XBAwdkRvR01QlpXooUscV5NuDhKrJFRe+j8r/A33fURyGuaXLl0IvXj8mF9h/Z/ICfqBKbsutb7OpI2HmDkd+SgyQy1NvyHc2KjhqRggE4dUm3dCW1MLGvw7hBVu+Rk1iMoizbrf9mdshKFMhIa+ex1086R0EUkLzBogS+K6rdK1EZUNP5zdWUgkoAOx09VJ4o5B/38XLLLzAn8nubN2ILRU1E2UkTI+84XFo5UiPs3SDvyYDJdVjuRRZAL+NXBUxGQj9tsx8UOAVODc5MwW8it9X8ztmev7HiEU0nGqR/FNLDA8djS3/mBxlaTQNZFhZP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccqz7W9lHpMSEfVMqMuvBMBPZov8vGKI3pvRoOSrANo=;
 b=c2IU8i+PP7amnAnl0Ls/AltglSt5wKrEePuX7OaM9i5xDSZPcIg+mF92P/vQT23XzejHpSeQ1SHYP420Li12oShxsUY4SDpXcAD254ODysfsEto+eiQ0Rr4xRR5zID0/bkPOq0ojWMw1y1l32hR4KT+OtdTMpJ1bA9u3gVZH/2o=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3621.namprd03.prod.outlook.com (52.135.215.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 03:44:57 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 03:44:57 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] hwmon: (as370-hwmon) Add DT bindings for Synaptics
 AS370 PVT
Thread-Topic: [PATCH v2 2/2] hwmon: (as370-hwmon) Add DT bindings for
 Synaptics AS370 PVT
Thread-Index: AQHVXInLxpfuyCPOk0qBZBggFtFcnw==
Date:   Tue, 27 Aug 2019 03:44:57 +0000
Message-ID: <20190827113337.384457f6@xhacker.debian>
References: <20190827113214.13773d45@xhacker.debian>
In-Reply-To: <20190827113214.13773d45@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:404:42::25) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d55c992a-b010-4310-4489-08d72aa0ee0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3621;
x-ms-traffictypediagnostic: BYAPR03MB3621:
x-microsoft-antispam-prvs: <BYAPR03MB3621402C7ACE88A3B8E98A00EDA00@BYAPR03MB3621.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(6436002)(102836004)(476003)(26005)(186003)(1076003)(478600001)(386003)(305945005)(2906002)(8676002)(9686003)(8936002)(66066001)(446003)(6486002)(486006)(81156014)(11346002)(7736002)(4744005)(256004)(71200400001)(5660300002)(81166006)(14454004)(52116002)(86362001)(53936002)(110136005)(54906003)(76176011)(66946007)(3846002)(6116002)(66446008)(66476007)(64756008)(66556008)(71190400001)(99286004)(25786009)(6506007)(4326008)(316002)(6512007)(50226002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3621;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zwC0viifDlK9QBS3eAoxRAr5GiYWidOQprA0wK4wIeouO7ijXg2IhUQMX3yRreSL6LgJ/VOzVaTf5gDdp813qduALmRxX8LBSAH4I9c/IbmiNCPVL0Jo/F6BmwItuQ0Tg96UUiHba/c7GXL9Ni6AVRjoTN/QyW+nUXJZOlkZWoVlRse/yJSQp2hFTA1woeetp5FF3/c5xmr/kjHurbMizmTQElvLHXADkVORu8Bgl0VPIGfijK72KtmrBO24SCCHNt/hR3r2qurqk+SS2sqtu2eze5ykdXP2XcT5aNKL42aRK7sbD+vJph/L+/MToW1PaN8F9lL0aO8bsTV0eEkPu+i/QMdlifE7nhmfUN9XUlw0DcNabckju370nMpb47Ed5V2d98F8m5kJXEAYH+/HWRp874oBKnlP2XaiJf99jLA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81C5B70750D99244A7F4EAFA30C0A6DF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55c992a-b010-4310-4489-08d72aa0ee0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 03:44:57.5929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjaPuh1DaPPJM+qEFzTJH6PFN4m0VfXrDI9U10ijysdJgJ8cwPtukbO0k5J5lEnvefNXEv5IoEYm63kM18/0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3621
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

