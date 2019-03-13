Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A944C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A6A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="WyxKDAx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCMST4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:19:56 -0400
Received: from mail-eopbgr1400098.outbound.protection.outlook.com ([40.107.140.98]:36543
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfCMST4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBz1VQONOmZwcoUJ+eHt8M+R0BilmN6PE1U6GYzH4Zo=;
 b=WyxKDAx4X/G4eohiSGoNTi9ExCs30BSvZZ0E3q4yk4Ar58EaN71aufI3dZ9Ar/Hbg7/e/1DifZJzmwg5xQX62zaC+jZEequXWnGD1R8Iu6yMGVeQ9FaSTOsK98zkELkGceGcOaA8BTYajP4SQiFh1L/DJITwnAwqOvwFCJGf+Y0=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1609.jpnprd01.prod.outlook.com (52.133.162.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 18:19:49 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::b593:2e3c:aa50:2273]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::b593:2e3c:aa50:2273%4]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 18:19:49 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Jiada Wang <jiada_wang@mentor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential
 deadlock
Thread-Topic: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential
 deadlock
Thread-Index: AQHU1K08bW0xPMRUEEGNOLI3VAcrUKYHvv8AgAG/FoCAAFh2kA==
Date:   Wed, 13 Mar 2019 18:19:49 +0000
Message-ID: <TY1PR01MB177056C725F16385A627111EC04A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <20190307061554.26486-1-jiada_wang@mentor.com>
 <20190307061554.26486-2-jiada_wang@mentor.com>
 <CAMuHMdU+1Ntz6uvk-VYsSdWJgBfzHu99SztqyfLX7z2FRxPdNg@mail.gmail.com>
 <8cd7f718-bfb2-15c8-823d-88458b385377@mentor.com>
In-Reply-To: <8cd7f718-bfb2-15c8-823d-88458b385377@mentor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d7289c-4eff-4600-d969-08d6a7e07b03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1609;
x-ms-traffictypediagnostic: TY1PR01MB1609:
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1609;20:cxj7JsHHFMvXIYveJithbW2gvUO09xzucQmFfRA9f3Ds9fUeS3FVKGNdGyw8E/XM7OdNEs/rvGHJ0SuC5+c4TmKQs71qPr/9CFAsU2zN10063dApcTyzlXMrOWryg23ev9cHXxoT/4N7OkvHsMhYh0b5wzzjfaTUt573yF5eipI/WncrIaE1QWnPBD4vLFQfhMUruJX9SVWk981/y7pR9dOg4l7ip/P0ef/XXC2M2ugd4ep3OlQZz1rL4tuVgRtW
x-microsoft-antispam-prvs: <TY1PR01MB16090F473A3EAA9704068535C04A0@TY1PR01MB1609.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(71200400001)(25786009)(74316002)(33656002)(44832011)(6116002)(81156014)(478600001)(229853002)(53546011)(52536013)(102836004)(93886005)(81166006)(6506007)(14454004)(8676002)(66066001)(71190400001)(68736007)(8936002)(7736002)(305945005)(86362001)(97736004)(55016002)(256004)(9686003)(99286004)(2906002)(14444005)(476003)(4326008)(105586002)(110136005)(54906003)(6246003)(106356001)(5660300002)(7696005)(316002)(76176011)(26005)(53936002)(486006)(186003)(6436002)(11346002)(446003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1609;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kqdpm6iAEaRkQbKnXup0F4A+GzVXCVffkYKm5vX5EOkQ8yfmognGnp3ueDVfF2klxHIqySht7CDQ7lcEGBII2nIUJUtxbrM0OZJZiO/ZtoFAClN9QprJMuGtio1WPffHJVb5W/rFEJnkwZGWr9LsVHmC3LKDGFiX4ODH0bYdcJnoOm59Xp4ntFYrnWeuyj5ZXOHr8hh35eA10UTzBnj6mAW2lWoJzs5vBH/6saUtuytNLc/dv30ic+0wlNQGYrureKkNX7DY+iRVkSHBBISNlfHUqQ0r6blyxlqAyamOnj4mLtOWWKdFZs/2IjWvf6cqfc+k4NlS1suvK7l7rpR/jFUGAwwEGhI4Dlp37og+OFQfyVlkSQs0M+zRR/4CrS8d3UCMGg4Xdq+WCSCU740HLpHVDnOeAK9yV7s2IhjITiA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d7289c-4eff-4600-d969-08d6a7e07b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 18:19:49.5985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSmlhZGEsDQoNCj4gRnJvbTogSmlhZGEgV2FuZyA8amlhZGFfd2FuZ0BtZW50b3IuY29t
Pg0KPiBTZW50OiAxMyBNYXJjaCAyMDE5IDExOjU2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbGlu
dXgtbmV4dCB2MiAxLzJdIEFTb0M6IHJzbmQ6IHNyYzogQXZvaWQgYSBwb3RlbnRpYWwgZGVhZGxv
Y2sNCj4gDQo+IEhpIEdlZXJ0DQo+IA0KPiBPbiAyMDE5LzAzLzEyIDE4OjE1LCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6DQo+ID4gSGkgSmlhZGEsIEZhYnJpemlvLA0KPiA+DQo+ID4gT24gVGh1
LCBNYXIgNywgMjAxOSBhdCA3OjE3IEFNIEppYWRhIFdhbmcgPGppYWRhX3dhbmdAbWVudG9yLmNv
bT4gd3JvdGU6DQo+ID4+IGxvY2tkZXAgd2FybnMgdXMgdGhhdCBwcml2LT5sb2NrIGFuZCBrLT5r
X2xvY2sgY2FuIGNhdXNlIGENCj4gPj4gZGVhZGxvY2sgd2hlbiBhZnRlciBhY3F1aXJlIG9mIGst
PmtfbG9jaywgcHJvY2VzcyBpcyBpbnRlcnJ1cHRlZA0KPiA+PiBieSBzcmMsIHdoaWxlIGluIGFu
b3RoZXIgcm91dGluZSBvZiBzcmMgLmluaXQsIGstPmtfbG9jayBpcw0KPiA+PiBhY3F1aXJlZCB3
aXRoIHByaXYtPmxvY2sgaGVsZC4NCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCBhdm9pZHMgYSBwb3Rl
bnRpYWwgZGVhZGxvY2sgYnkgbm90IGNhbGxpbmcgc29jX2RldmljZV9tYXRjaCgpDQo+ID4+IGlu
IFNSQyAuaW5pdCBjYWxsYmFjaywgaW5zdGVhZCBpdCBhZGRzIG5ldyBzb2MgZmllbGRzIGluIHBy
aXYtPmZsYWdzIHRvDQo+ID4+IGRpZmZlcmVudGlhdGUgU29Dcy4NCj4gPj4NCj4gPj4gRml4ZXM6
IGxpbnV4LW5leHQgY29tbWl0IDc2NzRiZWM0ZmMwOSAoIkFTb0M6IHJzbmQ6IHVwZGF0ZSBCU0RT
Ui9CU0RJU1IgaGFuZGxpbmciKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBKaWFkYSBXYW5nIDxqaWFk
YV93YW5nQG1lbnRvci5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIHNvdW5kL3NvYy9zaC9yY2FyL2Nv
cmUuYyB8IDIgKysNCj4gPj4gICBzb3VuZC9zb2Mvc2gvcmNhci9yc25kLmggfCA1ICsrKysrDQo+
ID4+ICAgc291bmQvc29jL3NoL3JjYXIvc3JjLmMgIHwgOSArLS0tLS0tLS0NCj4gPj4gICAzIGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4g
ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zaC9yY2FyL2NvcmUuYyBiL3NvdW5kL3NvYy9zaC9yY2Fy
L2NvcmUuYw0KPiA+PiBpbmRleCAwMjI5OTZkMmRiMTMuLjRmZTgzZTYxMWMwMSAxMDA2NDQNCj4g
Pj4gLS0tIGEvc291bmQvc29jL3NoL3JjYXIvY29yZS5jDQo+ID4+ICsrKyBiL3NvdW5kL3NvYy9z
aC9yY2FyL2NvcmUuYw0KPiA+PiBAQCAtMTEwLDYgKzExMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIHJzbmRfb2ZfbWF0Y2hbXSA9IHsNCj4gPj4gICAgICAgICAgeyAuY29t
cGF0aWJsZSA9ICJyZW5lc2FzLHJjYXJfc291bmQtZ2VuMSIsIC5kYXRhID0gKHZvaWQgKilSU05E
X0dFTjEgfSwNCj4gPj4gICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHJjYXJfc291
bmQtZ2VuMiIsIC5kYXRhID0gKHZvaWQgKilSU05EX0dFTjIgfSwNCj4gPj4gICAgICAgICAgeyAu
Y29tcGF0aWJsZSA9ICJyZW5lc2FzLHJjYXJfc291bmQtZ2VuMyIsIC5kYXRhID0gKHZvaWQgKilS
U05EX0dFTjMgfSwNCj4gPj4gKyAgICAgICAvKiBTcGVjaWFsIEhhbmRsaW5nICovDQo+ID4+ICsg
ICAgICAgeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHJjYXJfc291bmQtcjhhNzc5OTAiLCAuZGF0
YSA9ICh2b2lkICopKFJTTkRfR0VOMyB8IFJTTkRfU09DX0UpIH0sDQo+ID4NCj4gPiBJIGd1ZXNz
IHdlIG5lZWQgYW4gZW50cnkgZm9yIFJaL0cyRSwgdG9vPw0KDQpHZWVydCBoYXMgYSBwb2ludCwg
SSBhbSBsb29raW5nIGF0IHRoZSBVc2VyIG1hbnVhbCBmb3IgdGhlIFJaL0cyRSBhbmQgaXQgbG9v
a3MgbGlrZSB0aGUNCmltcGxlbWVudGF0aW9uIGZvciB0aGUgUlovRzJFIGlzIHRoZSBzYW1lIGFz
IHRoZSBvbmUgZm9yIHRoZSByOGE3Nzk5MA0KDQo+ID4NCj4gU29ycnksIEkgZG9uJ3QgaGF2ZSB1
c2VyIG1hbnVhbCBmb3IgUlovRzJFLA0KPiBpZiB5b3UgY2FuIGxldCBtZSBrbm93IHdoZXJlIHRv
IGZpbmQgUlovRzJFJ3MgdXNlciBtYW51YWwsDQo+IEkgY2FuIGFkZCBlbnRyeSBmb3IgdGhlc2Ug
U29Dcw0KDQpJZiB5b3UgcHJlZmVyIEkgY291bGQgYWRkIHRoYXQgYWZ0ZXIgcnVubmluZyBzb21l
IHRlc3RzPyBJIGRvIGhhdmUgYSBib2FyZCB3aXRoIGEgUlovRzJFLg0KDQpUaGFua3MsDQpGYWIN
Cg0KPiANCj4gVGhhbmtzLA0KPiBKaWFkYQ0KPiA+IEdye29ldGplLGVldGluZ31zLA0KPiA+DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+ID4NCg==
