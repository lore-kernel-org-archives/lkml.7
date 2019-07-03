Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC5DC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5677C21721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="b1zWJ6Ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGCCpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:45:53 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:33702 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfGCCpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:45:52 -0400
X-IronPort-AV: E=McAfee;i="6000,8403,9306"; a="4806661"
X-IronPort-AV: E=Sophos;i="5.63,445,1557154800"; 
   d="scan'208";a="4806661"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2019 11:45:46 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector1-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKZcpOoFqfOdgRPnmJeccFquOud/T2brELsNWogYUig=;
 b=b1zWJ6Lnojg8Jzvh60hsQneJ6+l+ZoMpkDhM7ia7Dwn2XCD93rz3p//tr0JBSj7zWZlJ5v15xi+gC5HnFiWy9SN1zxGjzVZNdbAcaiplA7f40Ada9RSKb4LbKLK1us33C3eY77dfEobfP4FGwcemydvx8qJgxz2Jmnk10BY+UlQ=
Received: from OSAPR01MB4993.jpnprd01.prod.outlook.com (20.179.178.151) by
 OSAPR01MB1970.jpnprd01.prod.outlook.com (52.134.235.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Wed, 3 Jul 2019 02:45:43 +0000
Received: from OSAPR01MB4993.jpnprd01.prod.outlook.com
 ([fe80::59f0:837d:b06f:9dbd]) by OSAPR01MB4993.jpnprd01.prod.outlook.com
 ([fe80::59f0:837d:b06f:9dbd%5]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 02:45:43 +0000
From:   "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
To:     Will Deacon <will@kernel.org>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
CC:     Will Deacon <will.deacon@arm.com>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Thread-Topic: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Thread-Index: AQHVJRmVihUXsBTsv0iIDHwIrvWdbKagEvcAgAqT5QCABLTDgIAI7WYA
Date:   Wed, 3 Jul 2019 02:45:43 +0000
Message-ID: <5999ed84-72d0-9d42-bf7d-b8d56eaa4d4a@jp.fujitsu.com>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617170328.GJ30800@fuggles.cambridge.arm.com>
 <e8fe8faa-72ef-8185-1a9d-dc1bbe0ae15d@jp.fujitsu.com>
 <20190627102724.vif6zh6zfqktpmjx@willie-the-truck>
In-Reply-To: <20190627102724.vif6zh6zfqktpmjx@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qi.fuli@fujitsu.com; 
x-originating-ip: [114.160.9.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4ab4ca5-e4fb-43d5-284d-08d6ff608b17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:OSAPR01MB1970;
x-ms-traffictypediagnostic: OSAPR01MB1970:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSAPR01MB19701E6EB1C353066FA2274AF7FB0@OSAPR01MB1970.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(2906002)(6436002)(8936002)(68736007)(4326008)(31696002)(8676002)(31686004)(186003)(7736002)(476003)(966005)(81166006)(86362001)(6486002)(66446008)(305945005)(53936002)(71190400001)(64756008)(66556008)(66476007)(71200400001)(478600001)(81156014)(73956011)(66946007)(486006)(99286004)(76116006)(256004)(316002)(76176011)(14444005)(66066001)(6506007)(53546011)(6512007)(3846002)(102836004)(25786009)(54906003)(446003)(110136005)(26005)(11346002)(5660300002)(14454004)(6246003)(229853002)(85182001)(6116002)(6306002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSAPR01MB1970;H:OSAPR01MB4993.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MJ85Zbk0ejfeqNRHSsVBjer52CAFTxFHXmDYsonueIj4A1hmJ8brdkBDOSeUBILRwERGZIKdFYP4kEsglYIXAG5wygvWb0VqAiUjuOQqICDgu8s0AA0tx7IJ32d/PkFVQ3nTQp90SHeCCtrgnrSbfndG+lla4dx/6+QSybWhEtC/Fo8il6jOZ4JWvo71TLuJzdcIz3MXsjj85ONvKVymYCTUZIulLd+2NRZ6Kyk5fejs/1sBCCsRkoh598J5ywxPpDXHlkd/ScGLXY7eRqM7tShT6EdNrNulGCEBdeFQ3/piQRm9s99ZZYR/Ih8mQIwHDZnN5ExW73pUk/ZWtPC6cSBJajhz3B4h5syjx7AUJXOUpfEBrHalirGl5AorfIQAVZKv1gwTdcFgp5gdxjk4pQZ6+HH0EaPsoAq1T8bAFKg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AFE113769931F44996C217BB96D8C55@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ab4ca5-e4fb-43d5-284d-08d6ff608b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 02:45:43.4668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qi.fuli@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpPbiA2LzI3LzE5IDc6Mjcg
UE0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBNb24sIEp1biAyNCwgMjAxOSBhdCAxMDozNDow
MkFNICswMDAwLCBxaS5mdWxpQGZ1aml0c3UuY29tIHdyb3RlOg0KPj4gT24gNi8xOC8xOSAyOjAz
IEFNLCBXaWxsIERlYWNvbiB3cm90ZToNCj4+PiBPbiBNb24sIEp1biAxNywgMjAxOSBhdCAxMToz
Mjo1M1BNICswOTAwLCBUYWthbyBJbmRvaCB3cm90ZToNCj4+Pj4gRnJvbTogVGFrYW8gSW5kb2gg
PGluZG91LnRha2FvQGZ1aml0c3UuY29tPg0KPj4+Pg0KPj4+PiBJIGZvdW5kIGEgcGVyZm9ybWFu
Y2UgaXNzdWUgcmVsYXRlZCBvbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgTGludXgncyBUTEINCj4+
Pj4gZmx1c2ggZm9yIGFybTY0Lg0KPj4+Pg0KPj4+PiBXaGVuIEkgcnVuIGEgc2luZ2xlLXRocmVh
ZGVkIHRlc3QgcHJvZ3JhbSBvbiBtb2RlcmF0ZSBlbnZpcm9ubWVudCwgaXQNCj4+Pj4gdXN1YWxs
eSB0YWtlcyAzOW1zIHRvIGZpbmlzaCBpdHMgd29yay4gSG93ZXZlciwgd2hlbiBJIHB1dCBhIHNt
YWxsDQo+Pj4+IGFwcHJpY2F0aW9uLCB3aGljaCBqdXN0IGNhbGxzIG1wcm90ZXN0KCkgY29udGlu
dW91c2x5LCBvbiBvbmUgb2Ygc2libGluZw0KPj4+PiBjb3JlcyBhbmQgcnVuIGl0IHNpbXVsdGFu
ZW91c2x5LCB0aGUgdGVzdCBwcm9ncmFtIHNsb3dzIGRvd24gc2lnbmlmaWNhbnRseS4NCj4+Pj4g
SXQgYmVjb21lcyA0OW1zKDEyNSUpIG9uIFRodW5kZXJYMi4gSSBhbHNvIGRldGVjdGVkIHRoZSBz
YW1lIHByb2JsZW0gb24NCj4+Pj4gVGh1bmRlclgxIGFuZCBGdWppdHN1IEE2NEZYLg0KPj4+IFRo
aXMgaXMgYSBwcm9ibGVtIGZvciBhbnkgYXBwbGljYXRpb25zIHRoYXQgc2hhcmUgaGFyZHdhcmUg
cmVzb3VyY2VzIHdpdGgNCj4+PiBlYWNoIG90aGVyLCBzbyBJIGRvbid0IHRoaW5rIGl0J3Mgc29t
ZXRoaW5nIHdlIHNob3VsZCBiZSB0b28gY29uY2VybmVkIGFib3V0DQo+Pj4gYWRkcmVzc2luZyB1
bmxlc3MgdGhlcmUgaXMgYSBwcmFjdGljYWwgRG9TIHNjZW5hcmlvLCB3aGljaCB0aGVyZSBkb2Vz
bid0DQo+Pj4gYXBwZWFyIHRvIGJlIGluIHRoaXMgY2FzZS4gSXQgbWF5IGJlIHRoYXQgdGhlIHJl
YWwgYW5zd2VyIGlzICJkb24ndCBjYWxsDQo+Pj4gbXByb3RlY3QoKSBpbiBhIGxvb3AiLg0KPj4g
SSB0aGluayB0aGVyZSBoYXMgYmVlbiBhIG1pc3VuZGVyc3RhbmRpbmcsIHBsZWFzZSBsZXQgbWUg
ZXhwbGFpbi4NCj4+IFRoaXMgYXBwbGljYXRpb24gaXMganVzdCBhbiBleGFtcGxlIHVzaW5nIGZv
ciByZXByb2R1Y2luZyB0aGUNCj4+IHBlcmZvcm1hbmNlIGlzc3VlIHdlIGZvdW5kLg0KPj4gT3Vy
IG9yaWdpbmFsIHB1cnBvc2UgaXMgcmVkdWNpbmcgT1Mgaml0dGVyIGJ5IHRoaXMgc2VyaWVzLg0K
Pj4gVGhlIE9TIGppdHRlciBvbiBtYXNzaXZlbHkgcGFyYWxsZWwgcHJvY2Vzc2luZyBzeXN0ZW1z
IGhhdmUgYmVlbiBrbm93bg0KPj4gYW5kIHN0dWRpZWQgZm9yIG1hbnkgeWVhcnMuDQo+PiBUaGUg
Mi41JSBPUyBqaXR0ZXIgY2FuIHJlc3VsdCBpbiBvdmVyIGEgZmFjdG9yIG9mIDIwIHNsb3dkb3du
IGZvciB0aGUNCj4+IHNhbWUgYXBwbGljYXRpb24gWzFdLg0KPiBJIHRoaW5rIGl0J3Mgd29ydGgg
cG9pbnRpbmcgb3V0IHRoYXQgdGhlIHN5c3RlbSBpbiBxdWVzdGlvbiB3YXMgbmVpdGhlcg0KPiBB
Uk0tYmFzZWQgbm9yIHJ1bm5pbmcgTGludXgsIHNvIEknZCBiZSBjYXV0aW91cyBpbiBhcHBseWlu
ZyB0aGUgY29uY2x1c2lvbnMNCj4gb2YgdGhhdCBwYXBlciBkaXJlY3RseSB0byBvdXIgVExCIGlu
dmFsaWRhdGlvbiBjb2RlLiBGdXJ0aGVybW9yZSwgdGhlIG5vaXNlDQo+IGJlaW5nIGdlbmVyYXRl
ZCBpbiB0aGVpciBleHBlcmltZW50cyB1c2VzIGEgdGltZXIgaW50ZXJydXB0LCB3aGljaCBoYXMg
YQ0KPiAvdmFzdGx5LyBkaWZmZXJlbnQgcHJvZmlsZSB0byBhIERWTSBtZXNzYWdlIGluIHRlcm1z
IG9mIGJvdGggc3lzdGVtIGltcGFjdA0KPiBhbmQgZnJlcXVlbmN5Lg0KTXkgb3JpZ2luYWwgcHVy
cG9zZSB3YXMgdG8gZXhwbGFpbiB0aGF0IHRoZSBPUyBqaXR0ZXIgaXMgYSB2aXRhbCBpc3N1ZSBm
b3INCmxhcmdlLXNjYWxlIEhQQyBlbnZpcm9ubWVudCBieSByZWZlcmVuY2luZyB0aGlzIHBhcGVy
Lg0KUGxlYXNlIGFsbG93IG1lIHRvIGludHJvZHVjZSB0aGUgaXNzdWUgdGhhdCBoYWQgb2NjdXJy
ZWQgdG8gb3VyIEhQQyANCmVudmlyb25tZW50Lg0KV2UgdXNlZCBGV1EgWzFdIHRvIGRvIGFuIGV4
cGVyaW1lbnQgb24gMSBub2RlIG9mIG91ciBIUEMgZW52aXJvbm1lbnQsDQp3ZSBleHBlY3RlZCBp
dCB3b3VsZCBiZSB0ZW5zIG9mIG1pY3Jvc2Vjb25kcyBvZiBtYXhpbXVtIE9TIGppdHRlciwgYnV0
IA0KaXQgd2FzDQpodW5kcmVkcyBvZiBtaWNyb3NlY29uZHMsIHdoaWNoIGRpZG4ndCBtZWV0IG91
ciByZXF1aXJlbWVudC4gV2UgdHJpZWQgdG8gDQpmaW5kDQpvdXQgdGhlIGNhdXNlIGJ5IHVzaW5n
IGZ0cmFjZSwgYnV0IHdlIGNhbm5vdCBmaW5kIGFueSBwcm9jZXNzZXMgd2hpY2ggd291bGQNCmNh
dXNlIG5vaXNlIGFuZCBvbmx5IGtuZXcgdGhlIGV4dGVuc2lvbiBvZiBwcm9jZXNzaW5nIHRpbWUu
IFRoZW4gd2UgDQpjb25maXJtZWQNCnRoZSBDUFUgaW5zdHJ1Y3Rpb24gY291bnQgdGhyb3VnaCBD
UFUgUE1VLCB3ZSBhbHNvIGRpZG4ndCBmaW5kIGFueSBjaGFuZ2VzLg0KSG93ZXZlciwgd2UgZm91
bmQgdGhhdCB3aXRoIHRoZSBpbmNyZWFzZSBvZiB0aGF0IHRoZSBUTEIgZmxhc2ggd2FzIGNhbGxl
ZCwNCnRoZSBub2lzZSB3YXMgYWxzbyBpbmNyZWFzaW5nLiBIZXJlIHdlIHVuZGVyc3Rvb2QgdGhh
dCB0aGUgY2F1c2Ugb2YgdGhpcyANCmlzc3VlDQppcyB0aGUgaW1wbGVtZW50YXRpb24gb2YgTGlu
dXgncyBUTEIgZmx1c2ggZm9yIGFybTY0LCBlc3BlY2lhbGx5IHVzZSBvZiANClRMQkktaXMNCmlu
c3RydWN0aW9uIHdoaWNoIGlzIGEgYnJvYWRjYXN0IHRvIGFsbCBwcm9jZXNzb3IgY29yZSBvbiB0
aGUgc3lzdGVtLiANClRoZXJlZm9yZSwNCndlIG1hZGUgdGhpcyBwYXRjaCBzZXQgdG8gZml4IHRo
aXMgaXNzdWUuIEFmdGVyIHRlc3RpbmcgZm9yIHNldmVyYWwgDQp0aW1lcywgdGhlDQpub2lzZSB3
YXMgcmVkdWNlZCBhbmQgb3VyIG9yaWdpbmFsIGdvYWwgd2FzIGFjaGlldmVkLCBzbyB3ZSBkbyB0
aGluayANCnRoaXMgcGF0Y2gNCm1ha2VzIHNlbnNlLg0KDQpBcyBJIG1lbnRpb25lZCwgdGhlIE9T
IGppdHRlciBpcyBhIHZpdGFsIGlzc3VlIGZvciBsYXJnZS1zY2FsZSBIUEMgDQplbnZpcm9ubWVu
dC4NCldlIHRyaWVkIGEgbG90IG9mIHRoaW5ncyB0byByZWR1Y2UgdGhlIE9TIGppdHRlci4gT25l
IG9mIHRoZW0gaXMgdGFzayANCnNlcGFyYXRpb24NCmJldHdlZW4gdGhlIENQVXMgd2hpY2ggYXJl
IHVzZWQgZm9yIGNvbXB1dGluZyBhbmQgdGhlIENQVXMgd2hpY2ggYXJlIA0KdXNlZCBmb3INCm1h
aW50ZW5hbmNlLiBBbGwgb2YgdGhlIGRhZW1vbiBwcm9jZXNzZXMgYW5kIEkvTyBpbnRlcnJ1cHRz
IGFyZSBib3VuZGVuIA0KdG8gdGhlDQptYWludGVuYW5jZSBDUFVzLiBGdXJ0aGVyIG1vcmUsIHdl
IHVzZWQgbm9oel9mdWxsIHRvIGF2b2lkIHRoZSBub2lzZSANCmNhdXNlZCBieQ0KY29tcHV0aW5n
IENQVSBpbnRlcnJ1cHRpb24sIGJ1dCBhbGwgb2YgdGhlIENQVXMgd2VyZSBhZmZlY3RlZCBieSBU
TEJJLWlzDQppbnN0cnVjdGlvbiwgdGhlIHRhc2sgc2VwYXJhdGlvbiBvZiBDUFVzIGRpZG4ndCB3
b3JrLiBUaGVyZWZvcmUsIHdlIA0Kd291bGQgbGlrZQ0KdG8gaW1wbGVtZW50IHRoYXQgVExCIGZs
dXNoIGlzIGRvbmUgb24gbWluaW1hbCBDUFVzIHRvIHJlZHVjaW5nIHRoZSBPUyANCmppdHRlcg0K
YnkgdXNpbmcgdGhpcyBwYXRjaCBzZXQuDQoNClsxXSBodHRwczovL2FzYy5sbG5sLmdvdi9zZXF1
b2lhL2JlbmNobWFya3MvRlRRX3N1bW1hcnlfdjEuMS5wZGYNCg0KVGhhbmtzLA0KUUkgRnVsaQ0K
DQo+PiBUaG91Z2ggaXQgbWF5IGJlIGFuIGV4dHJlbWUgZXhhbXBsZSwgcmVkdWNpbmcgdGhlIE9T
IGppdHRlciBoYXMgYmVlbiBhbg0KPj4gaXNzdWUgaW4gSFBDIGVudmlyb25tZW50Lg0KPj4NCj4+
IFsxXSBGZXJyZWlyYSwgS3VydCBCLiwgUGF0cmljayBCcmlkZ2VzLCBhbmQgUm9uIEJyaWdodHdl
bGwuDQo+PiAiQ2hhcmFjdGVyaXppbmcgYXBwbGljYXRpb24gc2Vuc2l0aXZpdHkgdG8gT1MgaW50
ZXJmZXJlbmNlIHVzaW5nDQo+PiBrZXJuZWwtbGV2ZWwgbm9pc2UgaW5qZWN0aW9uLiIgUHJvY2Vl
ZGluZ3Mgb2YgdGhlIDIwMDggQUNNL0lFRUUNCj4+IGNvbmZlcmVuY2Ugb24gU3VwZXJjb21wdXRp
bmcuIElFRUUgUHJlc3MsIDIwMDguDQo+Pg0KPj4+PiBJIHN1cHBvc2UgdGhlIHJvb3QgY2F1c2Ug
b2YgdGhpcyBpc3N1ZSBpcyB0aGUgaW1wbGVtZW50YXRpb24gb2YgTGludXgncyBUTEINCj4+Pj4g
Zmx1c2ggZm9yIGFybTY0LCBlc3BlY2lhbGx5IHVzZSBvZiBUTEJJLWlzIGluc3RydWN0aW9uIHdo
aWNoIGlzIGEgYnJvYWRjYXN0DQo+Pj4+IHRvIGFsbCBwcm9jZXNzb3IgY29yZSBvbiB0aGUgc3lz
dGVtLiBJbiBjYXNlIG9mIHRoZSBhYm92ZSBzaXR1YXRpb24sDQo+Pj4+IFRMQkktaXMgaXMgY2Fs
bGVkIGJ5IG1wcm90ZWN0KCkuDQo+Pj4gT24gdGhlIGZsaXAgc2lkZSwgTGludXggaXMgcHJvdmlk
aW5nIHRoZSBoYXJkd2FyZSB3aXRoIGVub3VnaCBpbmZvcm1hdGlvbg0KPj4+IG5vdCB0byBicm9h
ZGNhc3QgdG8gY29yZXMgZm9yIHdoaWNoIHRoZSByZW1vdGUgVExCcyBkb24ndCBoYXZlIGVudHJp
ZXMNCj4+PiBhbGxvY2F0ZWQgZm9yIHRoZSBBU0lEIGJlaW5nIGludmFsaWRhdGVkLiBJIHdvdWxk
IHNheSB0aGF0IHRoZSByb290IGNhdXNlDQo+Pj4gb2YgdGhlIGlzc3VlIGlzIHRoYXQgdGhpcyBm
aWx0ZXJpbmcgaXMgbm90IHRha2luZyBwbGFjZS4NCj4+IERvIHlvdSBtZWFuIHRoYXQgdGhlIGZp
bHRlciBzaG91bGQgYmUgaW1wbGVtZW50ZWQgaW4gaGFyZHdhcmU/DQo+IFllcy4gSWYgeW91J3Jl
IGJ1aWxkaW5nIGEgbGFyZ2Ugc3lzdGVtIGFuZCB5b3UgY2FyZSBhYm91dCAiaml0dGVyIiwgdGhl
bg0KPiB5b3UgZWl0aGVyIG5lZWQgdG8gcGFydGl0aW9uIGl0IGluIHN1Y2ggYSB3YXkgdGhhdCBz
b3VyY2VzIG9mIG5vaXNlIGFyZQ0KPiBjb250YWluZWQsIG9yIHlvdSBuZWVkIHRvIGludHJvZHVj
ZSBmaWx0ZXJzIHRvIGxpbWl0IHRoZWlyIHNjb3BlLiBSZXdyaXRpbmcNCj4gdGhlIGxvdy1sZXZl
bCBtZW1vcnktbWFuYWdlbWVudCBwYXJ0cyBvZiB0aGUgb3BlcmF0aW5nIHN5c3RlbSBpcyBhIHJl
ZA0KPiBoZXJyaW5nIGFuZCBpbXBvc2VzIGEgbmVlZGxlc3MgYnVyZGVuIG9uIGV2ZXJ5Ym9keSBl
bHNlIHdpdGhvdXQgc29sdmluZw0KPiB0aGUgcmVhbCBwcm9ibGVtLCB3aGljaCBpcyB0aGF0IGNv
bnRlbmRlZCB1c2Ugb2Ygc2hhcmVkIHJlc291cmNlcyBkb2Vzbid0DQo+IHNjYWxlLg0KPg0KPiBX
aWxs
