Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B218DC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FF92173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DCDio6RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfGPNnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:43:33 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:60294
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728608AbfGPNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+51NcjZ9TW3xGuQxqcTSgKwDIFxW86ghVMfZlZm7n4VrmHNkn/Gxwo8V42cFw6uFCVM4szoZkENUhNzqwJBr5VCyC9UJLRkcNQBdeFxzfVBaJtrp3dQlmdYBlVbOWUch1fpVF0zVWTJW2hNB+kdafA68aChw4pBzQ5BLg1rqYZ+RmupviFSlyhhknXlrIIwgOmnYBHRiX4u1DxbV8nd+T0ereHs9QCfJJn+M7SD1Ht6viDlA+qnbTzunEvum1m3bssYhA9WEb1k3dH5OQung/DaMpVhKwRMMR1stY8pi3exaIUqfji6+zJlWhmCH370oRIEkCjuw8Rb1aIwviHONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juac/9qmwJIdJ1Z30Z0bRAEMeBj9weTRg1ncI0fm9Zc=;
 b=YkkeKoZm9kGTSZa+c7/L6X4n8b8CDH60GBB+DNViiuQbGjr4KAo6LktqQ/haBvjRf8cCeswoXatbWGb2EemPBE5zm32tBIq+EQtprlG1EpYu2Jc49o394FixtLxUqW542CQ2FZibWFwEY/KcH03L2t6CPT8AO5u5+U4MP79r/PId2cZSX5FzxAeBFyLtOQYdXmaaepegc9bSM1oMA7wXWn/StKrcIWKzu6DFdDDxMflsyl4CmY4y23dEefd0A4CdxXHVKDm4C8jPrS44O3xAyFQv4v65KHlctP1uQvf0ZDKaH6lvclHsW4ASyg75ABERMzehLeMSoiKTiyt8x5PIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Juac/9qmwJIdJ1Z30Z0bRAEMeBj9weTRg1ncI0fm9Zc=;
 b=DCDio6REhxWH7l+UDYA2RQRaU2XgYSnABCj/3rV+tk6EkdrDb+sg8IK6Jf7ahWh0eFZKvrbX435fU5kqQOiz5HEvB/RL01iYffsc6CVjyAS0zLhMzceay6P+cPF5KLTKzLaJkiTA6FIrVyfpzGmGBCc4mAhR4xaE2yOHXUsjR6Q=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6102.eurprd04.prod.outlook.com (20.179.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 13:43:28 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::5563:4416:c0a2:f511]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::5563:4416:c0a2:f511%6]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 13:43:28 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: nxp: Add device tree binding for
 ls1046a-frwy board
Thread-Topic: [PATCH v4 1/2] dt-bindings: arm: nxp: Add device tree binding
 for ls1046a-frwy board
Thread-Index: AQHVO9xyFW1tU/GSXEyIdbnd6hYJ3g==
Date:   Tue, 16 Jul 2019 13:43:27 +0000
Message-ID: <1563284586-29928-2-git-send-email-pramod.kumar_1@nxp.com>
References: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
In-Reply-To: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0133.apcprd04.prod.outlook.com
 (2603:1096:3:16::17) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.142.151.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 495e12da-9300-4ab1-fa0a-08d709f394ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB6102;
x-ms-traffictypediagnostic: AM6PR04MB6102:
x-microsoft-antispam-prvs: <AM6PR04MB6102A69C62855106DCE8BFB9F6CE0@AM6PR04MB6102.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(186003)(66066001)(2906002)(54906003)(110136005)(14454004)(71190400001)(78486014)(26005)(76176011)(4326008)(6636002)(7736002)(305945005)(486006)(68736007)(71200400001)(102836004)(52116002)(5660300002)(55236004)(8676002)(6506007)(386003)(8936002)(86362001)(50226002)(81166006)(6436002)(81156014)(3846002)(99286004)(256004)(446003)(53936002)(4744005)(476003)(36756003)(66556008)(2616005)(478600001)(66446008)(6512007)(66476007)(66946007)(11346002)(6116002)(316002)(6486002)(25786009)(2501003)(2201001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6102;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZtOdor6LZR7YU0HftV2VZIzJXALwQWTqcTj9x3f72TG4GlM9OQQ3n4ftzBylo9FQqLXf/0HYTuPTTj465aSYt1P2PkB1nHuQZPwJ5ane+PLbD7dAUJKskvUvG4XWoJWnje6p3MC2kK21cWKvTxaUdHHAvXn7f/j8x/LDDydb4XjWj57OhtsgySVMn+IGgesgGF4cf23U+blNtr9TlRaVbek2t7oaQ2Q0FdhmRo6L0qbWIsKO133zAvadNBArPy7Cjh1tVmqKiPGQuoYQmNEoIBSeTd0Tb+K2tynUSsaRS+Wc4N1Ix4h1KzWrh7YgHBweSaD+X1SbtS+wFbQXQdM2/iDaAFxn8D4pkMWjw8BCq5OnYYyxK+My7ZoDQMg3Ung38W1PrM31F6CEJX9i0wLawmoeZjYYrAp7w3DypWRMR6M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495e12da-9300-4ab1-fa0a-08d709f394ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 13:43:27.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "fsl,ls1046a-frwy" bindings for ls1046afrwy board based on ls1046a SoC

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index 407138e..86e9821 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -239,6 +239,7 @@ properties:
       - description: LS1046A based Boards
         items:
           - enum:
+              - fsl,ls1046a-frwy
               - fsl,ls1046a-qds
               - fsl,ls1046a-rdb
           - const: fsl,ls1046a
--=20
2.7.4

