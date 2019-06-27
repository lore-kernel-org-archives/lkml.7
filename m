Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E5C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551182083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3jgEwVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF0IMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:12:22 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:62531
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfF0IMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Edh21XYJrnG6YimwpaE0dr+Sw+dQYGYWcmI3HN1pH/A=;
 b=d3jgEwVO0Zj7T5BeWvPTL880Ddo9WhJxe4IaCKpanlJ1zHGVNST8Dj0ZMu7HDhVU4LLEHHLWaN6bc8YMtqOT93R11S5cppQOy7SZIbegIfCSi69RacP7JaaF7SvTFtymSlVCyrA2t0uc1lIjoQIF3C7fY4f88oCjH9rEYgm1y74=
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com (20.177.35.159) by
 AM6PR04MB4453.eurprd04.prod.outlook.com (20.176.242.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 08:12:18 +0000
Received: from AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::9c87:7753:43b9:6d4a]) by AM6PR04MB5207.eurprd04.prod.outlook.com
 ([fe80::9c87:7753:43b9:6d4a%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 08:12:18 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/2] Add support for DSP IPC protocol driver
Thread-Topic: [PATCH v2 0/2] Add support for DSP IPC protocol driver
Thread-Index: AQHVLMAJcPye2nIwl0OOFv4iPigrbg==
Date:   Thu, 27 Jun 2019 08:12:18 +0000
Message-ID: <20190627081205.22065-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0020.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::30) To AM6PR04MB5207.eurprd04.prod.outlook.com
 (2603:10a6:20b:e::31)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64b1fdd8-0d82-4367-bf71-08d6fad72be2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4453;
x-ms-traffictypediagnostic: AM6PR04MB4453:
x-microsoft-antispam-prvs: <AM6PR04MB4453A3AD5ECE3910B5603A62F9FD0@AM6PR04MB4453.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(2501003)(81156014)(25786009)(68736007)(14444005)(256004)(186003)(14454004)(26005)(66066001)(476003)(99286004)(50226002)(6506007)(4326008)(8936002)(8676002)(81166006)(386003)(44832011)(102836004)(52116002)(305945005)(486006)(3846002)(71190400001)(54906003)(71200400001)(7736002)(6436002)(2616005)(478600001)(86362001)(316002)(53936002)(36756003)(5660300002)(1076003)(110136005)(66556008)(66476007)(64756008)(66946007)(73956011)(6486002)(2906002)(6116002)(66446008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4453;H:AM6PR04MB5207.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mgpqGQnfA0sI0sx+sfUM6WtY5oq3Gw45fBfkHNZ0+RvjKwOnBShumsSlN12ki2w2mw88N/M+UXk3rFzxFle7orcKXZb6crtW/IQUCnibY4W/fZW7WfdUCmVTkvVF2Sr+yF23h+7KmtVEqyAcia1i6JPkxhjP1DlcDIt5tTclzeC1SatVOEA3W9Pka7NeEmqa2jQvNGBCT5LcN4yXWii2APJU7/sX8CxOaEvHo92TjQm/Tp5hM2hwsqGwS1mYzijZjnUQYScNkSHBhkG/LfF9+KicbJ9DwEMyURY3HkVnn2PA9UIBOKv2O3xTv+XJ8oni3a3V1WL8+HakNwf30OHI9T0iafVAs9cCK5DmGF0ySyWiK9kaBq59niDO+Ou7kHZ2X0siW3HbrTrYWzGKMVQlNFVixalJqmpZl/QJ/ZmgmtQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b1fdd8-0d82-4367-bf71-08d6fad72be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:12:18.4374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daniel.baluta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGlmaTQgRFNQIGNhbiBiZSBmb3VuZCBvbiBzb21lIGkuTVg4IHBsYXRmb3JtcyAoZS5nIGkuTVg4
UVhQLCBpLk1YOFFNKS4NClRoaXMgcGF0Y2ggc2VyaWVzIGludHJvZHVjZXMgdGhlIGxheWVyIHRo
YXQgYWxsb3dzIEhvc3QgQ1BVIHRvDQpjb21tdW5pY2F0ZSB3aXRoIERTUC4NCg0KVGhpcyBsYXll
ciBwcm92aWRlcyBhIGRvb3JiZWxsIGFuZCBjbGllbnRzIGNhbiB1c2VkIHRoYXQgdG8gbm90aWZ5
IERTUA0KdGhhdCBhIG1lc3NhZ2UgaXMgcGxhY2VkIHNvbWV3aGVyZSBpbiB0aGUgc2hhcmVkIG1l
bW9yeS4NCg0KVGhlIHByb3RvY29sIHVzZWQgaXMgcmVxdWVzdCAtIHJlcGx5LiBVc3VhbGx5LCBI
b3N0L0RTUCB3cml0ZSBhIG1lc3NhZ2UNCmluIGEgc2hhcmVkIG1lbW9yeSBhcmVhIGFuZCBub3Rp
ZnkgdGhlIG90aGVyIHNpZGUuIFRoZSBvdGhlciBzaWRlIHdpbGwNCmFsc28gd3JpdGUgYSByZXBs
eSBpbiBhIGRlc2lnbmF0ZWQgc2hhcmVkIG1lbW9yeSBhcmVhIGFuZCB0aGVuIHJpbmcNCnRoZSBk
b29yYmVsbCB0byBsZXQgdGhlIGNvdW50ZXJwYXJ0IHRoYXQgYSBtZXNzYWdlIGlzIHJlYWR5Lg0K
DQpDaGFuZ2VzIHNpbmNlIHYxOiAoYWZ0ZXIgUm9iJ3MgYW5kIE9sZWtzaWogY29tbWVudHMpDQoJ
LSByZW1vdmVkIGlteF9kc3BfZ2V0X2hhbmRsZSBub3cgZHJpdmVycyB3YW50aW5nIHRvIHVzZSBE
U1AgSVBDDQogICAgICAgICAgd2lsbCBnZXQgYSByZWZlcmVuY2UgdG8gZHNwX2lwYyBub2RlIGlu
IGR0cy4NCiAgICAgICAgLSBhZGRlZCBjaGlwIG5hbWUgaW4gY29tcGF0aWJsZSBzdHJpbmcgZnNs
LGlteDhxeHAtZHNwDQoJLSBhdm9pZCBtZW1vcnkgbGVha3MNCgktIG1ha2UgZHRfYmluZGluZ19j
aGVjayB3b3JrcyBmaW5lIG5vdyENCg0KRGFuaWVsIEJhbHV0YSAoMik6DQogIGZpcm13YXJlOiBp
bXg6IEFkZCBEU1AgSVBDIHByb3RvY29sIGludGVyZmFjZQ0KICBkdC1iaW5kaW5nczogZHNwOiBm
c2w6IEFkZCBEU1AgSVBDIGJpbmRpbmcgc3VwcG9ydA0KDQogLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvZHNwL2ZzbCxkc3BfaXBjLnlhbWwgIHwgIDQ0ICsrKysrKw0KIGRyaXZlcnMvZmlybXdhcmUv
aW14L0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAxMSArKw0KIGRyaXZlcnMvZmlybXdhcmUv
aW14L01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9maXJtd2FyZS9p
bXgvaW14LWRzcC5jICAgICAgICAgICAgICAgIHwgMTQyICsrKysrKysrKysrKysrKysrKw0KIGlu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW14L2RzcC5oICAgICAgICAgICAgICB8ICA2NyArKysrKysr
KysNCiA1IGZpbGVzIGNoYW5nZWQsIDI2NSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvZnNsLGRzcF9pcGMueWFt
bA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtZHNwLmMNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvZHNwLmgNCg0KLS0g
DQoyLjE3LjENCg0K
