Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C6FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969D2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="h/LVoJ+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfH1GIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:08:55 -0400
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:21711
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfH1GIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:08:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW01XGIK3tH3PnLD3NmHruGFe2enKGIWdvUK3jCZ/HiPBLvMsRIvgahhf9n6J/sRIn06Kb5o0ktE8EhhGps2g1QtHaGZkBGdrHyvYPW+apjuPb7L+For+hRtDCt6og7hFcgcy2KnL378YB61M68WvikOxnWKB1luqL619OSdkQWch3q6X5leNUC0ut8ivVlcSF3tmxzYYiOEBDzVVW3COLToDtdQg+sMScxbwgh7D03A0QkdYFeGT1I4FIj3AoMxAkGRni9oxImFaXynLMKRR7JYuathj+1Ho6Sk67pqTo2LqrcruWDcBXruY3ntKHXeI20PRyJ5RdiVtuK+H0y58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RERL0TOi6wCwMg1U6k8F+/1A4BHrHMxNgHnSYhQVX1w=;
 b=c5diRC+A6dPKix2g1ztkd7sYU7DdmmsPp3k1lpjwUqUbJDg94KymnO/bEch/r7nYtjf/r1XIp6ISgLvKGHDW5ruEGcveQPlKrDT1/Mx2AuLiTG0L0CvSViIjvFZVdvtce47F7afF3Hy1v2BQhio8NbNexlCG0JIIrYa/G2E0IgRVAdc6Afw74YUQxX0mMilv/0iwgAfChcSPSuysBb3IIQfA5j/APHQs+/BExUv1ijEjKwxs5KUQ4yhtb2vJ381UYDxWbt1v+ddwFhgbncVFADtgDZZSJyZH3lobd/mwkf5zqVm+fKvscRyTaB1WdNKBVpEbAM+mW4hHjMmFkMWZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RERL0TOi6wCwMg1U6k8F+/1A4BHrHMxNgHnSYhQVX1w=;
 b=h/LVoJ+y287ju0GTkiNl43+juJeOo4N0421N+8kWwLdnHiQOvZecQS6YkJXA4kQpHbog8EvRJ2bJTYFrah95cfiUamIEB1dMpiJKtf5q0d9Ct8iZL0HWqtY2K4sjQJhUXH5Pz1GpUC4LbgVAaKqKHymbdMMhC5KRrDzuzEQtrhs=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4487.namprd03.prod.outlook.com (20.178.49.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 06:08:52 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:08:52 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/8] regulator: add binding for the SY8824C voltage
 regulator
Thread-Topic: [PATCH v2 1/8] regulator: add binding for the SY8824C voltage
 regulator
Thread-Index: AQHVXWcQN9g0ZslKfUGrTbgrWX/msQ==
Date:   Wed, 28 Aug 2019 06:08:52 +0000
Message-ID: <20190828135734.05aa51ec@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0087.jpnprd01.prod.outlook.com
 (2603:1096:405:3::27) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a2f42d-f2d2-46a0-9d6d-08d72b7e32f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4487;
x-ms-traffictypediagnostic: BYAPR03MB4487:
x-microsoft-antispam-prvs: <BYAPR03MB448775E922CFEEECABF2DF24EDA30@BYAPR03MB4487.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(54906003)(66066001)(50226002)(186003)(102836004)(305945005)(8936002)(7736002)(26005)(52116002)(386003)(99286004)(8676002)(11346002)(3846002)(110136005)(81166006)(81156014)(6436002)(5660300002)(66476007)(66446008)(64756008)(66556008)(476003)(76176011)(6116002)(2906002)(1076003)(71190400001)(486006)(66946007)(256004)(86362001)(25786009)(4326008)(14454004)(6512007)(478600001)(6486002)(53936002)(71200400001)(446003)(6506007)(316002)(9686003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4487;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CKN/ojpcGvPANZDVl8NtORWRtGW6LrXIphkLVy07oX8gFPLWl56lQYr7qup/3etI/uuZk3AFx9j69+3Cts4t0SDlOpqoGtefS5GE86eKZXpZRmMQxFO4hTxZEnUU1b/+h2yKKsbY9WTDiT86GT91fjzy7eqXTf7qFYj3ufepFkwXSR9bC1jReucBKOCl2/oB6c8iAA9Wj9L6GCOfDFaKJHTCGu8YfnzG+I7fFH9oF34gTZYARdW4tC4GuYBw65zZocSvUT+OhSL1LWAIv6Se2ea3P+iJ6fZ/kE6Gl/U4Lg8+rKYOq3oMKvpamJrI1m/qZZjmhV6vl/bonMp8xWmY3B3nTtfMMmck5CKWtWbe/zrMcfk7C3EWLaljY1zNsYsEMjVzn3dZgZHumM0rLkip9xRFIi0LUDgrbPEohkCHz8A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <48C12E409EA8FD48808A9AA0DA49990A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a2f42d-f2d2-46a0-9d6d-08d72b7e32f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:08:52.4012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16jIXA9zQTYuFf/xzEysClgbt41OO+Qwc+G54bYTzLCj7Arp5B/G89rDI9+BV60F3jyTgNE1PS7s52XvVzzKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY8824C is an I2C-controlled adjustable voltage regulator made by
Silergy Corp.

Add its device tree binding.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../devicetree/bindings/regulator/sy8824x.txt | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt

diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Docu=
mentation/devicetree/bindings/regulator/sy8824x.txt
new file mode 100644
index 000000000000..ff8d1af04f7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/sy8824x.txt
@@ -0,0 +1,20 @@
+SY8824C Voltage regulator
+
+Required properties:
+- compatible: Must be "silergy,sy8824c"
+- reg: I2C slave address
+
+Any property defined as part of the core regulator binding, defined in
+./regulator.txt, can also be used.
+
+Example:
+
+	vcore: regulator@00 {
+		compatible =3D "silergy,sy8824c";
+		reg =3D <0x66>;
+		regulator-name =3D "vcore";
+		regulator-min-microvolt =3D <800000>;
+		regulator-max-microvolt =3D <1150000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
--=20
2.23.0.rc1

