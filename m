Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B577C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E27206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EpOuSUFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfCFOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:45:26 -0500
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:15344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbfCFOp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4KfQtHXulwRj6zE3tm4FrZ988YcQvO4eRvbSiSCjqY=;
 b=EpOuSUFLCVIJc7YwO74MHowvZYvlNyA3nUTLyCfELkG1hQTXOWOGLNUS2T+ur2nkFwFH0QDx9YV2xQc7Ewj2Ush7A7Eb59HcLA748RyPpi/M91dEkpELxU2bcIIpGwTY961TzQa+WKUswR6sNVPjnLUtsCtaPwQ34r8Ua4mxQo8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Wed, 6 Mar 2019 14:45:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 14:45:03 +0000
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
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tKXsQYyAgAFkewCAAKW9YIAABU2AgAGCOQCAAtQPAIAMH4YA
Date:   Wed, 6 Mar 2019 14:45:03 +0000
Message-ID: <DB3PR0402MB391698A30FC58BA8BFAC20B3F5730@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
In-Reply-To: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b88995c-4310-46b8-685f-08d6a2425173
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3ODU7MjM6Ry9LOFBzS2UvZDQvVmhqRmVYdGhhc1or?=
 =?utf-8?B?MzN6czRURVppNTlscm1lTERCMzVCcDBRWHhlRXNOMzk1U1NmZ3VSUmxMYzRk?=
 =?utf-8?B?aVVmUVM0QUxuOFZ0L1pwcG1zYytCZFhSU1BQZVZrVlU2M3J0UGVzU01uRWxD?=
 =?utf-8?B?RlJMU2NGai9pRnNyekROaU9rSDdSMnhxNTJ4b1Jyck1nR1RuanRNZFp0WUQv?=
 =?utf-8?B?ZTdmVUtCb2pnM2ZIelFnRUxEYVRiTlNNWUc2RjFIakpKaGZvd1gzS0djWmFX?=
 =?utf-8?B?bEk1NWxuZHJyVW1QQ3ZlcG45TVRtRXJFSzVwQWhUVDhkVTB4TXFIajFoamVF?=
 =?utf-8?B?L0FJWFVLL2FtVzdLUkU3T2hkNlZTRUg0bm5sOENnOWZqcXlHWDU0SG5IV0hr?=
 =?utf-8?B?UnNBV1pndnladnZEM1p0SWtieVBTOHJUS0t3VnZ4REVBMkRHMjdiRkpiandk?=
 =?utf-8?B?bVRSYWp6MzhoQ0s5aXFIVW9TZlVLSktxS3V6OEdVcjBUOWdhcnk2Yld3YVoz?=
 =?utf-8?B?MXdRSGlmckdueXZxd2lIeHYzMnZuMEhiVkpYUGViVUFqQy9JZERybjhoY01P?=
 =?utf-8?B?dy8vbTZmbmFyRXN3ay9zUUJxd2RnTWVES1dmS3JOcEdlY1htVmQrUFdycXZr?=
 =?utf-8?B?cnBYb3VzQnJHaG5SRTBwNnJGRGxJcVRqT2QxSHVXbkVhMGw3dEtULzQ1bDIv?=
 =?utf-8?B?a0tsWWpWMFZHc21vZnNlZUxKSGcxZGwra0xDaTRXWGtPdHNtMW5tT0g0a00z?=
 =?utf-8?B?L2k4bms5b0EyaUV4SE9xSHpDcno5V3lkc2l3OUk0NGJFRGNRVngxbUF1MkM1?=
 =?utf-8?B?TGFPQncySUcvaTltb2g5NDF1Qm1zd1d0NVIra09WeGVZUVhmeCtpdEdyUit3?=
 =?utf-8?B?SU1POGFZdDc1bHMvcVk4RGhuWjhEblJ3ZmZoclBFVUdqNjQ2RG9vQ2loKzJN?=
 =?utf-8?B?d2wxejA3UGhGc3NZZ25sMU14NDJIbTZ4dkpQRCsrQW9nQ1hoY0VORXBhYmFE?=
 =?utf-8?B?UldsSmN6dHFnTjZQbWFTRUVzWkVHT0FkMVh6emllWEVTSzc5dHEwUU9CSDl2?=
 =?utf-8?B?TzMrVnpTR1NiSnczcGtyYk9sTHYxemZTUzFkWi9rbDJ0dTJPNVJ5bjV0akJ6?=
 =?utf-8?B?TlpJbjhDaU9uU3lQT3dPZHBkNk43SkFKUVAvcmJSV1BVamlTRDdWSjJIb2xn?=
 =?utf-8?B?NGNTcVZEdGxvVGhMdEhVM3gzL3BPeHg0dlFwVkpsM01EOSt2R1VPVSs3MXRR?=
 =?utf-8?B?ZzBPNFJRaFRORlB6QTgwQVc1MkVXRGcrZ3pIN01WcE5BcWhFRXFVM0xTK1B4?=
 =?utf-8?B?bjE2eHN5UDJjL1JKT2xGa2dBcGplL0tpS3BmYUplVGZOOHlIRVpjYkxNN1Z3?=
 =?utf-8?B?SHJZeFg3aEUxVjJTdmNTcHdBZG5PeGxwRFZsSXNnV2xxSjNSREZ1dTJSRGR4?=
 =?utf-8?B?c081RFZhR0hNK1RDZmR0U0RDM3dWdUhCdWtKSU4yZDM3R2RQdTZxeGpReHU3?=
 =?utf-8?B?MGQ5Yy9BZGZ4MjFUSW1vZU5tUlgxY3dYR05PdWlCMEI5Y0ZFSXcybC9NckJC?=
 =?utf-8?B?ajd5dE9FM0tDNWxhYmhkV0Z1aE1ObWRZTzhxZld5bklBYlZOOFdzaTZsQ3JJ?=
 =?utf-8?B?bDRtblJFbzJncnovcXdDR1F0ZlorMWV0cE1BcHBLbjEyeW8rQUtSU0doOGdZ?=
 =?utf-8?B?ZlQ4N2JmaGZmaTgrc09sNGVIVDRKUlNXbzdSMXptanN1aElXRVRYREx6TkNP?=
 =?utf-8?B?a2k0YjhoaEtYSGhWd2FRelU0Uk85U1ZwMGlQRld1dG54d3BLN3hhS1l5UnlT?=
 =?utf-8?B?bHNENzVZdEV5bkxMamczd0dPcFYwdEN3V2hXSzJVV3c2QmtTQT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3785888E7014E42C694B16DDF5730@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(13464003)(189003)(199004)(6436002)(52536013)(4326008)(3846002)(6116002)(9686003)(5660300002)(7696005)(6506007)(53546011)(76176011)(106356001)(53936002)(6916009)(25786009)(7736002)(68736007)(7416002)(305945005)(55016002)(2906002)(74316002)(6246003)(8936002)(86362001)(478600001)(8676002)(93886005)(446003)(11346002)(105586002)(33656002)(229853002)(97736004)(102836004)(99286004)(14444005)(256004)(54906003)(476003)(66066001)(14454004)(316002)(81166006)(81156014)(486006)(71200400001)(26005)(186003)(71190400001)(44832011)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 34mzkgwg+9IHgCbG0Z3p9hqOi6xZ0Ix50ynwzLTG4h/TEx9nQHYCw5UgPLRDC/YfnZRibgWDh2uGzLwtPccERl0WfCoyAOp+IuX9FVhMycRDxDh4TIQvSxo/cDNTTQnT/4pnrmDQDjkquCDKyhO+imR21xPZgn7px3BQ2f+YOcmQ55SGP8Kis8bM5HsRZAZArpG0CmkSoiv3dJJC88L58SwHZlTl/+U/0PeSXLo0c3w7cqngtT9/0TDU4vSmv4JYBi13A0lTNgaNDTD26bPJ2uwXHabMG7XdgbWqO7zMNW0yB9IV30FwbcmWkUGYkwlhunj33sV0kpdJvtDGym37yMaywd/5UcieaRJRB3G23o/RWwND2AyAcGBdjpirthSB5ZUF1gjrGQ5sQqTC2vUL996wqJzShEg6p6daj898+rk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b88995c-4310-46b8-685f-08d6a2425173
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 14:45:03.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KCVNvcnJ5IHRvIGJyaW5nIGJhY2sgdGhpcyB0b3BpYyBhZ2FpbiBhYm91dCB3aGV0
aGVyIHRvIHB1dCAiaW14LXNjLXdkdCIgbm9kZSBpbnNpZGUgRFQncyBTQ1Ugbm9kZSwgYWZ0ZXIg
c29tZSBkaXNjdXNzaW9uIHdpdGggbXkgdGVhbSwgdGhlcmUgaXMgY2FzZSBvZiB2aXJ0dWFsaXph
dGlvbiwgZGlzYWJsaW5nICJpbXgtc2Mtd2R0IiBmb3IgTGludXggT1MsIHdoaWxlIGVuYWJsZSBp
dCBmb3IgQW5kcm9pZCBPUyBydW5uaW5nIHRvZ2V0aGVyIG9uIHNhbWUgU29DLCB0aGVuIExpbnV4
IG5lZWRzIHRvIGRpc2FibGUgd2F0Y2hkb2cgZnJvbSBpdHMgRFRCIHdoaWxlIEFuZHJvaWQgY2Fu
IGVuYWJsZSBpdC4gRm9yIHN1Y2gga2luZCBvZiBzY2VuYXJpbywgZG8geW91IHRoaW5rIGl0IGlz
IHJlYXNvbmFibGUgdG8gaGF2ZSAiaW14LXNjLXdkdCIgbm9kZSBpbnNpZGUgU0NVIG5vZGUgaW4g
RFQ/IFdlIGRvIE5PVCBoYXZlIGdvb2QgaWRlYSBmb3IgdGhpcyBzY2VuYXJpbyBpZiBpbXgtc2Mt
d2R0IGlzIGFkZGVkIGFzIGJ1aWx0LWluIHBsYXRmb3JtIGRldmljZSBpbnNpZGUgU0NVIGRyaXZl
ci4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyBbbWFpbHRvOnJvYmhAa2VybmVsLm9yZ10NCj4g
U2VudDogMjAxOeW5tDLmnIgyN+aXpSA1OjM0DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVh
bmdAbnhwLmNvbT4NCj4gQ2M6IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD47IG1h
cmsucnV0bGFuZEBhcm0uY29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBoZWlrb0BzbnRl
Y2guZGU7IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBi
am9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBqYWdhbkBh
bWFydWxhc29sdXRpb25zLmNvbTsgQW5keSBHcm9zcyA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsg
ZGwtDQo+IGxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IHdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgYXJuZEBhcm5kYi5k
ZTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGVu
cmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207DQo+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
OyB3aW1AbGludXgtd2F0Y2hkb2cub3JnOyBEYW5pZWwgQmFsdXRhDQo+IDxkYW5pZWwuYmFsdXRh
QG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IEFpc2hlbmcN
Cj4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IG9sb2ZAbGl4b20ubmV0OyBzaGF3bmd1b0Br
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIFYyIDEvNF0gZHQtYmluZGlu
Z3M6IGZzbDogc2N1OiBhZGQgd2F0Y2hkb2cNCj4gYmluZGluZw0KPiANCj4gT24gU3VuLCBGZWIg
MjQsIDIwMTkgYXQgODoyNiBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBIaSwgR3VlbnRlcg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzIQ0KPiA+
IEFuc29uIEh1YW5nDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFs
ZiBPZiBHdWVudGVyDQo+ID4gPiBSb2Vjaw0KPiA+ID4gU2VudDogMjAxOeW5tDLmnIgyNOaXpSAx
MToyMA0KPiA+ID4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgUm9iIEhl
cnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+IENjOiBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiA+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+ID4gY2F0YWxpbi5t
YXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207DQo+ID4gPiB3aW1AbGludXgtd2F0
Y2hkb2cub3JnOyBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gPiA+IHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc7IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNv
bT47IEFuZHkNCj4gPiA+IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+Ow0KPiA+ID4gaG9y
bXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGhlaWtvQHNudGVjaC5kZTsgYXJuZEBhcm5kYi5kZTsN
Cj4gPiA+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRpb25z
LmNvbTsNCj4gPiA+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IG1hcmMudy5nb256YWxl
ekBmcmVlLmZyOw0KPiA+ID4gb2xvZkBsaXhvbS5uZXQ7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLSBrZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVs
Lm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggUkVTRU5EIFYyIDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQNCj4gPiA+
IHdhdGNoZG9nIGJpbmRpbmcNCj4gPiA+DQo+ID4gPiBPbiAyLzIzLzE5IDc6MDQgUE0sIEFuc29u
IEh1YW5nIHdyb3RlOg0KPiA+ID4gPiBIaSwgR3VlbnRlci9Sb2INCj4gPiA+ID4NCj4gPiA+ID4g
QmVzdCBSZWdhcmRzIQ0KPiA+ID4gPiBBbnNvbiBIdWFuZw0KPiA+ID4gPg0KPiA+ID4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4+IEZyb206IEd1ZW50ZXIgUm9lY2sgW21h
aWx0bzpncm9lY2s3QGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mDQo+ID4gPiA+PiBHdWVudGVyIFJv
ZWNrDQo+ID4gPiA+PiBTZW50OiAyMDE55bm0MuaciDI05pelIDE6MDgNCj4gPiA+ID4+IFRvOiBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQW5zb24gSHVhbmcNCj4gPiA+IDxhbnNvbi5o
dWFuZ0BueHAuY29tPg0KPiA+ID4gPj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1
b0BrZXJuZWwub3JnOw0KPiA+ID4gPj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBl
bmd1dHJvbml4LmRlOw0KPiA+ID4gPj4gZmVzdGV2YW1AZ21haWwuY29tOyBjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbTsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gPiA+ID4+IHdpbUBsaW51eC0N
Cj4gPiA+IHdhdGNoZG9nLm9yZzsNCj4gPiA+ID4+IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiA+ID4gPj4gRGFuaWVsIEJhbHV0
YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgQW5keSBHcm9zcw0KPiA+ID4gPj4gPGFuZHkuZ3Jv
c3NAbGluYXJvLm9yZz47DQo+ID4gPiA+PiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgaGVp
a29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOw0KPiA+ID4gPj4gYmpvcm4uYW5kZXJzc29uQGxp
bmFyby5vcmc7IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiA+ID4gPj4gZW5yaWMuYmFs
bGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7DQo+ID4gPiA+PiBv
bG9mQGxpeG9tLm5ldDsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+PiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+ID4gPiA+PiBrZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4g
Pj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggUkVTRU5EIFYyIDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQNCj4gPiA+
ID4+IHdhdGNoZG9nIGJpbmRpbmcNCj4gPiA+ID4+DQo+ID4gPiA+PiBPbiAyLzIyLzE5IDExOjUy
IEFNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+ID4+PiBPbiBNb24sIEZlYiAxOCwgMjAxOSBh
dCAwNjo1Mzo0OEFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+ID4+Pj4gQWRkIGku
TVg4UVhQIHN5c3RlbSBjb250cm9sbGVyIHdhdGNoZG9nIGJpbmRpbmcuDQo+ID4gPiA+Pj4+DQo+
ID4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiA+ID4gPj4+PiAtLS0NCj4gPiA+ID4+Pj4gQ2hhbmdlcyBzaW5jZSBWMToNCj4gPiA+ID4+
Pj4gIC0gdXBkYXRlIGR0cyBub2RlIG5hbWUgdG8gIndhdGNoZG9nIjsNCj4gPiA+ID4+Pj4gLS0t
DQo+ID4gPiA+Pj4+ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJl
ZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+Pj4+IHwgMTANCj4gPiA+ID4+ICsrKysrKysrKysN
Cj4gPiA+ID4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiA+ID4+
Pj4NCj4gPiA+ID4+Pj4gZGlmZiAtLWdpdA0KPiA+ID4gPj4+PiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gPiA+Pj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQNCj4gPiA+ID4+Pj4gaW5kZXggNGI3OTc1MS4uZjM4OGVjNiAxMDA2NDQNCj4gPiA+ID4+Pj4g
LS0tDQo+ID4gPiA+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9m
cmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiA+ID4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50DQo+ID4gPiA+Pj4+ICsrKyB4
dA0KPiA+ID4gPj4+PiBAQCAtMTM2LDYgKzEzNiwxMiBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
PiA+ID4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2UgaWQgZm9yIHRo
ZXJtYWwgZHJpdmVyIHRvDQo+ID4gPiA+Pj4+IGdldCB0ZW1wZXJhdHVyZQ0KPiA+ID4gPj4gdmlh
DQo+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTQ1UgSVBDLg0KPiA+ID4g
Pj4+Pg0KPiA+ID4gPj4+PiArV2F0Y2hkb2cgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2Ug
UHJvdG9jb2wNCj4gPiA+ID4+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPj4+PiArDQo+ID4gPiA+Pj4+ICtSZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4gPj4+PiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImZz
bCxpbXg4cXhwLXNjLXdkdCI7DQo+ID4gPiA+Pj4+ICsNCj4gPiA+ID4+Pj4gICAgRXhhbXBsZSAo
aW14OHF4cCk6DQo+ID4gPiA+Pj4+ICAgIC0tLS0tLS0tLS0tLS0NCj4gPiA+ID4+Pj4gICAgbHNp
b19tdTE6IG1haWxib3hANWQxYzAwMDAgeyBAQCAtMTg4LDYgKzE5NCwxMCBAQCBmaXJtd2FyZQ0K
PiB7DQo+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB0c2Vucy1udW0gPSA8MT47
DQo+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAjdGhlcm1hbC1zZW5zb3ItY2Vs
bHMgPSA8MT47DQo+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4+Pj4gKw0K
PiA+ID4gPj4+PiArICAgICAgICAgICAgICAgIHdhdGNoZG9nOiB3YXRjaGRvZyB7DQo+ID4gPiA+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNj
LXdkdCI7DQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBBcy1pcywgdGhlcmUncyBubyByZWFzb24gZm9y
IHRoaXMgdG8gYmUgaW4gRFQuIFRoZSBwYXJlbnQgbm9kZSdzDQo+ID4gPiA+Pj4gZHJpdmVyIGNh
biBpbnN0YW50aWF0ZSB0aGUgd2RvZy4NCj4gPiA+ID4+Pg0KPiA+ID4gPj4NCj4gPiA+ID4+IEFz
IHRoZSBkcml2ZXIgaXMgY3VycmVudGx5IHdyaXR0ZW4sIHlvdSBhcmUgY29ycmVjdCwgc2luY2Ug
aXQNCj4gPiA+ID4+IGRvZXNuJ3QgYWNjZXB0IHdhdGNoZG9nIHRpbWVvdXQgY29uZmlndXJhdGlv
biB0aHJvdWdoIGRldmljZXRyZWUuDQo+ID4gPiA+Pg0KPiA+ID4gPj4gUXVlc3Rpb24gaXMgaWYg
dGhhdCBpcyBpbnRlbmRlZC4gSXMgaXQgPw0KPiA+ID4gPg0KPiA+ID4gPiBJIGFtIGEgbGl0dGxl
IGNvbmZ1c2VkLCBkbyB5b3UgbWVhbiB3ZSBubyBuZWVkIHRvIGhhdmUgIndhdGNoZG9nIg0KPiA+
ID4gPiBub2RlDQo+ID4gPiBpbiBzaWRlICJzY3UiDQo+ID4gPiA+IG5vZGU/IE9yIHdlIG5lZWQg
dG8gbW9kaWZ5IHRoZSB3YXRjaGRvZyBub2RlJ3MgY29tcGF0aWJsZSBzdHJpbmcgdG8gIg0KPiA+
ID4gPiBmc2wsaW14LXNjLXdkdCIgdG8gbWFrZSBpdCBtb3JlIGdlbmVyaWMgZm9yIG90aGVyIHBs
YXRmb3Jtcz8gSWYNCj4gPiA+ID4geWVzLCBJIGNhbg0KPiA+ID4gcmVzZW5kIHRoZSBwYXRjaCBz
ZXJpZXMgdG8gbW9kaWZ5IGl0Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgUm9iIHN1
Z2dlc3RlZCB0aGF0IHRoZSBTQ1UgcGFyZW50IGRyaXZlciBzaG91bGQgaW5zdGFudGlhdGUNCj4g
PiA+IHRoZSB3YXRjaGRvZyB3aXRob3V0IGV4cGxpY2l0IHdhdGNoZG9nIG5vZGUuIFRoYXQgd291
bGQgYmUgcG9zc2libGUsDQo+ID4gPiBidXQgaXQgY3VycmVudGx5IHVzZXMNCj4gPiA+IGRldm1f
b2ZfcGxhdGZvcm1fcG9wdWxhdGUoKSB0byBkbyB0aGUgaW5zdGFudGlhdGlvbiwgYW5kIGNoYW5n
aW5nDQo+ID4gPiB0aGF0IHdvdWxkIGJlIGEgbWVzcy4gQmVzaWRlcywgaXQgZG9lcyBzZW0gdG8g
bWUgdGhhdCB5b3VyIHN1Z2dlc3RlZA0KPiA+ID4gbm9kZSB3b3VsZCBkZXNjcmliZSB0aGUgaGFy
ZHdhcmUsIHNvIEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZQ0KPiByZWFzb25pbmcuDQo+
IA0KPiBJdCB3b3VsZCBqdXN0IGJlIGEgY2FsbCB0byBjcmVhdGUgYSBwbGF0Zm9ybSBkZXZpY2Ug
aW5zdGVhZC4gSG93IGlzIHRoYXQgYSBtZXNzPw0KPiANCj4gSXQncyBkZXNjcmliaW5nIGZpcm13
YXJlLiBXZSBoYXZlIERUIGZvciBkZXNjcmliaW5nIGgvdyB3ZSd2ZSBmYWlsZWQgdG8gbWFrZQ0K
PiBkaXNjb3ZlcmFibGUuIFdlIHNob3VsZCBub3QgcmVwZWF0IHRoYXQgYW5kIGp1c3QgZGVzY3Jp
YmUgZmlybXdhcmUgaW4gRFQuDQo+IE1ha2UgdGhlIGZpcm13YXJlIGRpc2NvdmVyYWJsZSEgVGhv
dWdoIHRoZXJlIGFyZSBjYXNlcyBsaWtlIGZpcm13YXJlDQo+IHByb3ZpZGVkIGNsb2NrcyB3aGVy
ZSB3ZSBzdGlsbCBuZWVkIHNvbWV0aGluZyBpbiBEVCwgYnV0IHRoaXMgaXMgbm90IG9uZSBvZg0K
PiB0aGVtLg0KPiANCj4gPiA+DQo+ID4gPiBGb3IgbXkgcGFydCBJIHJlZmVycmVkIHRvDQo+ID4g
PiAgICAgICB3YXRjaGRvZ19pbml0X3RpbWVvdXQoaW14X3NjX3dkZCwgREVGQVVMVF9USU1FT1VU
LCAmcGRldi0NCj4gPiA+ID5kZXYpOyBpbiB0aGUgZHJpdmVyLCB3aGljaCBndWFyYW50ZWVzIHRo
YXQgdGhlIHRpbWVvdXQgcHJvcGVydHkNCj4gPiA+ID53aWxsIG5vdCBiZQ0KPiA+ID4gdXNlZCB0
byBzZXQgdGhlIHRpbWVvdXQuIEEgbW9yZSBjb21tb24gaW1wbGVtZW50YXRpb24gd291bGQgaGF2
ZQ0KPiA+ID4gYmVlbg0KPiA+ID4NCj4gPiA+ICAgICAgIGlteF9zY193ZGQtPnRpbWVvdXQgPSBE
RUZBVUxUX1RJTUVPVVQ7DQo+ID4gPiAgICAgICByZXQgPSB3YXRjaGRvZ19pbml0X3RpbWVvdXQo
aW14X3NjX3dkZCwgdGltZW91dCwgJnBkZXYtPmRldik7DQo+ID4gPg0KPiA+ID4gd2hlcmUgJ3Rp
bWVvdXQnIGlzIHRoZSBtb2R1bGUgcGFyYW1ldGVyLiBXaGljaCBpcyBhY3R1YWxseSBub3QgdXNl
ZA0KPiA+ID4gaW4geW91ciBkcml2ZXIuDQo+ID4gPiBIbW0gLi4uIEkgd2Fzbid0IGNhcmVmdWwg
ZW5vdWdoIHdpdGggbXkgcmV2aWV3LiBUaGUgdGltZW91dA0KPiA+ID4gaW5pdGlhbGl6YXRpb24g
YXMtIGlzIGRvZXNuJ3QgbWFrZSBzZW5zZS4gSSdsbCBjb21tZW50IG9uIHRoYXQgaW4gdGhlIHBh
dGNoLg0KPiA+DQo+ID4gSSB1bmRlcnN0YW5kIG5vdywgaW4gb3VyIGNhc2VzLCBJIHdvdWxkIHN0
aWxsIHByZWZlciB0byBoYXZlIHdhdGNoZG9nDQo+ID4gbm9kZSB1bmRlciB0aGUgU0NVIHBhcmVu
dCBub2RlLCBzaW5jZSB0aGVyZSBjb3VsZCBiZSBvdGhlciBwcm9wZXJ0eQ0KPiA+IHNldHRpbmcg
ZGlmZmVyZW5jZSBiZXR3ZWVuIGRpZmZlcmVudCBpLk1YIHBsYXRmb3JtcyB3aXRoIHN5c3RlbQ0K
PiA+IGNvbnRyb2xsZXIgd2F0Y2hkb2cgaW5zaWRlLCB1c2luZyB0aGUgU0NVIG5vZGUgdG8gaW5z
dGFudGlhdGUgbWFrZXMgdXMNCj4gPiBhIGxpdHRsZSBjb25mdXNlZCBhYm91dCB0aGUgd2F0Y2hk
b2csIHNvIGlmIGl0IGlzIE5PVCB0aGF0IGNyaXRpY2FsLCBJDQo+ID4gdGhpbmsgd2Ugc2hvdWxk
IGtlZXAgd2F0Y2hkb2cgbm9kZS4gQnV0IHRvIG1ha2UgdGhlIHdhdGNoZG9nIGRyaXZlcg0KPiA+
IG1vcmUgZ2VuZXJpYyBmb3Igb3RoZXIgaS5NWCBwbGF0Zm9ybXMsIEkgY2hhbmdlZCB0aGUgY29t
cGF0aWJsZSBzdHJpbmcgdG8NCj4gImZzbCxpbXgtc2Mtd2R0IiBpbiBkcml2ZXIsIGFuZCBlYWNo
IFNvQyBzaG91bGQgaGFzIGl0IGFzIGZhbGxiYWNrIGlmIGl0IGNhbg0KPiByZXVzZSB0aGlzIHdh
dGNoZG9nIGRyaXZlci4NCj4gDQo+IFlvdSBoYW5kbGUgZGlmZmVyZW5jZXMgYmV0d2VlbiBTb0Nz
IGJ5IGhhdmluZyBzcGVjaWZpYyBjb21wYXRpYmxlcy4gU28NCj4gImZzbCxpbXgtc2Mtd2R0IiBt
b3ZlcyBpbiB0aGUgd3JvbmcgZGlyZWN0aW9uIGFzc3VtaW5nIHdlIGhhdmUgYSBub2RlIGluDQo+
IHRoZSBmaXJzdCBwbGFjZS4NCj4gDQo+IFJvYg0K
