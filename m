Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC09C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA8D22387
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hXVnN4YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfGYCRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:17:13 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:65449
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387784AbfGYCRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO8Iv2SKeBpJVB6EgrynBzMsGVq9vzc3lXl01spDJ76ItNKoGYJ62K67dYq+buV8ulSP95AiYZWpsmomshryER+0kB4wOj2CT7E3jQwZgbEOW6VopKWqOpFBm2wjSZ2vq4eSv8jwnGxQMjvEuPJecxbq/6aiNte+4gzn6wY4X7P//pn3SAGkLGGrxT8O6vS3H+23WXaBs3J++jyU0ah0yrO4X4YPRD+XHFKubNfoVJiex+TGJjXO7Vbk0hMFcmroBoGzDicWtjRKYN9zDecK5RKpjSHEHs7bOjF8jX542q+OWEgGpPLNWDCtrBkekfj0w1GzwxRElwD2AxvuiWeRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0mgIKzVyCphgL25EDVWyAurRhll0FtVykQBdQiTs0Q=;
 b=dscdgEf3F2guTArPNvi4759e6/7hNRh0ZF6YYzlX8w3rMuW9dBWt8zHrz7QQbmkBwu7c96/ICj+tc7foipEilEr51aR3y+bQljComsynu3mGy3sO/5UVv+leYd7MqRuZ9B5sKw+VEeHWqyc2rl0MeNmrUfbC/ZJMqOxf6a6VHCptW2TgqS2m4unz/9b8mkhPN/owMiau3F4l91qrbC5c0yuIoJLcF6e4BrwNTM6GjHS7ukFoNWM0RCOsILpXPdD4+yy8ESrMxQ7sQTyzGvyhn2IKZzudcfn6WH/zqYH7Vw4I1PKfOHd++QOHxUc65wqJM4puz73X9e7mMxlv8OAJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0mgIKzVyCphgL25EDVWyAurRhll0FtVykQBdQiTs0Q=;
 b=hXVnN4YPU7L4YB2+pkTo9a4EnfcygtJwTAZ6plQETCVohXs+2e0qU5jm3itaHk6v4b4E2KkNGIFzuBapHfgwL1BdgSoGZ9JyIQQ6mJQL/Ig1zMQeOQSDmY/YkTTk/NHFGqw6WrTI5oK/GqDt4hwoELkuESrYlUOwQ0zTto4LvwQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Thu, 25 Jul 2019 02:17:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2094.017; Thu, 25 Jul 2019
 02:17:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/5] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Thread-Topic: [PATCH V5 1/5] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Thread-Index: AQHVJmMF006ndGW3RkqrRMH2CdLcnabWEvkAgAP8B4CAAMHU4A==
Date:   Thu, 25 Jul 2019 02:17:07 +0000
Message-ID: <DB3PR0402MB3916A6EF2B9A34FB798120F3F5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190619055247.35771-1-Anson.Huang@nxp.com>
 <20190722015043.GP3738@dragon>
 <CAL_JsqKv39XdFABuRvxwiXg6qQpHSuykwgqTwsGw1g+D2wA1+w@mail.gmail.com>
In-Reply-To: <CAL_JsqKv39XdFABuRvxwiXg6qQpHSuykwgqTwsGw1g+D2wA1+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e457c78a-ad0c-4eff-6cde-08d710a631a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37054A7FE6B0A73AD53089A4F5C10@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(229853002)(99286004)(476003)(8676002)(110136005)(446003)(53936002)(11346002)(14454004)(76176011)(478600001)(76116006)(7696005)(305945005)(66476007)(7736002)(66946007)(54906003)(186003)(74316002)(66556008)(64756008)(66446008)(4326008)(53546011)(966005)(102836004)(5660300002)(52536014)(81166006)(81156014)(26005)(86362001)(7416002)(66066001)(25786009)(44832011)(68736007)(4744005)(33656002)(6506007)(486006)(316002)(8936002)(256004)(6306002)(55016002)(2906002)(6436002)(6116002)(9686003)(3846002)(71200400001)(71190400001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wy6h3EaLCvHxyT0+rpNeDPu1FlojLXi5O0HOZgkQeo3qSAux3+xFePgA26LIRxsiD703T8w6TEenO8pG9kQXBbMXLL1m+ofzx7kLUFYwPTUTwRSmzlHkEGj09ADpx+aBtehBwvDhJJItrD47d8ttNJ+SkR6c4Y5uj62lih7vQw0D0toXpf7GvLwwjyWn6JYZBclRaTCujgf4aKkc3raf/hdYajJli9pl3e+ZmZWvOAHnC6MsdmWD/DgRa6b1Se7lMnid2ytMM6XFl3rb8+fswbuRhXz+UdJ+YNDGzkGb0DnQVYCNYBCJIm+GOO0keN33aFxdzhL8TWn/rN6PWTfO+emMQIR4ERKLliuCsDjtVqcl6RfZSrvMCukykenZJRTlQJ+6K03MY5dcpymTdMorbV6u+WVD9quDoAjighiQ55E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e457c78a-ad0c-4eff-6cde-08d710a631a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 02:17:07.6947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU3VuLCBKdWwgMjEsIDIwMTkgYXQgNzo1MSBQTSBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBKdW4gMTksIDIwMTkgYXQgMDE6
NTI6NDNQTSArMDgwMCwgQW5zb24uSHVhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiA+IEZyb206IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4NCj4gPiA+IEFkZCB0aGUgY2xv
Y2sgYmluZGluZyBkb2MgZm9yIGkuTVg4TU4uDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogTWF4
aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4NCj4gPg0KPiA+IEFwcGxpZWQg
YWxsLCB0aGFua3MuDQo+IA0KPiBUaGlzIGJyZWFrcyBidWlsZGluZyBvZiAnZHRfYmluZGluZ19j
aGVjaycuIExvb2tzIGxpa2UgdGhlcmUgYXJlIHRhYnMgaW4gdGhlIGZpbGUNCj4gd2hpY2ggZG9l
c24ndCBtaXggd2l0aCBZQU1MLiBQbGVhc2UgZml4Lg0KDQpBaCwgeWVzLCB0aGVyZSBpcyBhIHRh
YiBpbiBmaWxlIGFuZCBicmVhayB0aGUgWUFNTCBmb3JtYXQsIEkgaGF2ZSBzZW5kIG91dCBhIHBh
dGNoIHRvDQpmaXggaXQsIGFuZCBZQU1MIGZpbGUgY2hlY2sgbm93IGNhbiBwYXNzLiBTb3JyeSBm
b3IgaXQuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEwNTc4MTUvDQoN
Ci0gICAgICAgY2xvY2stb3V0cHV0LW5hbWVzID0gIm9zY18zMmsiOw0KKyAgICAgICAgY2xvY2st
b3V0cHV0LW5hbWVzID0gIm9zY18zMmsiOw0KICAgICB9Ow0KDQpUaGFua3MsDQpBbnNvbg0K
