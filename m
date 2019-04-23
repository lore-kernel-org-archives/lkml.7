Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500BAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2C2206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XzyiZeS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfDWNui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:50:38 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:24963
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfDWNui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4q+KfkZ548fRBsjhTaA2XKTALFn1gteHj7k7G6UC9k=;
 b=XzyiZeS7aHSARYn74OUemZZ0FdQIaWrywGgAKENUShgHMqzK5mFrqJ64BpFdhh5u5T8stuqX8kKHuQNSyamBoSXhSnEcRhEsxerBv6UNG299TrnLiemw7jgEWBgXFACuZpZdlINH03cGTJ5LHmjLUbNWaJ7n4Qzg8lqOfC49Pf8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:50:34 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:50:34 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v1 00/15] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHU+duGTXiEawO6vkOZRAs4Bg3Yeg==
Date:   Tue, 23 Apr 2019 13:50:34 +0000
Message-ID: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db4fe6c9-adc8-47e5-50f7-08d6c7f2a850
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB590184D9476C3F1BD46D218A89230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(316002)(14454004)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(966005)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(50226002)(2616005)(52116002)(2906002)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PpQx5do2VVhhfW9aHljzGOxjB8o8KHWYidwt8ZzwsiWBMc7K6TIm44AambuLRKQGnXJGHwiaRz5x+24s/ISU0CzbjKtSt2dGYYuWKiY9NF8d6UoEtIOh2EcDj0NyHer+wFWyWSVd+D/cOqAy6BGcUzFJkhLtfn/HP+Cbwl6EEFaXlLFwLE5JQEJZ9vpXFWFU5HUFmMPQGdG8U/Sgy7tw2K2m28FbsBj34DTeqReowtgwnF8kqaxpihsYVDjYDcJw0FETZA75yeKvWd8sL5CR+QedNgugv7qtHcmxyNWUVoqH3aDDkL8f2yNxSFJhk6YW+jyJMZ4gLPiEE3Vs9T9dmgU4pqYMqBBzGQriedxMyoiRc+Aofjju/nltvIcIjnNa/GjyAH1vlthYqa7fcE5K6p4MhvXjlvNIrwatYeBeviE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4fe6c9-adc8-47e5-50f7-08d6c7f2a850
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:50:34.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
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
ZWUvaW14L3NkbWENCg0KUm9iaW4gR29uZyAoMTUpOg0KICBSZXZlcnQgIkFSTTogZHRzOiBpbXg2
cTogVXNlIGNvcnJlY3QgU0RNQSBzY3JpcHQgZm9yIFNQSTUgY29yZSINCiAgUmV2ZXJ0ICJBUk06
IGR0czogaW14NjogVXNlIGNvcnJlY3QgU0RNQSBzY3JpcHQgZm9yIFNQSSBjb3JlcyINCiAgUmV2
ZXJ0ICJkbWFlbmdpbmU6IGlteC1zZG1hOiByZWZpbmUgdG8gbG9hZCBjb250ZXh0IG9ubHkgb25j
ZSINCiAgZG1hZW5naW5lOiBpbXgtc2RtYTogcmVtb3ZlIGR1cGlsaWNhdGVkIHNkbWFfbG9hZF9j
b250ZXh0DQogIGRtYTogZW5naW5lOiBpbXgtc2RtYTogYWRkIG1jdV8yX2Vjc3BpIHNjcmlwdA0K
ICBzcGk6IGlteDogZml4IEVSUjAwOTE2NQ0KICBzcGk6IGlteDogcmVtb3ZlIEVSUjAwOTE2NSB3
b3JrYXJvdW5kIG9uIGkubXg2dWwNCiAgZHQtYmluZGluZ3M6IHNwaTogaW14OiBhZGQgaS5teDZ1
bCB0byBzdGF0ZSBlcnJhdGEgZml4ZWQNCiAgZG1hZW5naW5lOiBpbXgtc2RtYTogcmVtb3ZlIEVS
UjAwOTE2NSBvbiBpLm14NnVsDQogIGR0LWJpbmRpbmdzOiBkbWE6IGlteC1zZG1hOiBhZGQgaS5t
eDZ1bC82c3ggY29tcGF0aWJsZSBuYW1lDQogIGRtYWVuZ2luZTogaW14LXNkbWE6IGZpeCBlY3Nw
aTEgcnggZG1hIG5vdCB3b3JrIG9uIGkubXg4bW0NCiAgQVJNNjQ6IGR0czogZnJlZXNjYWxlOiBp
bXg4bW0vOG1xOiB1cGRhdGUgbmV3IGNvbXBhdGlibGUgbmFtZSBmb3INCiAgICBlY3NwaSBhbmQg
c2RtYQ0KICBBUk06IGR0czogaW14NnVsOiBhZGQgZG1hIHN1cHBvcnQgb24gZWNzcGkNCiAgQVJN
OiBkdHM6IGlteDZzbGw6IGNvcnJlY3QgZWNzcGkvc2RtYSBjb21wYXRpYmxlDQogIGFybTY0OiBk
ZWZjb25maWc6IEVuYWJsZSBTRE1BIG9uIGkubXg4bXEvOG1tDQoNCiAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9kbWEvZnNsLWlteC1zZG1hLnR4dCAgICAgICB8ICAyICsNCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dCAgICAgICB8ICAyICsNCiBhcmNoL2FybS9i
b290L2R0cy9pbXg2cS5kdHNpICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQogYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpICAgICAgICAgICAgICAgICAgICAgfCAgOCArLS0NCiBh
cmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kgICAgICAgICAgICAgICAgICAgICB8IDEwICsr
LS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSAgICAgICAgICAgICAgICAgICAgICB8
ICA4ICsrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpICAgICAg
ICAgIHwgMTQgKystLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRz
aSAgICAgICAgICB8ICA2ICstDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMyArDQogZHJpdmVycy9kbWEvaW14LXNkbWEuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysrKysrLS0tLS0tDQogZHJpdmVycy9z
cGkvc3BpLWlteC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA0NiArKysrKysrKysr
KystLS0NCiBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmggICAgICAg
ICB8ICAxICsNCiAxMiBmaWxlcyBjaGFuZ2VkLCAxMjQgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
