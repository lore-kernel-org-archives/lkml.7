Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C918AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874702464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="DWrYZ4W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfLEPnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:43:55 -0500
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:47456
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfLEPnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:43:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ33A0aYd5KE27j7Vsg0//GAZNTZpRnIseE60LikuFyejogLXq4+fD8/6t7BM59/u5XTuQD+dylkIQJB6V9f/PrctBlyDJQLpIbk+gNSg1ZeEj1YMsX/fS1ZHDGQNUOtni07AQe2cR5TNC5Fcwoett0OfFGeMZ6g8RfXUXFZSznp66mKBiX8DwC7wSZ8kg7cXKHMQFao90wK2ukicsz8qi+YDVrEIdgVAd7Uve2jK0SQoWd5zC0+fPCStcLIAtXWlsdPS5eP+iiTjn/yClKBQBYciDMqufH8nkPHAMMegROMPdmFLtwWQO8Ud4wkRXNPoKr+lj9Dpdx1xonutwOj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPKHy/POoIjZCDM2QdQ/WfizrQ8vpv0sCNAwcPPgAz8=;
 b=nz3LfC7RzzTWz2b4/uLyXfyYynEghxIPKS0O0+J3tmGKZosa4wXxRu+8td+kg0PxQhiL8AwlIx9WwFqMvZcZSe/lqs4g369m8DCTFtlPdDUvUdwDkqIHvmJFaw46olp7maeexNOFMVVXdy9UgrMomL3NELf0eiOenoJiCWyh5kOpeDN50+3rWOzAh2nXO2BTgNbp4xsLzHQt5MDzvoyNBpZ/l1lcaXF+fFJ7LTqxRfoheH1vFI8rULTk+nWk+vhk4f1dmRQQfKb+YPGOIdyHQS88Sg3xaxu6N8jR26jl96anJBZVeoO8QsZqf76P9TKGSEy+Yictc9+LjuIphu6HMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPKHy/POoIjZCDM2QdQ/WfizrQ8vpv0sCNAwcPPgAz8=;
 b=DWrYZ4W9f8uTuF//b+aZ1sjoDINO/HsH7hnfIkv9REVGkMb8pZ2ZkqKeTRzKRaAx8WsSf9GBovS3yySopSf3fSetVI8KQHXslZtx4DTLm44pRJP9bHlrBA/06TW4UVTDF7vzcsxRCVgD5iQo8/Kb0v2iaHR4j3xR3k0yvGUSqdY=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3917.namprd11.prod.outlook.com (20.179.149.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 15:43:49 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::f46c:e5b4:2a85:f0bf%4]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:43:49 +0000
From:   =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix reset GPIO polarity
Thread-Topic: [PATCH] staging: wfx: fix reset GPIO polarity
Thread-Index: AQHVqsQ7GK4GtaETQkCLDhcnUtoexqerlV8AgAALi4CAAA8fAA==
Date:   Thu, 5 Dec 2019 15:43:49 +0000
Message-ID: <5226570.CMH5hVlZcI@pc-42>
References: <f9ebb05f4a13cce4a8724dfb17f8383ec9b2d468.1575478705.git.mirq-linux@rere.qmqm.pl>
 <3343657.nOMI9WY9u8@pc-42> <20191205144941.GA12859@qmqm.qmqm.pl>
In-Reply-To: <20191205144941.GA12859@qmqm.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f742e400-079b-4014-b860-08d77999ebf2
x-ms-traffictypediagnostic: MN2PR11MB3917:
x-microsoft-antispam-prvs: <MN2PR11MB39179145D1946F2729B81D46935C0@MN2PR11MB3917.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(366004)(346002)(39850400004)(376002)(189003)(199004)(26005)(186003)(5660300002)(76176011)(102836004)(66446008)(66476007)(66556008)(66946007)(71200400001)(316002)(64756008)(6486002)(86362001)(14444005)(14454004)(76116006)(99286004)(66574012)(71190400001)(85202003)(305945005)(85182001)(6916009)(33716001)(478600001)(6512007)(6506007)(2906002)(229853002)(4326008)(9686003)(8936002)(91956017)(25786009)(54906003)(81156014)(81166006)(8676002)(11346002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3917;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdWhSMeQWS39IFZJK29S0wzR/pVDZObMYE+hBao6hNz4pvudpcHPBhtMOhlxHeq19fch+wrSBxCSzNL7/NRg1ZpYn5rVpJIS8ifbZj0kFaUZEEZvuq6eKJdURborJK6QNOM/1yZq6vfNjuzvDMCPWl0MoogzqN1Jkfo+V/bcEdEmYBjiv4Ksc74L4m+marGQ5Ibi224HkXHefGU/GjI5unstn3ZjkQVnICHGevGP2d9eekcTfJ7eCFvMQ3a0ZXtCjAxyYVLuh69ndfbNKQXkqmcYD6/2a6HpJwognHhbVpVkzPHphijnI2yaEhmkf06XguCA8duJbWzOUNzvWXzPqDmmHYIMNIEYUQQSpxeXLGChxThIZjhyPKAoOQXZKvKGPMIbSu3vLFVw9DQg4aY4+zqrRecwWL2qcDHlvSDS8+74jPuAVHl4YMKg00XH0kQC049IUCe/CFUJaeSTDi39KOFYt72gibeIhfYBkFHeA6liHsEpja8VudG08Yra7IL5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C708DB317899C438719C4E2167849F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f742e400-079b-4014-b860-08d77999ebf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:43:49.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFCxz66K5OwHo0y9LybD424xeSlXy0I/LUKtppHH5aUo6RPsxYd5F8KyzIFhY1hrg79NamFKcJbInnR3yJIBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXkgNSBEZWNlbWJlciAyMDE5IDE1OjQ5OjU1IENFVCBNaWNoYcWCIE1pcm9zxYJh
dyB3cm90ZToNCj4gT24gVGh1LCBEZWMgMDUsIDIwMTkgYXQgMDI6MDg6MjNQTSArMDAwMCwgSsOp
csO0bWUgUG91aWxsZXIgd3JvdGU6DQo+ID4gT24gV2VkbmVzZGF5IDQgRGVjZW1iZXIgMjAxOSAx
Nzo1OTo0NiBDRVQgTWljaGHFgiBNaXJvc8WCYXcgd3JvdGU6DQo+ID4gPiBEcml2ZXIgaW52ZXJ0
cyBtZWFuaW5nIG9mIEdQSU9fQUNUSVZFX0xPVy9ISUdILiBGaXggaXQgdG8gcHJldmVudA0KPiA+
ID4gY29uZnVzaW9uLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PF
gmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMv
c3RhZ2luZy93ZngvYnVzX3NwaS5jIHwgNCArKy0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zdGFnaW5nL3dmeC9idXNfc3BpLmMgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19z
cGkuYw0KPiA+ID4gaW5kZXggYWIwY2RhMWUxMjRmLi43M2QwMTU3YTg2YmEgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2J1c19zcGkuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9idXNfc3BpLmMNCj4gPiA+IEBAIC0xOTksOSArMTk5LDkgQEAgc3RhdGlj
IGludCB3Znhfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5jKQ0KPiA+ID4gICAgICAg
ICBpZiAoIWJ1cy0+Z3Bpb19yZXNldCkgew0KPiA+ID4gICAgICAgICAgICAgICAgIGRldl93YXJu
KCZmdW5jLT5kZXYsICJ0cnkgdG8gbG9hZCBmaXJtd2FyZSBhbnl3YXlcbiIpOw0KPiA+ID4gICAg
ICAgICB9IGVsc2Ugew0KPiA+ID4gLSAgICAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZShidXMt
PmdwaW9fcmVzZXQsIDApOw0KPiA+ID4gLSAgICAgICAgICAgICAgIHVkZWxheSgxMDApOw0KPiA+
ID4gICAgICAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZShidXMtPmdwaW9fcmVzZXQsIDEpOw0K
PiA+ID4gKyAgICAgICAgICAgICAgIHVkZWxheSgxMDApOw0KPiA+ID4gKyAgICAgICAgICAgICAg
IGdwaW9kX3NldF92YWx1ZShidXMtPmdwaW9fcmVzZXQsIDApOw0KPiA+ID4gICAgICAgICAgICAg
ICAgIHVkZWxheSgyMDAwKTsNCj4gPiA+ICAgICAgICAgfQ0KPiA+IEhlbGxvIE1pY2hhxYIsDQo+
ID4NCj4gPiBJIGRpZCBub3QgZmluZCByZWFsIGNvbnNlbnN1cyBpbiBrZXJuZWwgY29kZS4gTXkg
cGVyc29uYWwgdGFzdGUgd291bGQNCj4gPiBiZSB0byBrZWVwIHRoaXMgZ3BpbyAiQUNUSVZFX0hJ
R0giIGFuZCByZW5hbWUgaXQgZ3Bpb19ucmVzZXQuIFdoYXQgZG8NCj4gPiB5b3UgdGhpbmsgYWJv
dXQgaXQ/DQo+ID4NCj4gPiAoaW4gYWRkLCB0aGlzIHNvbHV0aW9uIHdvdWxkIGV4cGxpY2l0bHkg
Y2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBEVA0KPiA+IGF0dHJpYnV0ZSBpbnN0ZWFkIG9mIGNoYW5n
aW5nIHRoZSBzZW1hbnRpYyBvZiB0aGUgZXhpc3RpbmcgYXR0cmlidXRlKQ0KPiANCj4gQXMgYSB1
c2VyIChib2FyZCBkZXZlbG9wZXIpIEkgd291bGQgZXhwZWN0IHRoYXQgRFQgZGVzY3JpYmVzIHRo
ZQ0KPiBHUElPIG1lYW5pbmcgZGlyZWN0bHk6IHNvIHdoZW4gSSBzcGVjaWZ5IEdQSU9fQUNUSVZF
X0hJR0ggZmxhZyBJIGFsc28NCj4gd2lyZSB1cCB0aGUgYm9hcmQgc28gdGhhdCBvdXRwdXRpbmcg
MSB3b3VsZCBtYXRjaCB0aGUgYWN0aXZlIHN0YXRlIG9mDQo+IHRoZSBjaGlwJ3Mgc2lnbmFsICh0
aGF0IG1pZ2h0IGJlIGludmVydGVkIGZvciBzb21lIHJlYXNvbikuIEkgdGhpbmsgd2UNCj4gc2hv
dWxkIHN0aWNrIHRvIHdoYXQgaXMgc2FpZCBpbiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZ3Bpby50eHQNCj4gKHNlY3Rpb24gMS4xKS4NCj4gDQo+IFNpbmNlIHRoaXMgaXMgYSBu
ZXcgZHJpdmVyIGluIGtlcm5lbCBJIHdvdWxkIHByZWZlciB0byBmaXggaXQgYXQgdGhlIHN0YXJ0
Lg0KPiBDaGFuZ2luZyB0aGUgbmFtZSBvZiB0aGUgR1BJTyB3b3VsZCBhbHNvIGJlIG9rLCBidXQg
c2luY2UgdGhlcmUgaXMgbm8gRFQNCj4gYmluZGluZyB5ZXQsIEkgZ3Vlc3MgdGhlcmUgd2lsbCBj
b21lIHVwIGFuIGlzc3VlIG9mICdjb21wYXRpYmxlJyBzdHJpbmcNCj4gZm9ybWF0IHRoYXQgZG9l
cyBub3QgbWF0Y2ggJ3ZlbmRvcixjaGlwJyBub3csIHNvIHdlIGNhbiB1c2UgdGhlIGRpZmZlcmVu
Y2UNCj4gZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdpdGggb3V0LW9mLXRyZWUgZHJpdmVy
IGlmIG5lZWRlZC4NCg0KQ3VycmVudCAnY29tcGF0aWJsZScgc3RyaW5nIGlzICJzaWxhYnMsd2Z4
LXNwaSIgKGZvciBub3csIGl0IGlzIHRoZQ0Kc2FtZSBmb3Igb3V0LW9mLXRyZWUgYW5kIGluLXRy
ZWUgZHJpdmVyKS4gQW5kIGluZGVlZCwgIndmeCIgZG9lcyBub3QNCm5hbWVzIGEgY2hpcC4NCg0K
VGhlIHRocmVlIGNoaXBzIGN1cnJlbnRseSBzdXBwb3J0ZWQgYXJlIHdmMjAwLCB3ZjIwMHMgYW5k
IHdmbTIwMC4gU2luY2UNCnRoZSBkcml2ZXIgcHJvdmlkZXMgRFQgYmluZGluZ3MgZm9yIFNQSSBh
bmQgU0RJTyBidXNlcywgSSB0aGluayB3ZQ0KaGF2ZSB0byBrZWVwIHRoZSAiLXNwaSIgc3VmZml4
LiBTbyBjb21wYXRpYmxlIHN0cmluZ3Mgc2hvdWxkIGJlDQoic2lsYWJzLHdmMjAwLXNwaSIsICJz
aWxhYnMsd2YyMDBzLXNwaSIgYW5kICJzaWxhYnMsd2ZtMjAwLXNwaSIsIHJpZ2h0Pw0KDQpTbyB3
ZSBjb3VsZCBmaXggdGhlIHNlbWFudGljIG9mIGdwaW9zLXJlc2V0IGFuZCBrZWVwIHRoZSBiYWNr
d2FyZA0KY29tcGF0aWJpbGl0eS4gTG9va3MgcGVyZmVjdC4NCg0KSSBjYW4gbWFrZSB0aGlzIGNo
YW5nZSBpbiBteSBuZXh0IHB1bGwtcmVxdWVzdCAoYnV0IGlmIHlvdSBzdWJtaXQgYQ0KcGF0Y2gs
IGl0IHdpbGwgcHJvYmFibHkgZ28gZmFzdGVyIDopICkuDQoNCi0tIA0KSsOpcsO0bWUgUG91aWxs
ZXINCg0K
