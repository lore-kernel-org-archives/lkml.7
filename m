Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC1EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7571206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TvOPPdgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfFEQE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:04:58 -0400
Received: from mail-eopbgr740048.outbound.protection.outlook.com ([40.107.74.48]:17244
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfFEQE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU3Dxs3YR3VUOaJWBsLc32Dxjtf/IRrmdna1MMkd3x0=;
 b=TvOPPdgZ2WBSoqf7R8u9aYotWJQ3obTKMymhX47n74m72UguQcMnGnji5k7emvEen089mEtvvICNpVp7RYWHEAuC+1rzEUXKZto42o05+8TBdGt45VMma2jLuwFQC0F/EgXUkx/JVnJYBkPsHEPwHfNbGjfdY3CSqpDE5Vfe9jw=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3035.namprd12.prod.outlook.com (20.178.30.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 16:04:15 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 16:04:15 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Baoquan He <bhe@redhat.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: The current SME implementation fails kexec/kdump kernel booting.
Thread-Topic: The current SME implementation fails kexec/kdump kernel booting.
Thread-Index: AQHVGtxpl7Okj5q6IUu+1zsUud1soaaLUoUAgADqpACAAP2/AA==
Date:   Wed, 5 Jun 2019 16:04:14 +0000
Message-ID: <0d9fba9d-7bbe-a7c7-dfe4-696da0dfecc4@amd.com>
References: <20190604134952.GC26891@MiWiFi-R3L-srv>
 <508c2853-dc4f-70a6-6fa8-97c950dc31c6@amd.com>
 <20190605005600.GF26891@MiWiFi-R3L-srv>
In-Reply-To: <20190605005600.GF26891@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0018.namprd02.prod.outlook.com
 (2603:10b6:803:2b::28) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 636a69d6-73fe-45fc-d339-08d6e9cf74ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3035;
x-ms-traffictypediagnostic: DM6PR12MB3035:
x-microsoft-antispam-prvs: <DM6PR12MB303568A190696939DBD2B42CEC160@DM6PR12MB3035.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(478600001)(66066001)(73956011)(14444005)(72206003)(305945005)(8936002)(66446008)(4326008)(36756003)(14454004)(386003)(66476007)(256004)(6246003)(26005)(25786009)(5660300002)(76176011)(6506007)(68736007)(53546011)(66556008)(64756008)(476003)(316002)(81166006)(7736002)(6436002)(2616005)(102836004)(2906002)(52116002)(229853002)(11346002)(66946007)(99286004)(71190400001)(86362001)(71200400001)(6486002)(31686004)(31696002)(8676002)(54906003)(6116002)(3846002)(6512007)(6916009)(446003)(53936002)(186003)(81156014)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3035;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mb0wgSEArtYEQaeZKi97Vu+LNYw/J/ymDoDk4AlGsHEjgZZbLdftEakjs9BdI7EPPop7FyUhhzoYSJWZX2Hui+RImoblt5j7TRpxYqA1SaVdhqv/qSiZlYjkLWk+Holuw6uo4ne0K6NGcwJQvpHQliuUQUfvGluRAjWRaXsEFSezDuLxLzq5JPh4QBiALsuLuS2oI5sfpFFCAAV7tC4JMDBl9NoMO38upScYxGPbO6J4Bb04OH5DJkdpt/78QzL10Y5dHt2VdfSeyUBOHfk+qsOHjWOJqac0ikBYwA0Rrkl7pb1Z2qjF51STEyBzZGF98eQTRg0btRqWB/KI5OTdij7GjH/FE6lGWsK+PH/qquNiq/TCCZ6ZpPtvdw9okmy3ZNZx8lNSPRmvc1DzQO7TZ7w5eD1CXnUOQ/0FB0mE+p0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B84EE748BF0CF44F9E7ACFBC8B966561@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636a69d6-73fe-45fc-d339-08d6e9cf74ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 16:04:15.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi80LzE5IDc6NTYgUE0sIEJhb3F1YW4gSGUgd3JvdGU6DQo+IE9uIDA2LzA0LzE5IGF0IDAz
OjU2cG0sIExlbmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+PiBPbiA2LzQvMTkgODo0OSBBTSwgQmFv
cXVhbiBIZSB3cm90ZToNCj4+PiBIaSBUb20sDQo+Pj4NCj4+PiBMaWFuYm8gcmVwb3J0ZWQga2R1
bXAga2VybmVsIGNhbid0IGJvb3Qgd2VsbCB3aXRoICdub2thc2xyJyBhZGRlZCwgYW5kDQo+Pj4g
aGF2ZSB0byBlbmFibGUgS0FTTFIgaW4ga2R1bXAga2VybmVsIHRvIG1ha2UgaXQgYm9vdCBzdWNj
ZXNzZnVsbHkuIFRoaXMNCj4+PiBibG9ja2VkIGhpcyB3b3JrIG9uIGVuYWJsaW5nIHNtZSBmb3Ig
a2V4ZWMva2R1bXAuIEFuZCBvbiBzb21lIG1hY2hpbmVzDQo+Pj4gU01FIGtlcm5lbCBjYW4ndCBi
b290IGluIDFzdCBrZXJuZWwuDQo+Pj4NCj4+PiBJIGNoZWNrZWQgY29kZSBvZiBTTUUgaW1wbGVt
ZW50YXRpb24sIGFuZCBmb3VuZCBvdXQgdGhlIHJvb3QgY2F1c2UuIFRoZQ0KPj4+IGFib3ZlIGZh
aWx1cmVzIGFyZSBjYXVzZWQgYnkgU01FIGNvZGUsIHNtZV9lbmNyeXB0X2tlcm5lbCgpLiBJbg0K
Pj4+IHNtZV9lbmNyeXB0X2tlcm5lbCgpLCB5b3UgZ2V0IGEgMk0gb2YgZW5jcnlwdGlvbiB3b3Jr
IGFyZWEgYXMgaW50ZXJtZWRpYXRlDQo+Pj4gYnVmZmVyIHRvIGVuY3J5cHQga2VybmVsIGluLXBs
YWNlLiBBbmQgdGhlIHdvcmsgYXJlYSBpcyBqdXN0IGFmdGVyIF9lbmQgb2YNCj4+PiBrZXJuZWwu
DQo+Pg0KPj4gSSByZW1lbWJlciB3b3JyeWluZyBhYm91dCBzb21ldGhpbmcgbGlrZSB0aGlzIGJh
Y2sgd2hlbiBJIHdhcyB0ZXN0aW5nIHRoZQ0KPj4ga2V4ZWMgc3VwcG9ydC4gSSBoYWQgY29tZSB1
cCB3aXRoIGEgcGF0Y2ggdG8gYWRkcmVzcyBpdCwgYnV0IG5ldmVyIGdvdCB0aGUNCj4+IHRpbWUg
dG8gdGVzdCBhbmQgc3VibWl0IGl0LiAgSSd2ZSBpbmNsdWRlZCBpdCBoZXJlIGlmIHlvdSdkIGxp
a2UgdG8gdGVzdA0KPj4gaXQgKEkgaGF2ZW4ndCBkb25lIHJ1biB0aGlzIHBhdGNoIGluIHF1aXRl
IHNvbWUgdGltZSkuIElmIGl0IHdvcmtzLCB3ZSBjYW4NCj4+IHRoaW5rIGFib3V0IHN1Ym1pdHRp
bmcgaXQuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2UgYW5kIG1ha2luZyB0
aGlzIHBhdGNoLCBUb20uDQo+IA0KPiBUZXN0ZWQgb24gYSBzcGVlZHdheSBtYWNoaW5lLCBpdCBl
bnRlcmVkIGludG8ga2VybmVsLCBidXQgZmFpbGVkIGluDQo+IGJlbG93IHN0YWdlLiBUZXN0ZWQg
dHdvIHRpbWVzLCBhbHdheXMgaGFwcGVuZWQuDQoNCklzIHRoaXMgdGhlIGluaXRpYWwga2VybmVs
IGJvb3Qgb3IgdGhlIGtleGVjIGtlcm5lbCBib290Pw0KDQpJdCBsb29rcyBsaWtlIHRoaXMgaXMg
cmVsYXRlZCB0byB0aGUgaW5pdHJkL2luaXRyYW1mcyBkZWNyeXB0aW9uLiBOb3QNCnN1cmUgd2hh
dCBjb3VsZCBiZSBoYXBwZW5pbmcgdGhlcmUuIEkganVzdCB0cmllZCB0aGUgcGF0Y2ggb24gbXkg
TmFwbGVzDQpzeXN0ZW0gYW5kIGEgNS4yLjAtcmMzIGtlcm5lbCBhbmQgaGF2ZSBiZWVuIGFibGUg
dG8gcmVwZWF0ZWRseSBrZXhlYyBib290DQphIG51bWJlciBvZiB0aW1lcyBzbyBmYXIuDQoNClRo
YW5rcywNClRvbQ0KDQo+IA0KPiANCj4gWyAgICA0Ljk3ODUyMV0gRnJlZWluZyB1bnVzZWQgZGVj
cnlwdGVkIG1lbW9yeTogMjA0MEsNCj4gWyAgICA0Ljk4MzgwMF0gRnJlZWluZyB1bnVzZWQga2Vy
bmVsIGltYWdlIG1lbW9yeTogMjM0NEsNCj4gWyAgICA0Ljk4ODk0M10gV3JpdGUgcHJvdGVjdGlu
ZyB0aGUga2VybmVsIHJlYWQtb25seSBkYXRhOiAxODQzMmsNCj4gWyAgICA0Ljk5NTMwNl0gRnJl
ZWluZyB1bnVzZWQga2VybmVsIGltYWdlIG1lbW9yeTogMjAxMksNCj4gWyAgICA1LjAwMDQ4OF0g
RnJlZWluZyB1bnVzZWQga2VybmVsIGltYWdlIG1lbW9yeTogMjU2Sw0KPiBbICAgIDUuMDA1NTQw
XSBSdW4gL2luaXQgYXMgaW5pdCBwcm9jZXNzDQo+IFsgICAgNS4wMDk0NDNdIEtlcm5lbCBwYW5p
YyAtIG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0ISBleGl0Y29kZT0weDAwMDA3
ZjAwDQo+IFsgICAgNS4wMTcyMzBdIENQVTogMCBQSUQ6IDEgQ29tbTogaW5pdCBOb3QgdGFpbnRl
ZCA1LjIuMC1yYzIrICMzOA0KPiBbICAgIDUuMDIzMjUxXSBIYXJkd2FyZSBuYW1lOiBBTUQgQ29y
cG9yYXRpb24gU3BlZWR3YXkvU3BlZWR3YXksIEJJT1MgUlNXMTAwNEIgMTAvMTgvMjAxNw0KPiBb
ICAgIDUuMDMxMjk5XSBDYWxsIFRyYWNlOg0KPiBbICAgIDUuMDMzNzkzXSAgZHVtcF9zdGFjaysw
eDQ2LzB4NjANCj4gWyAgICA1LjAzNzE2OV0gIHBhbmljKzB4ZmIvMHgyY2INCj4gWyAgICA1LjA0
MDE5MV0gIGRvX2V4aXQuY29sZC4yMSsweDU5LzB4ODENCj4gWyAgICA1LjA0NDAwNF0gIGRvX2dy
b3VwX2V4aXQrMHgzYS8weGEwDQo+IFsgICAgNS4wNDc2NDBdICBfX3g2NF9zeXNfZXhpdF9ncm91
cCsweDE0LzB4MjANCj4gWyAgICA1LjA1MTg5OV0gIGRvX3N5c2NhbGxfNjQrMHg1NS8weDFjMA0K
PiBbICAgIDUuMDU1NjI3XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhh
OQ0KPiBbICAgIDUuMDYwNzY0XSBSSVA6IDAwMzM6MHg3ZmExYjFmYzllMmUNCj4gWyAgICA1LjA2
NDQwNF0gQ29kZTogQmFkIFJJUCB2YWx1ZS4NCj4gWyAgICA1LjA2NzY4N10gUlNQOiAwMDJiOjAw
MDA3ZmZmYzVhYmI3NzggRUZMQUdTOiAwMDAwMDIwMiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBl
Nw0KPiBbICAgIDUuMDc1Mjk2XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2ZhMWIx
ZmQyNTI4IFJDWDogMDAwMDdmYTFiMWZjOWUyZQ0KPiBbICAgIDUuMDgyNjI1XSBSRFg6IDAwMDAw
MDAwMDAwMDAwN2YgUlNJOiAwMDAwMDAwMDAwMDAwMDNjIFJESTogMDAwMDAwMDAwMDAwMDA3Zg0K
PiBbICAgIDUuMDg5ODc5XSBSQlA6IDAwMDA3ZmExYjIxZDhkMDAgUjA4OiAwMDAwMDAwMDAwMDAw
MGU3IFIwOTogMDAwMDdmZmZjNWFiYjY4OA0KPiBbICAgIDUuMDk3MTM0XSBSMTA6IDAwMDAwMDAw
MDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjAyIFIxMjogMDAwMDAwMDAwMDAwMDAwMg0KPiBb
ICAgIDUuMTA0Mzg2XSBSMTM6IDAwMDAwMDAwMDAwMDAwMDEgUjE0OiAwMDAwN2ZhMWIyMWQ4ZDQw
IFIxNTogMDAwMDdmYTFiMjFkOGQzMA0KPiBbICAgIDUuMTExNjQ1XSBLZXJuZWwgT2Zmc2V0OiBk
aXNhYmxlZA0KPiBbICAgIDUuNDIzMDAyXSBSZWJvb3RpbmcgaW4gMTAgc2Vjb25kcy4uDQo+IFsg
ICAxNS40Mjk2NDFdIEFDUEkgTUVNT1JZIG9yIEkvTyBSRVNFVF9SRUcuDQo+IA0K
