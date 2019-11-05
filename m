Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C6C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEB6214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7+sunXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfKEOWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:22:14 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:32832
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730816AbfKEOWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:22:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0rHdtTVMKny4Jca7/VkyIlJM2fhUcJvSLGHD9pipw3MQwfvBwHLd7nabcFsWrslYrRNL0rLHl/CWz+3ELd8MoXuT4TlRXkZg7aOVnhCjUy79HUsezqaH8dPAKMo+7+ytXf/UqJ3OeJwj4VlKXJ/CPsxAhB7BS+kzQkSkjKdUySf98bTRqsz++ufcZDI9KVFZIctivJurGS0/vE/XegpFc+kbUf9ji91fQ42+5exGft+PyLslWxFbaZXmk1Ke5lDmeSYQN4AlBEMNbMkmHLKLrkPoPw1uFAp+sSa5nvsl5jeMnAZ4U8GKPSjs94syl9sTs1m/APNgMqr5EbfL3K3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3ljcKIj5w48h05BWXVGar1IMX9K9P2DtItLixqQBYI=;
 b=jVtW3HPYH2CRuvs/tgNB7GIK9HlhpGF3zgwss0dqEPhbVuJU39W8fqS4UlvMFQcGQTIbCq0WG0j5RbXnnn53f8D/V21KMC3mwUId34KaDXI2iuGKSnJ5MR6DdqX7/XadEIZU64KKRDd8YzIEz4dafxbM+4Cg589EwB7ppxsp6uEe+tU+ms3yD1fIoSVft9na2yv57vGz/udNmDuURp8utleQpyh3QMRtcUr1zs+PhghsKy970QPPgDC9Q34aZ7ubfRdiWuxq7eDhUJV3YpT31D0ej2FJcSGl2jxW/76i3QASRUYtJwj7fwe5c3Fs9DjWTJbgRggPtFAlGPFoqsYTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3ljcKIj5w48h05BWXVGar1IMX9K9P2DtItLixqQBYI=;
 b=f7+sunXccqHNBS8BnGDIVmJmvyNkqJ7RCSXH/XLyzgEVpS49VQnOouufItFVLwHaggmlgQODusCxNwvWMOL4gDxdlisb8R2w1FvkXkRcL3RR+NZpxgn0eYlkU5hIhXZAUVfy9kNh7F6IVLFc5XPicHPkkbG9Zq9lqcmK4t1aSg8=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.175.24.138) by
 VI1PR0402MB3775.eurprd04.prod.outlook.com (52.134.13.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 14:22:10 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::749b:178a:b8c5:5aaa]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::749b:178a:b8c5:5aaa%11]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 14:22:10 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Thread-Topic: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Thread-Index: AQHVk9VvxsH2LOJbvkC7T6NABFcyUqd8kRCAgAAKtwCAAAVFAA==
Date:   Tue, 5 Nov 2019 14:22:10 +0000
Message-ID: <39cf7504-7599-83bb-4b53-5a25ff9240a8@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <20191105132435.GA2616182@kroah.com> <20191105140256.GB7189@lunn.ch>
In-Reply-To: <20191105140256.GB7189@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::25) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:b8::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3a1b361-8bbf-438a-6788-08d761fb8b68
x-ms-traffictypediagnostic: VI1PR0402MB3775:
x-microsoft-antispam-prvs: <VI1PR0402MB3775BAC13296DBBE539B49A3E07E0@VI1PR0402MB3775.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(446003)(71190400001)(486006)(186003)(81156014)(2616005)(36756003)(4326008)(8936002)(44832011)(6506007)(31696002)(5660300002)(53546011)(76176011)(31686004)(86362001)(7736002)(305945005)(81166006)(6486002)(6436002)(102836004)(52116002)(8676002)(229853002)(6116002)(99286004)(66476007)(66556008)(66946007)(71200400001)(25786009)(64756008)(66446008)(3846002)(2906002)(26005)(66066001)(386003)(478600001)(6512007)(6246003)(54906003)(256004)(14444005)(316002)(110136005)(476003)(14454004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3775;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJhV+slKkTH7/re7Dtja6Wuvp7hHUiDARl1NxyjiTv7rJG9T+SENNIceAH5C48E4IEKHMu3mmy2m3rH5VmcXjLtVIpz5/YnGUo+iJXoUsa4ujoO0L1+w60G3UQO9i0MlStn8y1em5kzYM/A0t876jwkigZUPcHGlV7VcqC0hydVpHENYujmbyl53WMEu5hQYp+dibXUuehHVnNrz/h2MGLJ9ff70CPmvIY4JzKwEdPrOePTzoDoIvz8sE50CRV/Fp0rfYy2xDB6veBhtz2T0dgA6AZy+Mgu+nxBWAcoiqTnqfWBXOBLcUQvx/+AH7SYLUtychqvYpz11ty0NOw1FGUTmSrzRMKnIsvoFjXWvCixqN1UZ6hfpNhLao9FC1piVI+F4VlON2L5Ow7D4Oge44eHHZonEQMYBK9f09SKg17+7ouStPmNU/CVlVIXCDTds
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A22860778B41141AB0FEDB561CDEAC4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1b361-8bbf-438a-6788-08d761fb8b68
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 14:22:10.1974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZ3ObT+F1913kdWI7NRmDkHW8MHj6hQgISV34OQBsaURhBKxzCvCWa33UKHZvJDjIZb7MnevRVY9FHCPnT2yQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMTEuMjAxOSAxNjowMywgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDA1
LCAyMDE5IGF0IDAyOjI0OjM1UE0gKzAxMDAsIEdyZWcgS0ggd3JvdGU6DQo+PiBPbiBUdWUsIE5v
diAwNSwgMjAxOSBhdCAwMjozNDoyM1BNICswMjAwLCBJb2FuYSBDaW9ybmVpIHdyb3RlOg0KPj4+
IFRoaXMgcGF0Y2ggc2V0IGFkZHMgc3VwcG9ydCBmb3IgUngvVHggY2FwYWJpbGl0aWVzIG9uIHN3
aXRjaCBwb3J0IGludGVyZmFjZXMuDQo+Pj4gQWxzbywgY29udHJvbCB0cmFmZmljIGlzIHJlZGly
ZWN0ZWQgdGhyb3VnaCBBQ0xzIHRvIHRoZSBDUFUgaW4gb3JkZXIgdG8NCj4+PiBlbmFibGUgcHJv
cGVyIFNUUCBwcm90b2NvbCBoYW5kbGluZy4NCj4gICANCj4+IEkgdGhvdWdodCBJIGFza2VkIGZv
ciBubyBuZXcgZmVhdHVyZXMgdW50aWwgdGhpcyBjb2RlIGdldHMgb3V0IG9mDQo+PiBzdGFnaW5n
PyAgT25seSB0aGVuIGNhbiB5b3UgYWRkIG5ldyBzdHVmZi4gIFBsZWFzZSB3b3JrIHRvIG1ha2Ug
dGhhdA0KPj4gaGFwcGVuIGZpcnN0Lg0KPiANCj4gSGkgR3JlZw0KPiANCj4gVGhpcyBpcyBpbiBy
ZXNwb25zZSB0byBteSByZXZpZXcgb2YgdGhlIGNvZGUgaW4gc3RhZ2luZy4gVGhlIGN1cnJlbnQN
Cj4gY29kZSBpcyBtaXNzaW5nIGEgY29yZSBmZWF0dXJlIGZvciBhbiBFdGhlcm5ldCBzd2l0Y2gg
ZHJpdmVyLCBiZWluZw0KPiBhYmxlIHRvIHNlbmQvcmVjZWl2ZSBmcmFtZXMgZnJvbSB0aGUgaG9z
dC4gQXQgdGhlIG1vbWVudCBpdCBjYW4gb25seQ0KPiBjb250cm9sIHRoZSBoYXJkd2FyZSBmb3Ig
aG93IGl0IHN3aXRjaGVzIEV0aGVybmV0IGZyYW1lcyBjb21pbmcNCj4gaW50by9nb2luZyBvdXQg
b2YgZXh0ZXJuYWwgcG9ydHMuDQo+IA0KPiBPbmUgb2YgdGhlIGNvcmUgaWRlYXMgYmVoaW5kIGhv
dyBsaW51eCBoYW5kbGVzIEV0aGVybmV0IHN3aXRjaGVzIGlzDQo+IHRoYXQgdGhleSBhcmUganVz
dCBhIGJ1bmNoIG9mIG5ldHdvcmsgaW50ZXJmYWNlcy4gQW5kIGN1cnJlbnRseSwgdGhlc2UNCj4g
bmV0d29yayBpbnRlcmZhY2VzIGNhbm5vdCBzZW5kL3JlY2VpdmUuIFdlIHdvdWxkIG5ldmVyIG1v
dmUgYW4NCj4gRXRoZXJuZXQgZHJpdmVyIG91dCBvZiBzdGFnaW5nIHdoaWNoIGNhbm5vdCBzZW5k
L3JlY2VpdmUsIHNvIGkgZG9uJ3QNCj4gc2VlIHdoeSB3ZSBzaG91bGQgbW92ZSBhbiBFdGhlcm5l
dCBzd2l0Y2ggZHJpdmVyIG91dCBvZiBzdGFnaW5nIHdoaWNoDQo+IGFsc28gY2Fubm90IHNlbmQv
cmVjZWl2ZS4NCj4gDQo+IE1heWJlIHRoaXMgcGF0Y2hzZXQgY291bGQgYmUgbWluaW1pc2VkLiBU
aGUgU1RQIGhhbmRsaW5nIGlzIGp1c3QgbmljZQ0KPiB0byBoYXZlLCBhbmQgY291bGQgd2FpdCB1
bnRpbCB0aGUgZHJpdmVyIGhhcyBtb3ZlZCBpbnRvIHRoZSBtYWluIHRyZWUuDQo+IA0KPiAgICAg
QW5kcmV3DQo+IA0KDQoNCkhpIEFuZHJldywNCg0KSnVzdCB0byBjbGFyaWZ5Li4uaWYgdGhlIFNU
UCBoYW5kbGluZyBpcyByZW1vdmVkLCB0aGVuIHdlJ2xsIGhhdmUgYSANCnJlY2VpdmUgY29kZSBw
YXRoIGJ1dCBubyBmcmFtZSB3aWxsIHJlYWNoIGl0Lg0KVGhpcyBpcyBiZWNhdXNlLCB0aGUgb25s
eSB3YXkgd2UgY291bGQgZGlyZWN0IHRyYWZmaWMgdG8gdGhlIENQVSBpcyBieSANCmFkZGluZyBh
biBBQ0wgcnVsZS4NCg0KSXMgdGhhdCBzb21ldGhpbmcgdGhhdCB0aGUgbmV0ZGV2IGNvbW11bml0
eSB3b3VsZCBtYXliZSBhY2NlcHQ/DQoNCklvYW5hDQoNCg0K
