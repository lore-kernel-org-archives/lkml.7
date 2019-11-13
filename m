Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD9CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C022245D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="puFhWNIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKMHNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:13:43 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:51783
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfKMHNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:13:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UccYmiHbS09oymdtjR2Qm77nwQVD13C0R4MLBJDZJwInTXn5l1QfGfPzIpmPWn7Ha3SUZEPNFyO2Q1rf8yY8qyBtEC23ma5AU/X1z6Yo8n8eMdQtavXZiSTIC+796M/2U/Q5v0KyXipmXrvE9b8T0KATkmepRHbkS4Bx7mCp08d8gMifJbL2BRhvUuKoansyozUHt+wM+MokElmt+HfppuSL2NTfHeRni14VrCCsKng0pyH5yFI9PtFRYrIbcDoisnyapI9vz6sYIc+GG8yrUIhiUoed0XUAzOiprCH1dESWY9VsQpXFsE+xwyRnjheWsPJw2Gg33JlR6CoKJwOU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4erIvFYSbuSKD748g/0qZZheuh/FiHv57w4AW0I5hE=;
 b=lTfLWPxPR+l2p6MW7E+U838ZTu99NIdajmEI8++UldDXUhSPx5fN7txUp2LSIaK1DCxcRtYjytMNLNZbZC9IhS/yHNhWbJIPKuGYhKGCVB1LrM1vThx+agOGxo1RC7RjzYJlj7VT4H7nhaCoAQVlmcZgf1v6NZLWiGsA3/I2GzVvLHIG5C59royw28y4G+wJfo6fY3FtLLy8f/5sPhK759Xb36ZHilgf/x7yoZUhZ4DwIF7Pxg//SP7J+WRqtia0cuVM5mz2H973Fdwqb3Cyycol9OL2FZIbdXN9shZUhmKrlxHAw4iPT4n0RIw/LIpDxP3zBwe02C/TGfpaOywNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4erIvFYSbuSKD748g/0qZZheuh/FiHv57w4AW0I5hE=;
 b=puFhWNIFAjppLBDSNFdIFrPck9TBAA1cSbxaTa8F3imiJOIziCDw/v3WG6WgJXXAYvI0WzkPP82Zl7JYg0dKBd76MA7Ep45GhUCgEyK7nqUbvSIFV3ceKOdyg4En1Z2H5XGJ0oj7ZDNFDonOH7WPMC28QF3U8P/5WomQNVtXTOk=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6128.eurprd04.prod.outlook.com (20.179.27.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 07:13:38 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 07:13:38 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     hui yang <yanghui.def@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] USB(u_serial.c): it has a NULL point
Thread-Topic: [PATCH 2/2] USB(u_serial.c): it has a NULL point
Thread-Index: AQHVkfCf1ocBuOTQN0Sry43xj2y2mqd5ZEuAgAkcL4CABkAJAA==
Date:   Wed, 13 Nov 2019 07:13:38 +0000
Message-ID: <20191113071558.GB30608@b29397-desktop>
References: <1572749044-6091-1-git-send-email-yanghui.def@gmail.com>
 <20191103124201.GB619218@kroah.com>
 <CA+wXOo2nzANnbfFA6mHa3ZQxyA6bYgL9CM3Ykq12m_rxkRyQ4Q@mail.gmail.com>
In-Reply-To: <CA+wXOo2nzANnbfFA6mHa3ZQxyA6bYgL9CM3Ykq12m_rxkRyQ4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21239bd8-b42c-408f-f268-08d7680901b0
x-ms-traffictypediagnostic: VI1PR04MB6128:
x-microsoft-antispam-prvs: <VI1PR04MB612819522DA4733D21DAC6528B760@VI1PR04MB6128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(305945005)(229853002)(71200400001)(91956017)(76116006)(86362001)(6116002)(44832011)(33716001)(3846002)(71190400001)(6916009)(6436002)(256004)(6486002)(14444005)(7736002)(33656002)(6512007)(9686003)(76176011)(99286004)(186003)(66066001)(26005)(102836004)(476003)(4326008)(6506007)(446003)(11346002)(53546011)(5660300002)(8676002)(81156014)(14454004)(81166006)(54906003)(2906002)(25786009)(66556008)(66446008)(64756008)(1076003)(478600001)(6246003)(66946007)(8936002)(316002)(486006)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6128;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gT8DO5FtbDORg+NI/+RTtCAepqE/jvpJPAUIESZg1jSVUAPdzumdN/uCYw4ZlGfibDjqI5p1JK4B9LrZhB+llbIlSw3VG3PrnLIgYyheOqO7mLBcI6R4bcuQOknYVI1yNrj48UEEvGUqYTxsK67tZPlBMtJ1Zx3mvge43KvKVpWOS0G9Kuzyr1uFSSCYp4j0ISOkVPcZutz6yw4yeJsu+BTNZjEEU4umT8ON6kgv7DR4VJfk2QEUzdkv2CHSvIdsOIeAc3oTWkvNGPsYzgHoFXM9KiyaDuvLSy98T8rdC+T13rHurLqHb0ijDFR9b2Je+wDCpgc6dPDyreaJmk+sOhUMExEgylSgsrBaCiUtqXhD5CiPGFYS8UaVJom1bSItODSDC5KkE4B2mRUJpL88cFJEhcLxCKNKWSSF8R/V2UHXCPrGRU85+9GG2rpyNQ3N
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B72E1DCD32444CB92A0C8506DDBE16@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21239bd8-b42c-408f-f268-08d7680901b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:13:38.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bdKIKy3NWVxp7HNFIPknU4NoXB27biSuJzugrLAwKdmTOS6MF5fhb2/QkHZxJNkiL5ODav8sL9acRxlHy100A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTktMTEtMDkgMTU6NDk6MTMsIGh1aSB5YW5nIHdyb3RlOg0KPiBJJ20gc29ycnkgZm9yIG15
IGZhdWx0IC4gTm93IEkgc2VuZCB0byBldmVyeW9uZSAuDQo+IA0KPiBXaGVuIHdlIHVzZSBVU0Ig
dG8gdHJhbnNtaXQgZGF0YQ0KPiB3aXRoIFBDLCB0aGUgcGhvbmUgd2lsbCBjcmFzaGVkIExvdyBw
cm9iYWJpbGl0eSAuDQo+IFdlIGZvdW5kIHBvcnQtPnBvcnQudHR5IGJlY2FtZSBOVUxMLg0KDQpX
b3VsZCB5b3UgcGxlYXNlIGRlYnVnIG1vcmUsIGl0IHNlZW1zIGdzIG9wZW4vY2xvc2UgKGdzX29w
ZW4vZ3NfY2xvc2UpDQphcmUgc29tZXRoaW5nIHdyb25nLiBUaGUgdmFsdWUgcG9ydC0+cG9ydC50
dHkgYW5kIHBvcnQtPnBvcnQuY291bnQNCmFyZSBpbmNvbnNpc3RlbnQuDQoNClBldGVyDQoNCj4g
DQo+IFRoYW5rcw0KPiANCj4gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IOS6
jjIwMTnlubQxMeaciDPml6Xlkajml6Ug5LiL5Y2IODo0MuWGmemBk++8mg0KPiA+DQo+ID4gT24g
U3VuLCBOb3YgMDMsIDIwMTkgYXQgMTA6NDQ6MDRBTSArMDgwMCwgaHVpIHlhbmcgd3JvdGU6DQo+
ID4gPiBGcm9tOiBZYW5nSHVpIDx5YW5naHVpLmRlZkBnbWFpbC5jb20+DQo+ID4gPg0KPiA+ID4g
VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1
YWwgYWRkcmVzcyAwMDAwMDJhMA0KPiA+ID4gS2VybmVsIEJVRyBhdCB0dHlfd2FrZXVwKzB4MTgv
MHg4Yw0KPiA+ID4gWzwwMDAwMDAwMDk1MTM1ZTlkPl0gdHR5X3dha2V1cCsweDE4LzB4OGMNCj4g
PiA+IFs8MDAwMDAwMDBjMzVmMTllND5dIGdzX3N0YXJ0X2lvKzB4YzgvMHgxNTgNCj4gPiA+IFs8
MDAwMDAwMDBiMTFiMTg0ZT5dIGdzZXJpYWxfY29ubmVjdCsweGQwLzB4MTc0DQo+ID4gPiBbPDAw
MDAwMDAwNjQyMjAxZGU+XSBhY21fc2V0X2FsdCsweDcwLzB4MTgwDQo+ID4gPiBbPDAwMDAwMDAw
YTlkMzhlOGI+XSBjb21wb3NpdGVfc2V0dXArMHgxODQ4LzB4MWE3Yw0KPiA+ID4gWzwwMDAwMDAw
MDcyYzg4NzgxPl0gYW5kcm9pZF9zZXR1cCsweDFlYy8weDFmNA0KPiA+ID4gWzwwMDAwMDAwMDRj
MDEyN2E1Pl0gbXNtX3VkY19pcnErMHg4ZDAvMHhjMGMNCj4gPiA+IFs8MDAwMDAwMDBmOGJiOWFj
Zj5dIF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHg3NC8weDI5NA0KPiA+ID4gWzwwMDAwMDAw
MGFmZDU3MjU2Pl0gaGFuZGxlX2lycV9ldmVudCsweDYwLzB4YzgNCj4gPiA+IFs8MDAwMDAwMDA3
NjcxOWIyND5dIGhhbmRsZV9mYXN0ZW9pX2lycSsweGM4LzB4MWM0DQo+ID4gPiBbPDAwMDAwMDAw
NDIxZjNkODc+XSBnZW5lcmljX2hhbmRsZV9pcnErMHgzNC8weDRjDQo+ID4gPiBbPDAwMDAwMDAw
YjJmMmQzNDM+XSBfX2hhbmRsZV9kb21haW5faXJxKzB4NmMvMHhiYw0KPiA+ID4gWzwwMDAwMDAw
MGM3NDMyNWU4Pl0gZ2ljX2hhbmRsZV9pcnErMHg2Yy8weGUwDQo+ID4gPiB5ZXMsd2UgY2FuIHNl
ZSB0aGUgcG9ydC0+cG9ydC50dHk9PU5VTEwsIHNvIHN5c3RlbSBjcmFzaGVkDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogWWFuZ0h1aSA8eWFuZ2h1aS5kZWZAZ21haWwuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCAyICsr
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQo+ID4gPiBpbmRleCA2NWY2MzRlLi5h
MWMyYWMyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vf
c2VyaWFsLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3Nlcmlh
bC5jDQo+ID4gPiBAQCAtNTYyLDYgKzU2Miw4IEBAIHN0YXRpYyBpbnQgZ3Nfc3RhcnRfaW8oc3Ry
dWN0IGdzX3BvcnQgKnBvcnQpDQo+ID4gPg0KPiA+ID4gICAgICAgLyogdW5ibG9jayBhbnkgcGVu
ZGluZyB3cml0ZXMgaW50byBvdXIgY2lyY3VsYXIgYnVmZmVyICovDQo+ID4gPiAgICAgICBpZiAo
c3RhcnRlZCkgew0KPiA+ID4gKyAgICAgICAgICAgICBpZiAocG9ydC0+cG9ydC50dHkgPT0gTlVM
TCkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gPg0KPiA+IEhv
dyBjYW4gdGhpcyBoYXBwZW4/ICBTaG91bGRuJ3QgdGhpcyBiZSBoYW5kbGVkIGVhcmxpZXI/DQo+
ID4NCj4gPiBJZiBub3QsIGNhbiB5b3UgZG9jdW1lbnQgdGhpcyBob3cgdGhpcyBjYW4gYmUgdHJ1
ZSBhbmQgd2hhdCBzaG91bGQgYmUNCj4gPiBkb25lIGFib3V0IGl0Pw0KPiA+DQo+ID4gdGhhbmtz
LA0KPiA+DQo+ID4gZ3JlZyBrLWgNCg0KLS0gDQoNClRoYW5rcywNClBldGVyIENoZW4=
