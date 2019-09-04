Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D56C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C1222CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="EiMCZvKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfIDIHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:07:55 -0400
Received: from mail-eopbgr60100.outbound.protection.outlook.com ([40.107.6.100]:10980
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728698AbfIDIHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:07:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGfgILCw9rOcXuK9DFMbfpYzqXUOfA2aM3vasJXrpeJO6ABGF1KNQ4P6QWKxZ1QFrMu1qHRsqwwNftB29xUK8DOCsRwo7N5AsTpjRXulIwBm4RiPSB54OA3m5T2NtLVkP0vp6BHnLAYCKT+HZ+9TqHVnSpzxisJxPsaYjp2lj406Km1pV617MKCKpFWHgy2YWc5RhpBXWY/4bG5UtcpHjFkcFFBdjCAa8Tn5c+6Vp/n+CeXQV9BWtVIq0x+cK05iodi9xHaL9GWOUwsw5+1EaaLOftzPkIe53s7uGqSy1FwfOFlqUOAF+xTsLdnqqUUuEIrY0PJFIgGxyA2u2nFcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A63fIizQuAoBE6Vfps4D4T5hv6kLRCDSoaUZ44rsJVI=;
 b=gAWaRypuvVhch/IuS0x/6Vzib1H6jWH1dQfajA0qIvWgX8ZEnU8Bl5mP+x6A+uJ8Yw/4L1ruoITwh9dRjcde1P7kNPaZ2FYM4Ko29vXzZn/PD0BxTJ1jSJIfTxOm4grxHApxmHUrkjMDc+kTYD+UDE7sYl/ZHNMIBTJXswBvtEVmoTEJwMOmSGnj5ZVYtKtfzhH8nZJWUqGTb1DPXtuFrt1ZWtHOa+ZGZg/RR5dgulFk238XhZ4geaUiraeqEN96RBso14hrIngb7/q2SbQhmVIBoxpVGvh9jSzO9mVQ/KpKK0sdu6nZYoGcgfsDdK7IfEEdBoFKKUTUzN59PG0iEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A63fIizQuAoBE6Vfps4D4T5hv6kLRCDSoaUZ44rsJVI=;
 b=EiMCZvKWm6CAlbQR44aK5Q4S/xcqYSvXV54B4mNBEarUU7v+wFFYJBQHyh6LoBHfhi4//Js/PTbWkW0TxGpKw8RnKCIDRP7bzpFTzOWy7aipc9frXcHx9wbzo44sdwhs/Bv8kY0k9OqUqgrPLlRAzYdjoH9PcYe+X77qHjxSifI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3936.eurprd05.prod.outlook.com (52.134.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Wed, 4 Sep 2019 08:07:48 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 08:07:48 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Topic: [PATCH 3/3] dt-bindings: regulator: add regulator-fixed-clock
 binding
Thread-Index: AQHVYi4eVTMHP4rOrkKfHmYdMpCNbKcZo3GAgAGH34A=
Date:   Wed, 4 Sep 2019 08:07:47 +0000
Message-ID: <e64429ba4b86411da1741ab54176fb5b4b7a36de.camel@toradex.com>
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
         <20190903080336.32288-4-philippe.schenker@toradex.com>
         <CAL_JsqLnqZ80soGVMvZjAMZvu+K=ebDUz2bM_ZodPp7YRvUnDw@mail.gmail.com>
In-Reply-To: <CAL_JsqLnqZ80soGVMvZjAMZvu+K=ebDUz2bM_ZodPp7YRvUnDw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7860de5c-6be2-4345-27b8-08d7310ef97e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3936;
x-ms-traffictypediagnostic: VI1PR0502MB3936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB39366F7860E521BCABBFDAADF4B80@VI1PR0502MB3936.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39840400004)(396003)(346002)(136003)(366004)(199004)(189003)(71200400001)(71190400001)(118296001)(476003)(6246003)(44832011)(486006)(25786009)(256004)(14444005)(36756003)(14454004)(8676002)(53936002)(7736002)(305945005)(6512007)(99286004)(4326008)(6486002)(229853002)(6436002)(446003)(2616005)(11346002)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(26005)(91956017)(76116006)(6506007)(186003)(2906002)(5660300002)(8936002)(86362001)(54906003)(102836004)(478600001)(76176011)(53546011)(6116002)(81156014)(3846002)(316002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3936;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: of/Xk0+TnPZyuGcyyiBhuq8DjiObqB9Z1WiuWjOzTNozCUlTbbIjuEfPhtND3p04/74SvfWA2xdnvl1JpkHkcVBrH1eFDVrElMUqs85tmvHHcJiCCZNdVRQ2CmsXfHCDXbvdTRFJRrjDDmBJoajzI/hRV0krBrw3KHrLwNhBdvfGK4py70tnFmgyYGUFK6mGheFigjeOB0PteNyNQzLChNzsFNM4yL+RkjmtGK6+WMJOavKN8ZNahhEjtKey93e7exO3oJg4uaXw+LFykngeyoHvaxUb3aZkA4lmqesdRfsHbGUhwzWQYv8AUqNWod0x5y5tVV1ASdxYeGTK7dzRcGv4qEBYBXtzI9XprqWWOAgXpjKfzNPM/VNYvzM7z/fQNRgPomvZMVvKVgWgcNUmJ67fQTSQjci1dNghSR1EPnQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F6969123F304048AF083CD716008E7C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7860de5c-6be2-4345-27b8-08d7310ef97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 08:07:47.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNyYxIUUC3Xbzg6povI7IMoZNNAUu32sN3PW9kHClF6uS3vYjfyDd/yE1thSrx/w0JKch3fW1gSwhir8CpMXgEn+9kclFxLaOvp9ch6vN+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTAzIGF0IDA5OjQ1ICswMTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBTZXAgMywgMjAxOSBhdCA5OjAzIEFNIFBoaWxpcHBlIFNjaGVua2VyDQo+IDxwaGls
aXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+ID4gVGhpcyBhZGRzIHRoZSBkb2N1
bWVudGF0aW9uIHRvIHRoZSBjb21wYXRpYmxlIHJlZ3VsYXRvci1maXhlZC1jbG9jaw0KPiANCj4g
UGxlYXNlIGV4cGxhaW4gd2hhdCB0aGF0IGlzIGluIHRoaXMgcGF0Y2guDQoNCkhpIFJvYiBhbmQg
dGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBJIHdpbGwgY2hhbmdlIHRoaXMgY29tbWl0IG1lc3Nh
Z2UNCmZvciBhIHBvc3NpYmxlIHYyIGludG8gdGhpczoNCg0KVGhpcyBhZGRzIHRoZSBkb2N1bWVu
dGF0aW9uIHRvIHRoZSBjb21wYXRpYmxlIHJlZ3VsYXRvci1maXhlZC1jbG9jay4NClRoaXMgYmlu
ZGluZyBpcyBhIHNwZWNpYWwgYmluZGluZyBvZiByZWd1bGF0b3ItZml4ZWQgYW5kIGFkZHMgdGhl
DQphYmlsaXR5IHRvIGFkZCBhIGNsb2NrIHRvIHJlZ3VsYXRvci1maXhlZCwgc28gdGhlIHJlZ3Vs
YXRvciBjYW4gYmUNCmVuYWJsZWQgYW5kIGRpc2FibGVkIHdpdGggdGhhdCBjbG9jay4NCklmIHRo
ZSBzcGVjaWFsIGNvbXBhdGlibGUgcmVndWxhdG9yLWZpeGVkLWNsb2NrIGlzIHVzZWQgaXQgaXMg
bWFuZGF0b3J5DQp0byBzdXBwbHkgYSBjbG9jay4NCg0KPiA+IA0KPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+
ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gIC4uLi9iaW5kaW5ncy9yZWd1bGF0b3IvZml4ZWQtcmVn
dWxhdG9yLnlhbWwgICAgfCAxOA0KPiA+ICsrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL2ZpeGVk
LQ0KPiA+IHJlZ3VsYXRvci55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3JlZ3VsYXRvci9maXhlZC0NCj4gPiByZWd1bGF0b3IueWFtbA0KPiA+IGluZGV4IGE2NTBiNDU3
MDg1ZC4uNWZkMDgxZTgwYjQzIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvZml4ZWQtDQo+ID4gcmVndWxhdG9yLnlhbWwNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL2ZpeGVkLQ0K
PiA+IHJlZ3VsYXRvci55YW1sDQo+ID4gQEAgLTE5LDkgKzE5LDE5IEBAIGRlc2NyaXB0aW9uOg0K
PiA+ICBhbGxPZjoNCj4gPiAgICAtICRyZWY6ICJyZWd1bGF0b3IueWFtbCMiDQo+ID4gDQo+ID4g
K3NlbGVjdDoNCj4gPiArICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgY29tcGF0aWJsZToNCj4gPiAr
ICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgY29uc3Q6IHJlZ3VsYXRvci1maXhlZC1jbG9j
aw0KPiA+ICsgIHJlcXVpcmVkOg0KPiA+ICsgICAgLSBjbG9ja3MNCj4gDQo+IFlvdSBkb24ndCBu
ZWVkIHRoaXMuDQo+IA0KPiBJZiB5b3UgYWRkIGEgbmV3IGNvbXBhdGlibGUsIHRoZW4gdGhpcyBz
aG91bGQgcHJvYmFibHkgYmUgYSBuZXcgc2NoZW1hDQo+IGRvYy4gSXMgdGhlICdncGlvJyBwcm9w
ZXJ0eSB2YWxpZCBpbiB0aGlzIGNhc2UgYXMgaWYgYSBjbG9jayBpcyB0aGUNCj4gZW5hYmxlLCBj
YW4geW91IGFsc28gaGF2ZSBhIGdwaW8gZW5hYmxlPyBUaGF0IHNhaWQsIGl0IHNlZW1zIGxpa2Ug
dGhlDQo+IG5ldyBjb21wYXRpYmxlIGlzIG9ubHkgZm9yIHZhbGlkYXRpbmcgdGhlIERUIGluIHRo
ZSBkcml2ZXIuIFlvdSBjb3VsZA0KPiBqdXN0IHVzZSBhIGNsb2NrIGlmIHByZXNlbnQgYW5kIGRl
ZmF1bHQgdG8gY3VycmVudCBiZWhhdmlvciBpZiBub3QuDQo+IEl0J3Mgbm90IHRoZSBrZXJuZWwn
cyBqb2IgdG8gdmFsaWRhdGUgRFRzLg0KDQpUaGUgZ3BpbyBwcm9wZXJ0eSBpcyB2YWxpZCB3aXRo
IHRoaXMgY29tcGF0aWJsZS4gSSBhZGRlZCByZWd1bGF0b3ItDQpmaXhlZC1jbG9jayB0byByZWd1
bGF0b3ItZml4ZWQgaGVuY2UgSSBhbHNvIGRvbid0IHdhbnQgdG8gY3JlYXRlIGEgbmV3DQpzY2hl
bWEgZmlsZS4NCg0KV2l0aCB0aGUgYWJvdmUgc2VsZWN0IHN0YXRlbWVudCBJIHdhbnRlZCB0byBz
dGF0ZSBjbG9ja3MgYXMgcmVxdWlyZWQNCndoZW4gdGhlIGNvbXBhdGlibGUgcmVndWxhdG9yLWZp
eGVkLWNsb2NrIGlzIGdpdmVuLg0KDQo+IA0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBh
dGlibGU6DQo+ID4gLSAgICBjb25zdDogcmVndWxhdG9yLWZpeGVkDQo+ID4gKyAgICBpdGVtczoN
Cj4gPiArICAgICAgLSBjb25zdDogcmVndWxhdG9yLWZpeGVkDQo+ID4gKyAgICAgIC0gY29uc3Q6
IHJlZ3VsYXRvci1maXhlZC1jbG9jaw0KPiANCj4gVGhpcyBzYXlzIHlvdSBtdXN0IGhhdmUgJ2Nv
bXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIiwNCj4gInJlZ3VsYXRvci1maXhlZC1jbG9jayI7
Jy4NCj4gDQo+IFdoYXQgeW91IHdhbnQgaXM6DQo+IA0KPiBlbnVtOg0KPiAgIC0gcmVndWxhdG9y
LWZpeGVkDQo+ICAgLSByZWd1bGF0b3ItZml4ZWQtY2xvY2sNCg0KVGhhbmtzLCB0aGlzIHdhcyBl
eGFjdGx5IHdoYXQgSSB3YW50ZWQgdG8gZG8uDQoNCj4gDQo+ID4gICAgcmVndWxhdG9yLW5hbWU6
IHRydWUNCj4gPiANCj4gPiBAQCAtMjksNiArMzksMTIgQEAgcHJvcGVydGllczoNCj4gPiAgICAg
IGRlc2NyaXB0aW9uOiBncGlvIHRvIHVzZSBmb3IgZW5hYmxlIGNvbnRyb2wNCj4gPiAgICAgIG1h
eEl0ZW1zOiAxDQo+ID4gDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+
ID4gKyAgICAgIGNsb2NrIHRvIHVzZSBmb3IgZW5hYmxlIGNvbnRyb2wuIFRoaXMgYmluZGluZyBp
cyBvbmx5DQo+ID4gYXZhaWxhYmxlIGlmDQo+ID4gKyAgICAgIHRoZSBjb21wYXRpYmxlIGlzIGNo
b3NlbiB0byByZWd1bGF0b3ItZml4ZWQtY2xvY2suIFRoZSBjbG9jaw0KPiA+IGJpbmRpbmcNCj4g
PiArICAgICAgaXMgbWFuZGF0b3J5IGlmIGNvbXBhdGlibGUgaXMgY2hvc2VuIHRvIHJlZ3VsYXRv
ci1maXhlZC0NCj4gPiBjbG9jay4NCj4gDQo+IE5lZWQgdG8gZGVmaW5lIGhvdyBtYW55IGNsb2Nr
cyAobWF4SXRlbXM6IDEpLg0KDQpXaWxsIGRvIGZvciBhIHBvc3NpYmxlIHYyLiBJIHdhbnQgdG8g
d2FpdCB3aGF0IE1hcmsgQnJvd24gc2F5cyBhYm91dCB0aGUNCmFkZGl0aW9uIGluIGdlbmVyYWws
IG1heWJlIEkgaGF2ZSB0byBjaGFuZ2UgYWxsIG92ZXIgaG93IHRoaXMgc3BlY2lhbGl0eQ0KaXMg
YWRkZWQgaW50byByZWd1bGF0b3Igc3Vic3lzdGVtIGFuZCB0aGVyZWZvcmUgYWxzbyB0aGUgYmlu
ZGluZyB3aWxsDQpjaGFuZ2UuDQoNClBoaWxpcHBlDQo+IA0KPiA+ICsNCj4gPiAgICBzdGFydHVw
LWRlbGF5LXVzOg0KPiA+ICAgICAgZGVzY3JpcHRpb246IHN0YXJ0dXAgdGltZSBpbiBtaWNyb3Nl
Y29uZHMNCj4gPiAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Vp
bnQzMg0KPiA+IC0tDQo+ID4gMi4yMy4wDQo+ID4gDQo=
