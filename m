Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6242173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LLOZ2PZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCMILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:11:32 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:18368
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfCMILc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXvNCEDkyigH3KReL85x3OinMBgqruEZu/GxCI2F3jg=;
 b=LLOZ2PZAGPMn5o8Z9m5VgnJ1TXPGZZdn9ZL+YscVQON6xf8ietmP9IXGliD7bb6jFCb7mKia0DuW7yUF3kvtv2bub/0FuggrwePmX8f9hyLVsQziUh5Rh6xntdo92FPiJPLXHmjfKPCRpDq4MZ7bwkYeQ3Mn8q82bUgzxZwY7tw=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3734.eurprd04.prod.outlook.com (52.133.29.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 13 Mar 2019 08:11:22 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 08:11:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
 binding
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tKXsQYyAgAFkewCAAKW9YIAABU2AgAGCOQCAAtQPAIAMH4YAgAqS4CA=
Date:   Wed, 13 Mar 2019 08:11:22 +0000
Message-ID: <AM6PR0402MB3911BA1CDA911F94071BE320F54A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
 <DB3PR0402MB391698A30FC58BA8BFAC20B3F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391698A30FC58BA8BFAC20B3F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26ab634e-29c1-48cc-95a3-08d6a78b7b12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3734;
x-ms-traffictypediagnostic: AM6PR0402MB3734:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0MDJNQjM3MzQ7MjM6aWVxOGN0SkhLRUx4NDlWWmYxWTYzZ1Ax?=
 =?utf-8?B?bW45blM5NTFIMVE3OUEzb3RveWpPUkIyMDJ1TEoxbWxHcUZ6ZHpFaVpEdXZ0?=
 =?utf-8?B?NmQzOGx5RkNjeUpCQWxQVzFDL1FBZzFXRGNtV0xyaE1nVXBIV0JsdTYwbkZS?=
 =?utf-8?B?WkN1ZGliR0tXdzFBOTFGUlEwblVnL0dWOWhxK3BFRjdzT2NQYmJHbkQ1VWg4?=
 =?utf-8?B?cTFkYjU3RUNNeFhPbXorcUVlNWI3akc0Yi8wRmxXUVU5QlR4MlBhM1JpN21H?=
 =?utf-8?B?ZE9hUWc4dWh6U3BUYWxGNTlVK2RtME1xbDFGb0NyL2lwY1JqbUUyNVZPZ0w2?=
 =?utf-8?B?aUU5TnVQdkwrSkVNYlZPVUZsZ0ROaXF2Nm1FdlYxQkh4ZGV1am90TlNFSEZ1?=
 =?utf-8?B?VmZjZ3hNcWpjcnRYb3U5VDd3TXZNVUE1K2pVVlV5RC9EdE1aZ1VsRzA3eXow?=
 =?utf-8?B?QTczRmRBQ1owUXE5TXNzQ20rcmFpTVoyZU1oSE9yL1czK3pPSVpZQURpN1E1?=
 =?utf-8?B?citBNWFsYXpnMFFib2FQcS9FdkNjbGJJY1draG55Wi9MOWhQM2UrMXFieWNY?=
 =?utf-8?B?UithVVlOOTBGODE2RjFGY002Tm01T1BnMGpXRGs2Zmo0K2pab3pKUWVYWVBX?=
 =?utf-8?B?YTAwU21IeDFwY0M3RkdOaVJpTXI5VXdEYlBhOGZRL01oUTdpNGFzWU1uYVFY?=
 =?utf-8?B?Qk9MWVNuYWNiL2dPNUtEN0ZDRHYrbGxnSG10Wmp4VzcrSm53VElLM2R1Qjk2?=
 =?utf-8?B?Z0tWcG8yeWkybnpSakpuODNlQVVvQzdTS3RtQlFPM2dUeUVDbFd4aEQxV21S?=
 =?utf-8?B?NkhzSWtFNXorSW8zZ3dUUGNkZ29JYThwSitkeVZkY1hHaUN4RENjTjhNZXRY?=
 =?utf-8?B?OHJrdCtIME8rZ1RDTHk0c1l5ZHFVcG1Eb01jSlJzaG5XT0l0eEMyMkFuRnJI?=
 =?utf-8?B?VDVqc3lNdWliRW4vdjBKcmVxejdaM0QyZnlUZHVLOWc3OVFOSm16SkRvOTdM?=
 =?utf-8?B?akM5T1gwTnFhaTdWUWZtbHErYTlmUFVoelZjY0F2N2UzdENWOTFZMGVYQnlY?=
 =?utf-8?B?NUlXNEZIWi9IMVFYL00rNHIxNHgvbE1udzdUVjI3c0MwU3lFN3EvdXZTT1Iy?=
 =?utf-8?B?QkJwN1pibnB3M0hDWDA0dEkrMmkyRXl1Y09GVlBiSUZ4bjdncFowV2VYWDUx?=
 =?utf-8?B?TzN3NUVIV1dsVzNvdTJlRzFTeHZvRFFkRmN5Z3YvUTkwcUZmLzlFTVFTbTdH?=
 =?utf-8?B?aGtKaUI0N2c4OTUraUVLeGJWQjl6ZWhCOUxDMGpUVHpaV0ZNaEhTalFFR2Zj?=
 =?utf-8?B?MEJKd3ZpNVhVcDRVSWtNeUd5MzlySjZmc3huVWNXYUU0WUZaeFI1Y1lkYWtr?=
 =?utf-8?B?MXNRT2o3d2d0NlFDaS9EOEVJSWZ0bHBWQjBXU1dhdUcrU0hLbXpTRFlrOHJy?=
 =?utf-8?B?bW44UmVuMERabjhkYzlkb1N2V2xaV0U1bTdxLzVjZG5yNnlzd3dCVitlQ0FG?=
 =?utf-8?B?L2ZZblJoaElPcTV2YVNuRFZSRHYxOFQ5L3lZbWZEMnFjRkF3ZCtXVmRFKzdq?=
 =?utf-8?B?ZFlMdHY1TzNCcTJxZkd3dGt6SlgyY2oyZ1laRktFQ1N4bFNabDd4eElYbEpt?=
 =?utf-8?B?UmliU0kwcithRmV5a09NVHFOOHNOSW9XTzd0Z0xtdGlNTlltTkZBMWdCTFQx?=
 =?utf-8?B?OUx3RUVXdHdXZVNnNXJ4UkdlOTdTbk5DUGdNbFdCai9yYzE2OWZ1TGdmVmxM?=
 =?utf-8?B?RUhuY1ExZDdEY0RnZGxpMmszTVBjb3BGZDZYRXNrZTU3Mm92ZWFSTU4xZlB4?=
 =?utf-8?B?Rm55MHB4RUdaZHp4MWNKYnhuQUhCL1BvQldqNGQ3MW9PNzFPUT09?=
x-microsoft-antispam-prvs: <AM6PR0402MB3734FEE8257FF9B4CFAFB01BF54A0@AM6PR0402MB3734.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(13464003)(305945005)(71200400001)(7736002)(7696005)(6246003)(71190400001)(44832011)(186003)(8676002)(53936002)(9686003)(55016002)(6436002)(54906003)(11346002)(81166006)(74316002)(229853002)(76176011)(14454004)(478600001)(81156014)(33656002)(66066001)(8936002)(6916009)(4326008)(316002)(68736007)(86362001)(5660300002)(6116002)(106356001)(105586002)(3846002)(256004)(14444005)(99286004)(6506007)(446003)(52536013)(97736004)(53546011)(476003)(25786009)(486006)(7416002)(102836004)(2906002)(26005)(93886005)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3734;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KA4Dws6x3/MTNJIPowzcsMFMatk9fnbNPa0jldj1d9v7rDuuApRBeZ7Sh9zfyIwq9jG0RoxWS3QmAuTjAWnfmA+UHVf5nWyKt0mXUCzZ2h/xzFE/3h7SwziqZIPchGgXsJQg0YQXZsMzQClzBv/PSoGEDJJbsHTZTCLhSvaQpTwMEhERFAvOUehqGa+g6g1Wb65wc0HvMMiiOv2VFAVjLH00x87AaEKXNfqCxjf7QX+NKShtFPk5c1VwV41qbBwEAaNy7fVLtL4Zsx+8bFs863UyVKAhZSi7j4EwwbZk9+LX1Qq+6g+ykk2azuzXXkQ/+eUdtv+sFkNJHBXAN1eACk5rNHDbKhccxfAP+MYbvFc5sXrSLtIwqKk0W1PCO7mzTKLaaEzEZS2WSZ6I5N3eS0S4blLaUFhyir2MqTFNMG4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ab634e-29c1-48cc-95a3-08d6a78b7b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 08:11:22.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KCURvIHlvdSBoYXZlIGFueSBmZWVkYmFjayBhYm91dCBhZGRpbmcgaW14IHNjdSB3
YXRjaGRvZyBub2RlIGluIGR0cz8gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFu
Zw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nDQo+
IFNlbnQ6IDIwMTnlubQz5pyINuaXpSAyMjo0NQ0KPiBUbzogJ1JvYiBIZXJyaW5nJyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBDYzogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PjsgbWFy
ay5ydXRsYW5kQGFybS5jb207DQo+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGhlaWtvQHNudGVj
aC5kZTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFybS5jb207IGJq
b3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGphZ2FuQGFt
YXJ1bGFzb2x1dGlvbnMuY29tOyBBbmR5IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBk
bC0NCj4gbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOyBhcm5kQGFybmRiLmRl
OyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZW5y
aWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7
IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFA
bnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQWlzaGVuZw0K
PiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgb2xvZkBsaXhvbS5uZXQ7IHNoYXduZ3VvQGtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBSRVNFTkQgVjIgMS80XSBkdC1iaW5kaW5n
czogZnNsOiBzY3U6IGFkZCB3YXRjaGRvZw0KPiBiaW5kaW5nDQo+IA0KPiBIaSwgUm9iDQo+IAlT
b3JyeSB0byBicmluZyBiYWNrIHRoaXMgdG9waWMgYWdhaW4gYWJvdXQgd2hldGhlciB0byBwdXQg
ImlteC1zYy0NCj4gd2R0IiBub2RlIGluc2lkZSBEVCdzIFNDVSBub2RlLCBhZnRlciBzb21lIGRp
c2N1c3Npb24gd2l0aCBteSB0ZWFtLCB0aGVyZQ0KPiBpcyBjYXNlIG9mIHZpcnR1YWxpemF0aW9u
LCBkaXNhYmxpbmcgImlteC1zYy13ZHQiIGZvciBMaW51eCBPUywgd2hpbGUgZW5hYmxlIGl0DQo+
IGZvciBBbmRyb2lkIE9TIHJ1bm5pbmcgdG9nZXRoZXIgb24gc2FtZSBTb0MsIHRoZW4gTGludXgg
bmVlZHMgdG8gZGlzYWJsZQ0KPiB3YXRjaGRvZyBmcm9tIGl0cyBEVEIgd2hpbGUgQW5kcm9pZCBj
YW4gZW5hYmxlIGl0LiBGb3Igc3VjaCBraW5kIG9mIHNjZW5hcmlvLA0KPiBkbyB5b3UgdGhpbmsg
aXQgaXMgcmVhc29uYWJsZSB0byBoYXZlICJpbXgtc2Mtd2R0IiBub2RlIGluc2lkZSBTQ1Ugbm9k
ZSBpbg0KPiBEVD8gV2UgZG8gTk9UIGhhdmUgZ29vZCBpZGVhIGZvciB0aGlzIHNjZW5hcmlvIGlm
IGlteC1zYy13ZHQgaXMgYWRkZWQgYXMNCj4gYnVpbHQtaW4gcGxhdGZvcm0gZGV2aWNlIGluc2lk
ZSBTQ1UgZHJpdmVyLg0KPiANCj4gQmVzdCBSZWdhcmRzIQ0KPiBBbnNvbiBIdWFuZw0KPiANCj4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFJvYiBIZXJyaW5nIFttYWls
dG86cm9iaEBrZXJuZWwub3JnXQ0KPiA+IFNlbnQ6IDIwMTnlubQy5pyIMjfml6UgNTozNA0KPiA+
IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiBDYzogR3VlbnRlciBS
b2VjayA8bGludXhAcm9lY2stdXMubmV0PjsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4gdWxm
LmhhbnNzb25AbGluYXJvLm9yZzsgaGVpa29Ac250ZWNoLmRlOyBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsNCj4gPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9y
ZzsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBB
bmR5IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBkbC0NCj4gPiBsaW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+
IHdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgYXJuZEBhcm5kYi5kZTsgbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZW5yaWMuYmFsbGV0Ym9AY29s
bGFib3JhLmNvbTsNCj4gPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgd2ltQGxpbnV4LXdh
dGNoZG9nLm9yZzsgRGFuaWVsIEJhbHV0YQ0KPiA+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IEFpc2hlbmcNCj4gPiBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4g
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBvbG9mQGxpeG9tLm5ldDsgc2hhd25ndW9Aa2VybmVsLm9y
Zw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFYyIDEvNF0gZHQtYmluZGluZ3M6IGZz
bDogc2N1OiBhZGQgd2F0Y2hkb2cNCj4gPiBiaW5kaW5nDQo+ID4NCj4gPiBPbiBTdW4sIEZlYiAy
NCwgMjAxOSBhdCA4OjI2IFBNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEhpLCBHdWVudGVyDQo+ID4gPg0KPiA+ID4gQmVzdCBSZWdh
cmRzIQ0KPiA+ID4gQW5zb24gSHVhbmcNCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEd1ZW50ZXIgUm9lY2sgW21haWx0bzpncm9lY2s3QGdt
YWlsLmNvbV0gT24gQmVoYWxmIE9mDQo+ID4gPiA+IEd1ZW50ZXIgUm9lY2sNCj4gPiA+ID4gU2Vu
dDogMjAxOeW5tDLmnIgyNOaXpSAxMToyMA0KPiA+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29u
Lmh1YW5nQG54cC5jb20+OyBSb2IgSGVycmluZw0KPiA+IDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4g
PiA+IENjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiA+
ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0
ZXZhbUBnbWFpbC5jb207DQo+ID4gPiA+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRl
YWNvbkBhcm0uY29tOw0KPiA+ID4gPiB3aW1AbGludXgtd2F0Y2hkb2cub3JnOyBBaXNoZW5nIERv
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gPiA+ID4gdWxmLmhhbnNzb25AbGluYXJvLm9y
ZzsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsNCj4gPiA+ID4gQW5keSBH
cm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsNCj4gPiA+ID4gaG9ybXMrcmVuZXNhc0B2ZXJn
ZS5uZXQuYXU7IGhlaWtvQHNudGVjaC5kZTsgYXJuZEBhcm5kYi5kZTsNCj4gPiA+ID4gYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiA+ID4g
PiBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsN
Cj4gPiA+ID4gb2xvZkBsaXhvbS5uZXQ7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+ID4gPiA+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFYyIDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQN
Cj4gPiA+ID4gd2F0Y2hkb2cgYmluZGluZw0KPiA+ID4gPg0KPiA+ID4gPiBPbiAyLzIzLzE5IDc6
MDQgUE0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+ID4gPiA+IEhpLCBHdWVudGVyL1JvYg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gQmVzdCBSZWdhcmRzIQ0KPiA+ID4gPiA+IEFuc29uIEh1YW5nDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4g
Pj4gRnJvbTogR3VlbnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhh
bGYgT2YNCj4gPiA+ID4gPj4gR3VlbnRlciBSb2Vjaw0KPiA+ID4gPiA+PiBTZW50OiAyMDE55bm0
MuaciDI05pelIDE6MDgNCj4gPiA+ID4gPj4gVG86IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBBbnNvbiBIdWFuZw0KPiA+ID4gPiA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4g
Pj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+ID4g
PiA+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4g
PiA+ID4+IGZlc3RldmFtQGdtYWlsLmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+ID4g
d2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gPiA+ID4gPj4gd2ltQGxpbnV4LQ0KPiA+ID4gPiB3YXRj
aGRvZy5vcmc7DQo+ID4gPiA+ID4+IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+
OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiA+ID4gPiA+PiBEYW5pZWwgQmFsdXRhIDxkYW5p
ZWwuYmFsdXRhQG54cC5jb20+OyBBbmR5IEdyb3NzDQo+ID4gPiA+ID4+IDxhbmR5Lmdyb3NzQGxp
bmFyby5vcmc+Ow0KPiA+ID4gPiA+PiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgaGVpa29A
c250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOw0KPiA+ID4gPiA+PiBiam9ybi5hbmRlcnNzb25AbGlu
YXJvLm9yZzsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+ID4gPiA+ID4+IGVucmljLmJh
bGxldGJvQGNvbGxhYm9yYS5jb207IG1hcmMudy5nb256YWxlekBmcmVlLmZyOw0KPiA+ID4gPiA+
PiBvbG9mQGxpeG9tLm5ldDsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+ID4+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4gPiA+ID4gPj4ga2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsN
Cj4gPiA+ID4gPj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+ID4gPj4g
U3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgVjIgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6
IGFkZA0KPiA+ID4gPiA+PiB3YXRjaGRvZyBiaW5kaW5nDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+
IE9uIDIvMjIvMTkgMTE6NTIgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4gPiA+Pj4gT24g
TW9uLCBGZWIgMTgsIDIwMTkgYXQgMDY6NTM6NDhBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6
DQo+ID4gPiA+ID4+Pj4gQWRkIGkuTVg4UVhQIHN5c3RlbSBjb250cm9sbGVyIHdhdGNoZG9nIGJp
bmRpbmcuDQo+ID4gPiA+ID4+Pj4NCj4gPiA+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gPj4+PiAtLS0NCj4gPiA+ID4gPj4+
PiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiA+ID4gPiA+Pj4+ICAtIHVwZGF0ZSBkdHMgbm9kZSBuYW1l
IHRvICJ3YXRjaGRvZyI7DQo+ID4gPiA+ID4+Pj4gLS0tDQo+ID4gPiA+ID4+Pj4NCj4gPiA+ID4g
Pj4+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dA0KPiA+ID4gPiA+Pj4+IHwgMTANCj4gPiA+ID4gPj4gKysrKysrKysrKw0KPiA+ID4g
PiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4+Pj4N
Cj4gPiA+ID4gPj4+PiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4+Pj4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+ID4gPiA+Pj4+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNj
dS50eHQNCj4gPiA+ID4gPj4+PiBpbmRleCA0Yjc5NzUxLi5mMzg4ZWM2IDEwMDY0NA0KPiA+ID4g
PiA+Pj4+IC0tLQ0KPiA+ID4gPiA+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiA+ID4gPj4+PiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1DQo+ID4gPiA+
ID4+Pj4gKysrIC50DQo+ID4gPiA+ID4+Pj4gKysrIHh0DQo+ID4gPiA+ID4+Pj4gQEAgLTEzNiw2
ICsxMzYsMTIgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ID4gPj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVzb3VyY2UgaWQgZm9yIHRoZXJtYWwgZHJpdmVyIHRvDQo+ID4g
PiA+ID4+Pj4gZ2V0IHRlbXBlcmF0dXJlDQo+ID4gPiA+ID4+IHZpYQ0KPiA+ID4gPiA+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBTQ1UgSVBDLg0KPiA+ID4gPiA+Pj4+DQo+ID4gPiA+
ID4+Pj4gK1dhdGNoZG9nIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+
ID4gPiA+ID4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+Pj4+ICsNCj4gPiA+ID4gPj4+PiArUmVxdWlyZWQg
cHJvcGVydGllczoNCj4gPiA+ID4gPj4+PiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImZzbCxp
bXg4cXhwLXNjLXdkdCI7DQo+ID4gPiA+ID4+Pj4gKw0KPiA+ID4gPiA+Pj4+ICAgIEV4YW1wbGUg
KGlteDhxeHApOg0KPiA+ID4gPiA+Pj4+ICAgIC0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPj4+PiAg
ICBsc2lvX211MTogbWFpbGJveEA1ZDFjMDAwMCB7IEBAIC0xODgsNiArMTk0LDEwIEBADQo+IGZp
cm13YXJlDQo+ID4gew0KPiA+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB0c2Vu
cy1udW0gPSA8MT47DQo+ID4gPiA+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICN0aGVy
bWFsLXNlbnNvci1jZWxscyA9IDwxPjsNCj4gPiA+ID4gPj4+PiAgICAgICAgICAgICAgICAgIH07
DQo+ID4gPiA+ID4+Pj4gKw0KPiA+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgd2F0Y2hkb2c6
IHdhdGNoZG9nIHsNCj4gPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJmc2wsaW14OHF4cC1zYy13ZHQiOw0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+IEFz
LWlzLCB0aGVyZSdzIG5vIHJlYXNvbiBmb3IgdGhpcyB0byBiZSBpbiBEVC4gVGhlIHBhcmVudA0K
PiA+ID4gPiA+Pj4gbm9kZSdzIGRyaXZlciBjYW4gaW5zdGFudGlhdGUgdGhlIHdkb2cuDQo+ID4g
PiA+ID4+Pg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBBcyB0aGUgZHJpdmVyIGlzIGN1cnJlbnRs
eSB3cml0dGVuLCB5b3UgYXJlIGNvcnJlY3QsIHNpbmNlIGl0DQo+ID4gPiA+ID4+IGRvZXNuJ3Qg
YWNjZXB0IHdhdGNoZG9nIHRpbWVvdXQgY29uZmlndXJhdGlvbiB0aHJvdWdoIGRldmljZXRyZWUu
DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IFF1ZXN0aW9uIGlzIGlmIHRoYXQgaXMgaW50ZW5kZWQu
IElzIGl0ID8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgYW0gYSBsaXR0bGUgY29uZnVzZWQsIGRv
IHlvdSBtZWFuIHdlIG5vIG5lZWQgdG8gaGF2ZSAid2F0Y2hkb2ciDQo+ID4gPiA+ID4gbm9kZQ0K
PiA+ID4gPiBpbiBzaWRlICJzY3UiDQo+ID4gPiA+ID4gbm9kZT8gT3Igd2UgbmVlZCB0byBtb2Rp
ZnkgdGhlIHdhdGNoZG9nIG5vZGUncyBjb21wYXRpYmxlIHN0cmluZw0KPiB0byAiDQo+ID4gPiA+
ID4gZnNsLGlteC1zYy13ZHQiIHRvIG1ha2UgaXQgbW9yZSBnZW5lcmljIGZvciBvdGhlciBwbGF0
Zm9ybXM/IElmDQo+ID4gPiA+ID4geWVzLCBJIGNhbg0KPiA+ID4gPiByZXNlbmQgdGhlIHBhdGNo
IHNlcmllcyB0byBtb2RpZnkgaXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGlu
ayBSb2Igc3VnZ2VzdGVkIHRoYXQgdGhlIFNDVSBwYXJlbnQgZHJpdmVyIHNob3VsZA0KPiA+ID4g
PiBpbnN0YW50aWF0ZSB0aGUgd2F0Y2hkb2cgd2l0aG91dCBleHBsaWNpdCB3YXRjaGRvZyBub2Rl
LiBUaGF0DQo+ID4gPiA+IHdvdWxkIGJlIHBvc3NpYmxlLCBidXQgaXQgY3VycmVudGx5IHVzZXMN
Cj4gPiA+ID4gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgpIHRvIGRvIHRoZSBpbnN0YW50aWF0
aW9uLCBhbmQgY2hhbmdpbmcNCj4gPiA+ID4gdGhhdCB3b3VsZCBiZSBhIG1lc3MuIEJlc2lkZXMs
IGl0IGRvZXMgc2VtIHRvIG1lIHRoYXQgeW91cg0KPiA+ID4gPiBzdWdnZXN0ZWQgbm9kZSB3b3Vs
ZCBkZXNjcmliZSB0aGUgaGFyZHdhcmUsIHNvIEkgYW0gbm90IHN1cmUgSQ0KPiA+ID4gPiB1bmRl
cnN0YW5kIHRoZQ0KPiA+IHJlYXNvbmluZy4NCj4gPg0KPiA+IEl0IHdvdWxkIGp1c3QgYmUgYSBj
YWxsIHRvIGNyZWF0ZSBhIHBsYXRmb3JtIGRldmljZSBpbnN0ZWFkLiBIb3cgaXMgdGhhdCBhDQo+
IG1lc3M/DQo+ID4NCj4gPiBJdCdzIGRlc2NyaWJpbmcgZmlybXdhcmUuIFdlIGhhdmUgRFQgZm9y
IGRlc2NyaWJpbmcgaC93IHdlJ3ZlIGZhaWxlZA0KPiA+IHRvIG1ha2UgZGlzY292ZXJhYmxlLiBX
ZSBzaG91bGQgbm90IHJlcGVhdCB0aGF0IGFuZCBqdXN0IGRlc2NyaWJlDQo+IGZpcm13YXJlIGlu
IERULg0KPiA+IE1ha2UgdGhlIGZpcm13YXJlIGRpc2NvdmVyYWJsZSEgVGhvdWdoIHRoZXJlIGFy
ZSBjYXNlcyBsaWtlIGZpcm13YXJlDQo+ID4gcHJvdmlkZWQgY2xvY2tzIHdoZXJlIHdlIHN0aWxs
IG5lZWQgc29tZXRoaW5nIGluIERULCBidXQgdGhpcyBpcyBub3QNCj4gPiBvbmUgb2YgdGhlbS4N
Cj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBGb3IgbXkgcGFydCBJIHJlZmVycmVkIHRvDQo+ID4gPiA+
ICAgICAgIHdhdGNoZG9nX2luaXRfdGltZW91dChpbXhfc2Nfd2RkLCBERUZBVUxUX1RJTUVPVVQs
ICZwZGV2LQ0KPiA+ID4gPiA+ZGV2KTsgaW4gdGhlIGRyaXZlciwgd2hpY2ggZ3VhcmFudGVlcyB0
aGF0IHRoZSB0aW1lb3V0IHByb3BlcnR5DQo+ID4gPiA+ID53aWxsIG5vdCBiZQ0KPiA+ID4gPiB1
c2VkIHRvIHNldCB0aGUgdGltZW91dC4gQSBtb3JlIGNvbW1vbiBpbXBsZW1lbnRhdGlvbiB3b3Vs
ZCBoYXZlDQo+ID4gPiA+IGJlZW4NCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgaW14X3NjX3dkZC0+
dGltZW91dCA9IERFRkFVTFRfVElNRU9VVDsNCj4gPiA+ID4gICAgICAgcmV0ID0gd2F0Y2hkb2df
aW5pdF90aW1lb3V0KGlteF9zY193ZGQsIHRpbWVvdXQsDQo+ID4gPiA+ICZwZGV2LT5kZXYpOw0K
PiA+ID4gPg0KPiA+ID4gPiB3aGVyZSAndGltZW91dCcgaXMgdGhlIG1vZHVsZSBwYXJhbWV0ZXIu
IFdoaWNoIGlzIGFjdHVhbGx5IG5vdA0KPiA+ID4gPiB1c2VkIGluIHlvdXIgZHJpdmVyLg0KPiA+
ID4gPiBIbW0gLi4uIEkgd2Fzbid0IGNhcmVmdWwgZW5vdWdoIHdpdGggbXkgcmV2aWV3LiBUaGUg
dGltZW91dA0KPiA+ID4gPiBpbml0aWFsaXphdGlvbiBhcy0gaXMgZG9lc24ndCBtYWtlIHNlbnNl
LiBJJ2xsIGNvbW1lbnQgb24gdGhhdCBpbiB0aGUgcGF0Y2guDQo+ID4gPg0KPiA+ID4gSSB1bmRl
cnN0YW5kIG5vdywgaW4gb3VyIGNhc2VzLCBJIHdvdWxkIHN0aWxsIHByZWZlciB0byBoYXZlDQo+
ID4gPiB3YXRjaGRvZyBub2RlIHVuZGVyIHRoZSBTQ1UgcGFyZW50IG5vZGUsIHNpbmNlIHRoZXJl
IGNvdWxkIGJlIG90aGVyDQo+ID4gPiBwcm9wZXJ0eSBzZXR0aW5nIGRpZmZlcmVuY2UgYmV0d2Vl
biBkaWZmZXJlbnQgaS5NWCBwbGF0Zm9ybXMgd2l0aA0KPiA+ID4gc3lzdGVtIGNvbnRyb2xsZXIg
d2F0Y2hkb2cgaW5zaWRlLCB1c2luZyB0aGUgU0NVIG5vZGUgdG8gaW5zdGFudGlhdGUNCj4gPiA+
IG1ha2VzIHVzIGEgbGl0dGxlIGNvbmZ1c2VkIGFib3V0IHRoZSB3YXRjaGRvZywgc28gaWYgaXQg
aXMgTk9UIHRoYXQNCj4gPiA+IGNyaXRpY2FsLCBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHdhdGNo
ZG9nIG5vZGUuIEJ1dCB0byBtYWtlIHRoZQ0KPiA+ID4gd2F0Y2hkb2cgZHJpdmVyIG1vcmUgZ2Vu
ZXJpYyBmb3Igb3RoZXIgaS5NWCBwbGF0Zm9ybXMsIEkgY2hhbmdlZCB0aGUNCj4gPiA+IGNvbXBh
dGlibGUgc3RyaW5nIHRvDQo+ID4gImZzbCxpbXgtc2Mtd2R0IiBpbiBkcml2ZXIsIGFuZCBlYWNo
IFNvQyBzaG91bGQgaGFzIGl0IGFzIGZhbGxiYWNrIGlmDQo+ID4gaXQgY2FuIHJldXNlIHRoaXMg
d2F0Y2hkb2cgZHJpdmVyLg0KPiA+DQo+ID4gWW91IGhhbmRsZSBkaWZmZXJlbmNlcyBiZXR3ZWVu
IFNvQ3MgYnkgaGF2aW5nIHNwZWNpZmljIGNvbXBhdGlibGVzLiBTbw0KPiA+ICJmc2wsaW14LXNj
LXdkdCIgbW92ZXMgaW4gdGhlIHdyb25nIGRpcmVjdGlvbiBhc3N1bWluZyB3ZSBoYXZlIGEgbm9k
ZQ0KPiA+IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gPg0KPiA+IFJvYg0K
