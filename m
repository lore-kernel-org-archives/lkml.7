Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447AC282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C944B20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g5KixgI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfE0CGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:06:48 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:1248
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfE0CGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=126Nm8RIhXX6zkUSjEAWjmImR6xdGMacWsz4U54OXHU=;
 b=g5KixgI3HmliMM2bZ+/b5+nhBH45xxnTVY5xLu75snhVDMl9ODLt8w/7JKB9DZaR9wuakA2Z/n97pGzrEwpq6GxxWFcr7bxAYlkD/O7Y8QnoBI1DbgoTgtojjjHHpu+vm8qZtI6w6+6hB4diDMowQY8lKq0R6nrilY0e9S80F70=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0SPR01MB013.eurprd04.prod.outlook.com (52.133.41.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Mon, 27 May 2019 02:06:44 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 02:06:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVESt7O8zUR8j7k0mzGFqyu7YBg6Z+PE2AgAAAU9A=
Date:   Mon, 27 May 2019 02:06:44 +0000
Message-ID: <AM0PR04MB4481E92EFFD69301432C9D23881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
 <CABb+yY0r-njq2OGVP9xAh=-wgib5zk8XbS-vdY1jtz2R=rT4Nw@mail.gmail.com>
In-Reply-To: <CABb+yY0r-njq2OGVP9xAh=-wgib5zk8XbS-vdY1jtz2R=rT4Nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5530f8c4-4d7c-47bc-c9b7-08d6e247f781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0SPR01MB013;
x-ms-traffictypediagnostic: AM0SPR01MB013:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0SPR01MB013B2035595233A9120BD70881D0@AM0SPR01MB013.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(54906003)(76176011)(7696005)(15650500001)(66066001)(5660300002)(53546011)(102836004)(6506007)(186003)(11346002)(4326008)(256004)(81166006)(1411001)(26005)(7416002)(44832011)(6246003)(71200400001)(71190400001)(8936002)(446003)(99286004)(486006)(53936002)(8676002)(476003)(25786009)(81156014)(55016002)(9686003)(6306002)(6436002)(14454004)(76116006)(73956011)(86362001)(52536014)(229853002)(7736002)(6916009)(68736007)(316002)(305945005)(74316002)(6116002)(3846002)(2906002)(966005)(33656002)(45080400002)(478600001)(64756008)(66476007)(66946007)(66446008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB013;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rpR/wsKoZQ/ZTUQSCAIrhsg9SRRgPGjXuFRA/HR306opNFAAtVdHB8VPNmAOp9G1CVA+Q4OUJVzFCi8cZVElOZbk6JOFwR2nrA828vCO1Uuq9EIFL1AJiQqATc5XCppgeoktRBNPpGKV83zNFxlhgMK7yi27JnTAGAy9B0yTy0lsqp0UEqpnHw4VAGzC+ZZXw/3gwjPfpU4E+RtGY6yGpRIVMXw4jSb6p7BvjUND0iNZuN9G11k/H0Ie+aFzI+wSLgKuj1B1xwVquJCCX0/VdrDb+WBPxif7ON0ztlewsGMHLarL1zzBU/wJVYDAYn3ay+uLLJtcXsCqoJsFGj9oRSXJDWlqhQ6JPxk2/pPoF+zTbpnamvvT1ALVTQe+8pBE4ZH756HAfsBpaXsZgqWXre9DBqP03wWyylh3nwj6zBs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5530f8c4-4d7c-47bc-c9b7-08d6e247f781
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 02:06:44.1667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIG1haWxib3g6IGFybTogaW50
cm9kdWNlIHNtYyB0cmlnZ2VyZWQgbWFpbGJveA0KPiANCj4gT24gVGh1LCBNYXkgMjMsIDIwMTkg
YXQgMTI6NTAgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
VGhpcyBpcyBhIG1vZGlmaWVkIHZlcnNpb24gZnJvbSBBbmRyZSBQcnp5d2FyYSdzIHBhdGNoIHNl
cmllcw0KPiA+DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2UNCj4gcm5lbC5vcmclMkZwYXRjaHdvcmslMkZj
b3ZlciUyRjgxMjk5NyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDcGUNCj4gbmcuZmFuJTQwbnhwLmNv
bSU3QzQwYmIxNjMyZjk5MjQ4ZjI0ZTEzMDhkNmUyNDY3YzhiJTdDNjg2ZWExZDNiDQo+IGMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzElN0M2MzY5NDUxODk3MDU2MjA3OTYmYW1wO3NkYXQN
Cj4gYT12Nm1MeURLTE84TmFCTWxYNlhsT0N0T3MyQzQxVHVPRzl5RkRZJTJGN3E4blUlM0QmYW1w
O3Jlc2VyDQo+IHZlZD0wLg0KPiA+DQo+IENhbiB5b3UgcGxlYXNlIHNwZWNpZnkgZXhhY3QgbW9k
aWZpY2F0aW9ucyBvbiB0b3Agb2YgQW5kcmUncyBsYXN0IHN1Ym1pc3Npb24/DQo+IEFzIGluICJD
aGFuZ2VzIHNpbmNlIHYxOiAuLi4uIg0KDQpTaW5jZSBBbmRyZSdzIGxhc3QgdjIgdmVyc2lvbiB3
YXMgc2VudCBpbiAyMDE3LCBJIHRob3VnaHQgbm8gbmVlZCB0byBhZGQgdGhhdC4NClRoZSBjaGFu
Z2VzIGFyZSBtb3N0bHkuDQpJbnRyb2R1Y2UgYXJtLG51bS1jaGFucw0KSW50cm9kdWNlIGFybV9z
bWNjY19tYm94X2NtZA0KdHhkb25lX3BvbGwgYW5kIHR4ZG9uZV9pcnEgYXJlIGJvdGggc2V0IHRv
IGZhbHNlDQphcm0sZnVuYy1pZHMgYXJlIGtlcHQsIGJ1dCBhcyBhbiBvcHRpb25hbCBwcm9wZXJ0
eS4NClJld29yZHMgU0NQSSB0byBTQ01JLCBiZWNhdXNlIEkgYW0gdHJ5aW5nIFNDTUkgb3ZlciBT
TUMsIG5vdCBTQ1BJLg0KDQpJJ2xsIGFkZCB0aGUgY2hhbmdlcyBpbmZvcm1hdGlvbiBhZnRlciBJ
IGNvbGxlY3QgbW9yZSBjb21tZW50cyBpbiB0aGlzIHBhdGNoc2V0Lg0KDQpUaGFua3MsDQpQZW5n
Lg0KPiANCj4gVGhhbmtzLg0K
