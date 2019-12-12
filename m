Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378AF214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="K7vEb1r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfLLJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:17:43 -0500
Received: from mail-eopbgr130118.outbound.protection.outlook.com ([40.107.13.118]:45241
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbfLLJRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:17:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su25yh1sCjex+ZUuV5R+SZcAxHj75OGk5dJCtT7i/2vPnVHBgyF2GNMKgtL8AMn/VrXEEe6t8s9Zpph6/8cvz1bHnKL9NIp9+34rYLt5MRzL/VCSbasRfKOWaIcy4b5CJvhBFKq9j124FNuWq4Yqde0rD/anUY8040ogThyIINnWF1vkNz/Khfc7UpzbOkb+v8hLe7MLaE2ApX9Rex7pby+UXfB2zpA6qCe+ycWUY+KtC0cWozu6hJouHDTpdqdMvlx1Q4bSRhT5xm8wiYSf61t4MDi/BBj432V7XNizFlb6ASmWIEBbfoJOxMdBAIdoN35QDc2bWMCvToMi24BvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0y8Pa9uORsh0RPEwbJpczbXKwXtEwSqAjAsLEoy9e8=;
 b=aQ2oP0nizwp6PlI5boCBIe5iWj+qlL8hN+BFRblJtSIJR4esbtMQXLkFa2HIYKYr2Mk4sOtEsN2A+vTFszPzuxI63HVXm/E1dGVdiX++xcjKb9FmMCVx4pEElBXXAocxJTv0QMIJX6lyUAnR160p7NTzngCS/VW8t8F7jfLwHntSr2SfhlHNAdjjeaksqpwe6x9WsZ+17Rl2RpaXYPam45dNT1JkgRPJ5jgDa0XQ8aZo6ooFWsEVw33/NlIFJVT1BTEB60CVeCR2nDyhsTvhhkABX3YWUd6eWe/QxWG0hbyaLCQ/YWVBtv2TQpbK+u815g2inGJz6Sx7tflz4haeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0y8Pa9uORsh0RPEwbJpczbXKwXtEwSqAjAsLEoy9e8=;
 b=K7vEb1r+0H959rpyfRKE6U6zatFuXPIxA9AQR41tUOGPrwgRLpJZ3b+wHJkOydmE4eUCpgKIWsoq86bhzjzwy7mGUfpxEXJzpexfs05OV6FhQZILd5M7WoankrM/fVpKnkArYb1U0zmpmG/GxH9/DRV+ni9PbsbcSqazxzu3FGo=
Received: from AM6PR0502MB3702.eurprd05.prod.outlook.com (52.133.24.15) by
 AM6PR0502MB3895.eurprd05.prod.outlook.com (52.133.20.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 09:16:56 +0000
Received: from AM6PR0502MB3702.eurprd05.prod.outlook.com
 ([fe80::859e:e6e6:4de3:55a9]) by AM6PR0502MB3702.eurprd05.prod.outlook.com
 ([fe80::859e:e6e6:4de3:55a9%6]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 09:16:56 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Alison Wang <alison.wang@nxp.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of unmute
 outputs on probe"
Thread-Topic: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of unmute
 outputs on probe"
Thread-Index: AQHVsLyIRDFbzLs7vEuxsFkXl6DgTKe2NokA
Date:   Thu, 12 Dec 2019 09:16:56 +0000
Message-ID: <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
References: <20191212071847.45561-1-alison.wang@nxp.com>
In-Reply-To: <20191212071847.45561-1-alison.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:301:4a::25) To AM6PR0502MB3702.eurprd05.prod.outlook.com
 (2603:10a6:209:10::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVvoRqL4aJ2LHZLypKCZv8EhlWY+p4YPoHK4yw2T796CabcRJxP
        yFl+mNzBuJ3FvPMW/1dAqsmWP6L1hT0KG2I+j20=
x-google-smtp-source: APXvYqyzVg7+1PTUxcDYjVqoyrAao9relVCwYl9IARni0AEDEndIKVBsEZrQ5c1+NfV4o3gCcEpkrZe/rTNNZ3sgGCs=
x-received: by 2002:a0c:9476:: with SMTP id i51mr7105296qvi.75.1576141843811;
 Thu, 12 Dec 2019 01:10:43 -0800 (PST)
x-gmail-original-message-id: <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
x-originating-ip: [209.85.216.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56286404-af46-43fd-528a-08d77ee40909
x-ms-traffictypediagnostic: AM6PR0502MB3895:
x-microsoft-antispam-prvs: <AM6PR0502MB38957124651D6BE409F9D061F9550@AM6PR0502MB3895.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(396003)(39850400004)(366004)(189003)(199004)(55446002)(9686003)(54906003)(71200400001)(4326008)(53546011)(316002)(5660300002)(6506007)(6512007)(52116002)(2906002)(6862004)(44832011)(186003)(26005)(86362001)(8676002)(81156014)(66556008)(66446008)(6486002)(66476007)(64756008)(66946007)(8936002)(81166006)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0502MB3895;H:AM6PR0502MB3702.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3aIAIyQ7uf3Ea+b9IMc5PiGULFNVaKwxIUZvqBhxw++nbXjYLtCG6PpB8b5IfH6aJpGISdiVrUwsiow5jSLfuMpvcg6QzaR5hJ+mBi1wibjdczU0wYo3Zgf0lAsmMPr6XdQkmg9U1B2qCHKALt4eYVFBNSYIXjczkAKuB2hUhScCVky7dEZnb/cbbGs+pbr8MU58ES0vC6JZe9qF0+YjMtCIqj//1j/+x0DfldtRPUxzuxCWbnpj3MfF9O5hLYuexzRelyZiooIq6UU3u0FhEzDmKwFE29y93e5FVbZpacltkSE2S6KM+aDnmgdfIR4JW2frrQnzP87Gjrnihm0XJt3KBMVFP0tXqpKRgHGQkRq4Jinvf2A20fmCpMovZzxOCY9QSrUepuZDsh7ywqhyp7ApJi0sxp5r8WvnE/0esnQ1dPY3Oz+9uKpZzj81bTm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <44F7767294BC634797E73D18CEE9D414@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56286404-af46-43fd-528a-08d77ee40909
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 09:16:56.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ithmXzGwoFAIyFkSSdDsRzMJ6p8iBXDOhskLgs4oXdksFoHJywSWenOpNbRYooU8+o3Z9CTbO98PeEo6ybypnVD6RvnUflqGychnKpMWzM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxpc29uLCBjb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4sIHdoYXQgcmVhc29uIHRvIHJldmVydCB0
aGlzIGZpeD8gQWxsDQp0aGVzZSBibG9ja3MgaGF2ZSB0aGVpciBvd24gY29udHJvbCBhbmQgdW5t
dXRlIG9uIGRlbWFuZC4NCldoeSBkbyB5b3Ugc3RhbmQgb24gdW5jb25kaXRpb25hbCB1bm11dGlu
ZyBvZiBvdXRwdXRzIGFuZCBBREMgb24gZHJpdmVyIHByb2Jpbmc/DQoNCk9uIFRodSwgRGVjIDEy
LCAyMDE5IGF0IDk6MjAgQU0gQWxpc29uIFdhbmcgPGFsaXNvbi53YW5nQG54cC5jb20+IHdyb3Rl
Og0KPg0KPiBUaGlzIHJldmVydHMgY29tbWl0IDYzMWJjOGYwMTM0YWU5NjIwZDg2YTk2YjhjNWY5
NDQ1ZDkxYTJkY2EuDQo+DQo+IEluIGNvbW1pdCA2MzFiYzhmMDEzNGEsIHNuZF9zb2NfY29tcG9u
ZW50X3VwZGF0ZV9iaXRzIGlzIHVzZWQgaW5zdGVhZCBvZg0KPiBzbmRfc29jX2NvbXBvbmVudF93
cml0ZS4gQWx0aG91Z2ggRU5fSFBfWkNEIGFuZCBFTl9BRENfWkNEIGFyZSBlbmFibGVkDQo+IGlu
IEFOQV9DVFJMIHJlZ2lzdGVyLCBNVVRFX0xPLCBNVVRFX0hQIGFuZCBNVVRFX0FEQyBiaXRzIGFy
ZSByZW1haW5lZCBhcw0KPiB0aGUgZGVmYXVsdCB2YWx1ZS4gSXQgY2F1c2VzIExPLCBIUCBhbmQg
QURDIGFyZSBhbGwgbXV0ZWQgYWZ0ZXIgZHJpdmVyDQo+IHByb2JlLg0KPg0KPiBUaGUgcGF0Y2gg
aXMgdG8gcmV2ZXJ0IHRoaXMgY29tbWl0LCBzbmRfc29jX2NvbXBvbmVudF93cml0ZSBpcyBzdGls
bA0KPiB1c2VkIGFuZCBNVVRFX0xPLCBNVVRFX0hQIGFuZCBNVVRFX0FEQyBhcmUgc2V0IGFzIHpl
cm8gKHVubXV0ZWQpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gV2FuZyA8YWxpc29uLndh
bmdAbnhwLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCA2ICsr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyBiL3NvdW5kL3Nv
Yy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiBpbmRleCBhYTFmOTYzLi4wYjM1ZmNhIDEwMDY0NA0KPiAt
LS0gYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gKysrIGIvc291bmQvc29jL2NvZGVj
cy9zZ3RsNTAwMC5jDQo+IEBAIC0xNDU4LDcgKzE0NTgsNiBAQCBzdGF0aWMgaW50IHNndGw1MDAw
X3Byb2JlKHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50KQ0KPiAgICAgICAgIGlu
dCByZXQ7DQo+ICAgICAgICAgdTE2IHJlZzsNCj4gICAgICAgICBzdHJ1Y3Qgc2d0bDUwMDBfcHJp
diAqc2d0bDUwMDAgPSBzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21wb25lbnQpOw0K
PiAtICAgICAgIHVuc2lnbmVkIGludCB6Y2RfbWFzayA9IFNHVEw1MDAwX0hQX1pDRF9FTiB8IFNH
VEw1MDAwX0FEQ19aQ0RfRU47DQo+DQo+ICAgICAgICAgLyogcG93ZXIgdXAgc2d0bDUwMDAgKi8N
Cj4gICAgICAgICByZXQgPSBzZ3RsNTAwMF9zZXRfcG93ZXJfcmVncyhjb21wb25lbnQpOw0KPiBA
QCAtMTQ4Niw4ICsxNDg1LDkgQEAgc3RhdGljIGludCBzZ3RsNTAwMF9wcm9iZShzdHJ1Y3Qgc25k
X3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCj4gICAgICAgICAgICAgICAgMHgxZik7DQo+ICAg
ICAgICAgc25kX3NvY19jb21wb25lbnRfd3JpdGUoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX1BB
RF9TVFJFTkdUSCwgcmVnKTsNCj4NCj4gLSAgICAgICBzbmRfc29jX2NvbXBvbmVudF91cGRhdGVf
Yml0cyhjb21wb25lbnQsIFNHVEw1MDAwX0NISVBfQU5BX0NUUkwsDQo+IC0gICAgICAgICAgICAg
ICB6Y2RfbWFzaywgemNkX21hc2spOw0KPiArICAgICAgIHNuZF9zb2NfY29tcG9uZW50X3dyaXRl
KGNvbXBvbmVudCwgU0dUTDUwMDBfQ0hJUF9BTkFfQ1RSTCwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgU0dUTDUwMDBfSFBfWkNEX0VOIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgU0dU
TDUwMDBfQURDX1pDRF9FTik7DQo+DQo+ICAgICAgICAgc25kX3NvY19jb21wb25lbnRfdXBkYXRl
X2JpdHMoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX01JQ19DVFJMLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBTR1RMNTAwMF9CSUFTX1JfTUFTSywNCj4gLS0NCj4gMi45LjUNCj4NCg0KDQot
LSANCkJlc3QgcmVnYXJkcw0KT2xla3NhbmRyIFN1dm9yb3YNCg0KVG9yYWRleCBBRw0KQWx0c2Fn
ZW5zdHJhc3NlIDUgfCA2MDQ4IEhvcncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEg
NTAwDQo0ODAwIChtYWluIGxpbmUpDQo=
