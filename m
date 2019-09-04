Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5F021883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="GWbaQC2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfIDBP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 21:15:56 -0400
Received: from mail-eopbgr730115.outbound.protection.outlook.com ([40.107.73.115]:55992
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfIDBP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrNrVnWoEfVYulP33+2Z2QJbPZanE4J9VtCZfJYw/tvJYRa4pjmvBuTPighmeEj3Lab+RvyIjpqu37NBEZoaCnXn9ba3FA5LQZI2islVRnMScBgsu+AAaopUTAEEp5fueW31uw5oakryzAoZ5GDmxyDlLt73ry1W77YNr43sh7OZvC50tIBU5vqUQGZV+FZzgJSIu7WMohjUlb+gD3t6KRj8mjdFY1LzXJv1djNMkhSCihGhyYEJS/34FlI/rfbnqXcFl6Zi1G61clO74/NTVenf6u6GFZboA0ubmIHdw6lejuV1VZ7pYM+0XGnVkQKWaI5cLS7RdA2mohUlXbH3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhKbxrDv6pV6/jwfpDgjDpy7SHr7ReNflj8QLRj8dVw=;
 b=ldjE4JCuuaQHiY40fzbpF9OjEHnPWSLeLEZqq89ux4wiEYSILPnWa1qK70IKLnllidl79U9qnvLwrDcIlu/Mo7ZgxufyoN/xA6OFJ9Q0uNKbLTw8AYY3PwqUzSHF3QKOYXJZVY6f5X0sppjr7eNp+pYz61POU9S7OyeFtRZQwSPSauMtbX7UxeavA2lDARC/fHE36pJp5zYFMIxDtWeEDx3LtGnQn5zg2TmjVPGLQnipJn/GSv6GdGV77ZaD8v3HbvGZIcTQD9T6gvCdje9xjH4jk78nEpZ1ND+WyLCTMhi6B+friyEffG7c+01PMKocTat2xn5IcIb0FVbIpLlapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhKbxrDv6pV6/jwfpDgjDpy7SHr7ReNflj8QLRj8dVw=;
 b=GWbaQC2PPace5wjJYswmK/K7T6ZZFefhgU1D67INBypX2qnOI5IEBAutyA2pFFTf+CoAJzW3Ne/xzjB9x08Hf0gb88mYBMfkNox++56ctPwUK/6Ue/NZtNnajcPEoFT/2TlWleQOuCnYlRwtXLLRRjiU/3I4bg3a7Lpfg24HcjQ=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2089.namprd11.prod.outlook.com (10.174.106.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 01:15:14 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 01:15:14 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Index: AQHVYr406/tKUl7vTUifobCqeM8uGQ==
Date:   Wed, 4 Sep 2019 01:15:14 +0000
Message-ID: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.107.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20173c8f-6e26-4374-98e3-08d730d55744
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR1101MB2089;
x-ms-traffictypediagnostic: DM5PR1101MB2089:
x-microsoft-antispam-prvs: <DM5PR1101MB20899118D78C5F542EDD0F47AAB80@DM5PR1101MB2089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39840400004)(136003)(189003)(199004)(7736002)(25786009)(3846002)(14454004)(2906002)(6486002)(52116002)(5660300002)(6116002)(81166006)(81156014)(31696002)(8676002)(2201001)(508600001)(99286004)(86362001)(6436002)(8936002)(305945005)(316002)(66066001)(36756003)(31686004)(110136005)(386003)(71190400001)(6506007)(71200400001)(6512007)(66476007)(66556008)(64756008)(66446008)(14444005)(102836004)(66946007)(53936002)(476003)(2616005)(486006)(256004)(2501003)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2089;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qZLVY0xfUD9f189842mhNpmYXXlUj9X0qM8lbizMhbgacndDimgV8CIX3Q7fel33dzek/x+47tID1ReKrdx2opy9JkRahPi7pvPaZemklmYEZYtGWoAJaLiPvtR4OldB0WqcDw5Oq/pDYa4Mio76/nfRRTgZulUit7E6owENznD4/Mfygwcg3vjX2u4mJoE5o35rG7Cm3Z+ZS8Y0EqWL1aC9a4NJ0rD7g7qQGEE+sAQgjJcPqPcPPePnc+DygMfwY8eLsbqI/qAbPhZ4sDsSvUumWDmRgsnH8NUh0BKnA5z4Bhp4SjFEFK4d1pqwtChPlP4LWnEZkZ2vKj3yRnKYVVBUkK1V5yWjAZCFPe+45CLWjJliARgQHINq21b6z+9rS8muVfVmN5zXO4eN+Cqx8x/f7eWbLlDpejJ9r0Q1KL8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3AF020196A94B4680232C1E34DD1D1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20173c8f-6e26-4374-98e3-08d730d55744
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 01:15:14.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wp+6ATFyTT4ptWBVrTHBRSY+NR9TFPAhMkw8UGgjaENOFoV5FTlgQKThX+h0ZDrdiOcrKtlZ23ZxOIWMzxOsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBmbGFzaCBjb250cm9sbGVycyBkb24ndCBoYXZlIGEgc29mdHdhcmUgc2VxdWVuY2VyLiBB
dm9pZA0KY29uZmlndXJpbmcgdGhlIHJlZ2lzdGVyIGFkZHJlc3NlcyBmb3IgaXQsIGFuZCBkb3Vi
bGUgY2hlY2sNCmV2ZXJ5d2hlcmUgdGhhdCBpdHMgbm90IGFjY2lkZW50YWxseSB0cnlpbmcgdG8g
YmUgdXNlZC4NCg0KRXZlcnkgdXNlIG9mIGBzcmVnc2AgaXMgbm93IGd1YXJkZWQgYnkgYSBjaGVj
ayBvZiBgc3JlZ3NgIG9yDQpgc3dzZXFfcmVnYC4gVGhlIGNoZWNrIG1pZ2h0IGJlIGRvbmUgaW4g
dGhlIGNhbGxpbmcgZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IEpldGhybyBCZWVrbWFuIDxq
ZXRocm9AZm9ydGFuaXguY29tPg0KLS0tDQogZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGku
YyB8IDIzICsrKysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkt
bm9yL2ludGVsLXNwaS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGkuYw0KaW5kZXgg
MWNjZjIzZi4uMTk1Y2RjYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwt
c3BpLmMNCisrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3BpLmMNCkBAIC0xODcsMTIg
KzE4NywxNiBAQCBzdGF0aWMgdm9pZCBpbnRlbF9zcGlfZHVtcF9yZWdzKHN0cnVjdCBpbnRlbF9z
cGkgKmlzcGkpDQogCQlkZXZfZGJnKGlzcGktPmRldiwgIlBSKCVkKT0weCUwOHhcbiIsIGksDQog
CQkJcmVhZGwoaXNwaS0+cHJlZ3MgKyBQUihpKSkpOw0KIA0KLQl2YWx1ZSA9IHJlYWRsKGlzcGkt
PnNyZWdzICsgU1NGU1RTX0NUTCk7DQotCWRldl9kYmcoaXNwaS0+ZGV2LCAiU1NGU1RTX0NUTD0w
eCUwOHhcbiIsIHZhbHVlKTsNCi0JZGV2X2RiZyhpc3BpLT5kZXYsICJQUkVPUF9PUFRZUEU9MHgl
MDh4XG4iLA0KLQkJcmVhZGwoaXNwaS0+c3JlZ3MgKyBQUkVPUF9PUFRZUEUpKTsNCi0JZGV2X2Ri
Zyhpc3BpLT5kZXYsICJPUE1FTlUwPTB4JTA4eFxuIiwgcmVhZGwoaXNwaS0+c3JlZ3MgKyBPUE1F
TlUwKSk7DQotCWRldl9kYmcoaXNwaS0+ZGV2LCAiT1BNRU5VMT0weCUwOHhcbiIsIHJlYWRsKGlz
cGktPnNyZWdzICsgT1BNRU5VMSkpOw0KKwlpZiAoaXNwaS0+c3JlZ3MpIHsNCisJCXZhbHVlID0g
cmVhZGwoaXNwaS0+c3JlZ3MgKyBTU0ZTVFNfQ1RMKTsNCisJCWRldl9kYmcoaXNwaS0+ZGV2LCAi
U1NGU1RTX0NUTD0weCUwOHhcbiIsIHZhbHVlKTsNCisJCWRldl9kYmcoaXNwaS0+ZGV2LCAiUFJF
T1BfT1BUWVBFPTB4JTA4eFxuIiwNCisJCQlyZWFkbChpc3BpLT5zcmVncyArIFBSRU9QX09QVFlQ
RSkpOw0KKwkJZGV2X2RiZyhpc3BpLT5kZXYsICJPUE1FTlUwPTB4JTA4eFxuIiwNCisJCQlyZWFk
bChpc3BpLT5zcmVncyArIE9QTUVOVTApKTsNCisJCWRldl9kYmcoaXNwaS0+ZGV2LCAiT1BNRU5V
MT0weCUwOHhcbiIsDQorCQkJcmVhZGwoaXNwaS0+c3JlZ3MgKyBPUE1FTlUxKSk7DQorCX0NCiAN
CiAJaWYgKGlzcGktPmluZm8tPnR5cGUgPT0gSU5URUxfU1BJX0JZVCkNCiAJCWRldl9kYmcoaXNw
aS0+ZGV2LCAiQkNSPTB4JTA4eFxuIiwgcmVhZGwoaXNwaS0+YmFzZSArIEJZVF9CQ1IpKTsNCkBA
IC0zNjcsNiArMzcxLDExIEBAIHN0YXRpYyBpbnQgaW50ZWxfc3BpX2luaXQoc3RydWN0IGludGVs
X3NwaSAqaXNwaSkNCiAJCSAgICAhKHV2c2NjICYgRVJBU0VfNjRLX09QQ09ERV9NQVNLKSkNCiAJ
CQlpc3BpLT5lcmFzZV82NGsgPSBmYWxzZTsNCiANCisJaWYgKGlzcGktPnNyZWdzID09IE5VTEwg
JiYgKGlzcGktPnN3c2VxX3JlZyB8fCBpc3BpLT5zd3NlcV9lcmFzZSkpIHsNCisJCWRldl9lcnIo
aXNwaS0+ZGV2LCAic29mdHdhcmUgc2VxdWVuY2VyIG5vdCBzdXBwb3J0ZWQsIGJ1dCByZXF1aXJl
ZFxuIik7DQorCQlyZXR1cm4gLUVJTlZBTDsNCisJfQ0KKw0KIAkvKg0KIAkgKiBTb21lIGNvbnRy
b2xsZXJzIGNhbiBvbmx5IGRvIGJhc2ljIG9wZXJhdGlvbnMgdXNpbmcgaGFyZHdhcmUNCiAJICog
c2VxdWVuY2VyLiBBbGwgb3RoZXIgb3BlcmF0aW9ucyBhcmUgc3VwcG9zZWQgdG8gYmUgY2Fycmll
ZCBvdXQNCkBAIC0zODMsNyArMzkyLDcgQEAgc3RhdGljIGludCBpbnRlbF9zcGlfaW5pdChzdHJ1
Y3QgaW50ZWxfc3BpICppc3BpKQ0KIAl2YWwgPSByZWFkbChpc3BpLT5iYXNlICsgSFNGU1RTX0NU
TCk7DQogCWlzcGktPmxvY2tlZCA9ICEhKHZhbCAmIEhTRlNUU19DVExfRkxPQ0tETik7DQogDQot
CWlmIChpc3BpLT5sb2NrZWQpIHsNCisJaWYgKGlzcGktPmxvY2tlZCAmJiBpc3BpLT5zcmVncykg
ew0KIAkJLyoNCiAJCSAqIEJJT1MgcHJvZ3JhbXMgYWxsb3dlZCBvcGNvZGVzIGFuZCB0aGVuIGxv
Y2tzIGRvd24gdGhlDQogCQkgKiByZWdpc3Rlci4gU28gcmVhZCBiYWNrIHdoYXQgb3Bjb2RlcyBp
dCBkZWNpZGVkIHRvIHN1cHBvcnQuDQotLSANCjIuNy40DQoNCg==
