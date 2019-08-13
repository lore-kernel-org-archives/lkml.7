Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E05C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 02:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E517206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 02:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nC1P17/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfHMCfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 22:35:01 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:22941
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfHMCfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 22:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXgK5P+Z18cmB4bU5Klniy2Eo2KKyK+UBklLn0o/XxfYum+IhRYycan8rH428UBvhUQGzrOy3OvbTIqwJOINKRjk1o/j2zbwh1hpCeN+BYohwqz9qApcDtTlkj1gZxtOmRzxd2hbsvfaluR42hCJokO7CPvnmfXa4CpY88eIzCVi21u127AmiINFdIzyEiV7kFk/Ht2We/kaOCjzlta1aOQW/fcxhikcFh82S3qZnaMEItDLMyPPSBYDYqizJqeCZuBCZ10A8FqrW3HqrK0pc45esnEiJwy+QaaqlXCjx/smXU1Pg20Ftx2+c/YG5wfW5XJo8BOGxVX+CIAducMcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIvAVMBP0elbFxdXzosMu7Zzn/3rODuyMp9Il7um158=;
 b=SOsu7Ek5NCsUoO+Q7lcs07EoGN1NonZqPdFS25vfNtrn3aCdaVu0gh3kbpY+rJjPKF2z0tO7iTCac5JyBOo/Ee9HlzNKtIrN/lcff1dSTbahqMdYnTz3cGEdGCZRUWIou6UMNbDE2piYy6t5HSkkxtZWXzTheZdDhFVqiyrtSBEpAO+Qxgh+yTtu24SJI3jVL6W0FQagLCKHe4ZqWNBCZDR8/FVasPDQHJ8s8iFwbaoTaf6g/kTh0a9klOv9Ca6Iyf8fXQmqV+saIZuP8/+qnpFUTgNHavx+qNURv7dOMlK3HHkECQvfYnpdfsieXCvcib+SZ1YN0FZLD4wOB/gNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIvAVMBP0elbFxdXzosMu7Zzn/3rODuyMp9Il7um158=;
 b=nC1P17/ox++xNhSZXKHnQMXj1W58HvzDYzeBFM4iK3riRG6AW95tYp2Fsm8dLvxNme6MqvEEoUAioL3A+xb/qZ3yOknmLSjAQtQRopLJPyZVRNneb1oLCnpTqvAPffrTMvO6XZDdk+Tny3dlxJpjwJzIQoQQH0r3x6OQz5acc/w=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4601.eurprd04.prod.outlook.com (52.135.134.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 13 Aug 2019 02:34:55 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 02:34:55 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] Re: [v2 1/4] dt-bindings: display: Add DT bindings for
 LS1028A HDP-TX PHY.
Thread-Topic: [EXT] Re: [v2 1/4] dt-bindings: display: Add DT bindings for
 LS1028A HDP-TX PHY.
Thread-Index: AQHVPhtlvcMtag9V/UmjYDhREnPyq6b4T2EAgAAsmyA=
Date:   Tue, 13 Aug 2019 02:34:55 +0000
Message-ID: <DB7PR04MB51950BBAD5C2802D59A5C9B5E2D20@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190719100942.12016-1-wen.he_1@nxp.com>
 <20190812232934.GA1219@bogus>
In-Reply-To: <20190812232934.GA1219@bogus>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52f17375-5631-4b61-ccf7-08d71f96d3f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4601;
x-ms-traffictypediagnostic: DB7PR04MB4601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB46016EC49033965FE6A657ADE2D20@DB7PR04MB4601.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(13464003)(6116002)(74316002)(7736002)(229853002)(186003)(305945005)(3846002)(8676002)(26005)(5660300002)(25786009)(71190400001)(6246003)(66066001)(71200400001)(6916009)(99286004)(316002)(9686003)(52536014)(4326008)(6436002)(2906002)(54906003)(81156014)(102836004)(76176011)(478600001)(81166006)(55016002)(8936002)(53936002)(86362001)(53546011)(6506007)(7696005)(14454004)(66476007)(66556008)(64756008)(446003)(11346002)(66446008)(476003)(76116006)(66946007)(14444005)(486006)(33656002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4601;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8xMGiE7qsAofIq2IJv6MRNS6eZWQyMcb5chg589ZLjX2egtZkgqCKUdvpfd9HuDkw0ikv1I8zj3gVQLoFlnve6z7ggjcZsJFf/S3v8i4Dv1hDpeR6RHuESJzRv8hNdMgQdbGr9JztFMwVqgOpxGXJiPikUN3mmewbUgwdnPtn10/k2KwzHKYqWN7+DwtpNQ0yc7NZWmdQgLEt/5CSGw3o6oTdreeZPAtXhCG+URj2HwrO2BHvUac4yjevW9hLo1dSvh7jAxQRlKY+4yiyrplZFzFsaWYtsui+494kURI4XWlTJ5i5qSsDBRWu3OjieVuWWVfpnBnmsn4+XXMiJ57NuQDPNU0QyJwSQKpY0P7wpeg3fFnD0jRKLe14ZKGTowSkjIKPvd0rL+mHG8ElAS+9X3lqtaxFDEqg70RBuyp1bE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f17375-5631-4b61-ccf7-08d71f96d3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 02:34:55.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCCVa9bT4mMzixUuuCT1gnW0nims8fGeIpVtFedhPs0w2tBVWV6QY754MkU4eGc8Lyq85wau/TejaTyxJyoZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqONTCMTPI1SA3OjMwDQo+IFRvOiBXZW4gSGUg
PHdlbi5oZV8xQG54cC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IExlbyBM
aSA8bGVveWFuZy5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW3YyIDEvNF0gZHQt
YmluZGluZ3M6IGRpc3BsYXk6IEFkZCBEVCBiaW5kaW5ncyBmb3IgTFMxMDI4QQ0KPiBIRFAtVFgg
UEhZLg0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBGcmksIEp1bCAxOSwgMjAx
OSBhdCAwNjowOTozOVBNICswODAwLCBXZW4gSGUgd3JvdGU6DQo+ID4gQWRkIERUIGJpbmRpbmdz
IGRvY3VtZW50bWF0aW9uIGZvciB0aGUgSERQLVRYIFBIWSBjb250cm9sbGVyLiBUaGUNCj4gPiBk
ZXNjcmliZXMgd2hpY2ggY291bGQgYmUgZm91bmQgb24gTlhQIExheWVyc2NhcGUgbHMxMDI4YSBw
bGF0Zm9ybS4NCj4gDQo+IE5vdCByZXF1aXJlZCwgYnV0IHBsZWFzZSBjb25zaWRlciBjb252ZXJ0
aW5nIHRvIERUIHNjaGVtYSAoWUFNTCkgZm9ybWF0Lg0KDQpVbmRlcnN0YW5kLA0KDQo+IA0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+IGNoYW5nZSBpbiB2MjoNCj4gPiAgICAgICAgIC0gY29ycmVjdGlvbiB0aGUgbm9kZSBuYW1l
Lg0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZnNsLGhkcC50eHQg
ICB8IDU2ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU2IGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZnNsLGhkcC50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9mc2wsaGRwLnR4dA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvZnNsLGhkcC50
eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTNj
YTA4MzM3NTg3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2ZzbCxoZHAudHh0DQo+ID4gQEAgLTAsMCArMSw1NiBA
QA0KPiA+ICtOWFAgTGF5ZXJzY3BhZSBsczEwMjhhIEhEUC1UWCBQSFkgQ29udHJvbGxlcg0KPiAN
Cj4gdHlwbw0KPiANCj4gPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiArDQo+ID4gK1RoZSBmb2xsb3dpbmcgYmluZGluZ3MgZGVzY3JpYmUgdGhlIENh
ZGVuY2UgSERQIFRYIFBIWSBvbiBsczEwMjhhDQo+ID4gK3RoYXQgb2ZmZXIgbXVsdGktcHJvdG9j
b2wgc3VwcG9ydCBvZiBzdGFuZGFycyBzdWNoIGFzIGVEUCBhbmQNCj4gPiArRGlzcGxheXBvcnQs
DQo+IA0KPiBzL29mZmVyL29mZmVycy8NCj4gDQo+IGFuZCBhbm90aGVyIHR5cG8uDQo+IA0KPiA+
ICtzdXBwb3J0cyBmb3IgMjUtNjAwTUh6IHBpeGVsIGNsb2NrIGFuZCB1cCB0byA0azJrIGF0IDYw
TUh6IHJlc29sdXRpb24uDQo+ID4gK1RoZSBIRFAgdHJhbnNtaXR0ZXIgaXMgYSBDYWRlbmNlIEhE
UCBUWCBjb250cm9sbGVyIElQIHdpdGggYQ0KPiA+ICtjb21wYW5pb24gUEhZIElQLg0KPiA+ICsN
Cj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArICAtIGNvbXBhdGlibGU6ICAgU2hvdWxk
IGJlICJmc2wsbHMxMDI4YS1kcCIgZm9yIGxzMTAyOGEuDQo+ID4gKyAgLSByZWc6ICAgICAgICAg
IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUgYmxvY2sgb2YgcmVnaXN0ZXJz
DQo+IHVzZWQNCj4gPiArICBieSB0aGUgcHJvY2Vzc29yLg0KPiANCj4gVGhlIGV4YW1wbGUgc2hv
d3MgMiByZWdpb25zLCB3aGF0IGFyZSB0aGV5Pw0KDQpPbmUgaXMgSERQIHRyYW5zbWl0dGVyIGNv
bnRyb2xsZXIgYWRkcmVzcyByZWdpb24sIGFub3RoZXIgaXMgbXVsdGltZWRpYSBQTEwgYWRkcmVz
cyByZWdpb24uDQpTb3JyeSwgaGVyZSBzaG91bGQgYmUgdXNlIHRoZSBIRFAgdHJhbnNtaXR0ZXIg
Y29udHJvbGxlciByZWdpb24uIA0KDQpJJ3ZlIGFscmVhZHkgc2VuZCBjbG9jayBwYXRjaGVzIGlu
Y2x1ZGVkIHRoZSBtdWx0aW1lZGlhIFBMTCBpbXBsZW1lbnRhdGlvbi4NCg0KPiANCj4gPiArICAt
IGludGVycnVwdHM6ICAgSERQIGhvdHBsdWcgaW4vb3V0IGRldGVjdCBpbnRlcnJ1cHQgbnVtYmVy
DQo+ID4gKyAgLSBjbG9ja3M6ICAgICAgIEEgbGlzdCBvZiBwaGFuZGxlICsgY2xvY2stc3BlY2lm
aWVyIHBhaXJzLCBvbmUgZm9yIGVhY2gNCj4gZW50cnkNCj4gPiArICBpbiAnY2xvY2stbmFtZXMn
DQo+ID4gKyAgLSBjbG9jay1uYW1lczogIEEgbGlzdCBvZiBjbG9jayBuYW1lcy4gSXQgc2hvdWxk
IGNvbnRhaW46DQo+ID4gKyAgICAgIC0gImNsa19pcGciOiBpbnRlci1JbnRlZ3JhdGVkIGNpcmN1
aXQgY2xvY2sNCj4gPiArICAgICAgLSAiY2xrX2NvcmUiOiBmb3IgdGhlIE1haW4gRGlzcGxheSBU
WCBjb250cm9sbGVyIGNsb2NrDQo+ID4gKyAgICAgIC0gImNsa19weGwiOiBmb3IgdGhlIHBpeGVs
IGNsb2NrIGZlZWRpbmcgdGhlIG91dHB1dCBQTEwgb2YgdGhlIHByb2Nlc3Nvcg0KPiA+ICsgICAg
ICAtICJjbGtfcHhsX211eCI6IGZvciB0aGUgaGlnaCBQZXJmUExMIGJ5cGFzcyBjbG9jaw0KPiA+
ICsgICAgICAtICJjbGtfcHhsX2xpbmsiOiBmb3IgdGhlIGxpbmsgcmF0ZSBwaXhlbCBjbG9jaw0K
PiA+ICsgICAgICAtICJjbGtfYXBiIjogZm9yIHRoZSBBUEIgaW50ZXJmYWNlIGNsb2NrDQo+ID4g
KyAgICAgIC0gImNsa192aWYiOiBmb3IgdGhlIFZpZGVvIHBpeGVsIGNsb2NrDQo+IA0KPiAnY2xr
XycgaXMgcmVkdW5kYW50Lg0KPiANCg0KT0sNCg0KPiA+ICsNCj4gPiArUmVxdWlyZWQgc3ViLW5v
ZGVzOg0KPiA+ICsgIC0gcG9ydDogVGhlIEhEUCBjb25uZWN0aW9uIHRvIGFuIGVuY29kZXIgb3V0
cHV0IHBvcnQuIFRoZSBjb25uZWN0aW9uDQo+ID4gKyAgICBpcyBtb2RlbGxlZCB1c2luZyB0aGUg
T0YgZ3JhcGggYmluZGluZ3Mgc3BlY2lmaWVkIGluDQo+ID4gKyAgICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZ3JhcGgudHh0DQo+IA0KPiBJJ20gc3RpbGwgY29uZnVzZWQgYXMg
dG8gd2hhdCB0aGlzIGJsb2NrIGRvZXM/IFRoZSAnZW5jb2RlciBvdXRwdXQnIGlzDQo+IERpc3Bs
YXlQb3J0PyBJZiB0aGlzIGlzIGp1c3QgYSBwaHksIHRoZW4gdXNlIHRoZSBwaHkgYmluZGluZy4N
Cj4gDQo+IE5vcm1hbGx5LCBhIERpc3BsYXlQb3J0IGVuY29kZXIvYnJpZGdlIE9GIGdyYXBoIG91
dHB1dCB3b3VsZCBiZSBjb25uZWN0ZWQNCj4gdG8gYSBEUCBjb25uZWN0b3Igbm9kZSBvciBhIHBh
bmVsLg0KDQpZZXMsIHlvdSBhcmUgcmlnaHQsIGJ1dCANCkZvciBMUzEwMjhBLCBIRFAoQ2FkZW5j
ZSBIRCBEaXNwbGF5IFRyYW5zbWl0dGVyKSBhcmUgaW5jbHVkZWQgZURQL0Rpc3BsYXkgcG9ydCBj
b250cm9sbGVyIGFuZCBEaXNwbGF5IFBIWSBjb250cm9sbGVyLg0KSW4gb3RoZXIgd29yZCwgdGhl
eSBhcmUgMSBJUCBibG9jayBvbiBMUzEwMjhBLg0KDQpBIGZ1bGwgZ3JhcGhpY3MgY29ubmVjdGlv
biByZWxhdGlvbnNoaXAgb2YgdGhlIExTMTAyOEE6DQoNCkRQNTAwIC0tPiBlRFAvRFAgY29udHJv
bGxlciAtLS0+IERQSFkgLS0tPiBEUC9lRFAgaW50ZXJmYWNlLg0KDQpCZXN0IFJlZ2FyZHMsDQpX
ZW4NCg0KPiANCj4gUm9iDQo=
