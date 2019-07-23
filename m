Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F827C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D91D21E70
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N79w1PCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfGWC3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:29:17 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:25749
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728444AbfGWC3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaUDcH3Lhg6vpNeq8wMJfuEwqSB+fj3X9kvYaeVzWn8Hlmy9cCq4b6LQYfTwsnoyFAOYyToM9axo9TRHKC3aPps8lz7tJ10D/E0u2kQwhDMWJXvuPMN+n7bSlV2cu1MxYDm11o77OKGg5TmjkamZ36nHNYdnr9/gBQRGbA36Z81b6JgIYukGDqOfOE61pFyJ3sWDgFdDGWVPRsrhc8pIYRqSQE61KCNWDH40HJl8TENp3OI7XHtLW1rBlkzO/lEj9/l0rT/VHbcsmMMfzhHvYNHeSaSa8lbFXgsyba0wpD3q2cHI1JpgVBoULKPC3bY6cZ5Iqc8uf+/5yVaP4eqiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAFbg9RZKPdvP4lQA4YktEGcFVQRywFZlOsoVSNtEA=;
 b=KLIirGRfp1cPtUrfhlv6KujH0VN77PmkP9vhmkOkwSl+BuCJQPBuffN2HLKJlX6VzyaF2v+YQqidrxV1HSG+uQIvvyr6UZnWxkP97H5zGHZk7Ezgysyk7ddB4kYoRyFlEiRSfpnQpfHvli+9tw17oDS5S7ndS9ABWWOfHhFMUEC+E06Cw1P0aA4ONvRFlulL7dsCe6jfg4M4uF6s0gxP21VERzt9gZK3Ftdt41c5LDzd9YKT7frevbcd26UNshgmt/R9ObcVKpUyEHx0pVpU809X5YQgDMT7p/+4m9KTb8lhrjMzM+WhyQh2VSTShxdY1ieLMqMLCqgkVgNyTZj5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAFbg9RZKPdvP4lQA4YktEGcFVQRywFZlOsoVSNtEA=;
 b=N79w1PCrLmZLdE+FiZz+TsWGtqqByeO9cGAj5hq/OHQ6ggT882ll53va2REi5sN7w4bSr9EcGqA7guhVRBXIHQmmpK0aTFgTWn0M6BXXqeReYLsJjlui/H5jBCSEHo/TqHSLq/WhBS9VsQB4q7eBp8LhnS/mwHqAMx3hRHgUyrc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 23 Jul 2019 02:29:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2094.017; Tue, 23 Jul 2019
 02:29:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V5 3/5] arm64: dts: imx8mm: Add system counter node
Thread-Topic: [PATCH V5 3/5] arm64: dts: imx8mm: Add system counter node
Thread-Index: AQHVNupdpHqneu/4Kkm8mqBCnVtP4qbWCYsAgAGFOSA=
Date:   Tue, 23 Jul 2019 02:29:13 +0000
Message-ID: <DB3PR0402MB3916841134BBE0C98C05ABE8F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190710063056.35689-1-Anson.Huang@nxp.com>
 <20190710063056.35689-3-Anson.Huang@nxp.com> <20190722031517.GT3738@dragon>
In-Reply-To: <20190722031517.GT3738@dragon>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: daniel.lezcano@linaro.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e421fb-44c3-4d3e-84fb-08d70f158d4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB3787FCA4647C4B2EC38316D5F5C70@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(199004)(189003)(316002)(44832011)(33656002)(486006)(6246003)(86362001)(25786009)(68736007)(66066001)(4744005)(6116002)(3846002)(8936002)(6436002)(81166006)(71190400001)(2906002)(229853002)(71200400001)(2501003)(9686003)(256004)(55016002)(53936002)(76116006)(66476007)(478600001)(54906003)(14454004)(110136005)(8676002)(305945005)(74316002)(186003)(7696005)(99286004)(7736002)(476003)(76176011)(11346002)(446003)(102836004)(52536014)(5660300002)(6506007)(4326008)(66946007)(26005)(7416002)(66446008)(64756008)(66556008)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +5ktEyUsssK7k7Ge7daFuijVb0RmXe3tnijbnNZAnWjkIjri5swNfIpdRF6NP5JjBvTBUTRfHtk0lUfsOEMf8cpIsWTVLWBP1jog2qQ39UVQoUM/9t3OudMlwmgMT7jPLoTGpdSJfNSPHYOqDSGnwfe9f0cefNOYqx8S8ycDATLFN3SQEmlErnU0eSOw3+33qnoWEvzTSJX4UmParu/kmkI81KTe+6c//IXwjxd+yFtVsTmgDd0YgNjNjgaelHPS4a3Q15i+KtZsHjHxbf0sj6pRth2rfaBlNDcpHlMUMHFXEwrhW0c2IJwpH3de0kMaS2v9Vf5O3rnFJJtQV1qabm37VVbMHyuJBvOpT7oVm1FWnuBT6uwelSWczCSFKIX5hXniCkcy4qKYnYLw3AMgqDwIPsC/zP6vTqNs2M0lEZQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e421fb-44c3-4d3e-84fb-08d70f158d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 02:29:13.4588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gT24gV2VkLCBKdWwgMTAsIDIwMTkgYXQgMDI6MzA6NTRQTSArMDgwMCwg
QW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCBpLk1YOE1NIHN5c3RlbSBjb3VudGVyIG5vZGUg
dG8gZW5hYmxlIHRpbWVyLWlteC1zeXNjdHIgYnJvYWRjYXN0DQo+ID4gdGltZXIgZHJpdmVyLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+IA0KPiBEbyBJIG5lZWQgdG8gd2FpdCBmb3IgcGF0Y2ggIzEgbGFuZGluZyBiZWZvcmUgSSBh
cHBseSAjMyB+ICM1LCBvciBjYW4gdGhleSBiZQ0KPiBhcHBsaWVkIGluZGVwZW5kZW50bHkgKG5v
IGJyZWFraW5nIG9uIGFueXRoaW5nKT8NCg0KV2l0aG91dCAjMSwgc3lzdGVtIGNhbiBib290dXAs
IGJ1dCB0aGUgc3lzdGVtIGNvdW50ZXIncyBmcmVxIHdpbGwgYmUgaW5jb3JyZWN0LA0KYWx0aG91
Z2ggaXQgZG9lcyBOT1QgaW1wYWN0IG5vcm1hbCBmdW5jdGlvbi4gU28gSSB0aGluayBpdCBpcyBi
ZXR0ZXIgdG8gd2FpdCBmb3INCiMxIGxhbmRpbmcuIEBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
LCBjYW4geW91IGhlbHAgcmV2aWV3IHRoZSAjMSBwYXRjaCwgc2luY2UNCkkgdXNlIGEgZGlmZmVy
ZW50IHdheSB0byBmaXggdGhlIGNsb2NrIGlzc3VlIHdoaWNoIGlzIG1vcmUgc2ltcGxlLg0KDQpB
bnNvbg0KDQo=
