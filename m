Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88192C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC2821743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sunix.onmicrosoft.com header.i=@sunix.onmicrosoft.com header.b="n+pnMjV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406075AbfHIJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:18:51 -0400
Received: from mail-eopbgr1300100.outbound.protection.outlook.com ([40.107.130.100]:11786
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405988AbfHIJSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeAImKffHo10OaGvgf0/CLvgd9VwIG2jIH4VBz4sw0vLgKjrzN0V1Unnv8dBw7bYUJ224orkRwM2nkgpPR0kRIIt68+mdMk1VU/SXVWKWUDSaBF2QhKtTwizda3bRLogSC07SDbrc9HQmVfMPKp3uqcnf5vNAJoQgTjEPfN5dcGLG7KP68ds82IsZTpSU7ePKl/QoukPWLEpezBVU+BwlYWBPYDSwVtZVbBlLgfIMcz79INvmce0hwte9jQwf/BbHoiYLOM+2RH2QiaeEKPPE5VBD5PBwRVQcd2cRpuiAmAb1HcrpO6xsINEUptisQPUrqfcyLiwlj5189Ww28mGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W94HbXo147DSr08idC/7sI5WzYMqXX82EvgEem2ij2A=;
 b=VLXWRT9nbA+ZsKiHSATOy4STjVUHVtDD7ZAlbIKFnYPXCuVr8s3d57fhMsLwBgpX4RBChYvPspx1yOStKSdZKDI7WHXeaByDUEZTo+K73zS53OycBgiipIGRM4VrjmDWHf4bpoGqrX/M928tKg9u05Ik++mJPjyYAJhdoQyHw1wk++0VBDYb+7+yZCjWqeZ0+jJE0Bqv2dZwUWEzonnaMddWvqOFUpalj3WQUf4BNegkKvW/dw7L41pt6ZUU06+xgAWf0yU6BhXts+Kz3C28pxXrZh0OQCGgc6ETd0yB3bp0Q6RWVREQVuGrFzJnOgo660PNm0ne+A/nTNKaUCE48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sunix.com; dmarc=pass action=none header.from=sunix.com;
 dkim=pass header.d=sunix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunix.onmicrosoft.com;
 s=selector2-sunix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W94HbXo147DSr08idC/7sI5WzYMqXX82EvgEem2ij2A=;
 b=n+pnMjV2qRutAyR5YeTyNa3KuFLO8qC8uWUbdxK+W00Ynh2rhu4rIyMRRRtibUPFNhvs2JwwDctnJkrklEChzUn4ecOx3glsafVyYK5QgiNm9exEecSG8pPmiIrNingcU2MAvgwJDQQJMYhqZB4w39vaS2EWlJGhU+Q4T8KCHCU=
Received: from HK0PR03MB3377.apcprd03.prod.outlook.com (52.133.215.13) by
 HK0PR03MB4657.apcprd03.prod.outlook.com (52.132.236.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.11; Fri, 9 Aug 2019 09:18:45 +0000
Received: from HK0PR03MB3377.apcprd03.prod.outlook.com
 ([fe80::dca2:722c:9e19:9df4]) by HK0PR03MB3377.apcprd03.prod.outlook.com
 ([fe80::dca2:722c:9e19:9df4%4]) with mapi id 15.20.2157.011; Fri, 9 Aug 2019
 09:18:45 +0000
From:   =?big5?B?RGViYmllIExpdSC8QrJRtdg=?= <debbie_liu@sunix.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?TW9ycmlzIEt1IKVqpOWrVA==?= <morris_ku@sunix.com>
Subject: RE: [PATCH 2/2] parport: parport_serial: Add support for Sunix Multi
 I/O boards
Thread-Topic: [PATCH 2/2] parport: parport_serial: Add support for Sunix Multi
 I/O boards
Thread-Index: AQHVThi8kouMLaMo/0qL9o+xj0+TOKbyiqUg
Date:   Fri, 9 Aug 2019 09:18:45 +0000
Message-ID: <HK0PR03MB337716592BB6E476F01417E5EED60@HK0PR03MB3377.apcprd03.prod.outlook.com>
References: <20190808184004.20162-1-kai.heng.feng@canonical.com>
 <20190808184004.20162-2-kai.heng.feng@canonical.com>
In-Reply-To: <20190808184004.20162-2-kai.heng.feng@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=debbie_liu@sunix.com; 
x-originating-ip: [118.160.160.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bfe2ec7-95a4-4239-8817-08d71caa949a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HK0PR03MB4657;
x-ms-traffictypediagnostic: HK0PR03MB4657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB465719B50FB10C22F01C4E04EED60@HK0PR03MB4657.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39840400004)(13464003)(199004)(189003)(316002)(74316002)(5660300002)(7736002)(76176011)(6436002)(9686003)(55016002)(64756008)(66556008)(66476007)(66946007)(66446008)(52536014)(54906003)(305945005)(478600001)(76116006)(2906002)(11346002)(7696005)(6506007)(55236004)(446003)(86362001)(26005)(53546011)(186003)(14454004)(99286004)(476003)(102836004)(2201001)(110136005)(6246003)(486006)(107886003)(81166006)(71200400001)(71190400001)(81156014)(8676002)(3846002)(256004)(6116002)(53936002)(33656002)(66066001)(25786009)(4326008)(85182001)(2501003)(8936002)(229853002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0PR03MB4657;H:HK0PR03MB3377.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sunix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: of/fOf+l0JTz5i6VPZ32elap8M3Hg9eaJbUhJDWPEnfnBRRWwE/eVif0++whDTfio+P6CMuRpgbo1b4sh4nM2lKhsKBlWT0qq7xVxyS2JBzzNZjDsao1blaCvWgIctXqZ+PfJqFwXDBsnSAfb4+fKDFH+w2qQZOj3891ysAHz3PheE9PM1Gdh3lcRv8H/MFOsRz3NOhOxEqFv/iyj8dB+5QdQJMNVbHge5DSzDJFT5qq5Q5m0dXBryf9giLHUdlFvKu9SEq7puFFY/BGg0UftK6ZhQcxbnOXXOtuxp9e15zDPwygYDw8u9ARAneeqIky1dSLmjN3Wp6c97Xi2EFpbR7W5bU0kB0531wL0L+lvTCOa9u1rzn0Z6OGwZnS59lnGHZuEDqQG35Nzmuckf0/1dIKTNFtbypaIBXevCxZVT8=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sunix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfe2ec7-95a4-4239-8817-08d71caa949a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 09:18:45.7568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c514a174-545b-4e85-8600-4eaceff17490
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4mgF+W5gYWCswzsfSsnUePinPncMiBmvqYx2Eeli2KOTqXN6j110tDS6uwgmjbb9Twx+qfe/DzmE8obzVDfEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkLWJ5OiBEZWJiaWUgTGl1ICA8ZGViYmllX2xpdUBzdW5peC5jb20+DQoNCk5pY2UgZGF5
LA0KRGViYmllIExpdSAvIFN1bml4IFdXIFNhbGVzIERlcHQuDQpUZWwgoUcrODg2LTItODkxMy0x
OTg3oUBleHQuMjc2OSANCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS2Fp
LUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPiANClNlbnQ6IEZyaWRheSwg
QXVndXN0IDA5LCAyMDE5IDI6NDAgQU0NClRvOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsg
c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20NCkNjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBLYWktSGVuZyBGZW5nIDxrYWkuaGVu
Zy5mZW5nQGNhbm9uaWNhbC5jb20+OyBNb3JyaXMgS3UgpWqk5atUIDxtb3JyaXNfa3VAc3VuaXgu
Y29tPjsgRGViYmllIExpdSC8QrJRtdggPGRlYmJpZV9saXVAc3VuaXguY29tPg0KU3ViamVjdDog
W1BBVENIIDIvMl0gcGFycG9ydDogcGFycG9ydF9zZXJpYWw6IEFkZCBzdXBwb3J0IGZvciBTdW5p
eCBNdWx0aSBJL08gYm9hcmRzDQoNClN1bml4IE11bHRpIEkvTyBib2FyZHMgYXJlIGRpZmZlcmVu
dCB0byBUaW1lZGlhJ3MuDQoNClRoaXMgcGF0Y2ggYWRkcyBwcm9wZXIgc3VwcG9ydCBmb3IgU3Vu
aXggTUlPIGJvYXJkcyB3aXRoIDEgcGFyYWxsZWwgYW5kIHVwIHRvIDQgc2VyaWFsIHBvcnRzLg0K
DQpDYzogTW9ycmlzIEt1IDxtb3JyaXNfa3VAc3VuaXguY29tPg0KQ2M6IERlYmJpZSBMaXUgPGRl
YmJpZV9saXVAc3VuaXguY29tPg0KU2lnbmVkLW9mZi1ieTogS2FpLUhlbmcgRmVuZyA8a2FpLmhl
bmcuZmVuZ0BjYW5vbmljYWwuY29tPg0KLS0tDQogZHJpdmVycy9wYXJwb3J0L3BhcnBvcnRfc2Vy
aWFsLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAzMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGFycG9ydC9wYXJwb3J0X3NlcmlhbC5jIGIvZHJpdmVycy9wYXJwb3J0L3BhcnBvcnRf
c2VyaWFsLmMNCmluZGV4IDQ2MWZkOGEyNDI3OC4uNjBkNWQ5ODUxMTNjIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9wYXJwb3J0L3BhcnBvcnRfc2VyaWFsLmMNCisrKyBiL2RyaXZlcnMvcGFycG9ydC9w
YXJwb3J0X3NlcmlhbC5jDQpAQCAtNjEsNyArNjEsMTAgQEAgZW51bSBwYXJwb3J0X3BjX3BjaV9j
YXJkcyB7DQogCXdjaF9jaDM4Ml8wczFwLA0KIAl3Y2hfY2gzODJfMnMxcCwNCiAJYnJhaW5ib3hl
c181czFwLA0KLQlzdW5peF8yczFwLA0KKwlzdW5peF80MDA4YSwNCisJc3VuaXhfNTA2OWEsDQor
CXN1bml4XzUwNzlhLA0KKwlzdW5peF81MDk5YSwNCiB9Ow0KIA0KIC8qIGVhY2ggZWxlbWVudCBk
aXJlY3RseSBpbmRleGVkIGZyb20gZW51bSBsaXN0LCBhYm92ZSAqLyBAQCAtMTUxLDcgKzE1NCwx
MCBAQCBzdGF0aWMgc3RydWN0IHBhcnBvcnRfcGNfcGNpIGNhcmRzW10gPSB7DQogCS8qIHdjaF9j
aDM4Ml8wczFwKi8JCXsgMSwgeyB7IDIsIC0xfSwgfSB9LA0KIAkvKiB3Y2hfY2gzODJfMnMxcCov
ICAgICAgICAgICAgIHsgMSwgeyB7IDIsIC0xfSwgfSB9LA0KIAkvKiBicmFpbmJveGVzXzVzMXAg
Ki8gICAgICAgICAgIHsgMSwgeyB7IDMsIC0xIH0sIH0gfSwNCi0JLyogc3VuaXhfMnMxcCAqLyAg
ICAgICAgICAgICAgICB7IDEsIHsgeyAzLCAtMSB9LCB9IH0sDQorCS8qIHN1bml4XzQwMDhhICov
CQl7IDEsIHsgeyAxLCAyIH0sIH0gfSwNCisJLyogc3VuaXhfNTA2OWEgKi8JCXsgMSwgeyB7IDEs
IDIgfSwgfSB9LA0KKwkvKiBzdW5peF81MDc5YSAqLwkJeyAxLCB7IHsgMSwgMiB9LCB9IH0sDQor
CS8qIHN1bml4XzUwOTlhICovCQl7IDEsIHsgeyAxLCAyIH0sIH0gfSwNCiB9Ow0KIA0KIHN0YXRp
YyBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwYXJwb3J0X3NlcmlhbF9wY2lfdGJsW10gPSB7IEBAIC0y
NjEsMTMgKzI2NywxNSBAQCBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgcGFycG9ydF9zZXJp
YWxfcGNpX3RibFtdID0gew0KIAl7IFBDSV9WRU5ET1JfSURfSU5UQVNISUVMRCwgMHg0MTAwLA0K
IAkgIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIGJyYWluYm94ZXNfNXMxcCB9LA0KIA0K
LQkvKg0KLQkgKiBNb3JlIFNVTklYIHZhcmlhdGlvbnMuIEF0IGxlYXN0IG9uZSBvZiB0aGVzZSBo
YXMgcGFydCBudW1iZXINCi0JICogJzUwNzlBIGJ1dCBzdWJkZXZpY2UgMHgxMDIuIFRoYXQgYm9h
cmQgcmVwb3J0cyAweDA3MDggYXMNCi0JICogaXRzIFBDSSBDbGFzcy4NCi0JICovDQorCS8qIFN1
bml4IGJvYXJkcyAqLw0KIAl7IFBDSV9WRU5ET1JfSURfU1VOSVgsIFBDSV9ERVZJQ0VfSURfU1VO
SVhfMTk5OSwgUENJX1ZFTkRPUl9JRF9TVU5JWCwNCi0JICAweDAxMDIsIDAsIDAsIHN1bml4XzJz
MXAgfSwNCisJICAweDAxMDAsIDAsIDAsIHN1bml4XzQwMDhhIH0sDQorCXsgUENJX1ZFTkRPUl9J
RF9TVU5JWCwgUENJX0RFVklDRV9JRF9TVU5JWF8xOTk5LCBQQ0lfVkVORE9SX0lEX1NVTklYLA0K
KwkgIDB4MDEwMSwgMCwgMCwgc3VuaXhfNTA2OWEgfSwNCisJeyBQQ0lfVkVORE9SX0lEX1NVTklY
LCBQQ0lfREVWSUNFX0lEX1NVTklYXzE5OTksIFBDSV9WRU5ET1JfSURfU1VOSVgsDQorCSAgMHgw
MTAyLCAwLCAwLCBzdW5peF81MDc5YSB9LA0KKwl7IFBDSV9WRU5ET1JfSURfU1VOSVgsIFBDSV9E
RVZJQ0VfSURfU1VOSVhfMTk5OSwgUENJX1ZFTkRPUl9JRF9TVU5JWCwNCisJICAweDAxMDQsIDAs
IDAsIHN1bml4XzUwOTlhIH0sDQogDQogCXsgMCwgfSAvKiB0ZXJtaW5hdGUgbGlzdCAqLw0KIH07
DQpAQCAtNTE2LDExICs1MjQsMjMgQEAgc3RhdGljIHN0cnVjdCBwY2lzZXJpYWxfYm9hcmQgcGNp
X3BhcnBvcnRfc2VyaWFsX2JvYXJkc1tdID0gew0KIAkJLmJhc2VfYmF1ZAk9IDkyMTYwMCwNCiAJ
CS51YXJ0X29mZnNldAk9IDgsDQogCX0sDQotCVtzdW5peF8yczFwXSA9IHsNCi0JCS5mbGFncwkJ
PSBGTF9CQVNFMHxGTF9CQVNFX0JBUlMsDQorCVtzdW5peF80MDA4YV0gPSB7DQorCQkubnVtX3Bv
cnRzCT0gMCwNCisJfSwNCisJW3N1bml4XzUwNjlhXSA9IHsNCisJCS5udW1fcG9ydHMJPSAxLA0K
KwkJLmJhc2VfYmF1ZCAgICAgID0gOTIxNjAwLA0KKwkJLnVhcnRfb2Zmc2V0CT0gMHg4LA0KKwl9
LA0KKwlbc3VuaXhfNTA3OWFdID0gew0KIAkJLm51bV9wb3J0cwk9IDIsDQotCQkuYmFzZV9iYXVk
CT0gOTIxNjAwLA0KLQkJLnVhcnRfb2Zmc2V0CT0gOCwNCisJCS5iYXNlX2JhdWQgICAgICA9IDky
MTYwMCwNCisJCS51YXJ0X29mZnNldAk9IDB4OCwNCisJfSwNCisJW3N1bml4XzUwOTlhXSA9IHsN
CisJCS5udW1fcG9ydHMJPSA0LA0KKwkJLmJhc2VfYmF1ZCAgICAgID0gOTIxNjAwLA0KKwkJLnVh
cnRfb2Zmc2V0CT0gMHg4LA0KIAl9LA0KIH07DQogDQotLQ0KMi4xNy4xDQoNCg==
