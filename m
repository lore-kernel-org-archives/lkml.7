Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F81AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9F8206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="hKMbGBqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfH0ItN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:49:13 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:42308
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0ItM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdCRxnkRfbdN/tKt6i1UdWXvJ3r4EzPQHgpMbRQFweoBNrg5pqapcEtvsZ4ciVwEZxXlWexQwAGkJ7KlvqAEu/dIDmfXglwHYm6D46iAqZFpC1PeF90S69RuRJWexhabvvRSmLMrUw8/CcJgnPb966y6EtxixmoQLdWx4fzcYDvfwMAc5KgpA56Ma6Mwg++mA0nUwhL9pAA7qoBkgyfuqwfT5blWtvvRPjSxk0qz6tQcwmkh4Yfw3jQlv7bgx+w59ZfbHXFJmGcR3EpK5Gpws2KQeG3N9xTyBb2MD7qrkEbtaYI++N4W7sAm45WfSrMJxnVsXuuQWUPV2uSGMMF6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hM/1VwFZ9U41hl2tV5KQsjAXKxC7VcULyfYGpyDgzU=;
 b=nfjeQM21u8lOq9ITbctT1JWay0T+4Gyq1xLBqdMkLT0MpI6VGOOdu0Ss/4R8GqKsC1GPYwIFpF5N70JGxVFLJ4HyJcbV/gU5Dr6UWgg+FHGjv5mARemB0bAlw//5Ff+AzyfmfeKhtjRtpxLKdASlFJKlhDeMvSe3Q3kCXVWSDAfGqDnAwohcsiV4G6ftvEbonA9XnXhylcSaqKsvsKS4CNBYv9LJH2p+n96Z5hJumy7Xj40kpi9+dp2IGQ6RTcohVLDlUkOgtoaY846RWp3Gjc+aHnr2V7ASxWWEhv996Qog1yUKT3ng9SokorAuoabM39Mzvlc0HmtscvfXyEYaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hM/1VwFZ9U41hl2tV5KQsjAXKxC7VcULyfYGpyDgzU=;
 b=hKMbGBqjBaCCEaMdGohOZSdzQROSsU1DnFlyGiZ+FCeflYiCheoB6mXo/Iu1RaAi6Z2dAlxgxbaWjrdbVPA09ozH1bHEMrn2pSAxDKayTGpJJnx7IuRq4LcuReMlAia88roS74NrQCFrmAbtu/9d1Uz8sezuvnZKAGpLLO42beE=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:49:09 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:49:09 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 7/8] dt-bindings: sy8824x: Document SY20278 support
Thread-Topic: [PATCH 7/8] dt-bindings: sy8824x: Document SY20278 support
Thread-Index: AQHVXLRKhGwuvsZRAECSlLD18cNQmQ==
Date:   Tue, 27 Aug 2019 08:49:09 +0000
Message-ID: <20190827163754.170cf130@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::15) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7613c523-cd31-4548-ef4c-08d72acb6d05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB42636843721CCCA002ED5CE2EDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(4744005)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZfI/B6Ts3IJiWaqyFDUKNvMfqsCZWF1Ybu/BCk17HAvNJGQvtKHNksl2ZQsqDcj1wAmq1YmGa9fIxUFKOJhIIHmnsipkWgu2LkEDs5zoEQpsdX1hL9u+c5Af1GYNNcITQ4NdQa3XSod0TN/fH9l6QQojLpTOE8sdd8raQhn4BCdv7Y7pFPWg29lRH9clX4MX3yx1tSgkmJs4p93cg53llpJjxVnSebjlQ2KF7H1TRFvae+gPhnPjR1SyCRpBHSi8YYtVk10Id3XMxGTznLwa6HTmr0qxgDzyqZAMjjRgMyo2d2SP5HWWPkef3ygwplWFtCSZTyGdhxUwzoKdJs9k7p5NP1TIUA804imYrcs0WujCBKYdV8JgB9fikzz64qoPQ/1jcpkyVRV/Jp5plYDwQTtNGF1Judll4uLsHlJ9MVE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60695DC90411274BBB98A90097C8145A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7613c523-cd31-4548-ef4c-08d72acb6d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:49:09.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovUuxRzgp2DL1+XPBs8617Pw+L4Zwzw2DRlEhxbGVaP2iFQYYxi14UXcEj1QWGsPC/Wq4O3AIyBwydn94481XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
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

