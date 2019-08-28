Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D216C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625492173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="e0USvROC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfH1GMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:12:47 -0400
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:28737
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfH1GMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK9Sbwz/zC2xqpWCt7RXeCxucJED5YhEdUfqg4H0yIKL6sX/FY+4pH2F1Ncfw77EIJjlY7SHI0on7TRh7/z/aZRX0ukpIAEwn8tS0vXMBrnjQQgXLm/cDyvIEdqiHaFI6CqQj+sZRCN9PUn1O2OKvS4e6dRXrBbAE96CGR4OjMiC9jXAAKQq+/XgiNJqmFjmtNouBvD0XvkeMJEfvO72pPE2VCle7bTDxMOVqgQHXV1xGgzjefxuOuAeYl8dZ9X4x+4gB4h/cMBaQHhBIxEjWLG9K2ZTvwpkpvBOatReEyWbq4hEeu8BZR3QeJii6kjV16+nr3/sm3PlAM87b3OT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hM/1VwFZ9U41hl2tV5KQsjAXKxC7VcULyfYGpyDgzU=;
 b=Ib2CoWRxDraQoXcTJTgXMzUSblbfQhtsD20tKkByqcbGY8q4CxsnT4vTWpZfXhWufospWJ5Rm7zXStoHkTav2LnXauxvn66O6SuxsCpJahjNoJb60ddsCtwVUKWDE/G4ehFywpL5Rucd2d2IWZ7tCu2IHywyI0Z0mNZOHaxey1XBV0jCE/+BWGEJJx7lyReDqQ1625J2+HlqeQLHasc9kazEWmi7O2c7xPBQPI0Kq3BMQwX5nJb0i7NaDRX9YABlyZi1BELzTvJO0DMEr37CctE1Mlvo58KcntaL418YGgjP/IFU/Nx6gzoSdqtyuLH2RtfaSTOnzYsREQEQZDFh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hM/1VwFZ9U41hl2tV5KQsjAXKxC7VcULyfYGpyDgzU=;
 b=e0USvROCrqbKAt2QYxUDqoo9aS0976ZvrxotaIpeZ1shhah5sjNy0CJg6UUV2Ru9HBhNgyFrhe2LfyBouhqfXwk6uJEh4bj+yI2/XwMaSiXcNwxr2NlwaBy+GtnRMCbmCqcajr8qW9i2TyEn28cAdVkPQvcOiQfOynlkv7ADcGk=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4503.namprd03.prod.outlook.com (20.178.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:12:43 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:12:43 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 7/8] dt-bindings: sy8824x: Document SY20278 support
Thread-Topic: [PATCH v2 7/8] dt-bindings: sy8824x: Document SY20278 support
Thread-Index: AQHVXWea8hUcdT2T4Uqj10xSV4lDSg==
Date:   Wed, 28 Aug 2019 06:12:42 +0000
Message-ID: <20190828140126.24bd7326@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:405::17)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 568c3e82-15d6-4468-31bc-08d72b7ebcaa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4503;
x-ms-traffictypediagnostic: BYAPR03MB4503:
x-microsoft-antispam-prvs: <BYAPR03MB450349541452D201FE87D86FEDA30@BYAPR03MB4503.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66556008)(386003)(64756008)(6506007)(52116002)(5660300002)(66446008)(71200400001)(81166006)(76176011)(71190400001)(99286004)(6512007)(9686003)(4744005)(81156014)(4326008)(14454004)(54906003)(66476007)(6486002)(102836004)(26005)(186003)(50226002)(1076003)(25786009)(6436002)(8676002)(8936002)(7736002)(478600001)(2906002)(6116002)(305945005)(53936002)(86362001)(3846002)(110136005)(66066001)(11346002)(256004)(486006)(476003)(446003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4503;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jqav4O2TYhHWu/Be0laXhvaCM8/UN05erfS2E0HdGGtGONBI2Hg+qyMsBT6gK81yNZe8VQ/1igbAPzX/0bY3s8wMZSk2YwITeR9Y5BA5MR+VxjE9otUg3VrRKoOSsvQZGIbbn5OJXbq+7Xxwc2eeprE5MvYXxq1Squ5K0Lfp4KDZu26KSXydabv31NVqdBzIn/jSFGTo+TtvwdCwocU2PgOICPy2DRZjLNOpdTE2fZPF0DCLoKzlWvTbNljwHxw2gi5Iw8pxC+bJUkrkOgWcp0CvWpaLRkkP5ybUvx1QhMbWEpMk4BYLRj0QWFfGFZqI4S31lySn5mPdi+Z8vUAMZ3X2yk19OgAQQODv9EydmSG9JNBjHMzyqB7BdDBf9eTTH83qjR9i/151B69DT+Bv2YNIuDkZoOQ8u9+s3w2tVxI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D65A230AA37574DA1496FF1919CAA33@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568c3e82-15d6-4468-31bc-08d72b7ebcaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:12:43.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ju3HNEQDfri0RN/dle4qs0Ibr51kvLnxK9gDsRLN7ChUB6AajbmL1P+ilWgi1gIulUfMzwoy1cszGeZwhYpHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY20276 is an I2C-controlled adjustable voltage regulator made by
Silergy Corp. The differences between SY8824C and SY20278 are
different regs for mode/enable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/sy8824x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Docu=
mentation/devicetree/bindings/regulator/sy8824x.txt
index 28600541b5de..c5e95850c427 100644
--- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
+++ b/Documentation/devicetree/bindings/regulator/sy8824x.txt
@@ -5,6 +5,7 @@ Required properties:
 	"silergy,sy8824c"
 	"silergy,sy8824e"
 	"silergy,sy20276"
+	"silergy,sy20278"
 - reg: I2C slave address
=20
 Any property defined as part of the core regulator binding, defined in
--=20
2.23.0.rc1

