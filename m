Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF1C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430D32184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N29pGl34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHSJwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:52:16 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:59398
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfHSJwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwwgMCDC53A9+0By5JlJvtuySR558TI3lzB23xmV5ra+YD80Z+AMRpTGqWyjyZb1Ogy1sySB8wm1U8VRmztp+bK8mW1jROPssr+JBT1E7fQ9P43G3qxQDZ8sm/BQm5BNuxESszbpfIO3Eqr0L057RgZDS+6k5falCCvp/eGvJsmqTowq/Ya1xAKOGgQa8Q9U/nSuDiKQnpLkw8el0l5lZnnmwJvIEHvfcCJKSfbK/8t9XoONsMEPikd3TQVGMgf1VlH9Um/kdkhyfddPQ7kkVdrO8YAkai21go3IcD8CIsTgzL/2xBiUcq5Z7+9tCMcYh75DBG+x9AjWA5bkbxTCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWvmYwrWi++yuYUh5x7JdjZtoqwY+HTCzM9NhhY299A=;
 b=Ur8aQE5GXBR2JaPDmbZA0TFA8IuKPCliJULO129zyBM3owZ1fr74R2tYq4iZuo0gJJd7np6gz7o+WnZNT99Xs1GKLLMXqRKsdTT2mgto8ighIhyVbrmPGiBpvhENuG+ugJaTknO5M5YNFGWfw0k9CXMO4wkl2KANK9WB19fEfwqaMxuPcFqCtIBRbrQtkiqFCr4PqywhFnN5Bza6f88px85Tkm2Pr6+nGRzrxL8G7Fm6ZXHHaH420Q1TBLWEO3qFIaNkp0CO3cgxuaEiEXXMtblYmB6Wm/bLpub0HunSumxPJ+No+LuuZQFlUJBWOfoHc6OcTwJwzYqNW4xwiMK2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWvmYwrWi++yuYUh5x7JdjZtoqwY+HTCzM9NhhY299A=;
 b=N29pGl34SEaUg+tMAqpBopUV9y+dEL9n+JXT0v4BEGCJ32gqCPs1IuXsb//kss4OueiBgE/Iwh7/Tmf3vI2yHmJMR2coHRDrfJkIf4nKlGqc0o2fXoxfCCKyp5XK2+3mB9L8+M0gDloV66ahAnxtFmy8LlIGazGGIN+yGKHB1xY=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB5162.eurprd04.prod.outlook.com (20.176.235.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 09:52:09 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 09:52:09 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v1 3/3] arm64: dts: ls1028a: Add properties node for
 Display output pixel clock
Thread-Topic: [EXT] Re: [v1 3/3] arm64: dts: ls1028a: Add properties node for
 Display output pixel clock
Thread-Index: AQHVUPZpmYJZqwqLE06H2mVgmUUN5acCP/uAgAAFdzA=
Date:   Mon, 19 Aug 2019 09:52:09 +0000
Message-ID: <DB7PR04MB51951491600141680A1146FDE2A80@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190812100224.34502-1-wen.he_1@nxp.com>
 <20190819093159.GJ5999@X250>
In-Reply-To: <20190819093159.GJ5999@X250>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e31e15e-3476-45d2-c39a-08d7248ae70f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5162;
x-ms-traffictypediagnostic: DB7PR04MB5162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB51628429D1B993E5514466AAE2A80@DB7PR04MB5162.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(13464003)(199004)(189003)(6246003)(52536014)(25786009)(76116006)(64756008)(66476007)(14454004)(478600001)(66446008)(66556008)(53936002)(4326008)(6116002)(3846002)(229853002)(2906002)(446003)(76176011)(7696005)(6916009)(102836004)(5660300002)(6506007)(53546011)(7736002)(4744005)(74316002)(55016002)(256004)(26005)(305945005)(33656002)(316002)(71190400001)(71200400001)(86362001)(66946007)(99286004)(186003)(81156014)(81166006)(8676002)(8936002)(54906003)(9686003)(66066001)(6436002)(476003)(11346002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5162;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XAXP7bn8rRvOYKVfHlxN4U5jDFn+JJcn5I+AF0pgMme83jYVEW6NBdFFGR3WM8NJ0s+gckH1R8zS7nPlY1rwnvy3/tMOwKJNV2iW5Mn858+snlfBbOGib7l6A4vazrto6TSjHfG4rfcWX24WyDGhAwUJH5exf5PTolNqyPK81wlN9BbLgob5FCzer5EbLCcc3nOslYy8D1MtTEVXPSDFUa2g9Kyv40RWWPeyKpwpfVYWq6+MSa7Hs82WynWNG0c16ioASd5FNx9ShN5yubg7SAiiFWj+s/h6spI0I879tMvaZ6Lkeg5WJzj/VHq+xl3jKZMzB2d2AvtSA/2llsW71iEy0ZJKPMigbosoLtoS2BjW/6lY2k91Snz/NQhbjlFioucowOd0AD0x9R4pVRPQTg3GYuakrlfdmrbJ6Z98j6E=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e31e15e-3476-45d2-c39a-08d7248ae70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 09:52:09.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaD5JtD2gpR2oqtJtOSbPC1VLCw3BUI5I2oBjjCLehNKJVtj/WgoQrhKgAAfFP5n2cpmt74b41SglGtVWUlNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOo41MIxOcjVIDE3OjMyDQo+IFRvOiBXZW4g
SGUgPHdlbi5oZV8xQG54cC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsgTWljaGFlbCBUdXJxdWV0dGUNCj4gPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPjsgU3Rl
cGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPjsgTWFyaw0KPiBSdXRsYW5kIDxtYXJrLnJ1dGxh
bmRAYXJtLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1jbGtAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxl
b3lhbmcubGlAbnhwLmNvbT47IGxpdml1LmR1ZGF1QGFybS5jb20NCj4gU3ViamVjdDogW0VYVF0g
UmU6IFt2MSAzLzNdIGFybTY0OiBkdHM6IGxzMTAyOGE6IEFkZCBwcm9wZXJ0aWVzIG5vZGUgZm9y
DQo+IERpc3BsYXkgb3V0cHV0IHBpeGVsIGNsb2NrDQo+IA0KPiANCj4gT24gTW9uLCBBdWcgMTIs
IDIwMTkgYXQgMDY6MDI6MjRQTSArMDgwMCwgV2VuIEhlIHdyb3RlOg0KPiA+IFRoZSBMUzEwMjhB
IGhhcyBhIGNsb2NrIGRvbWFpbiBQWExDTEswIHVzZWQgZm9yIHRoZSBEaXNwbGF5IG91dHB1dA0K
PiA+IGludGVyZmFjZSBpbiB0aGUgZGlzcGxheSBjb3JlLCBpbmRlcGVuZGVudCBvZiB0aGUgc3lz
dGVtIGJ1cw0KPiA+IGZyZXF1ZW5jeSwgZm9yIGZsZXhpYmxlIGNsb2NrIGRlc2lnbi4gVGhpcyBk
aXNwbGF5IGNvcmUgaGFzIGl0cyBvd24gcGl4ZWwgY2xvY2suDQo+ID4NCj4gPiBUaGlzIHBhdGNo
IGVuYWJsZSB0aGUgcGl4ZWwgY2xvY2sgcHJvdmlkZXIgb24gdGhlIExTMTAyOEEuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+DQo+IA0KPiBBcHBsaWVk
LCB0aGFua3MuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldywgU2hhd24uDQoNCkJlc3QgUmVn
YXJkcywNCldlbg0K
