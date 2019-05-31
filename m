Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F38C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABB3267EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="MI181h4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEaLCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:02:09 -0400
Received: from mail-eopbgr700056.outbound.protection.outlook.com ([40.107.70.56]:21839
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEaLCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3IENQ41Tvhoq/AxS/JuaDICZdOdJwVA5mzBHZY1Dcc=;
 b=MI181h4zONm7BxuZfTOtkOiRQhfAYCRt+F4OPwQbxrXCUBJIDSxA3j0uUdzrURSTkWaZo7rRVBWYLLhfJmLcj+D9fLemm1+sjuTzmpKY/3GcGtNe4JNFOmbQzz672n1dwt/bMsZISxqAkhPfOz8t/ie7wjl34nnLN7iEyybQaec=
Received: from CH2PR15MB3575.namprd15.prod.outlook.com (52.132.228.77) by
 CH2PR15MB3576.namprd15.prod.outlook.com (52.132.228.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Fri, 31 May 2019 11:02:04 +0000
Received: from CH2PR15MB3575.namprd15.prod.outlook.com
 ([fe80::8d6a:e759:6fd:5ee0]) by CH2PR15MB3575.namprd15.prod.outlook.com
 ([fe80::8d6a:e759:6fd:5ee0%7]) with mapi id 15.20.1943.018; Fri, 31 May 2019
 11:02:04 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     Ying Xue <ying.xue@windriver.com>, Mihai Moldovan <ionic@ionic.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Userspace woes with 5.1.5 due to TIPC
Thread-Topic: Userspace woes with 5.1.5 due to TIPC
Thread-Index: AQHVFx6rf0Q3NUZ4q0Cvx22vAuNEcKaEEfNQgAARi4CAAEFUAIAArCcQ
Date:   Fri, 31 May 2019 11:02:04 +0000
Message-ID: <CH2PR15MB3575E1402F1FF4418C8C67139A190@CH2PR15MB3575.namprd15.prod.outlook.com>
References: <4ad776cb-c597-da1d-7d5e-af39ded17c40@ionic.de>
 <CH2PR15MB3575BD29C90539022364B8719A180@CH2PR15MB3575.namprd15.prod.outlook.com>
 <1780dd6a-9546-0df5-7fb2-44b78643b079@ionic.de>
 <3cc60b11-2b63-3bfc-2be8-569f2b0ce7cf@windriver.com>
In-Reply-To: <3cc60b11-2b63-3bfc-2be8-569f2b0ce7cf@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [24.225.233.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af2806c2-d514-49be-e35b-08d6e5b76a76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR15MB3576;
x-ms-traffictypediagnostic: CH2PR15MB3576:
x-microsoft-antispam-prvs: <CH2PR15MB3576711843A23A3C4C7C5B389A190@CH2PR15MB3576.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(396003)(346002)(199004)(189003)(13464003)(6436002)(316002)(9686003)(110136005)(55016002)(229853002)(3846002)(2906002)(2501003)(8936002)(5660300002)(81166006)(81156014)(476003)(486006)(53936002)(68736007)(446003)(11346002)(44832011)(8676002)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(76116006)(186003)(86362001)(33656002)(66066001)(74316002)(6116002)(305945005)(6246003)(99286004)(7736002)(14454004)(478600001)(25786009)(6506007)(53546011)(71190400001)(71200400001)(102836004)(256004)(76176011)(14444005)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR15MB3576;H:CH2PR15MB3575.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8/Nc0HUIsUSQvx4sQ64dLfuzh9s1JRqUDnhbpRb8adoSk0UTjeBDmUvcvgUKbLhyq0+GimXao/f/ecenKdmYVeqh6U3lMtB4ux0tq93UbWDrm/u8l41KsGlubY8GfJ8X+rSd1XMd/Df61V0j64wu1tF6sRzeQuxcHZCFTnz9y7JzltZogZJz8hAKtVvAbNk7EuDIygCtMRSxLue0UQ2sEtDg6ZJU6Zv/Bup+1ePwzPYOnn0Vm27mmygPbsyFc9nLvwFby3YVViqDEo6DwbbOccRx47spNUykppFfxJXVH2ZzPcNhvLpj6dEkz/EZNGHc3pho8rCmFOPBgIifxGaZ+bNIJBsUeojF19w2pLyfVNd8i12AMHz4l6KwOmHms/4yxeE3LTiPL6a9euNh3gdKfXBeR5yY9ChaTAvV4sBeRM8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2806c2-d514-49be-e35b-08d6e5b76a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 11:02:04.5017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jon.maloy@ericsson.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWluZyBYdWUgPHlpbmcu
eHVlQHdpbmRyaXZlci5jb20+DQo+IFNlbnQ6IDMwLU1heS0xOSAyMDo0MQ0KPiBUbzogTWloYWkg
TW9sZG92YW4gPGlvbmljQGlvbmljLmRlPjsgSm9uIE1hbG95DQo+IDxqb24ubWFsb3lAZXJpY3Nz
b24uY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogVXNl
cnNwYWNlIHdvZXMgd2l0aCA1LjEuNSBkdWUgdG8gVElQQw0KPiANCj4gT24gNS8zMS8xOSA0OjQ3
IEFNLCBNaWhhaSBNb2xkb3ZhbiB3cm90ZToNCj4gPiAqIE9uIDUvMzAvMTkgOTo1MSBQTSwgSm9u
IE1hbG95IHdyb3RlOg0KPiA+PiBNYWtlIHN1cmUgdGhlIGZvbGxvd2luZyB0aHJlZSBjb21taXRz
IGFyZSBwcmVzZW50IGluIFRJUEMgKmFmdGVyKiB0aGUNCj4gb2ZmZW5kaW5nIGNvbW1pdDoNCj4g
Pj4NCj4gPj4gY29tbWl0IDUzMmIwZjdlY2U0YyAidGlwYzogZml4IG1vZHByb2JlIHRpcGMgZmFp
bGVkIGFmdGVyIHN3aXRjaCBvcmRlciBvZg0KPiBkZXZpY2UgcmVnaXN0cmF0aW9uIg0KPiA+DQo+
ID4gVGhpcyAqaXMqIHRoZSBvZmZlbmRpbmcgY29tbWl0LCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5k
LiBNZXJlbHkgcmViYXNlZA0KPiA+IGluIGxpbnV4LXN0YWJsZSwgYW5kIGhlbmNlIGhhdmluZyBh
IGRpZmZlcmVudCBTSEEsIGJ1dCBtZW50aW9uaW5nIHRoZQ0KPiA+IG9yaWdpbmFsIFNIQSAoaS5l
LiwgNTMyYjBmN2VjZTRjKSBpbiBpdHMgY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPg0KPiA+PiBT
aW5jZSB0aGF0IHBhdGNoIG9uZSB3YXMgZmxhd2VkIGl0IGhhZCB0byBiZSByZXZlcnRlZDoNCj4g
Pj4gY29tbWl0IDU1OTM1MzBlNTY5NCAgIiJSZXZlcnQgdGlwYzogZml4IG1vZHByb2JlIHRpcGMg
ZmFpbGVkIGFmdGVyIHN3aXRjaA0KPiBvcmRlciBvZiBkZXZpY2UgcmVnaXN0cmF0aW9uIg0KPiA+
Pg0KPiA+PiBJdCB3YXMgdGhlbiByZXBsYWNlZCB3aXRoIHRoaXMgb25lOg0KPiA+PiBjb21taXQg
NTI2ZjViODUxYTk2ICJ0aXBjOiBmaXggbW9kcHJvYmUgdGlwYyBmYWlsZWQgYWZ0ZXIgc3dpdGNo
IG9yZGVyIG9mDQo+IGRldmljZSByZWdpc3RyYXRpb24iDQo+ID4NCj4gPiBPa2F5LCB0aGVzZSB0
d28gYXJlIG5vdCBwYXJ0IG9mIDUuMS41LiBJJ3ZlIGJhY2twb3J0ZWQgdGhlbSAoYW5kIG9ubHkN
Cj4gPiB0aGVzZSB0d28pIHRvIDUuMS41IGFuZCB0aGUgaXNzdWUocykgc2VlbSB0byBiZSBnb25l
LiBEZWZpbml0ZWx5DQo+ID4gc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGJhY2twb3J0ZWQgdG8v
aW5jbHVkZWQgaW4gNS4xLjYuDQo+ID4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgcG9pbnRpbmcgYWxs
IHRoYXQgb3V0ISBVbmZvcnR1bmF0ZWx5IEkgZGlkbid0IGFkZCBhbnl0aGluZw0KPiA+IHVzZWZ1
bCBidXQgbm9pc2UsIHNpbmNlIHlvdSBvYnZpb3VzbHkgYWxyZWFkeSBrbmV3LCB0aGF0IHRoaXMg
Y29tbWl0DQo+ID4gd2FzIGJyb2tlbi4gSSdkIHVyZ2UgR3JlZyB0byByZWxlYXNlIGEgbmV3IHN0
YWJsZSB2ZXJzaW9uIGluY2x1ZGluZw0KPiA+IHRoZSBmaXhlcyBzb29uLCBpZiBwb3NzaWJsZSwg
dGhvdWdoLCBmb3Igbm90IGJlaW5nIGFibGUgdG8gc3RhcnQvdXNlDQo+ID4gdXNlcnNwYWNlIGJy
b3dzZXJzIHNvdW5kcyBsaWtlIGEgcHJldHR5IGJhZCByZWdyZXNzaW9uIHRvIG1lLg0KPiA+DQo+
IA0KPiBOb3Qgb25seSBjb21taXQgNTI2ZjViODUxYTk2ICkoInRpcGM6IGZpeCBtb2Rwcm9iZSB0
aXBjIGZhaWxlZCBhZnRlciBzd2l0Y2gNCj4gb3JkZXIgb2YgZGV2aWNlIHJlZ2lzdHJhdGlvbiIp
IGhhcyB0byBiZSByZXZlcnRlZCwgYnV0IGFsc28gSSBmb3VuZCBjb21taXQNCj4gN2UyN2U4ZDYx
MzBjICgidGlwYzogc3dpdGNoIG9yZGVyIG9mIGRldmljZSByZWdpc3RyYXRpb24gdG8gZml4IGEg
Y3Jhc2giKQ0KPiBpbnRyb2R1Y2VkIGEgc2VyaW91cyByZWdyZXNzaW9uIHdoaWNoIG1ha2VzIHRp
cGMgaW50ZXJuYWwgdG9wb2xvZ3kgc2VydmljZQ0KPiBzZXJ2ZXIgZmFpbGVkIHRvIGJlIGNyZWF0
ZWQuDQoNClRoaXMgd2FzIHRoZSB2ZXJ5IHJlYXNvbiB0aGUgYnJva2VuIHBhdGNoIHdhcyBpbnRy
b2R1Y2VkLiBBRkFJSyB0aGVyZSBpcyBubyBwcm9ibGVtIGFmdGVyIHRoZSBjb3JyZWN0ZWQgdmVy
c2lvbiBvZiB0aGF0IHBhdGNoIHdhcyBhcHBsaWVkLg0KDQovLy9qb24NCg0KPiANCj4gVG9kYXkg
SSB3aWxsIGZpeCBpdCB3aXRoIHRoZSBmb2xsb3dpbmcgYXBwcm9hY2hlczoNCj4gMS4gUmV2ZXJ0
IGNvbW1pdCA3ZTI3ZThkNjEzMGMgKCJ0aXBjOiBzd2l0Y2ggb3JkZXIgb2YgZGV2aWNlIHJlZ2lz
dHJhdGlvbiB0bw0KPiBmaXggYSBjcmFzaCIpIDIuIFVzZSBhbm90aGVyIG1ldGhvZCB0byBzb2x2
ZSB0aGUgcHJvYmxlbSB0aGF0IGNvbW1pdA0KPiA3ZTI3ZThkNjEzMGMgdHJpZXMgdG8gZml4Lg0K
PiANCj4gVGhhbmtzLA0KPiBZaW5nDQo+IA0KPiA+DQo+ID4NCj4gPiBNaWhhaQ0KPiA+DQo=
