Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA793C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09432173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="k0Ms7r2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfH1GKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:10:06 -0400
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:61536
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfH1GKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:10:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLLH+B2kbgRlXQljTwp4V30I+w05eTfFGOtblzz0bPEX/i0d8WQ5vPavttxlKch/S+/yA1UTLJk9uII5UrziJoqa5rZzKN2NVjBhuhErRHYWhx/nTAENN8le8mvsQEkPozxLoa5v1DBLppntbWnaJHQhYvuxWU5al8MXQfFBVJC1BMHCyABZH7Wq3NUSt75SFk/jkqttOmGEIpjKJMLzMPpR8h/qkFlEWfMonWKy6y01Q9XtXh/daePAS8EzRn398Z4IxYGaTpQnxufDsU6yhO8bvXjr5mIEn6HIMOt23Qys7SUiMFzdE8msHlYjh0l++iTJs/H7SsrpLcOc+y+/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jW7ol0b+eRIpM57eKXxR7zNDV0QWtN+Wrbh2+mXxo4=;
 b=M2uzMMwlTsFQpsaLKFB1yYo4vfee1LtIaHvm/5fhVLnZEko6mU1Lz09k8U8eNiLlj6slA1ljrH92f6jH0NHU40F3BPEhl38hU2bEShvR+6vlasW1KXDScgfBxNhtl1wICSw+h9/1YzXGRXZ75xOsFM8rHDFdt9OqqfQMar/icYHxFyUVDlQipcr4iOPhbgeD1JUYOxHnDxN6XRz4mirdYIc5Twf4k61KbXCCpji1x9v7J/1q4FbHWTx+OXRtNUePYZ9fMxji3E7wdpa0693pxHyNTyvWOA7GXl1d132kO1J9+LMdqryCeKM46e1a/YrdoM6xY6pfFCHmgVZU7pAMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jW7ol0b+eRIpM57eKXxR7zNDV0QWtN+Wrbh2+mXxo4=;
 b=k0Ms7r2Eamo0/MdbNTrknSpV2vbFEmOcID4NQSSyb+1YHK1TD1bzQ4J7CPjdQSiujwH5z0nvXQUfmz+3UasOVKPScUfoZSyInnbN0/63mq0U6h0ddro3i8zVxcqo9wYwvDCP2HP88WUvjhR93XJ4NlZGJ+7FVdZKLWG64gp/3U0=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4503.namprd03.prod.outlook.com (20.178.49.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 06:10:01 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 06:10:01 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/8] dt-bindings: sy8824x: Document SY8824E support
Thread-Topic: [PATCH v2 3/8] dt-bindings: sy8824x: Document SY8824E support
Thread-Index: AQHVXWc6ucucUMdhaU2GX4KPB1ps5A==
Date:   Wed, 28 Aug 2019 06:10:01 +0000
Message-ID: <20190828135844.19846b1c@xhacker.debian>
References: <20190828135646.52457ac3@xhacker.debian>
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:4::13) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 596fcbf4-4179-4b81-61cb-08d72b7e5c7b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4503;
x-ms-traffictypediagnostic: BYAPR03MB4503:
x-microsoft-antispam-prvs: <BYAPR03MB45038C8618ABDE49260B3850EDA30@BYAPR03MB4503.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(66946007)(66556008)(386003)(64756008)(6506007)(52116002)(5660300002)(66446008)(71200400001)(81166006)(76176011)(71190400001)(99286004)(6512007)(9686003)(4744005)(81156014)(4326008)(14454004)(54906003)(66476007)(6486002)(102836004)(26005)(186003)(50226002)(1076003)(25786009)(6436002)(8676002)(8936002)(7736002)(478600001)(2906002)(6116002)(305945005)(53936002)(86362001)(3846002)(110136005)(66066001)(11346002)(256004)(486006)(476003)(446003)(316002)(39210200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4503;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2lWW9xZkJS2Ut7geiP1+V3PZ7Xll1Cs1NTZ9BuL1zW+lWZgTx37pt6aYSoiZ782qLjQsSztld+aZ1RRZzmUAjAiDIVt6gs9GZD2EFA/v03bASm+7+l2bIC/YajXjU3CWuIXwr0t6RrwH667U9VypInsvsLrFoWFeuEILLF+B1f52UHzpaNV/D/01X7L/IoFsPPsUltScK5SANPQIlgSljVZQXov7x6l9GH6AXJkwg4sAsZPp2E+j8Q1AnRq+RL4Wv2yEuADRdiahAA4gjhOVe9JCQaZbipsTgvnSKVn6+kK0DCCKf9NRAxTLMiw6l1tdJGNPOIiX5Fe7nK2xooMqhzlBybHNVpBP0l9lYGYLi9fjdti3ZXORu2GF/13cQbQVMmd1JqweZUS2gTOQSJByG+wld7JNC+LKrzcZL/Q1grI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F70D55AB672B2468F2D6D8E1EEB113E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596fcbf4-4179-4b81-61cb-08d72b7e5c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 06:10:01.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwhWBoF0stlJqeqEUFqbFzm/U+S7gHfNtzWRaI1DjU5lvoHhcTYFAaIlofkOgQlFoQljrCktIXHlZ4O9t2sZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY8824E is an I2C-controlled adjustable voltage regulator made by
Silergy Corp. The only difference between SY8824C and SY8824E is the
vsel_min.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/sy8824x.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Docu=
mentation/devicetree/bindings/regulator/sy8824x.txt
index ff8d1af04f7b..31fefa3baa71 100644
--- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
+++ b/Documentation/devicetree/bindings/regulator/sy8824x.txt
@@ -1,7 +1,9 @@
-SY8824C Voltage regulator
+SY8824C/SY8824E Voltage regulator
=20
 Required properties:
-- compatible: Must be "silergy,sy8824c"
+- compatible: Must be one of the following.
+	"silergy,sy8824c"
+	"silergy,sy8824e"
 - reg: I2C slave address
=20
 Any property defined as part of the core regulator binding, defined in
--=20
2.23.0.rc1

