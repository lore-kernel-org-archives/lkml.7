Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FFCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E863621873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Ahz1xI3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCTTh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:37:26 -0400
Received: from mail-eopbgr740097.outbound.protection.outlook.com ([40.107.74.97]:58588
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbfCTThZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhmx74KzE3zfX/OzOcAsYvVFbEt36CxkapWoOBx9BPs=;
 b=Ahz1xI3gkRFm3AouaKurceGo/LbP5n0Vimz54CAxxSfQ5h+Wb3L1ADb+xDiY4Y5dQ8clTpoH/mooM7xdfh0DGO7ZkzSq1pFYgWOB88LE+sePeQ/2CMv0EsKjMAEEiWkZkiNMZmzzMPtKm8Fz6LTEWMdJnVkFFDVZDDn3tSiVDMY=
Received: from MWHPR2201MB1358.namprd22.prod.outlook.com (10.174.162.148) by
 MWHPR2201MB1294.namprd22.prod.outlook.com (10.174.162.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 19:37:19 +0000
Received: from MWHPR2201MB1358.namprd22.prod.outlook.com
 ([fe80::8c88:68f5:2d71:c8fd]) by MWHPR2201MB1358.namprd22.prod.outlook.com
 ([fe80::8c88:68f5:2d71:c8fd%7]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 19:37:19 +0000
From:   Hassan Naveed <hnaveed@wavecomp.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Paul Burton <pburton@wavecomp.com>
CC:     "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] MIPS: eBPF: Initial eBPF support for MIPS32
 architecture.
Thread-Topic: [PATCH v2 3/3] MIPS: eBPF: Initial eBPF support for MIPS32
 architecture.
Thread-Index: AQHU2SWseMNIwzbpm0W2ah2TnQcK0KYUmisAgABYvMA=
Date:   Wed, 20 Mar 2019 19:37:19 +0000
Message-ID: <MWHPR2201MB13583388481F01A422CE7D66D4410@MWHPR2201MB1358.namprd22.prod.outlook.com>
References: <20190312224706.6121-1-hnaveed@wavecomp.com>
 <20190312224706.6121-3-hnaveed@wavecomp.com>
 <98323a41-2851-d000-c928-242d055a5bc1@iogearbox.net>
In-Reply-To: <98323a41-2851-d000-c928-242d055a5bc1@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hnaveed@wavecomp.com; 
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b2ca842-9978-4824-9b3c-08d6ad6b777a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1294;
x-ms-traffictypediagnostic: MWHPR2201MB1294:
x-microsoft-antispam-prvs: <MWHPR2201MB12941A9650599E8A03B819F0D4410@MWHPR2201MB1294.namprd22.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39850400004)(199004)(189003)(229853002)(14454004)(6116002)(26005)(478600001)(6436002)(105586002)(3846002)(97736004)(186003)(305945005)(446003)(74316002)(106356001)(8676002)(81166006)(55016002)(486006)(11346002)(476003)(52536014)(81156014)(86362001)(2906002)(6246003)(316002)(5660300002)(110136005)(7416002)(7736002)(256004)(68736007)(6636002)(54906003)(25786009)(6506007)(8936002)(66066001)(53936002)(9686003)(33656002)(71190400001)(99286004)(4326008)(7696005)(76176011)(71200400001)(102836004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1294;H:MWHPR2201MB1358.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3vfh2iFd5ndwvgHrUKKQqIQd0Qd5NknUr2vRBQnwogtqeM8yN0xMaYr1Bjwn9XTmgkCQSG99sLA/Un8ySNWaEbLg8LKMsrDb3IVbI0efBSzFSfktIIESBp0zSuPKDzW/X95duyLx1nR5knWH1O5+K58uv8fvM05Wqbb22/UZduC7ssxAfJuPNywzCnsb9lKNTyVKCu9wcLlNEmpsZIDnbdv8Uw/uYZ1mvlIGps7UFvd+Sn/RNyHqCxwGZHEevYaDORhUqcjHSCDz9jpK6D99+sCVJitxlHV1czxyw9XN65ozkqUZc5f+hv5h1MaLULBzg0+8cLdif2nhZZDXCNNh12Uc9FfIe58MvLG7zbw3aV1YAZmvgJQFkgoLGXmeDSFTZoWxzv3Aj2pH4JJi1rXDfHqKmlP0EytpcmSWiO33M7U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2ca842-9978-4824-9b3c-08d6ad6b777a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 19:37:19.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQo+ID4NCj4gPk9uIDAzLzEyLzIwMTkgMTE6NDggUE0sIEhhc3NhbiBOYXZl
ZWQgd3JvdGU6DQo+ID4+IEN1cnJlbnRseSBNSVBTMzIgc3VwcG9ydHMgYSBKSVQgZm9yIGNsYXNz
aWMgQlBGIG9ubHksIG5vdCBleHRlbmRlZCBCUEYuDQo+ID4+IFRoaXMgcGF0Y2ggYWRkcyBKSVQg
c3VwcG9ydCBmb3IgZXh0ZW5kZWQgQlBGIG9uIE1JUFMzMiwgc28gY29kZSBpcw0KPiA+PiBhY3R1
YWxseSBKSVQnZWQgaW5zdGVhZCBvZiBiZWluZyBvbmx5IGludGVycHJldGVkLiBJbnN0cnVjdGlv
bnMgd2l0aA0KPiA+PiA2NC1iaXQgb3BlcmFuZHMgYXJlIG5vdCBzdXBwb3J0ZWQgYXQgdGhpcyBw
b2ludC4NCj4gPj4gV2UgY2FuIGRlbGV0ZSBjbGFzc2ljIEJQRiBiZWNhdXNlIHRoZSBrZXJuZWwg
d2lsbCB0cmFuc2xhdGUgY2xhc3NpYw0KPiA+PiBCUEYgcHJvZ3JhbXMgaW50byBleHRlbmRlZCBC
UEYgYW5kIEpJVCB0aGVtLCBlbGltaW5hdGluZyB0aGUgbmVlZCBmb3INCj4gPj4gY2xhc3NpYyBC
UEYuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEhhc3NhbiBOYXZlZWQgPGhuYXZlZWRAd2F2
ZWNvbXAuY29tPg0KPiA+DQo+ID5OaWNlISBEaWQgeW91IGNoZWNrIEJQRiB0ZXN0IHN1aXRlIChs
aWIvdGVzdF9icGYua28pIHRoYXQgYm90aCBiZWZvcmUvYWZ0ZXIgdGhlDQo+ID5zYW1lIG51bWJl
ciBvZiBjQlBGIHByb2dyYW1zIGNvdWxkIGJlIEpJVGVkPw0KDQpZZXMsIHdlIGRpZCBjaGVjayB0
aGF0IGFuZCB0aGUgbnVtYmVyIG9mIHRlc3RzIEpJVGVkIGlzIHNhbWUuIEhlbmNlIHdlIHRob3Vn
aHQgaXQncyBiZXR0ZXIgdG8gZ2V0IHJpZCBvZiBjQlBGIGFuZCBzaW1wbGlmeSB0aGluZ3MuDQoN
Cj4gPg0KPiA+UGxlYXNlIGFsc28gZm9sbG93LXVwIHRvIHVwZGF0ZSBEb2N1bWVudGF0aW9uL3N5
c2N0bC9uZXQudHh0LCBicGZfaml0X2VuYWJsZQ0KPiA+c2VjdGlvbiwgYW5kIGFkZGluZyB5b3Vy
c2VsZiBhcyBjby1tYWludGFpbmVyIGZvciAnQlBGIEpJVCBmb3IgTUlQUycgd291bGRuJ3QNCj4g
Pmh1cnQgZWl0aGVyIGlmIFBhdWwgd291bGQgYmUgZ29vZCB3aXRoIHRoYXQsIHRvby4NCj4gPg0K
DQpJJ2xsIHVwZGF0ZSB0aGUgYnBmX2ppdF9lbmFibGUgc2VjdGlvbiBpbiB0aGUgbmV4dCBwYXRj
aC4gSSBiZWxpZXZlIHRoaXMgb25lIGlzIGFscmVhZHkgYXBwbGllZC4NCg0KPiA+QW55IHBsYW5z
IG9uIGNvbXBsZXRpbmcgZUJQRiBzdXBwb3J0IGZvciBtaXBzMzI/DQoNCkl0IGRlZmluaXRlbHkg
aXMgb24gbXkgdG8tZG8gbGlzdCwgdGhvdWdoIEknbSBub3QgcXVpdGUgc3VyZSB3aGVuIEknZCBi
ZSBhYmxlIHRvIGdldCB0byBpdC4NCj4gPg0KPiA+VGhhbmtzLA0KPiA+RGFuaWVsDQo=
