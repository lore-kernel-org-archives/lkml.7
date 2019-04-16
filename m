Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D81CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DD820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ukepy+nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDPDWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:22:16 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:41838
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDPDWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjVzgxp9NtNOmWU69+HGsZ7hiXxCHTjeFno4DCz0C/o=;
 b=Ukepy+nw7CL2jJ6e9aQeNyibSt9USvjVobJ1GXkTXHzSqKh0KPtNsQ9exakFnZb4B7U5ADpVu0B8nSW4MyYz7tYubVRkBSDUAG8hsZSJVpzINhFRQRnZnQeTm/Eg2KGWKTKTsHGhwvnop6c6G7wyhyicHcgO9MGOSWhCdKq0Vdg=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 03:22:09 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::c854:fc94:f9ed:2ca2%6]) with mapi id 15.20.1792.020; Tue, 16 Apr 2019
 03:22:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHU9AOTUGgOS08iR0aOB0ANqNq0mg==
Date:   Tue, 16 Apr 2019 03:22:09 +0000
Message-ID: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90cc47c6-1e05-43fa-01b2-08d6c21ab59e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR0402MB3895;
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-microsoft-antispam-prvs: <AM6PR0402MB389537BC663E7164E4A58AFBF5240@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(6512007)(106356001)(105586002)(53936002)(2501003)(36756003)(6116002)(3846002)(66066001)(68736007)(486006)(110136005)(316002)(5660300002)(476003)(2616005)(97736004)(71190400001)(71200400001)(81166006)(99286004)(8936002)(81156014)(8676002)(50226002)(52116002)(102836004)(256004)(14454004)(478600001)(6506007)(386003)(26005)(7736002)(4326008)(86362001)(2906002)(7416002)(186003)(2201001)(25786009)(6486002)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3895;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w5lnTwSn1Jmm381eRWAiBoyff2JEoQPQFkJYNKV7m8yrQ4rEwsoAbsxS5Yt23TKM9Ubq4ArDo+VzEhYU68mQmBzlwVXgjKTISjsbg6FGhaTjRn4NSWzoNlM2DtcPWY/8hLhAmOddOSDzeuR8Bign2Vx81kLb0wVRvV6QYu7BPUnKo8jtnaytF8W4FVNttZqBeqIeMxvc32wNtcElOY8ODq0qV9Wdd5fqDtuanSmOfjRiYQ9cTgNhW6D4ed3dkpPkprLHr7+uGxFh/MZF+B3fx2MTPaj2ggHA/gTPY/AXcJzXAIoZZw883GUsf06NrsrjDN+pa8SIq/N92n+bMdelwuJa+YQhUYF8jdlaxEZLJ5apYWdoMBwRLoZ8qEDpCdSKSq6qkTC4QI1sZaXuoWTMP1CO3u2OZHvjtoDsPaIjKc4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cc47c6-1e05-43fa-01b2-08d6c21ab59e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 03:22:09.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRl
IGFzDQpzeXN0ZW0gY29udHJvbGxlciwgdGhlIHN5c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJn
ZSBvZiBzeXN0ZW0NCnBvd2VyLCBjbG9jayBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdl
bWVudCwgTGludXgga2VybmVsDQpoYXMgdG8gY29tbXVuaWNhdGUgd2l0aCBzeXN0ZW0gY29udHJv
bGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5pdCkNCklQQyB0byBnZXQgdGVtcGVyYXR1cmUgZnJvbSB0
aGVybWFsIHNlbnNvcnMsIHRoaXMgcGF0Y2ggYWRkcw0KYmluZGluZyBkb2MgZm9yIGkuTVggc3lz
dGVtIGNvbnRyb2xsZXIgdGhlcm1hbCBkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpObyBjaGFuZ2VzLg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dCAgICAgICAgfCAxNiAr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2ZzbCxzY3UudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVl
c2NhbGUvZnNsLHNjdS50eHQNCmluZGV4IDVkN2RiYWIuLmY0ZmI2ZDUgMTAwNjQ0DQotLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4
dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUv
ZnNsLHNjdS50eHQNCkBAIC0xMzMsNiArMTMzLDE3IEBAIFJUQyBiaW5kaW5ncyBiYXNlZCBvbiBT
Q1UgTWVzc2FnZSBQcm90b2NvbA0KIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxl
OiBzaG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQogDQorVGhlcm1hbCBiaW5kaW5ncyBi
YXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKw0KK1JlcXVpcmVkIHByb3BlcnRp
ZXM6DQorLSBjb21wYXRpYmxlOgkJCVNob3VsZCBiZSA6DQorCQkJCSAgImZzbCxpbXg4cXhwLXNj
LXRoZXJtYWwiDQorCQkJCWZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KKw0KKy0g
I3RoZXJtYWwtc2Vuc29yLWNlbGxzOglTZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3RoZXJtYWwvdGhlcm1hbC50eHQNCisJCQkJZm9yIGEgZGVzY3JpcHRpb24uDQorDQogRXhh
bXBsZSAoaW14OHF4cCk6DQogLS0tLS0tLS0tLS0tLQ0KIGFsaWFzZXMgew0KQEAgLTE4NSw2ICsx
OTYsMTEgQEAgZmlybXdhcmUgew0KIAkJcnRjOiBydGMgew0KIAkJCWNvbXBhdGlibGUgPSAiZnNs
LGlteDhxeHAtc2MtcnRjIjsNCiAJCX07DQorDQorCQl0c2VuczogdGhlcm1hbC1zZW5zb3Igew0K
KwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCIsICJmc2wsaW14LXNjLXRo
ZXJtYWwiOw0KKwkJCSN0aGVybWFsLXNlbnNvci1jZWxscyA9IDwxPjsNCisJCX07DQogCX07DQog
fTsNCiANCi0tIA0KMi43LjQNCg0K
