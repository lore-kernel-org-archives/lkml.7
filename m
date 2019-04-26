Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D984C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED14206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="bsFyA0aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDZNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:23:28 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:37574
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfDZNX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKMcyVMoVCGM5oW8adTBb5YsWyHngBGF52fgB0+g6DM=;
 b=bsFyA0ajikfk+KXJ7EuM7ZrlloVCa+dLfCUtulSV2pcpX0SEQl6KlHJ/7+APaIJLgjTN2ZT07BwtBBIHa7rpRnmlG9wDgVZvuk60UuhDB545657gLw8E8mjPCrFPYaxZSb0gJZv/V5OUM6vRvVEftW5nHfGsC9m7rMzfx7NKVCY=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3756.eurprd07.prod.outlook.com (52.133.7.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.4; Fri, 26 Apr 2019 13:23:17 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::8c3f:5775:198e:e0e7]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::8c3f:5775:198e:e0e7%7]) with mapi id 15.20.1856.006; Fri, 26 Apr 2019
 13:23:17 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "natechancellor@gmail.com" <natechancellor@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "andi.kleen@intel.com" <andi.kleen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "astrachan@google.com" <astrachan@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 4.14 09/69] x86: vdso: Use $LD instead of $CC to link
Thread-Topic: [PATCH 4.14 09/69] x86: vdso: Use $LD instead of $CC to link
Thread-Index: AQHU88GVdiIeV/TyhkCfli2iaLO9taZOYnaAgAASmgCAAAnUAA==
Date:   Fri, 26 Apr 2019 13:23:17 +0000
Message-ID: <0dbe840a89d279be2b66d6c612d25eba4cc4c2e2.camel@nokia.com>
References: <20190415183726.036654568@linuxfoundation.org>
         <20190415183728.632579553@linuxfoundation.org>
         <c9fc2241bb6687e6bfab50e329d81601ff6bc6bf.camel@nokia.com>
         <20190426124804.GA23970@archlinux-i9>
In-Reply-To: <20190426124804.GA23970@archlinux-i9>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2490396a-b135-4b38-e249-08d6ca4a5869
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3756;
x-ms-traffictypediagnostic: HE1PR0702MB3756:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <HE1PR0702MB3756739F95F30A6E123351CAB43E0@HE1PR0702MB3756.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(52314003)(1361003)(102836004)(476003)(2616005)(446003)(11346002)(966005)(6246003)(25786009)(2351001)(508600001)(66066001)(97736004)(5660300002)(486006)(186003)(8676002)(1730700003)(256004)(36756003)(8936002)(26005)(71200400001)(6506007)(2501003)(14444005)(5024004)(71190400001)(54906003)(1411001)(7736002)(305945005)(6436002)(99286004)(68736007)(3846002)(81166006)(66556008)(66946007)(73956011)(76116006)(118296001)(6486002)(316002)(64756008)(66476007)(66446008)(81156014)(229853002)(93886005)(4326008)(2906002)(5640700003)(6512007)(14454004)(53936002)(86362001)(76176011)(6306002)(7416002)(6916009)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3756;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k1Y8KA82RFNXMRZI07UQU9GZk+/J9Zz2zyaaJoRGIx0itth7V0f7Nve1WHGgMRT78so5JyDkJZ7hSRg7cBEPrpCwuJIX1x+SELB638y7BberoHL7FFGN3MDMCxYJEkBwwDRdyD6Pgmt6N2U1FJKjgXsvCdXYb8b8asbbXfNuFrAgTz/Nd284YRPW1hu4+84ZTA88JOXuIfS+u+7N2miyQSbA/dwlRXhGsS7c3fgn/RY/H5+pZJW9Z/TbWPXsGrCwTm8W2c1gxS8mFS7BbCKKVIQmFb75xdSv7GOEmmyQzf5qfRb1xDhr6dLiT2GoQiGYLsHYIIYV4GXxBcKlNbEufFe/NHtJ/eYTG/t9lNBuzcbape8WYBkR9Gl0fk2YSR2dqRDGaMIrA6S91vJEQqL3H2g/QYjVlIpk4UYOELmF6UM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <825D7BE17A179C49991462A650A3B11E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2490396a-b135-4b38-e249-08d6ca4a5869
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 13:23:17.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA0LTI2IGF0IDA1OjQ4IC0wNzAwLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90
ZToNCj4gT24gRnJpLCBBcHIgMjYsIDIwMTkgYXQgMTE6NDE6MzBBTSArMDAwMCwgUmFudGFsYSwg
VG9tbWkgVC4gKE5va2lhIC0NCj4gRkkvRXNwb28pIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0w
NC0xNSBhdCAyMDo1OCArMDIwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiA+ID4gY29t
bWl0IDM3OWQ5OGRkZjQxMzQ0MjczZDk3MTg1NTZmNzYxNDIwZjRkYzgwYjMgdXBzdHJlYW0uDQo+
ID4gPiANCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBXaXRoIHRoaXMgcGF0Y2ggaW4gNC4xNC4x
MTIgYnVpbGQtaWQgaXMgbm93IG1pc3NpbmcgaW4gdmRzbzMyLnNvOg0KPiA+IA0KPiA+ICQgZmls
ZSBhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28qc28qDQo+ID4gYXJjaC94ODYvZW50cnkvdmRzby92
ZHNvMzIuc286ICAgICBFTEYgMzItYml0IExTQiBwaWUgZXhlY3V0YWJsZSwNCj4gPiBJbnRlbA0K
PiA+IDgwMzg2LCB2ZXJzaW9uIDEgKFNZU1YpLCBkeW5hbWljYWxseSBsaW5rZWQsIHN0cmlwcGVk
DQo+ID4gYXJjaC94ODYvZW50cnkvdmRzby92ZHNvMzIuc28uZGJnOiBFTEYgMzItYml0IExTQiBw
aWUgZXhlY3V0YWJsZSwNCj4gPiBJbnRlbA0KPiA+IDgwMzg2LCB2ZXJzaW9uIDEgKFNZU1YpLCBk
eW5hbWljYWxseSBsaW5rZWQsIHdpdGggZGVidWdfaW5mbywgbm90DQo+ID4gc3RyaXBwZWQNCj4g
PiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc282NC5zbzogICAgIEVMRiA2NC1iaXQgTFNCIHBpZSBl
eGVjdXRhYmxlLA0KPiA+IHg4Ni0NCj4gPiA2NCwgdmVyc2lvbiAxIChTWVNWKSwgZHluYW1pY2Fs
bHkgbGlua2VkLA0KPiA+IEJ1aWxkSURbc2hhMV09ZDgwNzMwYTViNTYxYTMxNjFlNDg4YTM2OWQx
Yzc2YzI1MGI1ODRiNCwgc3RyaXBwZWQNCj4gPiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc282NC5z
by5kYmc6IEVMRiA2NC1iaXQgTFNCIHBpZSBleGVjdXRhYmxlLA0KPiA+IHg4Ni0NCj4gPiA2NCwg
dmVyc2lvbiAxIChTWVNWKSwgZHluYW1pY2FsbHkgbGlua2VkLA0KPiA+IEJ1aWxkSURbc2hhMV09
ZDgwNzMwYTViNTYxYTMxNjFlNDg4YTM2OWQxYzc2YzI1MGI1ODRiNCwgd2l0aA0KPiA+IGRlYnVn
X2luZm8sIG5vdCBzdHJpcHBlZA0KPiA+IA0KPiA+IA0KPiA+IEJhc2VkIG9uIHF1aWNrIGNoZWNr
LCAiJChjYWxsIGxkLW9wdGlvbiwgLS1idWlsZC1pZCkiIGZhaWxzIGR1ZSB0bw0KPiA+IHNvbWUN
Cj4gPiAzMi82NCBiaXQgbWlzbWF0Y2gsIHNvIHRoZSAtLWJ1aWxkLWlkIGxpbmtlciBmbGFnIGlz
IG5vdCB1c2VkIHdoZW4NCj4gPiBsaW5raW5nIHZkc28zMi5zbw0KPiA+IA0KPiA+IFBlcmhhcHMg
c2NyaXB0cy9LYnVpbGQuaW5jbHVkZSBpcyBtaXNzaW5nIHNvbWUgY2hhbmdlIGluIDQuMTQueSB0
bw0KPiA+IG1ha2UNCj4gPiB0aGlzIHdvcmsgcHJvcGVybHkuDQo+ID4gDQo+IA0KPiBIaSBUb21t
aSwNCj4gDQo+IFRoaXMgYXBwZWFycyB0byBiZSBmaXhlZCBieSBjb21taXQgMDI5NGU2ZjRhMDAw
ICgia2J1aWxkOiBzaW1wbGlmeQ0KPiBsZC1vcHRpb24gaW1wbGVtZW50YXRpb24iKSB1cHN0cmVh
bS4gQ291bGQgeW91IHRlc3QgdGhlIGF0dGFjaGVkDQo+IGJhY2twb3J0IGFuZCBtYWtlIHN1cmUg
ZXZlcnl0aGluZyB3b3JrcyBvbiB5b3VyIGVuZD8gQXNzdW1pbmcgdGhhdCBpdA0KPiBkb2VzLCBJ
IHdpbGwgdGVzdCB0aGUgb3RoZXIgc3RhYmxlIHJlbGVhc2VzIGFuZCBzZWUgaWYgdGhpcyBpcyBu
ZWVkZWQNCj4gYW5kIHNlbmQgdGhvc2UgYmFja3BvcnRzIGFsb25nLg0KDQpZZXMgdGhpcyBwYXRj
aCBmaXhlcyBpdC4gTWFueSB0aGFua3MhDQoNCi1Ub21taQ0KDQo+IFRoYW5rcyBhbmQgc29ycnkg
Zm9yIHRoZSB0cm91YmxlIQ0KPiBOYXRoYW4NCj4gDQo+ID4gLVRvbW1pDQo+ID4gDQo+ID4gPiBU
aGUgdmRzb3szMiw2NH0uc28gY2FuIGZhaWwgdG8gbGluayB3aXRoIENDPWNsYW5nIHdoZW4gY2xh
bmcNCj4gPiA+IHRyaWVzIHRvDQo+ID4gPiBmaW5kDQo+ID4gPiBhIHN1aXRhYmxlIEdDQyB0b29s
Y2hhaW4gdG8gbGluayB0aGVzZSBsaWJyYXJpZXMgd2l0aC4NCj4gPiA+IA0KPiA+ID4gL3Vzci9i
aW4vbGQ6IGFyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUubzoNCj4gPiA+ICAgYWNj
ZXNzIGJleW9uZCBlbmQgb2YgbWVyZ2VkIHNlY3Rpb24gKDc4MikNCj4gPiA+IA0KPiA+ID4gVGhp
cyBoYXBwZW5zIGJlY2F1c2UgdGhlIGhvc3QgZW52aXJvbm1lbnQgbGVha2VkIGludG8gdGhlIGNy
b3NzDQo+ID4gPiBjb21waWxlcg0KPiA+ID4gZW52aXJvbm1lbnQgZHVlIHRvIHRoZSB3YXkgY2xh
bmcgc2VhcmNoZXMgZm9yIHN1aXRhYmxlIEdDQw0KPiA+ID4gdG9vbGNoYWlucy4NCj4gPiA+IA0K
PiA+ID4gQ2xhbmcgaXMgYSByZXRhcmdldGFibGUgY29tcGlsZXIsIGFuZCBlYWNoIGludm9jYXRp
b24gb2YgaXQgbXVzdA0KPiA+ID4gcHJvdmlkZQ0KPiA+ID4gLS10YXJnZXQ9PHNvbWV0aGluZz4g
LS1nY2MtdG9vbGNoYWluPTxzb21ldGhpbmc+IHRvIGFsbG93IGl0IHRvDQo+ID4gPiBmaW5kDQo+
ID4gPiB0aGUNCj4gPiA+IGNvcnJlY3QgYmludXRpbHMgZm9yIGNyb3NzIGNvbXBpbGF0aW9uLiBU
aGVzZSBmbGFncyBoYWQgYmVlbg0KPiA+ID4gYWRkZWQgdG8NCj4gPiA+IEtCVUlMRF9DRkxBR1Ms
IGJ1dCB0aGUgdmRzbyBjb2RlIHVzZXMgQ0MgYW5kIG5vdCBLQlVJTERfQ0ZMQUdTDQo+ID4gPiAo
Zm9yDQo+ID4gPiB2YXJpb3VzDQo+ID4gPiByZWFzb25zKSB3aGljaCBicmVha3MgY2xhbmcncyBh
YmlsaXR5IHRvIGZpbmQgdGhlIGNvcnJlY3QgbGlua2VyDQo+ID4gPiB3aGVuDQo+ID4gPiBjcm9z
cw0KPiA+ID4gY29tcGlsaW5nLg0KPiA+ID4gDQo+ID4gPiBNb3N0IG9mIHRoZSB0aW1lIHRoaXMg
Z29lcyB1bm5vdGljZWQgYmVjYXVzZSB0aGUgaG9zdCBsaW5rZXIgaXMNCj4gPiA+IG5ldw0KPiA+
ID4gZW5vdWdoDQo+ID4gPiB0byB3b3JrIGFueXdheSwgb3IgaXMgaW5jb21wYXRpYmxlIGFuZCBz
a2lwcGVkLCBidXQgdGhpcyBjYW5ub3QNCj4gPiA+IGJlDQo+ID4gPiByZWxpYWJseQ0KPiA+ID4g
YXNzdW1lZC4NCj4gPiA+IA0KPiA+ID4gVGhpcyBjaGFuZ2UgYWx0ZXJzIHRoZSB2ZHNvIG1ha2Vm
aWxlIHRvIGp1c3QgdXNlIExEIGRpcmVjdGx5LA0KPiA+ID4gd2hpY2gNCj4gPiA+IGJ5cGFzc2Vz
IGNsYW5nIGFuZCB0aHVzIHRoZSBzZWFyY2hpbmcgcHJvYmxlbS4gVGhlIG1ha2VmaWxlIHdpbGwN
Cj4gPiA+IGp1c3QNCj4gPiA+IHVzZQ0KPiA+ID4gJHtDUk9TU19DT01QSUxFfWxkIGluc3RlYWQs
IHdoaWNoIGlzIGFsd2F5cyB3aGF0IHdlIHdhbnQuIFRoaXMNCj4gPiA+IG1hdGNoZXMgdGhlDQo+
ID4gPiBtZXRob2QgdXNlZCB0byBsaW5rIHZtbGludXguDQo+ID4gPiANCj4gPiA+IFRoaXMgZHJv
cHMgcmVmZXJlbmNlcyB0byBESVNBQkxFX0xUTzsgdGhpcyBvcHRpb24gZG9lc24ndCBzZWVtIHRv
DQo+ID4gPiBiZQ0KPiA+ID4gc2V0DQo+ID4gPiBhbnl3aGVyZSwgYW5kIG5vdCBrbm93aW5nIHdo
YXQgaXRzIHBvc3NpYmxlIHZhbHVlcyBhcmUsIGl0J3Mgbm90DQo+ID4gPiBjbGVhciBob3cNCj4g
PiA+IHRvIGNvbnZlcnQgaXQgZnJvbSBDQyB0byBMRCBmbGFnLg0KPiA+ID4gDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGlzdGFpciBTdHJhY2hhbiA8YXN0cmFjaGFuQGdvb2dsZS5jb20+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4g
PiA+IEFja2VkLWJ5OiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gPiA+IENj
OiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiA+ID4gQ2M6IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiBDYzoga2VybmVsLXRl
YW1AYW5kcm9pZC5jb20NCj4gPiA+IENjOiBqb2VsQGpvZWxmZXJuYW5kZXMub3JnDQo+ID4gPiBD
YzogQW5kaSBLbGVlbiA8YW5kaS5rbGVlbkBpbnRlbC5jb20+DQo+ID4gPiBMaW5rOiANCj4gPiA+
IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxODA4MDMxNzM5MzEuMTE3NTE1LTEtYXN0cmFj
aGFuQGdvb2dsZS5jb20NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxu
YXRlY2hhbmNlbGxvckBnbWFpbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZp
biA8c2FzaGFsQGtlcm5lbC5vcmc+DQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL3g4Ni9lbnRyeS92
ZHNvL01ha2VmaWxlIHwgMjIgKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvdmRzby9NYWtlZmlsZQ0KPiA+ID4gYi9hcmNoL3g4
Ni9lbnRyeS92ZHNvL01ha2VmaWxlDQo+ID4gPiBpbmRleCAwYTU1MGRjNWM1MjUuLjBkZWZjYzkz
OWFiNCAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2VudHJ5L3Zkc28vTWFrZWZpbGUNCj4g
PiA+ICsrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vTWFrZWZpbGUNCj4gPiA+IEBAIC00OCwxMCAr
NDgsOCBAQCB0YXJnZXRzICs9ICQodmRzb19pbWdfc29kYmcpDQo+ID4gPiAgDQo+ID4gPiAgZXhw
b3J0IENQUEZMQUdTX3Zkc28ubGRzICs9IC1QIC1DDQo+ID4gPiAgDQo+ID4gPiAtVkRTT19MREZM
QUdTX3Zkc28ubGRzID0gLW02NCAtV2wsLXNvbmFtZT1saW51eC12ZHNvLnNvLjEgXA0KPiA+ID4g
LQkJCS1XbCwtLW5vLXVuZGVmaW5lZCBcDQo+ID4gPiAtCQkJLVdsLC16LG1heC1wYWdlLXNpemU9
NDA5NiAtV2wsLXosY29tbW9uLXBhZ2UtDQo+ID4gPiBzaXplPTQwOTYgXA0KPiA+ID4gLQkJCSQo
RElTQUJMRV9MVE8pDQo+ID4gPiArVkRTT19MREZMQUdTX3Zkc28ubGRzID0gLW0gZWxmX3g4Nl82
NCAtc29uYW1lIGxpbnV4LXZkc28uc28uMSAtLQ0KPiA+ID4gbm8tDQo+ID4gPiB1bmRlZmluZWQg
XA0KPiA+ID4gKwkJCS16IG1heC1wYWdlLXNpemU9NDA5NiAteiBjb21tb24tcGFnZS1zaXplPTQw
OTYNCj4gPiA+ICANCj4gPiA+ICAkKG9iaikvdmRzbzY0LnNvLmRiZzogJChzcmMpL3Zkc28ubGRz
ICQodm9ianMpIEZPUkNFDQo+ID4gPiAgCSQoY2FsbCBpZl9jaGFuZ2VkLHZkc28pDQo+ID4gPiBA
QCAtMTAzLDEwICsxMDEsOCBAQCBDRkxBR1NfUkVNT1ZFX3Z2YXIubyA9IC1wZw0KPiA+ID4gICMN
Cj4gPiA+ICANCj4gPiA+ICBDUFBGTEFHU192ZHNveDMyLmxkcyA9ICQoQ1BQRkxBR1NfdmRzby5s
ZHMpDQo+ID4gPiAtVkRTT19MREZMQUdTX3Zkc294MzIubGRzID0gLVdsLC1tLGVsZjMyX3g4Nl82
NCBcDQo+ID4gPiAtCQkJICAgLVdsLC1zb25hbWU9bGludXgtdmRzby5zby4xIFwNCj4gPiA+IC0J
CQkgICAtV2wsLXosbWF4LXBhZ2Utc2l6ZT00MDk2IFwNCj4gPiA+IC0JCQkgICAtV2wsLXosY29t
bW9uLXBhZ2Utc2l6ZT00MDk2DQo+ID4gPiArVkRTT19MREZMQUdTX3Zkc294MzIubGRzID0gLW0g
ZWxmMzJfeDg2XzY0IC1zb25hbWUgbGludXgtDQo+ID4gPiB2ZHNvLnNvLjEgXA0KPiA+ID4gKwkJ
CSAgIC16IG1heC1wYWdlLXNpemU9NDA5NiAteiBjb21tb24tcGFnZS0NCj4gPiA+IHNpemU9NDA5
Ng0KPiA+ID4gIA0KPiA+ID4gICMgNjQtYml0IG9iamVjdHMgdG8gcmUtYnJhbmQgYXMgeDMyDQo+
ID4gPiAgdm9ianM2NC1mb3IteDMyIDo9ICQoZmlsdGVyLW91dCAkKHZvYmpzLW5veDMyKSwkKHZv
YmpzLXkpKQ0KPiA+ID4gQEAgLTEzNCw3ICsxMzAsNyBAQCAkKG9iaikvdmRzb3gzMi5zby5kYmc6
ICQoc3JjKS92ZHNveDMyLmxkcw0KPiA+ID4gJCh2b2JqeDMycykgRk9SQ0UNCj4gPiA+ICAJJChj
YWxsIGlmX2NoYW5nZWQsdmRzbykNCj4gPiA+ICANCj4gPiA+ICBDUFBGTEFHU192ZHNvMzIubGRz
ID0gJChDUFBGTEFHU192ZHNvLmxkcykNCj4gPiA+IC1WRFNPX0xERkxBR1NfdmRzbzMyLmxkcyA9
IC1tMzIgLVdsLC1tLGVsZl9pMzg2IC1XbCwtDQo+ID4gPiBzb25hbWU9bGludXgtDQo+ID4gPiBn
YXRlLnNvLjENCj4gPiA+ICtWRFNPX0xERkxBR1NfdmRzbzMyLmxkcyA9IC1tIGVsZl9pMzg2IC1z
b25hbWUgbGludXgtZ2F0ZS5zby4xDQo+ID4gPiAgDQo+ID4gPiAgIyBUaGlzIG1ha2VzIHN1cmUg
dGhlICQob2JqKSBzdWJkaXJlY3RvcnkgZXhpc3RzIGV2ZW4gdGhvdWdoDQo+ID4gPiB2ZHNvMzIv
DQo+ID4gPiAgIyBpcyBub3QgYSBrYnVpbGQgc3ViLW1ha2Ugc3ViZGlyZWN0b3J5Lg0KPiA+ID4g
QEAgLTE4MCwxMyArMTc2LDEzIEBAICQob2JqKS92ZHNvMzIuc28uZGJnOiBGT1JDRSBcDQo+ID4g
PiAgIyBUaGUgRFNPIGltYWdlcyBhcmUgYnVpbHQgdXNpbmcgYSBzcGVjaWFsIGxpbmtlciBzY3Jp
cHQuDQo+ID4gPiAgIw0KPiA+ID4gIHF1aWV0X2NtZF92ZHNvID0gVkRTTyAgICAkQA0KPiA+ID4g
LSAgICAgIGNtZF92ZHNvID0gJChDQykgLW5vc3RkbGliIC1vICRAIFwNCj4gPiA+ICsgICAgICBj
bWRfdmRzbyA9ICQoTEQpIC1ub3N0ZGxpYiAtbyAkQCBcDQo+ID4gPiAgCQkgICAgICAgJChWRFNP
X0xERkxBR1MpICQoVkRTT19MREZMQUdTXyQoZmlsdGVyDQo+ID4gPiAlLmxkcywkKF5GKSkpIFwN
Cj4gPiA+IC0JCSAgICAgICAtV2wsLVQsJChmaWx0ZXIgJS5sZHMsJF4pICQoZmlsdGVyICUubywk
XikgJiYgXA0KPiA+ID4gKwkJICAgICAgIC1UICQoZmlsdGVyICUubGRzLCReKSAkKGZpbHRlciAl
Lm8sJF4pICYmIFwNCj4gPiA+ICAJCSBzaCAkKHNyY3RyZWUpLyQoc3JjKS9jaGVja3VuZGVmLnNo
ICckKE5NKScgJyRAJw0KPiA+ID4gIA0KPiA+ID4gLVZEU09fTERGTEFHUyA9IC1mUElDIC1zaGFy
ZWQgJChjYWxsIGNjLWxkb3B0aW9uLCAtV2wkKGNvbW1hKQ0KPiA+ID4gLS1oYXNoLQ0KPiA+ID4g
c3R5bGU9Ym90aCkgXA0KPiA+ID4gLQkkKGNhbGwgY2MtbGRvcHRpb24sIC1XbCQoY29tbWEpLS1i
dWlsZC1pZCkgLVdsLC1Cc3ltYm9saWMNCj4gPiA+ICQoTFRPX0NGTEFHUykNCj4gPiA+ICtWRFNP
X0xERkxBR1MgPSAtc2hhcmVkICQoY2FsbCBsZC1vcHRpb24sIC0taGFzaC1zdHlsZT1ib3RoKSBc
DQo+ID4gPiArCSQoY2FsbCBsZC1vcHRpb24sIC0tYnVpbGQtaWQpIC1Cc3ltYm9saWMNCj4gPiA+
ICBHQ09WX1BST0ZJTEUgOj0gbg0KPiA+ID4gIA0KPiA+ID4gICMNCg0K
