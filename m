Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57CBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9653B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xpNzyT0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZIFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:22 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:7942
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfDZIFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRmNkvpROONlPBDJwxg4o2EtJfp3heGsQs2qS0IW7os=;
 b=xpNzyT0DEDq0dHLDXp/ebULupZ453yGufwtj3b4ERJ4Exi/WtzGVLyM1c6xc6IcT4uLuaBWtT+QWRG54IVZxsVlxeKRMOMWOUqEnvoE0ne3pCpx2IdaFuprcd9RbRh5WVqChg+WR5J9sqBn+ThzmeF4BUuTq6qCcdqYbS9cXe/Q=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:05 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v2 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHU/AbBy202P2j5a0C7BDmMWU+Kfw==
Date:   Fri, 26 Apr 2019 08:05:04 +0000
Message-ID: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f1e9d2d-8823-41b7-2bc1-08d6ca1de3de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB61095534DFB65E7324CC68FC893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(25786009)(386003)(6506007)(2501003)(4326008)(6306002)(52116002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(966005)(7736002)(54906003)(71190400001)(305945005)(71200400001)(14444005)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ahHf5ShBGcG3+t6NHMPzXMDr9RWaQuTIGU9XWheNUajdXVyGjZthtnnui+JSnVVqNwfq9gsi2mqmEp5clYnGtzfNAL3NMFFty8Li+svTk4jKR/DPJUFSRLVB+x7Q4zf6vmocrJ2hc/GCG0rvfJp3mOptAviRhHy6wxsEHsLKezjQObEQD+eyWvCiu7bkBDNVtAfFEhL5ggLTcCo1Q1CXvsgpdK5CcptS0nj0BBSO/ww1gp1sGcp0HnhI8E0OoeIp1GUzSRtcN08SLMEaRdKCMeWX0R6T0mR/okBjDJ7pfKOHkwxF5JOpTqDqdgUAqPVVX/umsURCJaFJPc8XzJBacll6HNfn6uEkgXrZJBbWTadu5JCTdcFyrO6bC1vegzXqFadTAvDg4mENLsAus1wKAruQmSkcS31BeSpMqF24fuc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1e9d2d-8823-41b7-2bc1-08d6ca1de3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:04.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICBUaGVyZSBpcyBlY3NwaSBFUlIwMDkxNjUgb24gaS5teDYvNyBzb2MgZmFtaWx5LCB3aGljaCBj
YXVzZSBGSUZPDQp0cmFuc2ZlciB0byBiZSBzZW5kIHR3aWNlIGluIERNQSBtb2RlLiBQbGVhc2Ug
Z2V0IG1vcmUgaW5mb3JtYXRpb24gZnJvbToNCmh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9l
cnJhdGEvSU1YNkRRQ0UucGRmLiBUaGUgd29ya2Fyb3VuZCBpcyBhZGRpbmcNCm5ldyBzZG1hIHJh
bSBzY3JpcHQgd2hpY2ggd29ya3MgaW4gWENIICBtb2RlIGFzIFBJTyBpbnNpZGUgc2RtYSBpbnN0
ZWFkDQpvZiBTTUMgbW9kZSwgbWVhbndoaWxlLCAnVFhfVEhSRVNIT0xEJyBzaG91bGQgYmUgMC4N
CiAgVGhlIGlzc3VlIHNob3VsZCBiZSBleGlzdCBvbiBhbGwgbGVnYWN5IGkubXg2Lzcgc29jIGZh
bWlseSBiZWZvcmUgaS5teDZ1bCwNCk5YUCBmaXggdGhpcyBkZXNpZ24gaXNzdWUgZnJvbSBpLm14
NnVsLCBzbyBuZXdlciBjaGlwcyBzdWNoIGFzIGkubXg2dWxsLw0KaS5teDhtcS9pLm14OG1tLCBk
b24ndCBuZWVkIHRoaXMgd29ya2Fyb3VkIGFueW1vcmUuIFRoaXMgcGF0Y2ggc2V0DQphZGQgbmV3
ICdmc2wsaW14NnVsLWVjc3BpJyBmb3IgZWNzcGkgZHJpdmVyIGFuZCAnZWNzcGlfZml4ZWQnIGlu
IHNkbWENCmRyaXZlciB0byBjaG9vc2UgaWYgbmVlZCBlcnJhdGEgb3Igbm90Lg0KICBUaGUgZmly
c3QgdHdvIHJldmVydGVkIHBhdGNoZXMgc2hvdWxkIGJlIHRoZSBzYW1lIGlzc3VlLCB0aG91Z2gs
IGl0DQpzZWVtcyAnZml4ZWQnIGJ5IGNoYW5naW5nIHRvIG90aGVyIHNocCBzY3JpcHQuIEhvcGUg
U2VhbiBvciBTYXNjaGEgY291bGQNCmhhdmUgdGhlIGNoYW5jZSB0byB0ZXN0IHRoaXMgcGF0Y2gg
c2V0IGlmIGNvdWxkIGZpeCB0aGVpciBpc3N1ZXMuDQogIEJlc2lkZXMsIGVuYWJsZSBzZG1hIHN1
cHBvcnQgZm9yIGkubXg4bW0vOG1xIGFuZCBmaXggZWNzcGkxIG5vdCB3b3JrDQpvbiBpLm14OG1t
IGJlY2F1c2UgdGhlIGV2ZW50IGlkIGlzIHplcm8uDQoNClBTOg0KIFBsZWFzZSBnZXQgc2RtYSBm
aXJtd2FyZSBmcm9tIGJlbG93IGxpbnV4LWZpcm13YXJlIGFuZCBjb3B5IGl0IHRvIHlvdXINCmxv
Y2FsIHJvb3RmcyAvbGliL2Zpcm13YXJlL2lteC9zZG1hLg0KaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZmlybXdhcmUvbGludXgtZmlybXdhcmUuZ2l0L3Ry
ZWUvaW14L3NkbWENCg0KdjI6DQogIDEuIGFkZCBjb21taXQgbG9nIGZvciByZXZlcnRlZCBwYXRj
aGVzLg0KICAyLiBhZGQgY29tbWVudCBmb3IgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlci4N
CiAgMy4gYWRkICdmc2wsaW14NnNsbC1lY3NwaScgY29tcGF0aWJsZSBpbnN0ZWFkIG9mICdmc2ws
aW14NnVsLWVjc3BpJw0KICAgICByYXRoZXIgdGhhbiByZW1vdmUuDQoNCg0KUm9iaW4gR29uZyAo
MTUpOg0KICBSZXZlcnQgIkFSTTogZHRzOiBpbXg2cTogVXNlIGNvcnJlY3QgU0RNQSBzY3JpcHQg
Zm9yIFNQSTUgY29yZSINCiAgUmV2ZXJ0ICJBUk06IGR0czogaW14NjogVXNlIGNvcnJlY3QgU0RN
QSBzY3JpcHQgZm9yIFNQSSBjb3JlcyINCiAgUmV2ZXJ0ICJkbWFlbmdpbmU6IGlteC1zZG1hOiBy
ZWZpbmUgdG8gbG9hZCBjb250ZXh0IG9ubHkgb25jZSINCiAgZG1hZW5naW5lOiBpbXgtc2RtYTog
cmVtb3ZlIGR1cGlsaWNhdGVkIHNkbWFfbG9hZF9jb250ZXh0DQogIGRtYTogZW5naW5lOiBpbXgt
c2RtYTogYWRkIG1jdV8yX2Vjc3BpIHNjcmlwdA0KICBzcGk6IGlteDogZml4IEVSUjAwOTE2NQ0K
ICBzcGk6IGlteDogcmVtb3ZlIEVSUjAwOTE2NSB3b3JrYXJvdW5kIG9uIGkubXg2dWwNCiAgZHQt
YmluZGluZ3M6IHNwaTogaW14OiBhZGQgaS5teDZ1bCB0byBzdGF0ZSBlcnJhdGEgZml4ZWQNCiAg
ZG1hZW5naW5lOiBpbXgtc2RtYTogcmVtb3ZlIEVSUjAwOTE2NSBvbiBpLm14NnVsDQogIGR0LWJp
bmRpbmdzOiBkbWE6IGlteC1zZG1hOiBhZGQgaS5teDZ1bC82c3ggY29tcGF0aWJsZSBuYW1lDQog
IGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBlY3NwaTEgcnggZG1hIG5vdCB3b3JrIG9uIGkubXg4
bW0NCiAgQVJNNjQ6IGR0czogZnJlZXNjYWxlOiBpbXg4bW0vOG1xOiB1cGRhdGUgbmV3IGNvbXBh
dGlibGUgbmFtZSBmb3INCiAgICBlY3NwaSBhbmQgc2RtYQ0KICBBUk06IGR0czogaW14NnVsOiBh
ZGQgZG1hIHN1cHBvcnQgb24gZWNzcGkNCiAgQVJNOiBkdHM6IGlteDZzbGw6IGNvcnJlY3QgZWNz
cGkvc2RtYSBjb21wYXRpYmxlDQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBTRE1BIG9uIGku
bXg4bXEvOG1tDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4
dCAgICAgICB8ICAyICsNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3Bp
LnR4dCAgICAgICB8ICAyICsNCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICstDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpICAg
ICAgICAgICAgICAgICAgICAgfCAgOCArLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0
c2kgICAgICAgICAgICAgICAgICAgICB8IDEwICsrLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2
dWwuZHRzaSAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKw0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpICAgICAgICAgIHwgMTQgKystLS0NCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSAgICAgICAgICB8ICA2ICstDQogYXJjaC9h
cm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArDQogZHJp
dmVycy9kbWEvaW14LXNkbWEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2NyArKysr
KysrKysrKysrKysrLS0tLS0tDQogZHJpdmVycy9zcGkvc3BpLWlteC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCA0NiArKysrKysrKysrKystLS0NCiBpbmNsdWRlL2xpbnV4L3BsYXRm
b3JtX2RhdGEvZG1hLWlteC1zZG1hLmggICAgICAgICB8ICAxICsNCiAxMiBmaWxlcyBjaGFuZ2Vk
LCAxMjQgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
