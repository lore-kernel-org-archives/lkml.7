Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECBBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608B2206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DokFnM2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfH0IqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:46:25 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:11542
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfH0IqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:46:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmcFsC/GjVWSj/nOI+mbrIv5C5MQ4gzqMvDMZZAGRJeVaghYpYrs4wuWOmFbTBXdCvYWi9sqJ9BUMEzxzjn56fFGMlJj75ALIfykSJCESqpl5xUq8kRbwOqibTk1g2FAl9Tdm9/9EvIst9M9hguu0RHSv+zLuGBbcT6UJ+nlCbwZzjGVXcLf4HROMo06IIi4Sv6UBfBDS7eMv94plfTKvmJKSEyXVvWuJLPenDhsag2ROk3ix4P8o7mreE50wxeEpawnFVF4ZilRejy7GTq96Qc47UlQTxTVUQ6fwIv1Evmh+mehHGHt1byr6yTP3GFyNERYLl3jP6s76w2MAnoE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jW7ol0b+eRIpM57eKXxR7zNDV0QWtN+Wrbh2+mXxo4=;
 b=LVhG7BMj3vVforUkWk/3HbV+5HIH1mypkqFHhwxWuFziPSjFi4SWSwyDC2Uzkvz84gjzYlmYKuoyAalPLvskojqJ+IacyrCQ/tAi0h+24XoHPae0BkVNZwupzaDnD5l9I+DnNnU66pOJPzm9CRmgqzXatMh1gsShSnhOaIgtmMVv0xnWjFb6H00LiNxOAGYFLJN332HCiAGUuM/9gm3bjVJNRIA9OqCb+zosscXuYIs3/I03h+2ZrPpljrFdePtzeE4xHRTJr0e/Ga8smpUdsfgw83cJpI58xC+npHRcCbrXVQLXAeB/HZTBvL0lqs4+EjRA8KmW86nF8yuXdPzVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jW7ol0b+eRIpM57eKXxR7zNDV0QWtN+Wrbh2+mXxo4=;
 b=DokFnM2ZgJboxnyLtTtH0t7IPH1jA/xmcpo8XI+RHc1H0kB1pyLYPAQYFuHhaPMgg4czcYS1oK0bgU/c6Fddf1IpShvwNjL1quaQvuOlZpVWYx2rPhtqCLmN6IQIjecBnVs1Rz5avUZMaBaGqq0FLJYT7RryEe9AJWNjic9g/o8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:46:21 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:46:21 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 3/8] dt-bindings: sy8824x: Document SY8824E support
Thread-Topic: [PATCH 3/8] dt-bindings: sy8824x: Document SY8824E support
Thread-Index: AQHVXLPm5kk21TV/k066LRENFE7Ahg==
Date:   Tue, 27 Aug 2019 08:46:21 +0000
Message-ID: <20190827163505.361890af@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bda50c9-9605-415f-48e4-08d72acb08d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB4263E9164E2BF1F6CA3EAC68EDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(4744005)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TPNXco8q+sc9iHWRYQqJZ8pGoVZbME3woUqeiBwZQ7tpzbc0gnDCldU2h+zqcFCbwbQNEpwJSIJ+x8ilLcSKfwe2YJnEkfHxs+59VpTRXtMw8lCYkdLi1/h56sp9EyYV2vQybMjn8exokOuQE4Ortc1igMjo7qFEnM64VVATj6mool0Rv/uMeJk77VMPLk8vnvP/D243sru3WR9rHJmaamn0MLq5aj6zkBcPwu0mp7NagYx1FK8/s5lq2AtWJ43dX5DhLGGnZM28skxszH2Gxej76WBumy5uoGNgHOoV8Wni0MYwo+V0GGeizjzN+d5MRKmHMF37iPn/7Nq4VlPSTgfMCyX/p6jcDPAUSh2O6kr6wwEmOA8X41rSf3HzSL+X8J3b5dBty/lhld79shN4iE6N3EF67ldFhZ+X0gL8kM0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F58E2B3DC09CCC41A813AE1F2A67652C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bda50c9-9605-415f-48e4-08d72acb08d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:46:21.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bor8Kzs7Nlq0YvYJw0FyrQofSp+mdn+LB/lIbsN65dKZfsbDejAgpM/bOK0oKix/kWWQcgJPXYugE+mw8Bbfwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
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

