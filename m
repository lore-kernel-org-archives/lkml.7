Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6322173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="an0SUNwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1Bv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:51:59 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:4870
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfH1Bv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrVnvch4NwfDfrOkvOtJs1JXhbarpcDDwtiPiqEGols6r8OayG4lJ68u3kQQnmEP7MLyHrtXEo0n83P2rf6uuGTq1Wgeh7beoQn2mM1FSW1xjxvdGWWKWk/hPPMee7WwqnGfsfMkM6+iFUIrPBaTdnB7f4NbUHfEXHpyK0dkUGF5gVVTJRiLH9+uhz8aun+fGxsubD9un2rTUqPzk6SbQR27kH6yUCE7JH7Z8S7CX2ls3K4b7/uTFCZ94Q75FgAM2q44UQBfuVHvoIOD0vY746d3DqQs/cBNRKhbeRe74vyul6CGim+xTlHLKAGhQJysUmxaG8GoSxQ7x7MLvVAgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UrvAGFiojcbRDmomNtNjcS5a4yioFXgy8bWFKU0qLg=;
 b=KYDpzYUsbGQO9gsCWkMv6rI1Sfn2aBvE/fBL/xoxDofwSpFXsegp2hgtQEu1/fgwTJbW6cALqsfZa/32YnT1uDehSX5yRgAXzrrLZcYhvtpgSvCe7jS0B0WvOpYuyMIc8nvFqnGKbqbDHm5iQfB4/3cIqPOl/puscldQgeTamWDXcx1RTlhAXw5BdP5NEQS0eNazLQCwLrBhEqbQMFUYMWAyfQsVrNcO3W8lIGwf/qIEG/d8I5Gvpfx556tR+Wg+pvCnRP6HTCFzn5jXH59lqdNJijZcomMrm8ClVfZd8IYZncLn2y5ppcfD+DW5HgnLS54tr97snd+jTr/cL1tORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UrvAGFiojcbRDmomNtNjcS5a4yioFXgy8bWFKU0qLg=;
 b=an0SUNwU0I7qiPh3/RmACrSpdOWjw1h5fLdP5MwvF8ZcdjTH/EMNsVAMfsJXo7fOOWFI1J4RuzBUIe9ILtlWqfHG1SH4KTsHAQ5Ik7RElNiAZ1Z7RVSoBw39M7Z8xSa+ZK17owoSUlS/450Zz+ShMLayJdbLcoQNeOeudO3MlfE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5939.eurprd04.prod.outlook.com (20.178.112.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 01:51:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Wed, 28 Aug 2019
 01:51:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v4 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXL0PhcurV8c5rUCEm7J1Y5VZmqcO+QqAgADTabA=
Date:   Wed, 28 Aug 2019 01:51:54 +0000
Message-ID: <AM0PR04MB44813D2F6CCC3211F9AAE56788A30@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1566942646-18015-1-git-send-email-peng.fan@nxp.com>
 <1566942646-18015-2-git-send-email-peng.fan@nxp.com>
 <CAL_JsqK7xPTYFzSXt52m+Z0LRcFy2TUfa45XzY1YGH0-JRA-WQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK7xPTYFzSXt52m+Z0LRcFy2TUfa45XzY1YGH0-JRA-WQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31af3159-3af8-412a-b4fb-08d72b5a4d96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5939;
x-ms-traffictypediagnostic: AM0PR04MB5939:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5939E7F0C5A15ED2AA66F51388A30@AM0PR04MB5939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(71190400001)(316002)(54906003)(14444005)(305945005)(256004)(25786009)(4326008)(7736002)(8936002)(5660300002)(14454004)(33656002)(8676002)(81156014)(81166006)(6506007)(45080400002)(6246003)(53546011)(102836004)(74316002)(53936002)(6436002)(476003)(44832011)(478600001)(71200400001)(99286004)(76176011)(7696005)(86362001)(446003)(6116002)(229853002)(3846002)(26005)(186003)(2906002)(76116006)(66446008)(64756008)(66556008)(66946007)(52536014)(66066001)(55016002)(11346002)(6306002)(15650500001)(486006)(9686003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5939;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vZMrgU0KK0ZVxDuBMKcLU0tJYYkAm2BBS3+Z0KKV196Otr7dscfAotlfSmDWRkCgj4E8y1q2uEuZE2y0LXkyjn3n00tFoHG+5qAtZxyeXW/77Nr8jaPzgNbLuPyT4cGNuOC/1cHrsAa9i8yA2Huf44kxhq+/jBwPLjMII6L/VSh0TTEZB+Sy6yslS0Rt8QIDNmKYjRoC2deozzHDNKeTLkI838H+eEVXSDOCtatjhQv1wHqD07v7l9VyEnsc3Rl9zLXHSKhfpYpay8pwCKMmsXI5MMxBXxOzOUBGd1DE7EPF5A3lfXWhiz+Q4B5w9GsXWZNUWOHErLQIO4tXBl5RVN/em24Sxk+g6f5OZsTHy5eXmhi6mAE6QFqZ6gG+nvW4jRwegBdBNu/Brodotxno29c5yjAphiBlF0iRB2mUeX0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31af3159-3af8-412a-b4fb-08d72b5a4d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 01:51:54.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqVmPnd9Ym2ulPtqsOqD19UNnKL1yiyW2mRZbHo5CHzcfEpK+buDsmCYm1GvtJJD4JZv0JJA2J6zLpaDM55Sbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8yXSBkdC1iaW5kaW5nczogbWFp
bGJveDogYWRkIGJpbmRpbmcgZG9jIGZvciB0aGUgQVJNDQo+IFNNQy9IVkMgbWFpbGJveA0KPiAN
Cj4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgNDo1MSBBTSBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4N
Cj4gPg0KPiA+IFRoZSBBUk0gU01DL0hWQyBtYWlsYm94IGJpbmRpbmcgZGVzY3JpYmVzIGEgZmly
bXdhcmUgaW50ZXJmYWNlIHRvDQo+ID4gdHJpZ2dlciBhY3Rpb25zIGluIHNvZnR3YXJlIGxheWVy
cyBydW5uaW5nIGluIHRoZSBFTDIgb3IgRUwzIGV4Y2VwdGlvbiBsZXZlbHMuDQo+ID4gVGhlIHRl
cm0gIkFSTSIgaGVyZSByZWxhdGVzIHRvIHRoZSBTTUMgaW5zdHJ1Y3Rpb24gYXMgcGFydCBvZiB0
aGUgQVJNDQo+ID4gaW5zdHJ1Y3Rpb24gc2V0LCBub3QgYXMgYSBzdGFuZGFyZCBlbmRvcnNlZCBi
eSBBUk0gTHRkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJt
LXNtYy55YW1sICAgICAgIHwgMTI2DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTI2IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+
ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLXNtYy55YW1s
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21haWxib3gvYXJtLXNtYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWFpbGJveC9hcm0tc21jLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uYWU2NzdlMGMwOTEwDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2FybS1zbWMu
eWFtbA0KPiA+IEBAIC0wLDAgKzEsMTI2IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICsk
aWQ6DQo+ID4gK2h0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwJTNBJTJGJTJGZGV2aQ0KPiA+DQo+ICtjZXRyZWUub3JnJTJGc2NoZW1hcyUyRm1h
aWxib3glMkZhcm0tc21jLnlhbWwlMjMmYW1wO2RhdGE9MDIlNw0KPiBDMDElN0NwDQo+ID4NCj4g
K2VuZy5mYW4lNDBueHAuY29tJTdDMGU5MDVmM2ZlODliNGRjOWVlMDYwOGQ3MmFmMDZlMzAlN0M2
ODZlYTFkDQo+IDNiYzJiNGMNCj4gPg0KPiArNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2
MzcwMjUwODQ0NTg5NjQ3NjEmYW1wO3NkYXRhPXA4DQo+IEVlRmtVNXBXMw0KPiA+ICtEOGJ6cFp1
OUlIQ29GRCUyRjJaQmNTcjZXeUNzSUs5THFVJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4gKyRzY2hl
bWE6DQo+ID4gK2h0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwJTNBJTJGJTJGZGV2aQ0KPiA+DQo+ICtjZXRyZWUub3JnJTJGbWV0YS1zY2hlbWFz
JTJGY29yZS55YW1sJTIzJmFtcDtkYXRhPTAyJTdDMDElN0NwZQ0KPiBuZy5mYW4lDQo+ID4NCj4g
KzQwbnhwLmNvbSU3QzBlOTA1ZjNmZTg5YjRkYzllZTA2MDhkNzJhZjA2ZTMwJTdDNjg2ZWExZDNi
YzJiNGM2DQo+IGZhOTJjZDkNCj4gPg0KPiArOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MDI1MDg0
NDU4OTY0NzYxJmFtcDtzZGF0YT1KRmh6N21lRnlHDQo+IG96TUxudDRKYg0KPiA+ICtSR25lWXR5
NmNCU0NLeXhIcGwyNlRBc0klM0QmYW1wO3Jlc2VydmVkPTANCj4gPiArDQo+ID4gK3RpdGxlOiBB
Uk0gU01DIE1haWxib3ggSW50ZXJmYWNlDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiAr
ICAtIFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246
IHwNCj4gPiArICBUaGlzIG1haWxib3ggdXNlcyB0aGUgQVJNIHNtYyAoc2VjdXJlIG1vbml0b3Ig
Y2FsbCkgYW5kIGh2Yw0KPiA+ICsoaHlwZXJ2aXNvcg0KPiA+ICsgIGNhbGwpIGluc3RydWN0aW9u
IHRvIHRyaWdnZXIgYSBtYWlsYm94LWNvbm5lY3RlZCBhY3Rpdml0eSBpbg0KPiA+ICtmaXJtd2Fy
ZSwNCj4gPiArICBleGVjdXRpbmcgb24gdGhlIHZlcnkgc2FtZSBjb3JlIGFzIHRoZSBjYWxsZXIu
IEJ5IG5hdHVyZSB0aGlzDQo+ID4gK29wZXJhdGlvbg0KPiA+ICsgIGlzIHN5bmNocm9ub3VzIGFu
ZCB0aGlzIG1haWxib3ggcHJvdmlkZXMgbm8gd2F5IGZvciBhc3luY2hyb25vdXMNCj4gPiArbWVz
c2FnZXMNCj4gPiArICB0byBiZSBkZWxpdmVyZWQgdGhlIG90aGVyIHdheSByb3VuZCwgZnJvbSBm
aXJtd2FyZSB0byB0aGUgT1MsIGJ1dA0KPiA+ICsgIGFzeW5jaHJvbm91cyBub3RpZmljYXRpb24g
Y291bGQgYWxzbyBiZSBzdXBwb3J0ZWQuIEhvd2V2ZXIgdGhlDQo+ID4gK3ZhbHVlIG9mDQo+ID4g
KyAgcjAvdzAveDAgdGhlIGZpcm13YXJlIHJldHVybnMgYWZ0ZXIgdGhlIHNtYyBjYWxsIGlzIGRl
bGl2ZXJlZCBhcyBhDQo+ID4gK3JlY2VpdmVkDQo+ID4gKyAgbWVzc2FnZSB0byB0aGUgbWFpbGJv
eCBmcmFtZXdvcmssIHNvIGEgc3luY2hyb25vdXMgY29tbXVuaWNhdGlvbg0KPiA+ICtjYW4gYmUN
Cj4gPiArICBlc3RhYmxpc2hlZCwgZm9yIGEgYXN5bmNocm9ub3VzIG5vdGlmaWNhdGlvbiwgbm8g
dmFsdWUgd2lsbCBiZSByZXR1cm5lZC4NCj4gPiArICBUaGUgZXhhY3QgbWVhbmluZyBvZiBib3Ro
IHRoZSBhY3Rpb24gdGhlIG1haWxib3ggdHJpZ2dlcnMgYXMgd2VsbA0KPiA+ICthcyB0aGUNCj4g
PiArICByZXR1cm4gdmFsdWUgaXMgZGVmaW5lZCBieSB0aGVpciB1c2VycyBhbmQgaXMgbm90IHN1
YmplY3QgdG8gdGhpcyBiaW5kaW5nLg0KPiA+ICsNCj4gPiArICBPbmUgdXNlIGNhc2Ugb2YgdGhp
cyBtYWlsYm94IGlzIHRoZSBTQ01JIGludGVyZmFjZSwgd2hpY2ggdXNlcw0KPiA+ICsgc2hhcmVk
IG1lbW9yeSAgdG8gdHJhbnNmZXIgY29tbWFuZHMgYW5kIHBhcmFtZXRlcnMsIGFuZCBhIG1haWxi
b3gNCj4gdG8NCj4gPiArIHRyaWdnZXIgYSBmdW5jdGlvbiAgY2FsbC4gVGhpcyBhbGxvd3MgU29D
cyB3aXRob3V0IGEgc2VwYXJhdGUNCj4gPiArIG1hbmFnZW1lbnQgcHJvY2Vzc29yIChvciB3aGVu
ICBzdWNoIGEgcHJvY2Vzc29yIGlzIG5vdCBhdmFpbGFibGUgb3INCj4gPiArIHVzZWQpIHRvIHVz
ZSB0aGlzIHN0YW5kYXJkaXplZCAgaW50ZXJmYWNlIGFueXdheS4NCj4gPiArDQo+ID4gKyAgVGhp
cyBiaW5kaW5nIGRlc2NyaWJlcyBubyBoYXJkd2FyZSwgYnV0IGVzdGFibGlzaGVzIGEgZmlybXdh
cmUNCj4gaW50ZXJmYWNlLg0KPiA+ICsgIFVwb24gcmVjZWl2aW5nIGFuIFNNQyB1c2luZyBvbmUg
b2YgdGhlIGRlc2NyaWJlZCBTTUMgZnVuY3Rpb24NCj4gPiArIGlkZW50aWZpZXJzLCAgdGhlIGZp
cm13YXJlIGlzIGV4cGVjdGVkIHRvIHRyaWdnZXIgc29tZSBtYWlsYm94IGNvbm5lY3RlZA0KPiBm
dW5jdGlvbmFsaXR5Lg0KPiA+ICsgIFRoZSBjb21tdW5pY2F0aW9uIGZvbGxvd3MgdGhlIEFSTSBT
TUMgY2FsbGluZyBjb252ZW50aW9uLg0KPiA+ICsgIEZpcm13YXJlIGV4cGVjdHMgYW4gU01DIGZ1
bmN0aW9uIGlkZW50aWZpZXIgaW4gcjAgb3IgdzAuIFRoZQ0KPiA+ICsgc3VwcG9ydGVkICBpZGVu
dGlmaWVycyBhcmUgcGFzc2VkIGZyb20gY29uc3VtZXJzLCBvciBsaXN0ZWQgaW4gdGhlDQo+ID4g
KyB0aGUgYXJtLGZ1bmMtaWRzICBwcm9wZXJ0aWVzIGFzIGRlc2NyaWJlZCBiZWxvdy4gVGhlIGZp
cm13YXJlIGNhbg0KPiA+ICsgcmV0dXJuIG9uZSB2YWx1ZSBpbiAgdGhlIGZpcnN0IFNNQyByZXN1
bHQgcmVnaXN0ZXIsIGl0IGlzIGV4cGVjdGVkDQo+ID4gKyB0byBiZSBhbiBlcnJvciB2YWx1ZSwg
IHdoaWNoIHNoYWxsIGJlIHByb3BhZ2F0ZWQgdG8gdGhlIG1haWxib3ggY2xpZW50Lg0KPiA+ICsN
Cj4gPiArICBBbnkgY29yZSB3aGljaCBzdXBwb3J0cyB0aGUgU01DIG9yIEhWQyBpbnN0cnVjdGlv
biBjYW4gYmUgdXNlZCwgYXMNCj4gPiArIGxvbmcgYXMgIGEgZmlybXdhcmUgY29tcG9uZW50IHJ1
bm5pbmcgaW4gRUwzIG9yIEVMMiBpcyBoYW5kbGluZyB0aGVzZQ0KPiBjYWxscy4NCj4gPiArDQo+
ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBhcm0s
c21jLW1ib3gNCj4gPiArDQo+ID4gKyAgIiNtYm94LWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAx
DQo+ID4gKw0KPiA+ICsgIGFybSxudW0tY2hhbnM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhl
IG51bWJlciBvZiBjaGFubmVscyBzdXBwb3J0ZWQuDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAg
ICBtaW5pbXVtOiAxDQo+ID4gKyAgICAgbWF4aW11bTogNDA5NiAjIFNob3VsZCBiZSBlbm91Z2g/
DQo+ID4gKw0KPiA+ICsgIG1ldGhvZDoNCj4gPiArICAgIGl0ZW1zOg0KPiANCj4gWW91IGNhbiBk
cm9wICdpdGVtcycgYXMgdGhpcyBpcyBhIHNpbmdsZSBlbnRyeS4NCg0KV2lsbCBmaXggaW4gdjUu
DQoNCj4gDQo+ID4gKyAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0gc21jDQo+ID4gKyAg
ICAgICAgICAtIGh2Yw0KPiA+ICsNCj4gPiArICB0cmFuc3BvcnRzOg0KPiA+ICsgICAgaXRlbXM6
DQo+IA0KPiBzYW1lIGhlcmUNCg0KRml4IGluIHY1Lg0KDQo+IA0KPiA+ICsgICAgICAtIGVudW06
DQo+ID4gKyAgICAgICAgICAtIG1lbQ0KPiA+ICsgICAgICAgICAgLSByZWcNCj4gPiArDQo+ID4g
KyAgYXJtLGZ1bmMtaWRzOg0KPiANCj4gTmVlZHMgYSAkcmVmIHRvIGEgdHlwZSAodWludDMyLWFy
cmF5KS4NCg0KRml4IGluIHY1Lg0KDQo+IA0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiAr
ICAgICAgQW4gYXJyYXkgb2YgMzItYml0IHZhbHVlcyBzcGVjaWZ5aW5nIHRoZSBmdW5jdGlvbiBJ
RHMgdXNlZCBieSBlYWNoDQo+ID4gKyAgICAgIG1haWxib3ggY2hhbm5lbC4gVGhvc2UgZnVuY3Rp
b24gSURzIGZvbGxvdyB0aGUgQVJNIFNNQyBjYWxsaW5nDQo+ID4gKyAgICAgIGNvbnZlbnRpb24g
c3RhbmRhcmQgWzFdLg0KPiA+ICsNCj4gPiArICAgICAgVGhlcmUgaXMgb25lIGlkZW50aWZpZXIg
cGVyIGNoYW5uZWwgYW5kIHRoZSBudW1iZXIgb2Ygc3VwcG9ydGVkDQo+ID4gKyAgICAgIGNoYW5u
ZWxzIGlzIGRldGVybWluZWQgYnkgdGhlIGxlbmd0aCBvZiB0aGlzIGFycmF5Lg0KPiA+ICsgICAg
bWluSXRlbXM6IDANCj4gPiArICAgIG1heEl0ZW1zOiA0MDk2ICAgIyBTaG91bGQgYmUgZW5vdWdo
Pw0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSAi
I21ib3gtY2VsbHMiDQo+ID4gKyAgLSBhcm0sbnVtLWNoYW5zDQo+ID4gKyAgLSB0cmFuc3BvcnRz
DQo+ID4gKyAgLSBtZXRob2QNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+
ICsgICAgc3JhbUA5MTAwMDAgew0KPiA+ICsgICAgICBjb21wYXRpYmxlID0gIm1taW8tc3JhbSI7
DQo+ID4gKyAgICAgIHJlZyA9IDwweDAgMHg5M2YwMDAgMHgwIDB4MTAwMD47DQo+ID4gKyAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
PiArICAgICAgcmFuZ2VzID0gPDAgMHgwIDB4OTNmMDAwIDB4MTAwMD47DQo+ID4gKw0KPiA+ICsg
ICAgICAgIGNwdV9zY3BfbHByaTogc2NwLXNobWVtQDAgew0KPiANCj4gTG9va3MgbGlrZSBzb21l
IGluZGVudGF0aW9uIHByb2JsZW0uLi4NCg0KRml4IGluIHY1Lg0KDQo+IA0KPiA+ICsgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJhcm0sc2NtaS1zaG1lbSI7DQo+ID4gKyAgICAgICAgICByZWcgPSA8
MHgwIDB4MjAwPjsNCj4gPiArICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICBjcHVfc2Nw
X2hwcmk6IHNjcC1zaG1lbUAyMDAgew0KPiA+ICsgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0s
c2NtaS1zaG1lbSI7DQo+ID4gKyAgICAgICAgICByZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiA+ICsg
ICAgICAgIH07DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiArICAgIGZpcm13YXJlIHsNCj4gPiAr
ICAgICAgc21jX21ib3g6IG1haWxib3ggew0KPiA+ICsgICAgICAgICNtYm94LWNlbGxzID0gPDE+
Ow0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNtYy1tYm94IjsNCj4gPiArICAgICAg
ICBtZXRob2QgPSAic21jIjsNCj4gPiArICAgICAgICBhcm0sbnVtLWNoYW5zID0gPDB4Mj47DQo+
ID4gKyAgICAgICAgdHJhbnNwb3J0cyA9ICJtZW0iOw0KPiA+ICsgICAgICAgIC8qIE9wdGlvbmFs
ICovDQo+ID4gKyAgICAgICAgYXJtLGZ1bmMtaWRzID0gPDB4YzIwMDAwZmU+LCA8MHhjMjAwMDBm
Zj47DQo+ID4gKyAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICBzY21pIHsNCj4gPiArICAgICAg
ICBjb21wYXRpYmxlID0gImFybSxzY21pIjsNCj4gPiArICAgICAgICBtYm94ZXMgPSA8Jm1haWxi
b3ggMCAmbWFpbGJveCAxPjsNCj4gDQo+ICZzbWNfbWJveCBhbmQgPD4gZWFjaCBlbnRyeS4NCg0K
Rml4IGluIHY1Lg0KDQo+IA0KPiA+ICsgICAgICAgIG1ib3gtbmFtZXMgPSAidHgiLCAicngiOw0K
PiA+ICsgICAgICAgIHNobWVtID0gPCZjcHVfc2NwX2xwcmkgJmNwdV9zY3BfaHByaT47DQo+IA0K
PiA8PiBlYWNoIGVudHJ5DQoNCkZpeCBpbiB2NS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4g
PiArICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gKw0KPiA+ICsuLi4NCj4gPiAtLQ0KPiA+IDIu
MTYuNA0KPiA+DQo=
