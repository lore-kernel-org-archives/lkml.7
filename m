Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B48C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD47923407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="arDISNE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfH2KDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:03:38 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:48145
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfH2KDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acovKZzwEcEF6rfLziXMa3ae5XLmArcc0Ro3+EzxgLOlAgaWPrLPt8kuXS1FBrPsF6+ak2Txg3CPboDwyhNHi1V8yhNR2jvJY3MWiHzcJAosbWsSi9GfC/PoW2EcC16j4feX+cxts+jFHiL/Sb7RwCE0aFKpLJasI1lXAZbdUoRj2WT7v1fjmBfF9r7ncWvrJ3dUkYnqUzYcddtBVKoCtJ2xdsoH+f0T/6qCl2d+FmKeLmUaPK0sLedaedLeYeOKKBG0ZgpWMHsqI8tNpiNRInMBohWVQuMkalhLnmXJpr9l+8Ma2uk2lsKNsjKSOSWogagNyQ25j0gVJq9LNxXdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61kIDKLFWSPaecxA2gh/zWB5Hf3lSZwL8gRwzPXIUhY=;
 b=DeUjlYawCcYjH+osRnkjWzSWkvmESrFG/mtMpIqHBlKtZmxCA1suy0xRDl9umwblAqxSGH+ABn7gonSxni5stp2FCVyDAswRgY5aJbfSR6xF62uKGHCLedcFh2RlMhJTlQbbB1lwlKSN1XeUY6od2l1GH1lTFrLCHU37I6TJ0N97ymd/XEgJk0/DxkCOlg5cZ+IaeNpwW9b9NVp9RoteyP6f1fcJKCMOVJMCqG0Qb4ZJlKwjcMckOzjYnmOa2GpDzL6x9SkClmWwAOpkCBzy7N+aIguYDUQQZmDb5kd9YEm3PHdXUGAA1+UXcu1pjwu/Epv67ObyXSTT1r91nj0XDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61kIDKLFWSPaecxA2gh/zWB5Hf3lSZwL8gRwzPXIUhY=;
 b=arDISNE07NFAL7vvbFpFA5/eYH7StF0XzEocHv0aifmvCsgaQNy9qTmvm64NGZmL1f74ZYfbpXTuEq5Pc404VeZjFIDdqNjZ6xJ8i250sbM/22JZM1zj/k4okk4+x8uGdq9R61GR9b+Br19niyjHMsvgFOpXkIufT0avBg1p/uY=
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com (52.133.13.160) by
 VI1PR04MB5613.eurprd04.prod.outlook.com (20.178.125.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 10:03:34 +0000
Received: from VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c]) by VI1PR04MB4094.eurprd04.prod.outlook.com
 ([fe80::c85e:7409:9270:3c3c%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 10:03:34 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42xx8: Force suspend/resume during
 system suspend/resume
Thread-Topic: [alsa-devel] [PATCH] ASoC: cs42xx8: Force suspend/resume during
 system suspend/resume
Thread-Index: AQHVXlEEGU4b2ITnKkSzGQAmiDenzw==
Date:   Thu, 29 Aug 2019 10:03:34 +0000
Message-ID: <0b6116bb10c1d94246383b715b89abd9d458a661.camel@nxp.com>
References: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a02723ec-6f05-4793-c6e0-08d72c68272b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5613;
x-ms-traffictypediagnostic: VI1PR04MB5613:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5613EE39815D35F357233C16F9A20@VI1PR04MB5613.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(8676002)(81156014)(478600001)(486006)(110136005)(316002)(81166006)(8936002)(44832011)(71200400001)(71190400001)(14454004)(86362001)(66066001)(6116002)(3846002)(6246003)(99286004)(25786009)(50226002)(91956017)(76116006)(2201001)(6486002)(6436002)(6512007)(53936002)(476003)(66946007)(2616005)(11346002)(446003)(26005)(118296001)(186003)(66446008)(64756008)(66556008)(66476007)(76176011)(6506007)(102836004)(2501003)(4744005)(229853002)(2906002)(15650500001)(7736002)(305945005)(36756003)(256004)(5660300002)(14444005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5613;H:VI1PR04MB4094.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KJO5O2Pn3M4h56u5ukeY6vs1IaT7zFeVH8fzvgQekYKeRz4XGuLpT+vyh0REZYH5kMQPhVz8bneYgQ7N1buyuBmZDko41Criv2C1G6TRgZg1zvGgxAeACRC344JZP680SUyrNpkgYV6MRQMm4zzCrBQwBAcNU4G4ruOgWXOrQv9bXByNE/NW59M079iwi0cLJW2oo3715tlkIKw7YOQl3wTaXhZdkLD13tBGEyQk6bBoSgG5M4xYoNC4qdxtcEz/3fOwBG3bjODTkxgoYJR2vTql7pB1e8Ks6WFAoZRp9xl5+cQWm4GtlwfPyjDTpCCpok1Ux+7Bgi/IdEbA4i8JDCLnS58CINLnP/VKIX6ixg8/koA9nVIvJe7P9TihfGLxWq06EwnXc1lSfoOVA7vGV2Sr2mkq8dPHlMf22E80kP0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41D1E37C5A1C8C4A8C580A13345026FA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02723ec-6f05-4793-c6e0-08d72c68272b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 10:03:34.0546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3t8fe0W2qxCPnzWM/DA4kTFha3h6zLizxFZoXjq6L9ejyojGWQUv+UkS21oCMNF1MbbsGVML54Si9CH31Xy30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDE4OjEzIC0wNDAwLCBTaGVuZ2ppdSBXYW5nIHdyb3RlOg0K
PiBVc2UgZm9yY2Vfc3VzcGVuZC9yZXN1bWUgdG8gbWFrZSBzdXJlIGNsb2NrcyBhcmUgZGlzYWJs
ZWQvZW5hYmxlZA0KPiBhY2NvcmRpbmdseSBkdXJpbmcgc3lzdGVtIHN1c3BlbmQvcmVzdW1lLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0K
DQpSZXZpZXdlZC1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KDQo+
IC0tLQ0KPiAgc291bmQvc29jL2NvZGVjcy9jczQyeHg4LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVj
cy9jczQyeHg4LmMgYi9zb3VuZC9zb2MvY29kZWNzL2NzNDJ4eDguYw0KPiBpbmRleCA1YjA0OWZj
ZGJhMjAuLjk0YjFhZGIwODhmZCAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9jczQy
eHg4LmMNCj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9jczQyeHg4LmMNCj4gQEAgLTY4NCw2ICs2
ODQsOCBAQCBzdGF0aWMgaW50IGNzNDJ4eDhfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UN
Cj4gKmRldikNCj4gICNlbmRpZg0KPiAgDQo+ICBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBjczQy
eHg4X3BtID0gew0KPiArCVNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKHBtX3J1bnRpbWVfZm9yY2Vf
c3VzcGVuZCwNCj4gKwkJCQlwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSkNCj4gIAlTRVRfUlVOVElN
RV9QTV9PUFMoY3M0Mnh4OF9ydW50aW1lX3N1c3BlbmQsDQo+IGNzNDJ4eDhfcnVudGltZV9yZXN1
bWUsIE5VTEwpDQo+ICB9Ow0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoY3M0Mnh4OF9wbSk7DQo=
