Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D4C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB902073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V5DlwxHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgAHIHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:07:02 -0500
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:26287
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgAHIHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:07:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiDvzEHINJpmz7R91dglDGPADAv3rk7Trw+DgVZ2JtmUoGUVy9WAdcV7STPim3pjaDHiqNzlBVkEda3NhksWCsByG/cTXWq4dMalPUQiM8pkY8XONqG7nUQXov0HRpZjcXm+knfCkPEcjQmvN7k7UODPnh+SzKAjYpBszwXKwib2titVbAGf5fBoVjXuFcSnxT3Ic3ULXDRa/o4iq6iaviX2TFY/owJOsdf7aXC8hOIOvkvxEvW6gdb1hymr8d5SLcaBvhiAq2e49i7NP+nUh8CSJPEHOlF7hgU5u3nuDzZr0VbJnzuDeudvNl2xFb7Qly8XJC7pXTPsm9WPR1XCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fVRusU3Ysr1lOAZSoClSvcLgazR37Akzh/t2MUIxVo=;
 b=Ze5vAEYs/kVcfjwi36Q2CfD1t9k0U2QYktucp7yO9YrL0tkXhZdYeiJHhRQvU7GzJFaoNIzJ8i1UkAAnOrYFSQaJa9HaFKOiCD3DbRnwZorAqleqWNcK6BsdDWWiOxP5+nX6l3wgBDb6fPhiwRnLte+X/yzvH5QE2fuMPW94T3ydJqNmgf/HQTT87ejkAzvzrCQ9a+7JWdNrg45fsRkRoxUq6n44ANxTVntN9a/fKN5ZXLbmb5cVPgE9XOT/OwRu/EaedFUYQAY5JSDdXptUK7whgGlcZkDpRdWXZF1h3USbAyI5uC/VHzHUKSA94pmdpW4no/Muu5ITxEzWgWnHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fVRusU3Ysr1lOAZSoClSvcLgazR37Akzh/t2MUIxVo=;
 b=V5DlwxHZN6hrv0MRKrPXj0+RonM38VVxU027BNkd8ck26oFgfEUiHtXCY5gJDogMQRmFePJArgahJucqPATTk8MXGaY9J6EDPa4TdUwwSsxUJ0wd/6E5avOQwubacHYJJphA+aCexyMSA58VNCEbuLggk5W/+tfsCF0cCxR7EL0=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3790.eurprd04.prod.outlook.com (52.134.18.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 08:06:57 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2602.015; Wed, 8 Jan 2020
 08:06:57 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mn: Memory node should be in board DT
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mn: Memory node should be in board
 DT
Thread-Index: AQHVxfVfUECs4Yztu0ytYo6rsOYu6afgaUaA
Date:   Wed, 8 Jan 2020 08:06:57 +0000
Message-ID: <d634927c27cfa91398e6d5c8be86dea29a21dbf1.camel@nxp.com>
References: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
         <1578468329-9983-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1578468329-9983-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05e2a018-589e-42a9-91f4-08d79411bb98
x-ms-traffictypediagnostic: VI1PR0402MB3790:|VI1PR0402MB3790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB37909B678BEEE5C0DADA4D7BF93E0@VI1PR0402MB3790.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(76116006)(71200400001)(26005)(66476007)(478600001)(2906002)(6506007)(7416002)(6512007)(66446008)(316002)(91956017)(66556008)(44832011)(2616005)(64756008)(66946007)(86362001)(110136005)(4326008)(36756003)(6486002)(8936002)(5660300002)(8676002)(186003)(81166006)(81156014)(99106002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3790;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJ8yf5EvEDB3QNK/oK7MxCSf06Y5Vr0cljTPb0vmDaVAVmoeb9z1Q3SizOSKQC2PH/0mLMc1c9t0WE5zDTkcNp7hdnMM26pH74Ihn/hhw6+mz0hR3Jm+1SvGe7r2KOMS0mm/ZtwLFk54b8xxXtIKbsUn69EN7dgr+vwXMFyesjp1jvBaNzOHUu8UWBDZSMl1bwg8DnS3Yx90M5+ny5lAUm2Pt17u+evEXoVitBcli4quJyI2MFT50cjztqjM5GfUxC6SwhfqzNJwP5rvTKZaizARrTeRrUdfn5hBG5FAlVj+S2TikfTexVMi5O/lj2/ZEK8ntheYa230cLZsFER+e1zwrhMdRfgzHnwhmSMphNEXK/aBpUloxDYrvxBgL4d8cRQNJ1qbM8x5id0QHK/XZ3fEUKpliDB/sA6HUzWXDW/7zBUPTkmldZZHbztjwoA2ov21epgiJa2+skr2qi9JqA6gheUVILqmSKEfa+WUJ2qGmkRkBhrQrxTiC4cwtSFHieLANQ+ir/th/bhyjtzkpXGcsdCfqKBD0vLFHmzfxkBl7srSWjL9dwF98zEyfQNE
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B73BFDE07A3F542BE0CA79B9825F18B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e2a018-589e-42a9-91f4-08d79411bb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 08:06:57.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgXSUGmTgeyphT2jzeGK8AWqQyFtRySYeu6AmbtsyGfcYj9L5zNP1hSh8+ht6l2qPh0PH6aCS6O5qLpBz8Rh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTA4IGF0IDE1OjI1ICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
TWVtb3J5IGFkZHJlc3Mvc2l6ZSBkZXBlbmRzIG9uIGJvYXJkIGRlc2lnbiwgc28gbWVtb3J5IG5v
ZGUgc2hvdWxkDQo+IGJlIGluIGJvYXJkIERULg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEYW5pZWwgQmFsdXRh
IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQoNCg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbi1ldmsuZHRzaSB8IDUgKysrKysNCj4gIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbi5kdHNpICAgICB8IDUgLS0tLS0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1ldmsuZHRzaQ0KPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1ldmsuZHRzaQ0KPiBpbmRleCA3YTkyOTUy
Li4wZDJlYzRhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW4tZXZrLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1uLWV2ay5kdHNpDQo+IEBAIC0yMyw2ICsyMywxMSBAQA0KPiAgCQl9Ow0KPiAgCX07DQo+ICAN
Cj4gKwltZW1vcnlANDAwMDAwMDAgew0KPiArCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiAr
CQlyZWcgPSA8MHgwIDB4NDAwMDAwMDAgMCAweDgwMDAwMDAwPjsNCj4gKwl9Ow0KPiArDQo+ICAJ
cmVnX3VzZGhjMl92bW1jOiByZWd1bGF0b3ItdXNkaGMyIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJy
ZWd1bGF0b3ItZml4ZWQiOw0KPiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiBpbmRleCBjY2U2NWI5
Li40MDE0MDI5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW4uZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4u
ZHRzaQ0KPiBAQCAtMTM5LDExICsxMzksNiBAQA0KPiAgCQl9Ow0KPiAgCX07DQo+ICANCj4gLQlt
ZW1vcnlANDAwMDAwMDAgew0KPiAtCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiAtCQlyZWcg
PSA8MHgwIDB4NDAwMDAwMDAgMCAweDgwMDAwMDAwPjsNCj4gLQl9Ow0KPiAtDQo+ICAJb3NjXzMy
azogY2xvY2stb3NjLTMyayB7DQo+ICAJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiAg
CQkjY2xvY2stY2VsbHMgPSA8MD47DQo=
