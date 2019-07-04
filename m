Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CEE2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="mBPFXtBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfGDIG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:06:56 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:30142 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbfGDIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:06:56 -0400
X-Greylist: delayed 678 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2019 04:06:54 EDT
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6486Ajg010136;
        Thu, 4 Jul 2019 03:06:52 -0500
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2052.outbound.protection.outlook.com [104.47.50.52])
        by mx0b-00010702.pphosted.com with ESMTP id 2tg8maep1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 03:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygdb1fbnQIpOtj3HDo8tNPiNwOR6Ar/9ShUTb3u/3FM=;
 b=mBPFXtBBiOIiKJqGWDdjnE68cAR10U2i7+Mmjn6bOnYMtZpwEXPA9p92YVls4+G50s3PqxKvPj51kLJRgXPiEekwKT7RrJAKEFnRhyQelAv7NsYBOiYYjDdc2IyasTk/lticFXkEmKvr31iDhGGuSs4Uw3Fu6PJPd5W3e33dm3I=
Received: from MN2PR04MB5920.namprd04.prod.outlook.com (20.179.21.161) by
 MN2PR04MB6048.namprd04.prod.outlook.com (20.178.249.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.17; Thu, 4 Jul 2019 08:06:49 +0000
Received: from MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7]) by MN2PR04MB5920.namprd04.prod.outlook.com
 ([fe80::7ca2:1dbc:355d:64c7%5]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 08:06:49 +0000
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [priv] Re: [PATCH 1/2] serial/8250: Add support for
 NI-Serial PXI/PXIe+485 devices.
Thread-Index: AQHVMIWbCP+HEZ5Oukas+L+0Z4rj1qa44rGAgAE45iA=
Date:   Thu, 4 Jul 2019 08:06:49 +0000
Message-ID: <MN2PR04MB5920698467D04284077C92DBB7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190702032323.28967-1-je.yen.tam@ni.com>
 <435fe9ba-04c9-e797-f750-4eebffa82fe9@metux.net>
In-Reply-To: <435fe9ba-04c9-e797-f750-4eebffa82fe9@metux.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.75.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f64fc266-b0ac-4221-9828-08d7005690d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR04MB6048;
x-ms-traffictypediagnostic: MN2PR04MB6048:
x-microsoft-antispam-prvs: <MN2PR04MB60483D0B1D158AD2EFA51DE0B7FA0@MN2PR04MB6048.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(186003)(256004)(14444005)(76176011)(11346002)(446003)(102836004)(71200400001)(52536014)(6506007)(486006)(476003)(7696005)(8936002)(66066001)(478600001)(4326008)(53546011)(25786009)(81166006)(81156014)(8676002)(71190400001)(316002)(86362001)(99286004)(5660300002)(6436002)(26005)(9686003)(33656002)(3846002)(6116002)(2906002)(229853002)(53936002)(66556008)(66476007)(66446008)(6916009)(6246003)(55016002)(64756008)(73956011)(305945005)(66946007)(14454004)(7736002)(76116006)(74316002)(68736007)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6048;H:MN2PR04MB5920.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E/fThcsXk3bJDqa9B6wWj3k5c4ZmTPvKlFyCyyheUYnnhhyCtL60ecL/5LB/J12W6mUgeWPWxH3kbflX8u/h6tfFjvR+kmWHIkCGRScoq4iuN8FzB0+GjvmasR6VMVebsMfnIIFyXnfglkSqkoXPnm3nZlxr8qhNxgCgX5aeiXGapvLREqtoZr9XJmEsKFhtx3rNkPpZPPiw5J2M+LzB6OCLW5l0Xy2R/f8AyGvvIp4vNTplbdlFUYJbAQpZNZ8Mg60H3grQuzjnZ27X92tXlhS+mCe8HoniM6UDLeDwJVmfJK9u3JjFLWcX2ota5RiHLeHH19Oyvvy8ffXkpN2I8z8D8CDguPNjpEW1eUYNCX6A/uwO9DsL2/CBTIQfdg57pAlfeMCwCuIOMnPNzf0kWZpbRiuxHE/8CABbguserHQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64fc266-b0ac-4221-9828-08d7005690d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:06:49.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je.yen.tam@ni.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6048
Subject: RE: [priv] Re: [PATCH 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbRVhURVJOQUxdIFtwcml2XSBSZTogW1BBVENIIDEvMl0gc2VyaWFsLzgyNTA6
IEFkZCBzdXBwb3J0IGZvciBOSS1TZXJpYWwNCj4gUFhJL1BYSWUrNDg1IGRldmljZXMuDQo+IA0K
PiBPbiAwMi4wNy4xOSAwNToyMywgamV5ZW50YW0gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IGJl
dHRlciB3cml0aW5nIHRvIHlvdSBwZXJzb25hbGx5LCBvZmYtbGlzdC4NCj4gDQo+ID4gQWRkIHN1
cHBvcnQgZm9yIE5JLVNlcmlhbCBQWEllLVJTMjMyLCBQWEktUlM0ODUgYW5kIFBYSWUtUlM0ODUg
ZGV2aWNlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGpleWVudGFtIDxqZS55ZW4udGFtQG5p
LmNvbT4NCj4gICAgICAgICAgICAgICAgICAgXl5eXl5eDQo+IG1heWJlIGl0IHdvdWxkIGJlIG5p
Y2UgdG8gaGF2ZSB5b3VyIHJlYWwgbmFtZSBoZXJlLg0KDQpPaywgd2lsbCBkbyBzby4NCg0KPiAN
Cj4gPiBAQCAtMSwxMCArMSwxMCBAQA0KPiA+ICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMA0KPiA+ICAvKg0KPiA+IC0gKiAgUHJvYmUgbW9kdWxlIGZvciA4MjUwLzE2NTUwLXR5
cGUgUENJIHNlcmlhbCBwb3J0cy4NCj4gPiArICoJUHJvYmUgbW9kdWxlIGZvciA4MjUwLzE2NTUw
LXR5cGUgUENJIHNlcmlhbCBwb3J0cy4NCj4gPiAgICoNCj4gPiAtICogIEJhc2VkIG9uIGRyaXZl
cnMvY2hhci9zZXJpYWwuYywgYnkgTGludXMgVG9ydmFsZHMsIFRoZW9kb3JlIFRzJ28uDQo+ID4g
KyAqCUJhc2VkIG9uIGRyaXZlcnMvY2hhci9zZXJpYWwuYywgYnkgTGludXMgVG9ydmFsZHMsIFRo
ZW9kb3JlIFRzJ28uDQo+ID4gICAqDQo+ID4gLSAqICBDb3B5cmlnaHQgKEMpIDIwMDEgUnVzc2Vs
bCBLaW5nLCBBbGwgUmlnaHRzIFJlc2VydmVkLg0KPiA+ICsgKglDb3B5cmlnaHQgKEMpIDIwMDEg
UnVzc2VsbCBLaW5nLCBBbGwgUmlnaHRzIFJlc2VydmVkLg0KPiA+ICAgKi8NCj4gPiAgI3VuZGVm
IERFQlVHDQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gDQo+IFdoeSBhbGwgdGhl
c2Ugd2hpdGVzcGFjZS1vbmx5IGNoYW5nZXMgPyBJIGRvdWJ0IHRoYXQgYW55Ym9keSBzZXJpb3Vz
bHkgd2FubmENCj4gcmV2aWV3IHRoYXQuDQo+IA0KPiBBcyBJIGtub3cgR3JlZywgaGUncyBkb2Vz
bid0IGxpa2Ugd2hpdGVzcGFjZS1vbmx5IGNoYW5nZXMgYXQgYWxsLCB1bmxlc3MgeW91IGdpdmUg
aGltDQo+IGFuIHJlYWxseSBnb29kIHJlYXNvbiBmb3IgaXQuDQo+IA0KPiA+IEBAIC03MzAsOCAr
NzMwLDE2IEBAIHN0YXRpYyBpbnQgcGNpX25pODQzMF9pbml0KHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+ID4gfQ0KPiA+DQo+ID4gIC8qIFVBUlQgUG9ydCBDb250cm9sIFJlZ2lzdGVyICovDQo+ID4g
LSNkZWZpbmUgTkk4NDMwX1BPUlRDT04JMHgwZg0KPiA+IC0jZGVmaW5lIE5JODQzMF9QT1JUQ09O
X1RYVlJfRU5BQkxFCSgxIDw8IDMpDQo+IA0KPiBJJ2QgcHJlZmVyIHRoYXQgbmFtZSBjaGFuZ2Ug
YXMgYSBzZXBhcmF0ZSAocHJldmlvdXMpIHBhdGNoLg0KPiANCj4gPiArI2RlZmluZSBOSTE2NTUw
X1BDUl9PRkZTRVQJCQkJICAweDBmDQo+ID4gKyNkZWZpbmUgTkkxNjU1MF9QQ1JfUlM0MjIJCQkJ
ICAweDAwDQo+ID4gKyNkZWZpbmUgTkkxNjU1MF9QQ1JfRUNIT19SUzQ4NQkJCSAgMHgwMQ0KPiA+
ICsjZGVmaW5lIE5JMTY1NTBfUENSX0RUUl9SUzQ4NQkJCSAgMHgwMg0KPiA+ICsjZGVmaW5lIE5J
MTY1NTBfUENSX0FVVE9fUlM0ODUJCQkgIDB4MDMNCj4gPiArI2RlZmluZSBOSTE2NTUwX1BDUl9X
SVJFX01PREVfTUFTSwkJICAweDAzDQo+ID4gKyNkZWZpbmUgTkkxNjU1MF9QQ1JfVFhWUl9FTkFC
TEVfQklUCQkgICgxIDw8IDMpDQo+ID4gKyNkZWZpbmUgTkkxNjU1MF9QQ1JfUlM0ODVfVEVSTUlO
QVRJT05fQklUICgxIDw8IDYpDQo+ID4gKyNkZWZpbmUgTkkxNjU1MF9BQ1JfRFRSX0FVVE9fRFRS
CQkgICgweDIgPDwgMykNCj4gPiArI2RlZmluZSBOSTE2NTUwX0FDUl9EVFJfTUFOVUFMX0RUUgkJ
ICAoMHgwIDw8IDMpDQo+IA0KPiB5b3Ugc2hvdWxkIHVzZSB0aGUgQklUKCkgbWFjcm8gaGVyZS4N
Cg0KV2lsbCBkbyBzby4NCg0KPiANCj4gPiArc3RhdGljIGludCBwY2lfbmk4NDMxX2NvbmZpZ19y
czQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LA0KPiA+ICsJc3RydWN0IHNlcmlhbF9yczQ4NSAq
cnM0ODUpDQo+ID4gK3sNCj4gPiArCXU4IHBjciwgYWNyOw0KPiA+ICsNCj4gPiArCXN0cnVjdCB1
YXJ0XzgyNTBfcG9ydCAqdXA7DQo+ID4gKw0KPiA+ICsJdXAgPSBjb250YWluZXJfb2YocG9ydCwg
c3RydWN0IHVhcnRfODI1MF9wb3J0LCBwb3J0KTsNCj4gPiArDQo+ID4gKwlhY3IgPSB1cC0+YWNy
Ow0KPiA+ICsNCj4gPiArCWRldl9kYmcocG9ydC0+ZGV2LCAibmkxNjU1MF9jb25maWdfcnM0ODVc
biIpOw0KPiANCj4gZG9uJ3QgbGVhdmUgaW4gc3VjaCBoYWNraXNoIGRlYnVnIGhlbHBlcnMNCj4g
DQo+ID4gKwlwb3J0LT5zZXJpYWxfb3V0KHBvcnQsIE5JMTY1NTBfUENSX09GRlNFVCwgcGNyKTsN
Cj4gDQo+IGlzIHRoYXQgaW5kaXJlY3Rpb24gcmVhbGx5IG5lY2Vzc2FyeSA/IChJT1c6IGFyZSB0
aGVyZSBzZXBhcmF0ZSBpbXBsZW1lbnRhdGlvbnMNCj4gbmVlZGVkID8pDQo+IA0KPiA+ICtzdGF0
aWMgaW50IHBjaV9uaTg0MzFfc2V0dXAoc3RydWN0IHNlcmlhbF9wcml2YXRlICpwcml2LA0KPiA+
ICsJCSBjb25zdCBzdHJ1Y3QgcGNpc2VyaWFsX2JvYXJkICpib2FyZCwNCj4gPiArCQkgc3RydWN0
IHVhcnRfODI1MF9wb3J0ICp1YXJ0LCBpbnQgaWR4KSB7DQo+ID4gKwl1OCBwY3IsIGFjcjsNCj4g
PiArCXN0cnVjdCBwY2lfZGV2ICpkZXYgPSBwcml2LT5kZXY7DQo+ID4gKwl2b2lkIF9faW9tZW0g
KmFkZHI7DQo+ID4gKwl1bnNpZ25lZCBpbnQgYmFyLCBvZmZzZXQgPSBib2FyZC0+Zmlyc3Rfb2Zm
c2V0Ow0KPiANCj4gbWF5YmUgc2l6ZV90IGZvciBvZmZzZXQgPw0KPiANCj4gPiBAQCAtMTk1Niw2
ICsyMDc3LDg3IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX3NlcmlhbF9xdWlyayBwY2lfc2VyaWFsX3F1
aXJrc1tdDQo+IF9fcmVmZGF0YSA9IHsNCj4gPiAgCQkuc2V0dXAJCT0gcGNpX25pODQzMF9zZXR1
cCwNCj4gPiAgCQkuZXhpdAkJPSBwY2lfbmk4NDMwX2V4aXQsDQo+ID4gIAl9LA0KPiA+ICsJew0K
PiA+ICsJCS52ZW5kb3IJCT0gUENJX1ZFTkRPUl9JRF9OSSwNCj4gPiArCQkuZGV2aWNlCQk9IFBD
SUVfREVWSUNFX0lEX05JX1BYSUU4NDMwXzIzMjgsDQo+ID4gKwkJLnN1YnZlbmRvcgk9IFBDSV9B
TllfSUQsDQo+ID4gKwkJLnN1YmRldmljZQk9IFBDSV9BTllfSUQsDQo+ID4gKwkJLmluaXQJCT0g
cGNpX25pODQzMF9pbml0LA0KPiA+ICsJCS5zZXR1cAkJPSBwY2lfbmk4NDMwX3NldHVwLA0KPiA+
ICsJCS5leGl0CQk9IHBjaV9uaTg0MzBfZXhpdCwNCj4gPiArCX0sDQo+IA0KPiBXZSBzaG91bGQg
aGF2ZSBhIGNvbmZpZyBzeW0gZm9yIHRoYXQsIHNvIG9ubHkgdGhvc2Ugd2hvIHJlYWxseSBuZWVk
IHRoZSBkZXZpY2UgY2FuDQo+IGVuYWJsZSBpdC4NCj4gDQo+IE9UT0gsIGl0IHdvdWxkIGJlIGV2
ZW4gbmljZXIgdG8gaGF2ZSB0aGlzIGFzIGFuIGV4dHJhIG1vZHVsZS4NCj4gDQo+IA0KPiBOZXZl
cnRoZWxlc3MgaXRzIGdvb2QgdGhhdCB5b3UgTkkgZm9sa3Mgbm93IHN0YXJ0IG1ha2luZyB5b3Vy
IHByb2R1Y3RzIHVzYWJsZSBvbg0KPiBtYWlubGluZSBrZXJuZWwsIGluc3RlYWQgb2YgdGhpcyBy
ZWFsbHkgcmlkaWN1bG91cyBhbmQgYnJva2VuLSBieS1kZXNpZ24gIm5pa2FsIi9kYXFteA0KPiBj
cmFwICh3aGljaCBldmVuIHNvbWV0aW1lcyBpbnRyb2R1Y2UgMGRheS0gZXhwbG9pdGFibGUgbGVh
a3MgYWxsb3dpbmcgcmVtb3RlDQo+IG1hY2hpbmUgdGFrZW92ZXIgLSBJJ3ZlIHBvc3RlZCBvbmUg
QGZ1bGwtZGlzY2xvc3VyZSBzZXZlcmFsIG1vbnRoIGFnby4gT25lIG9mIHRoZQ0KPiByZWFzb25z
IHdoeSBJIHdhcyBiYW5uZWQgZnJvbSB0aGUgZm9ydW1zIC0gY3JpdGljaXNtIGluIGdlbmVyYWwg
c2VlbXMgdG8gYmUgZGlzbGlrZWQNCj4gdGhlcmUpDQo+IA0KPiBPdmVyIHRoZSByZWNlbnQgeWVh
cnMsIEkgdHJpZWQgdG8gZ2V0IHNvbWUgc3BlY3Mgb24gdGhlIGNSSU9zLCBpbiBvcmRlciB0byB3
cml0ZQ0KPiBwcm9wZXIgZHJpdmVycyBhbmQgYnJpbmcgdGhlbSB0byBtYWlubGluZSAoY3VycmVu
dGx5IHRoZXNlIGJveGVzIG1pZ2h0IGJlIG5pY2UgZm9yDQo+IGR1bWIgUExDLCBidXQgbm90aGlu
ZyBtb3JlLCBhbmQgdGhlIG1hcmtldGluZyBjbGFpbSAibGludXggc3VwcG9ydCIgaXMganVzdCB3
cm9uZykuDQo+IEJ1dCB0aGVyZSB3YXMgbm8gd2F5IG9mIGdldHRpbmcgYW55dGhpbmcgZnJvbSBO
SSAobm90IGV2ZW4gYWZ0ZXIgc2V2ZXJhbCBjYWxscyB3aXRoDQo+IHByb2R1Y3QgbWFuYWdlbWVu
dCBhbmQgZGV2ZWxvcG1lbnQgdGVhbSkuIEFuZCBwbGF5aW5nIGFyb3VuZCB3LyBMViB3YXMgaW4g
bm8NCj4gd2F5IGFueSBvcHRpb24uIFNvIEkgaGFkIHRvIHRlbGwgbXkgY2xpZW50IHRoYXQgY1JJ
T3MgYXJlIGNvbXBsZXRlbHkgdW51c2FibGUgZm9yIGhpbSwNCj4gYW5kIHNvbWUgPiQxTSBwdXJj
aGFzZXMgd2VudCBvZmYgdGhlIHRhYmxlLg0KPiAoSSd2ZSByYXJlbHkgc2VlbiBhbnkgY29tcGFu
eSBzbyBob3N0aWxlIGFnYWluc3QgTGludXggc3VwcG9ydCBsaWtlIE5JKQ0KPiANCj4gDQo+IGdv
b2QgbHVjaywNCj4gDQo+IC0tbXR4DQo+IA0KPiAtLQ0KPiBFbnJpY28gV2VpZ2VsdCwgbWV0dXgg
SVQgY29uc3VsdA0KPiBGcmVlIHNvZnR3YXJlIGFuZCBMaW51eCBlbWJlZGRlZCBlbmdpbmVlcmlu
ZyBpbmZvQG1ldHV4Lm5ldCAtLSArNDktMTUxLQ0KPiAyNzU2NTI4Nw0KDQpQbGVhc2UgcmVmZXIg
dG8gdGhlIG90aGVyIHBhdGNoLCBzZXJpYWwvODI1MDogQWRkIHN1cHBvcnQgZm9yIE5JLVNlcmlh
bCANClBYSS9QWEllKzQ4NSBkZXZpY2VzIGFzIHRoZSB3aGl0ZXNwYWNlIGNoYW5nZXMgaW4gdGhp
cyBwYXRjaCB3YXMgbm90DQppbnRlbmRlZCwgaXQgd2FzIGEgIm1pc3Rha2UiLg0K
