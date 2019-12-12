Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76422C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2A3214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dAsc7g44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfLLKX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:23:57 -0500
Received: from mail-eopbgr30114.outbound.protection.outlook.com ([40.107.3.114]:25408
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728339AbfLLKX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzeBtH8N99fhYG1x1jlFvV2v8FZfGTqvxDUTVR1P0RbyGO7jV/+VdpzyDQG96l9ScBM18FoiEQMS8z5n0P33P5V3jgGLoDq4v+pJHisBsRd//dsWjU9lUo5kkrLwtlxOw+MAvQY7MOUxZG66CugLHJodsq5JRgN+kH8ZiYw28ggDDOlJ8BuOOyKEA+olNEle/1vk3R/y87Mt7GWa6QmmFmoWcJvT1fWLecQWdeuf+3oXCQe+z4+r5dR9g4INY8juXk2UPHLtUXEuqt9POMkGJpbOMdaY8NgDa8dwg8xw11i6tbwkh7TDI+XFgLj47x1gBF5ky3sVk+5MoLuct10P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDTuJuwidxTew9MufapxdOmHT5aegh40dF4S7K2S9R0=;
 b=EdtLy1q86w0skxtF3n9mv2rfEjhkONpxUMIGOOQ9t1NPuxZotRvfi6qI9mFug3RuKmhPzQ4u7IWDborufVdrYKyE25VoOlB079StiEPuBOMeyaptNllS5tn8Jn9t05maoiKyOrqXVIg+obSVGtUARirRaD/KmXIQqph4EyxVxw0PEnSLhtNePYhE5mXlyjGeOaeRQGldxxQIbRtq3AdEsfhYpYiutvErgyAL2Ld1shzFiibbGKxuxZhCut5gZbd7JNM2T+AfpC9JChAc6TPJdZLLljI4evXDo78GhcwYY/QJeriPJXVocl4gFe2jR/sN2lj1wggqt2N8f6XRlWaKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDTuJuwidxTew9MufapxdOmHT5aegh40dF4S7K2S9R0=;
 b=dAsc7g44VJ6jF+vQ1KjtL5WC8PU9/0mkSV0puknTpBgQyk5wQcHhN46RJ4amx908oLxzR0KZBsq+tG6rknGr9eD9kZwkuXAJJz88FbPdvd7FpxPmEYJ53T9CcELBV+ipuR8aiPYntrzvrxW4FZfRx0IGl3hbvSZRHweQg3/mipc=
Received: from AM6PR0502MB3702.eurprd05.prod.outlook.com (52.133.24.15) by
 AM6PR0502MB3687.eurprd05.prod.outlook.com (52.133.20.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 12 Dec 2019 10:23:52 +0000
Received: from AM6PR0502MB3702.eurprd05.prod.outlook.com
 ([fe80::859e:e6e6:4de3:55a9]) by AM6PR0502MB3702.eurprd05.prod.outlook.com
 ([fe80::859e:e6e6:4de3:55a9%6]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 10:23:52 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Alison Wang <alison.wang@nxp.com>
CC:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of
 unmute outputs on probe"
Thread-Topic: [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC: sgtl5000: Fix of
 unmute outputs on probe"
Thread-Index: AQHVsLyIRDFbzLs7vEuxsFkXl6DgTKe2NokAgAAA1bCAAAyIYIAABwsA
Date:   Thu, 12 Dec 2019 10:23:50 +0000
Message-ID: <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
References: <20191212071847.45561-1-alison.wang@nxp.com>
 <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To AM6PR0502MB3702.eurprd05.prod.outlook.com
 (2603:10a6:209:10::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAVl1vX38FjfpgCoCKeN0gyB49i2sNZrIJ3qCj2OCGVNhAejLQHz
        noDNAfftiLVhDhxxEyXYqEuju3Ih/ggQBRi8/JM=
x-google-smtp-source: APXvYqzCKNlggHGHxjigKZmCUVgZ+cip+vMnJTOoLKhRoOGQy0ad43JDjmtQNArXx1kh3+4ZLk8QYR6o+8xZQWPIAVU=
x-received: by 2002:a05:620a:21d4:: with SMTP id
 h20mr6976008qka.468.1576146225713; Thu, 12 Dec 2019 02:23:45 -0800 (PST)
x-gmail-original-message-id: <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
x-originating-ip: [209.85.222.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0f278ee-289e-4a97-15ff-08d77eed6146
x-ms-traffictypediagnostic: AM6PR0502MB3687:
x-microsoft-antispam-prvs: <AM6PR0502MB36874609BD505D51CACC6A0BF9550@AM6PR0502MB3687.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39850400004)(396003)(366004)(376002)(136003)(13464003)(189003)(199004)(66556008)(316002)(66476007)(66946007)(8676002)(64756008)(52116002)(26005)(5660300002)(66446008)(44832011)(53546011)(6512007)(9686003)(4326008)(186003)(478600001)(6506007)(55446002)(2906002)(6486002)(81166006)(71200400001)(54906003)(86362001)(6862004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0502MB3687;H:AM6PR0502MB3702.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDw3ptSAS+PEJ7VZnX5wrmG5ZtpqImNss7PKZN9PnUzpgsNYjlQClzdiwpGoyf4k0CnyfQBo8aNWCBueGUUQr8KryKQDmhNdVi14T2d3CN7hIZLA3C34hGY7nS7fhZgesV1j6yLxg37Tk2WQUgRRFKvM4yps06Zr3A1Bv/8UEpRmYUObaqpo17Eyp8lEmc+QA41EDhvzoMe8huhqT1kwNwVCyhi+ql0yo+o0y12/IcCszm7mhwIlA6SZoKcO0tKoB8jxc4le6qy2jBTXQMzdtvq8PaSNXMhq5hy4NNUuzCn+o7i1Dt9zy1CPsUm4v2SPcLwydGmUKjQnnd0dXhf3NI8GNzvuigRudYi3qw8V8b9dfYtyHx9hGwJiR+yMryCZ2jE9Otd9X8M3CWenCUSvSArgdD6y4aL9Z/AOT5OvDY7hzoCl74RlFS7d4b61KAiRn45uWWNvBPBibgLkb9gpboiWEuvP8M8ba2udAn9bo4kmUKg6ges0lH2wls1k8SK5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C088CBFAECD824D8708D13C05C788EB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f278ee-289e-4a97-15ff-08d77eed6146
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 10:23:50.2025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh8GxHBMo0a/t6USfVmRvBA8BoRflTlTNhaKYXWSg6jwCljwX+BrANISYeNKr/xwlTBKUuXfoeTXKVuwnVABQ8GRSHoZN82q0O+xIYOy4iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhleSB1bm11dGUgd2l0aCBzdGFuZGFyZCBzb3VuZCBjb250cm9sczoNCnN0YXRpYyBjb25zdCBz
dHJ1Y3Qgc25kX2tjb250cm9sX25ldyBzZ3RsNTAwMF9zbmRfY29udHJvbHNbXSA9IHsNCi4uLg0K
U09DX1NJTkdMRSgiQ2FwdHVyZSBTd2l0Y2giLCBTR1RMNTAwMF9DSElQX0FOQV9DVFJMLCAwLCAx
LCAxKSwNCi4uLg0KU09DX1NJTkdMRSgiSGVhZHBob25lIFBsYXliYWNrIFN3aXRjaCIsIFNHVEw1
MDAwX0NISVBfQU5BX0NUUkwsIDQsIDEsIDEpLA0KLi4uDQpTT0NfU0lOR0xFKCJMaW5lb3V0IFBs
YXliYWNrIFN3aXRjaCIsIFNHVEw1MDAwX0NISVBfQU5BX0NUUkwsIDgsIDEsIDEpLA0KLi4uDQoN
CldlIHRlc3RlZCB0aGlzIHN0YW5kYXJkIHNvbHV0aW9uIHVzaW5nIGdzdHJlYW1lciBhbmQgc3Rh
bmRhcmQgQUxTQQ0KdG9vbHMgbGlrZSBhcGxheSwgYXJlY29yZCBhbmQgYWxsIHRoZXNlIHRvb2xz
IHVubXV0ZSBuZWVkZWQgYmxvY2tzDQpzdWNjZXNzZnVsbHkuDQoNCk9uIFRodSwgRGVjIDEyLCAy
MDE5IGF0IDEyOjA4IFBNIEFsaXNvbiBXYW5nIDxhbGlzb24ud2FuZ0BueHAuY29tPiB3cm90ZToN
Cj4NCj4gSGksIE9sZWtzYW5kciwNCj4NCj4gSW4geW91ciBwYXRjaCwgb3V0cHV0cyBhbmQgQURD
IGFyZSBtdXRlZCBvbiBkcml2ZXIgcHJvYmluZy4gSSBkb24ndCBrbm93IHdoZW4gYW5kDQo+IHdo
ZXJlIHRoZXkgY2FuIGJlIHVubXV0ZWQgaW4gdGhlIGtlcm5lbCBiZWZvcmUgcGxheWluZyBpbiB0
aGUgYXBwbGljYXRpb24uDQo+DQo+IENvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBtZSBzb21lIGlkZWFz
Pw0KPg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IEFsaXNvbiBXYW5nDQo+DQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBbGlzb24gV2FuZw0KPiA+IFNlbnQ6IFRodXJz
ZGF5LCBEZWNlbWJlciAxMiwgMjAxOSA1OjI1IFBNDQo+ID4gVG86IE9sZWtzYW5kciBTdXZvcm92
IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4NCj4gPiBDYzogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyBJZ29yIE9wYW5pdWsNCj4gPiA8aWdvci5v
cGFuaXVrQHRvcmFkZXguY29tPjsgZmVzdGV2YW1AZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5v
cmc7DQo+ID4gbGdpcmR3b29kQGdtYWlsLmNvbTsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Ow0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSRTogW0VY
VF0gUmU6IFtQQVRDSF0gQVNvQzogc2d0bDUwMDA6IFJldmVydCAiQVNvQzogc2d0bDUwMDA6IEZp
eCBvZg0KPiA+IHVubXV0ZSBvdXRwdXRzIG9uIHByb2JlIg0KPiA+DQo+ID4gSGksIE9sZWtzYW5k
ciwNCj4gPg0KPiA+IEkgdGhpbmsgSSBoYXZlIGV4cGxhaW5lZCB0aGUgcmVhc29uIGluIG15IGVt
YWlsIHdoaWNoIHNlbnQgdG8geW91IHllc3RlcmRheS4gSQ0KPiA+IGF0dGFjaGVkIGl0IHRvby4N
Cj4gPiBBY2NvcmRpbmcgdG8gbXkgdGVzdCBvbiB0aGUgYm9hcmRzLCBNVVRFX0xPLCBNVVRFX0hQ
IGFuZCBNVVRFX0FEQyBhcmUNCj4gPiBhbGwgbXV0ZWQgd2hlbiBwbGF5aW5nIHRoZSBzb3VuZC4N
Cj4gPg0KPiA+IENvdWxkIHlvdSBnaXZlIG1lIHNvbWUgaWRlYXMgYWJvdXQgdGhpcyBpc3N1ZT8N
Cj4gPg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLEkNCj4gPiBBbGlzb24gV2FuZw0KPiA+DQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBPbGVrc2FuZHIg
U3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQo+ID4gPiBTZW50OiBUaHVy
c2RheSwgRGVjZW1iZXIgMTIsIDIwMTkgNToxMSBQTQ0KPiA+ID4gVG86IEFsaXNvbiBXYW5nIDxh
bGlzb24ud2FuZ0BueHAuY29tPg0KPiA+ID4gQ2M6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPjsgSWdvciBPcGFuaXVrDQo+ID4gPiA8aWdvci5vcGFuaXVrQHRv
cmFkZXguY29tPjsgZmVzdGV2YW1AZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5vcmc7DQo+ID4g
PiBsZ2lyZHdvb2RAZ21haWwuY29tOyBPbGVrc2FuZHIgU3V2b3Jvdg0KPiA+IDxvbGVrc2FuZHIu
c3V2b3JvdkB0b3JhZGV4LmNvbT47DQo+ID4gPiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBb
UEFUQ0hdIEFTb0M6IHNndGw1MDAwOiBSZXZlcnQgIkFTb0M6IHNndGw1MDAwOiBGaXggb2YNCj4g
PiA+IHVubXV0ZSBvdXRwdXRzIG9uIHByb2JlIg0KPiA+ID4NCj4gPiA+IENhdXRpb246IEVYVCBF
bWFpbA0KPiA+ID4NCj4gPiA+IEFsaXNvbiwgY291bGQgeW91IHBsZWFzZSBleHBsYWluLCB3aGF0
IHJlYXNvbiB0byByZXZlcnQgdGhpcyBmaXg/IEFsbCB0aGVzZQ0KPiA+IGJsb2Nrcw0KPiA+ID4g
aGF2ZSB0aGVpciBvd24gY29udHJvbCBhbmQgdW5tdXRlIG9uIGRlbWFuZC4NCj4gPiA+IFdoeSBk
byB5b3Ugc3RhbmQgb24gdW5jb25kaXRpb25hbCB1bm11dGluZyBvZiBvdXRwdXRzIGFuZCBBREMg
b24gZHJpdmVyDQo+ID4gPiBwcm9iaW5nPw0KPiA+ID4NCj4gPiA+IE9uIFRodSwgRGVjIDEyLCAy
MDE5IGF0IDk6MjAgQU0gQWxpc29uIFdhbmcgPGFsaXNvbi53YW5nQG54cC5jb20+DQo+ID4gPiB3
cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyByZXZlcnRzIGNvbW1pdCA2MzFiYzhmMDEzNGFl
OTYyMGQ4NmE5NmI4YzVmOTQ0NWQ5MWEyZGNhLg0KPiA+ID4gPg0KPiA+ID4gPiBJbiBjb21taXQg
NjMxYmM4ZjAxMzRhLCBzbmRfc29jX2NvbXBvbmVudF91cGRhdGVfYml0cyBpcyB1c2VkIGluc3Rl
YWQNCj4gPiA+ID4gb2Ygc25kX3NvY19jb21wb25lbnRfd3JpdGUuIEFsdGhvdWdoIEVOX0hQX1pD
RCBhbmQgRU5fQURDX1pDRCBhcmUNCj4gPiA+ID4gZW5hYmxlZCBpbiBBTkFfQ1RSTCByZWdpc3Rl
ciwgTVVURV9MTywgTVVURV9IUCBhbmQgTVVURV9BREMgYml0cw0KPiA+IGFyZQ0KPiA+ID4gPiBy
ZW1haW5lZCBhcyB0aGUgZGVmYXVsdCB2YWx1ZS4gSXQgY2F1c2VzIExPLCBIUCBhbmQgQURDIGFy
ZSBhbGwgbXV0ZWQNCj4gPiA+ID4gYWZ0ZXIgZHJpdmVyIHByb2JlLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGUgcGF0Y2ggaXMgdG8gcmV2ZXJ0IHRoaXMgY29tbWl0LCBzbmRfc29jX2NvbXBvbmVudF93
cml0ZSBpcyBzdGlsbA0KPiA+ID4gPiB1c2VkIGFuZCBNVVRFX0xPLCBNVVRFX0hQIGFuZCBNVVRF
X0FEQyBhcmUgc2V0IGFzIHplcm8gKHVubXV0ZWQpLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGlzb24gV2FuZyA8YWxpc29uLndhbmdAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+ICBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCA2ICsrKy0tLQ0KPiA+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4N
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYyBiL3NvdW5k
L3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiA+ID4gPiBpbmRleCBhYTFmOTYzLi4wYjM1ZmNhIDEw
MDY0NA0KPiA+ID4gPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gPiA+ID4g
KysrIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+ID4gPiA+IEBAIC0xNDU4LDcgKzE0
NTgsNiBAQCBzdGF0aWMgaW50IHNndGw1MDAwX3Byb2JlKHN0cnVjdA0KPiA+ID4gc25kX3NvY19j
b21wb25lbnQgKmNvbXBvbmVudCkNCj4gPiA+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+ID4gPiAg
ICAgICAgIHUxNiByZWc7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IHNndGw1MDAwX3ByaXYgKnNn
dGw1MDAwID0NCj4gPiA+IHNuZF9zb2NfY29tcG9uZW50X2dldF9kcnZkYXRhKGNvbXBvbmVudCk7
DQo+ID4gPiA+IC0gICAgICAgdW5zaWduZWQgaW50IHpjZF9tYXNrID0gU0dUTDUwMDBfSFBfWkNE
X0VOIHwNCj4gPiA+IFNHVEw1MDAwX0FEQ19aQ0RfRU47DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAg
ICAgLyogcG93ZXIgdXAgc2d0bDUwMDAgKi8NCj4gPiA+ID4gICAgICAgICByZXQgPSBzZ3RsNTAw
MF9zZXRfcG93ZXJfcmVncyhjb21wb25lbnQpOw0KPiA+ID4gPiBAQCAtMTQ4Niw4ICsxNDg1LDkg
QEAgc3RhdGljIGludCBzZ3RsNTAwMF9wcm9iZShzdHJ1Y3QNCj4gPiA+IHNuZF9zb2NfY29tcG9u
ZW50ICpjb21wb25lbnQpDQo+ID4gPiA+ICAgICAgICAgICAgICAgIDB4MWYpOw0KPiA+ID4gPiAg
ICAgICAgIHNuZF9zb2NfY29tcG9uZW50X3dyaXRlKGNvbXBvbmVudCwNCj4gPiA+IFNHVEw1MDAw
X0NISVBfUEFEX1NUUkVOR1RILA0KPiA+ID4gPiByZWcpOw0KPiA+ID4gPg0KPiA+ID4gPiAtICAg
ICAgIHNuZF9zb2NfY29tcG9uZW50X3VwZGF0ZV9iaXRzKGNvbXBvbmVudCwNCj4gPiA+IFNHVEw1
MDAwX0NISVBfQU5BX0NUUkwsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICB6Y2RfbWFzaywgemNk
X21hc2spOw0KPiA+ID4gPiArICAgICAgIHNuZF9zb2NfY29tcG9uZW50X3dyaXRlKGNvbXBvbmVu
dCwNCj4gPiA+IFNHVEw1MDAwX0NISVBfQU5BX0NUUkwsDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIFNHVEw1MDAwX0hQX1pDRF9FTiB8DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIFNHVEw1MDAwX0FEQ19aQ0RfRU4pOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIHNu
ZF9zb2NfY29tcG9uZW50X3VwZGF0ZV9iaXRzKGNvbXBvbmVudCwNCj4gPiA+IFNHVEw1MDAwX0NI
SVBfTUlDX0NUUkwsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIFNHVEw1MDAwX0JJ
QVNfUl9NQVNLLA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjkuNQ0KPiA+ID4gPg0KPiA+ID4NCj4g
PiA+DQo+ID4gPiAtLQ0KPiA+ID4gQmVzdCByZWdhcmRzDQo+ID4gPiBPbGVrc2FuZHIgU3V2b3Jv
dg0KPiA+ID4NCj4gPiA+IFRvcmFkZXggQUcNCj4gPiA+IEFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0
OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUwMA0KPiA+ID4gNDgwMCAo
bWFpbiBsaW5lKQ0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoN
ClRvcmFkZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6
ZXJsYW5kIHwgVDogKzQxIDQxIDUwMA0KNDgwMCAobWFpbiBsaW5lKQ0K
