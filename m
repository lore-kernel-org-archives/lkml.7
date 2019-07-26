Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77425C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2CB2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LQz+4QgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGZDaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:30:03 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:29842
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfGZDaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:30:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwxS0bgX36ycN1x/VzYnkAGgZgiWl5A7fMjH57DwJaCm2LW/lUxh3KT1+tBGgTpiMzC2b/hzEQQmHLRpH8FfqUw4WqdBNobYz1/nPCX0uampPBV4neYNLkWaDhYyMeM6UcXfGKLRwO+anUW1NioPGdILVopyTD9OcZoYjFlMEa/zmChdSd5obSXLiHdgrUpMWWdjfU4jyM6nQXRSJ2kQDzbUAysUvT5bFZShZZIF4mXNvyYgQb4IwUl3eqrc0MEZDMyadX60sgaCV1VsIO2oXoGwYJD09j+JfFNCuaXhl8tYnMBV/TaGHxvxQQpA+QlaGDPkrRTXuPY5D8iu7LHuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30ybZcZYZ7Gg9RaQ5UBxXIiY3ecXscRBdDVG74npcNs=;
 b=K2nCgle87AGQAmZ3xeHwJbCV76noaLM7ZlGFvxbJ7Zg3/a5ph9HfpcQgvKGdmUZxFJhyzcgLHXjgiLZuRyNqZBcuE9EX4RwGeTNAh2ONuKkfV5bS1EB7SUDDeMdB2FDrswQeK1hEegH89Kfn1qeHusJTgjbOUmW5WiXwUYM1RHsVKqObdKX7/A5oqS3zGXDg41yHuSf9LsbdMX6VJr9EJ/oi3uFdZWV+KZFR0cfI9kVrFaO1x2Oo2EXqr9aHsh9VFCMZZwOstpukMSih4ykKqTytN7LDVEinOLkHmh5S5JaoEbFxY/d8wMI1wWvHig7RnL/Xbwmz3r0I3XDuw4cgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30ybZcZYZ7Gg9RaQ5UBxXIiY3ecXscRBdDVG74npcNs=;
 b=LQz+4QgW1ZoC38i/rnDR8x4s/sZO9opWcSUomsRTN5ocxEHpgL54RELvWptqexPObGO0/DXMzVJq8cjIH7OaO08fGZzXtgt736DdasPyncvBBEPFMgA1VyWntL6wU0+BeKmNGADmyjRmIm82V0VhSR33OdcPpewWAYr7m75HTbU=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB5914.eurprd04.prod.outlook.com (20.179.12.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 03:29:57 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::a5a4:22ca:7b9b:2d92]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::a5a4:22ca:7b9b:2d92%2]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 03:29:57 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Thread-Topic: [PATCH V2 1/2] usb: dwc3: Add node to update cache type setting
Thread-Index: AQHVOH5G67Ou1TF8sk6MaGtvp7Q7iKbaT5kAgABcbSCAAUpwgIAATItw
Date:   Fri, 26 Jul 2019 03:29:57 +0000
Message-ID: <DB8PR04MB68263E97EAF455751DB8506BF1C00@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190712064206.48249-1-ran.wang_1@nxp.com>
 <20190724204222.GA1234@bogus>
 <DB8PR04MB6826B4479A5A67A66025E89CF1C10@DB8PR04MB6826.eurprd04.prod.outlook.com>
 <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
In-Reply-To: <CAL_JsqKd=+0kXyUJkTZezMfcv-SQznzefi_0J0VjdsXcP8qZ5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8ecbbe-5a8c-4972-5d37-08d7117988c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB5914;
x-ms-traffictypediagnostic: DB8PR04MB5914:
x-microsoft-antispam-prvs: <DB8PR04MB59145740A724DDBD54E93248F1C00@DB8PR04MB5914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(6246003)(54906003)(2906002)(316002)(8936002)(4326008)(68736007)(81156014)(86362001)(102836004)(81166006)(8676002)(6436002)(71190400001)(74316002)(5660300002)(446003)(7696005)(305945005)(53546011)(7736002)(26005)(6506007)(53936002)(55016002)(33656002)(486006)(478600001)(71200400001)(66066001)(66446008)(66946007)(76116006)(66476007)(229853002)(3846002)(6116002)(25786009)(476003)(256004)(66556008)(6916009)(52536014)(99286004)(15650500001)(11346002)(14444005)(76176011)(14454004)(186003)(9686003)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5914;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: llu5logXBpmHtc3ZAgWwNiP4WyVTq2xHUkQP8EKVHUm+AXALXxAu9clu6F4bB8W7x/xMAL2Q/DbzPAXQDoEHF/7nIwyi2+FfcTLLEjw2ZDbUcIAJqQq46fHej2y3cX7Cze+c0MudfTwzJGOzA8Q5bWY6LHDU3MjbQm/Hbco/Yv2STqkPXGfoYtLNVn2gGZGKBzM7Ki+vNs7KSWcg7D+ViJseP1cmBEig19Cg7QDdD+tJsullpFfh/JsiCQznEYLzVNNGbcn5q6FeZxtdyjWopJgFBEFEJkTQELH16D1qqVFO8wM///7hUFOhnivITDFqt1yjZJnRIZjlba2d0NDAnfzuLlvR8MUpWdLLWBrVhVLdS7uvHcFCpRyELheQ3Jl1p60y/O6KtonxNOfomepxuTP4L7gziAjDur6CC3ETekQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8ecbbe-5a8c-4972-5d37-08d7117988c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 03:29:57.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXBlLA0KDQpPbiBGcmlkYXksIEp1bHkgMjYsIDIwMTkgMDU6NTYsIFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBKdWwgMjQsIDIwMTkgYXQg
ODoyOSBQTSBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhp
IFJvYiwNCj4gPg0KPiA+IE9uIFRodXJzZGF5LCBKdWx5IDI1LCAyMDE5IDA0OjQyIFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgSnVsIDEy
LCAyMDE5IGF0IDAyOjQyOjA1UE0gKzA4MDAsIFJhbiBXYW5nIHdyb3RlOg0KPiA+ID4gPiBTb21l
IExheWVyc2NhcGUgcGFsdGZvcm1zIChzdWNoIGFzIExTMTA4OEEsIExTMjA4OEEsIGV0YykNCj4g
PiA+ID4gZW5jb3VudGVyIFVTQiBkZXRlY3QgZmFpbHVlcyB3aGVuIGFkZGluZyBkbWEtY29oZXJl
bnQgdG8gRFdDMw0KPiA+ID4gPiBub2RlLiBUaGlzIGlzIGJlY2F1c2UgdGhlIEhXIGRlZmF1bHQg
Y2FjaGUgdHlwZSBjb25maWd1cmF0aW9uIG9mDQo+ID4gPiA+IHRob3NlIFNvQyBhcmUgbm90IHJp
Z2h0LCBuZWVkIHRvIGJlIHVwZGF0ZWQgaW4gRFRTLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gQ2hhbmdlIGluIHYyOg0KPiA+ID4gPiAgICAgLSBOZXcgZmlsZS4NCj4gPiA+ID4NCj4gPiA+
ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQgfCA0Mw0K
PiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQzIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQNCj4gPiA+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3YzMudHh0DQo+ID4gPiA+IGluZGV4
IDhlNTI2NWUuLjdiYzFjZWYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMy50eHQNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MzLnR4dA0KPiA+ID4gPiBAQCAtMTEwLDYgKzEx
MCw0MyBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiAgIC0gaW4gYWRkaXRpb24gYWxs
IHByb3BlcnRpZXMgZnJvbSB1c2IteGhjaS50eHQgZnJvbSB0aGUgY3VycmVudCBkaXJlY3Rvcnkg
YXJlDQo+ID4gPiA+ICAgICBzdXBwb3J0ZWQgYXMgd2VsbA0KPiA+ID4gPg0KPiA+ID4gPiArKiBD
YWNoZSB0eXBlIG5vZGVzIChvcHRpb25hbCkNCj4gPiA+ID4gKw0KPiA+ID4gPiArVGhlIENhY2hl
IHR5cGUgbm9kZSBpcyB1c2VkIHRvIHRlbGwgaG93IHRvIGNvbmZpZ3VyZSBjYWNoZSB0eXBlDQo+
ID4gPiA+ICtvbiA0IGRpZmZlcmVudCB0cmFuc2ZlciB0eXBlczogRGF0YSBSZWFkLCBEZXNjIFJl
YWQsIERhdGEgV3JpdGUNCj4gPiA+ID4gK2FuZCBEZXNjIHdyaXRlLiBGb3IgZWFjaCB0cmVhc2Zl
ciB0eXBlLCBjb250cm9sbGVyIGhhcyBhIDQtYml0DQo+ID4gPiA+ICtyZWdpc3RlciBmaWVsZCB0
byBlbmFibGUgZGlmZmVyZW50IGNhY2hlIHR5cGUuIFF1b3RlZCBmcm9tIERXQzMNCj4gPiA+ID4g
K2RhdGEgYm9vayBUYWJsZSA2LTUNCj4gPiA+IENhY2hlIFR5cGUgQml0IEFzc2lnbm1lbnRzOg0K
PiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiArTUJVU19UWVBFfCBiaXRbM10gICAgICAgfGJpdFsy
XSAgICAgICB8Yml0WzFdICAgICB8Yml0WzBdDQo+ID4gPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICtB
SEIgICAgICB8Q2FjaGVhYmxlICAgICB8QnVmZmVyYWJsZSAgIHxQcml2aWxlZ2dlIHxEYXRhDQo+
ID4gPiA+ICtBWEkzICAgICB8V3JpdGUgQWxsb2NhdGV8UmVhZCBBbGxvY2F0ZXxDYWNoZWFibGUg
IHxCdWZmZXJhYmxlDQo+ID4gPiA+ICtBWEk0ICAgICB8QWxsb2NhdGUgT3RoZXJ8QWxsb2NhdGUg
ICAgIHxNb2RpZmlhYmxlIHxCdWZmZXJhYmxlDQo+ID4gPiA+ICtBWEk0ICAgICB8T3RoZXIgQWxs
b2NhdGV8QWxsb2NhdGUgICAgIHxNb2RpZmlhYmxlIHxCdWZmZXJhYmxlDQo+ID4gPiA+ICtOYXRp
dmUgICB8U2FtZSBhcyBBWEkgICB8U2FtZSBhcyBBWEkgIHxTYW1lIGFzIEFYSXxTYW1lIGFzIEFY
SQ0KPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiArTm90ZTogVGhlIEFIQiwgQVhJMywgQVhJNCwg
YW5kIFBDSWUgYnVzc2VzIHVzZSBkaWZmZXJlbnQgbmFtZXMNCj4gPiA+ID4gK2ZvciBjZXJ0YWlu
IHNpZ25hbHMsIHdoaWNoIGhhdmUgdGhlIHNhbWUgbWVhbmluZzoNCj4gPiA+ID4gKyAgQnVmZmVy
YWJsZSA9IFBvc3RlZA0KPiA+ID4gPiArICBDYWNoZWFibGUgPSBNb2RpZmlhYmxlID0gU25vb3Ag
KG5lZ2F0aW9uIG9mIE5vIFNub29wKQ0KPiA+ID4NCj4gPiA+IFRoaXMgc2hvdWxkIGFsbCBiZSBp
bXBsaWVkIGZyb20gdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlIHN0cmluZ3MuDQo+ID4NCj4g
PiBEaWQgeW91IG1lYW4gSSBjb3VsZCBpbXBsZW1lbnQgYSBzb2MgZHJpdmVyIHdoaWNoIGNhbiBi
ZSBtYXRjaGVkIGJ5DQo+IGNvbXBhdGlibGUgb2YgJ2ZzbCxsczEwODhhLWR3YzMnIHdoaWNoIHdp
bGwgcGFzcyBrbm93biBidXMgdHlwZSB0byBEV0MzIGRyaXZlcj8NCj4gSWYgeWVzLCBob3cgdG8g
cGFzcz8NCj4gDQo+IFllcy4gVGhlIERUIG1hdGNoIHRhYmxlIGNhbiBoYXZlIGRhdGEgYXNzb2Np
YXRlZCB3aXRoIHRoYXQgY29tcGF0aWJsZSBzdHJpbmcuDQo+IEJleW9uZCB0aGF0LCBJJ20gbm90
IHJlYWxseSBmYW1pbGlhciB3aXRoIHRoZSBEV0MzIGRyaXZlci4NCg0KRG8geW91IGhhdmUgYW55
IHN1Z2dlc3Rpb24gaGVyZT8NCklmIEkgYWRkIGEgZ2x1ZSBkcml2ZXIgb24gRFdDMyBjb3JlIGRy
aXZlciAoSSBrbm93IHlvdSBhcmUgbm90IGhhcHB5IG9uIHRoaXMgd2F5KSwgSSBkb24ndA0Ka25v
dyBob3cgdG8gcGFzcyB0aGUgTUJVU19UWVBFIGluZm8uIGZyb20gbXkgZ2x1ZSBkcml2ZXIgdG8g
RFdDMyBjb3JlIGRyaXZlciAoSSB0aGluayBjYWNoZQ0KdHlwZSByZWxhdGVkIHByb2dyYW1taW5n
IHNob3VsZCBiZSBkb25lIGJ5IERXQzMgY29yZSBkcml2ZXIsIGFtIEkgcmlnaHQ/KQ0KDQpUaGFu
a3MNClJhbg0K
