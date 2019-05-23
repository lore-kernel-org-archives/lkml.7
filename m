Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6ADC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314321019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRJP35P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEWFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:51:00 -0400
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:7844
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfEWFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zginAZIZPWKy8MR98wFqzlqik8S2uYqoxxLxkzhju7c=;
 b=HRJP35P9cKsBBoL0wQmZ6oqtkAsYfTLB3MjgT5/wtahfkG25DoJgX+XiqX0ecTM1hNZEBWE+nGaxYcqahUST2sgWCHIYML9sJquP8DTJe2SjdvBV8xXOyK/+OyAPJ+yl9jurw55Lc3IdFzgYZ4/04mV8DRWw+01/OQ2V/8g1DjE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3956.eurprd04.prod.outlook.com (52.134.93.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Thu, 23 May 2019 05:50:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 05:50:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVESt7O8zUR8j7k0mzGFqyu7YBgw==
Date:   Thu, 23 May 2019 05:50:53 +0000
Message-ID: <20190523060437.11059-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a390a697-eca7-475c-ef6d-08d6df429e26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB3956;
x-ms-traffictypediagnostic: AM0PR04MB3956:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB395604D264F63B651B23996388010@AM0PR04MB3956.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(2201001)(86362001)(6512007)(256004)(6436002)(6306002)(44832011)(486006)(2501003)(14444005)(2906002)(2616005)(476003)(6116002)(3846002)(81166006)(8676002)(25786009)(6486002)(305945005)(81156014)(8936002)(50226002)(4326008)(53936002)(15650500001)(7736002)(316002)(186003)(26005)(14454004)(66066001)(68736007)(1076003)(36756003)(71200400001)(71190400001)(102836004)(5660300002)(966005)(386003)(54906003)(110136005)(6506007)(99286004)(66556008)(66446008)(66476007)(7416002)(66946007)(478600001)(73956011)(52116002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3956;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9rIPLV+As7aP2HK12gKFHuczD85eTjQwTUOQTmCaEpF3eowb5vRHjUdZ1CZdA5/uSTj5qi14FaiNOiLW/PNKUb9bYXQSlO59hEwUNwZb3M0b+FG37XqpW1NuuiXaAJiwIkaRI1OMCCU6GTtyB+EahKlfs2Ul3vEn3b+W4+cKuuusnKBa3Kl9g8Yhx5BtvLVbYEwqYlsyvOn6MLqFiIm6C7o01rKuF4nQFnjRe6pcT3c7OqYS8ioEHR5m96a4ftr0zQgB9lFY4DG6PgryqoNS7PJV1VSjEV6h1TNqop/qPSIfyHOsoDobNXbR4G9L20VwHN2jmKjA7o45UWZyqMOFmsME/aRzXWcFVc/dfQreeZFFpg/of1ajU/oEC5Am0aNHJNj3haV/q1n6ufk6TsXuh+xSN9yCK1F/JRmB9tIUAdo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a390a697-eca7-475c-ef6d-08d6df429e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 05:50:53.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhIG1vZGlmaWVkIHZlcnNpb24gZnJvbSBBbmRyZSBQcnp5d2FyYSdzIHBhdGNoIHNl
cmllcwpodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvY292ZXIvODEyOTk3Ly4KWzFd
IGlzIGEgZHJhZnQgaW1wbGVtZW50YXRpb24gb2YgaS5NWDhNTSBTQ01JIEFURiBpbXBsZW1lbnRh
dGlvbiB0aGF0CnVzZSBzbWMgYXMgbWFpbGJveCwgcG93ZXIvY2xrIGlzIGluY2x1ZGVkLCBidXQg
b25seSBwYXJ0IG9mIGNsayBoYXMgYmVlbgppbXBsZW1lbnRlZCB0byB3b3JrIHdpdGggaGFyZHdh
cmUsIHBvd2VyIGRvbWFpbiBvbmx5IHN1cHBvcnRzIGdldCBuYW1lCmZvciBub3cuCgpUaGUgdHJh
ZGl0aW9uYWwgTGludXggbWFpbGJveCBtZWNoYW5pc20gdXNlcyBzb21lIGtpbmQgb2YgZGVkaWNh
dGVkIGhhcmR3YXJlCklQIHRvIHNpZ25hbCBhIGNvbmRpdGlvbiB0byBzb21lIG90aGVyIHByb2Nl
c3NpbmcgdW5pdCwgdHlwaWNhbGx5IGEgZGVkaWNhdGVkCm1hbmFnZW1lbnQgcHJvY2Vzc29yLgpU
aGlzIG1haWxib3ggZmVhdHVyZSBpcyB1c2VkIGZvciBpbnN0YW5jZSBieSB0aGUgU0NNSSBwcm90
b2NvbCB0byBzaWduYWwgYQpyZXF1ZXN0IGZvciBzb21lIGFjdGlvbiB0byBiZSB0YWtlbiBieSB0
aGUgbWFuYWdlbWVudCBwcm9jZXNzb3IuCkhvd2V2ZXIgc29tZSBTb0NzIGRvZXMgbm90IGhhdmUg
YSBkZWRpY2F0ZWQgbWFuYWdlbWVudCBjb3JlIHRvIHByb3ZpZGUKdGhvc2Ugc2VydmljZXMuIElu
IG9yZGVyIHRvIHNlcnZpY2UgVEVFIGFuZCB0byBhdm9pZCBsaW51eCBzaHV0ZG93bgpwb3dlciBh
bmQgY2xvY2sgdGhhdCB1c2VkIGJ5IFRFRSwgbmVlZCBsZXQgZmlybXdhcmUgdG8gaGFuZGxlIHBv
d2VyCmFuZCBjbG9jaywgdGhlIGZpcm13YXJlIGhlcmUgaXMgQVJNIFRydXN0ZWQgRmlybXdhcmUg
dGhhdCBjb3VsZCBhbHNvCnJ1biBTQ01JIHNlcnZpY2UuCgpUaGUgZXhpc3RpbmcgU0NNSSBpbXBs
ZW1lbnRhdGlvbiB1c2VzIGEgcmF0aGVyIGZsZXhpYmxlIHNoYXJlZCBtZW1vcnkKcmVnaW9uIHRv
IGNvbW11bmljYXRlIGNvbW1hbmRzIGFuZCB0aGVpciBwYXJhbWV0ZXJzLCBpdCBzdGlsbCByZXF1
aXJlcyBhCm1haWxib3ggdG8gYWN0dWFsbHkgdHJpZ2dlciB0aGUgYWN0aW9uLgoKVGhpcyBwYXRj
aCBzZXJpZXMgcHJvdmlkZXMgYSBMaW51eCBtYWlsYm94IGNvbXBhdGlibGUgc2VydmljZSB3aGlj
aCB1c2VzCnNtYyBjYWxscyB0byBpbnZva2UgZmlybXdhcmUgY29kZSwgZm9yIGluc3RhbmNlIHRh
a2luZyBjYXJlIG9mIFNDTUkgcmVxdWVzdHMuClRoZSBhY3R1YWwgcmVxdWVzdHMgYXJlIHN0aWxs
IGNvbW11bmljYXRlZCB1c2luZyB0aGUgc3RhbmRhcmQgU0NNSSB3YXkgb2YKc2hhcmVkIG1lbW9y
eSByZWdpb25zLCBidXQgYSBkZWRpY2F0ZWQgbWFpbGJveCBoYXJkd2FyZSBJUCBjYW4gYmUgcmVw
bGFjZWQgdmlhCnRoaXMgbmV3IGRyaXZlci4KClRoaXMgc2ltcGxlIGRyaXZlciB1c2VzIHRoZSBh
cmNoaXRlY3RlZCBTTUMgY2FsbGluZyBjb252ZW50aW9uIHRvIHRyaWdnZXIKZmlybXdhcmUgc2Vy
dmljZXMsIGFsc28gYWxsb3dzIGZvciB1c2luZyAiSFZDIiBjYWxscyB0byBjYWxsIGludG8gaHlw
ZXJ2aXNvcnMKb3IgZmlybXdhcmUgbGF5ZXJzIHJ1bm5pbmcgaW4gdGhlIEVMMiBleGNlcHRpb24g
bGV2ZWwuCgpQYXRjaCAxIGNvbnRhaW5zIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50
YXRpb24sIHBhdGNoIDIgaW50cm9kdWNlcwp0aGUgYWN0dWFsIG1haWxib3ggZHJpdmVyLgoKUGxl
YXNlIG5vdGUgdGhhdCB0aGlzIGRyaXZlciBqdXN0IHByb3ZpZGVzIGEgZ2VuZXJpYyBtYWlsYm94
IG1lY2hhbmlzbSwKdGhvdWdoIHRoaXMgaXMgc3luY2hyb25vdXMgYW5kIG9uZS13YXkgb25seSAo
dHJpZ2dlcmVkIGJ5IHRoZSBPUyBvbmx5LAp3aXRob3V0IHByb3ZpZGluZyBhbiBhc3luY2hyb25v
dXMgd2F5IG9mIHRyaWdnZXJpbmcgcmVxdWVzdCBmcm9tIHRoZQpmaXJtd2FyZSkuCkFuZCB3aGls
ZSBwcm92aWRpbmcgU0NNSSBzZXJ2aWNlcyB3YXMgdGhlIHJlYXNvbiBmb3IgdGhpcyBleGVyY2lz
ZSwgdGhpcwpkcml2ZXIgaXMgaW4gbm8gd2F5IGJvdW5kIHRvIHRoaXMgdXNlIGNhc2UsIGJ1dCBj
YW4gYmUgdXNlZCBnZW5lcmljYWxseQp3aGVyZSB0aGUgT1Mgd2FudHMgdG8gc2lnbmFsIGEgbWFp
bGJveCBjb25kaXRpb24gdG8gZmlybXdhcmUgb3IgYQpoeXBlcnZpc29yLgpBbHNvIHRoZSBkcml2
ZXIgaXMgaW4gbm8gd2F5IG1lYW50IHRvIHJlcGxhY2UgYW55IGV4aXN0aW5nIGZpcm13YXJlCmlu
dGVyZmFjZSwgYnV0IGFjdHVhbGx5IHRvIGNvbXBsZW1lbnQgZXhpc3RpbmcgaW50ZXJmYWNlcy4K
ClsxXSBodHRwczovL2dpdGh1Yi5jb20vTXJWYW4vYXJtLXRydXN0ZWQtZmlybXdhcmUvdHJlZS9z
Y21pCgpQZW5nIEZhbiAoMik6CiAgRFQ6IG1haWxib3g6IGFkZCBiaW5kaW5nIGRvYyBmb3IgdGhl
IEFSTSBTTUMgbWFpbGJveAogIG1haWxib3g6IGludHJvZHVjZSBBUk0gU01DIGJhc2VkIG1haWxi
b3gKCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FybS1zbWMudHh0ICAgICAgICB8
ICA5NiArKysrKysrKysrKysrCiBkcml2ZXJzL21haWxib3gvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNyArCiBkcml2ZXJzL21haWxib3gvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMiArCiBkcml2ZXJzL21haWxib3gvYXJtLXNtYy1tYWlsYm94
LmMgICAgICAgICAgICAgICAgICB8IDE1NCArKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUv
bGludXgvbWFpbGJveC9hcm0tc21jLW1haWxib3guaCAgICAgICAgICAgIHwgIDEwICsrCiA1IGZp
bGVzIGNoYW5nZWQsIDI2OSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy50eHQKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21haWxib3gvYXJtLXNtYy1tYWlsYm94LmMKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2xpbnV4L21haWxib3gvYXJtLXNtYy1tYWlsYm94LmgKCi0tIAoyLjE2
LjQKCg==
