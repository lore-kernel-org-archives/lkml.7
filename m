Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7CEC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543D220656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sClTnPeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfDVIc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:32:56 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:16985
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfDVIcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzRGe2XUOQzKTTGLfm/VcOl3k7OKECneRBXLIVGfZSs=;
 b=sClTnPeYbjVLK5e3FGDcD+a/zBrmhW3FzGXnYRSbsXGM5RJ7Bd5g8TwHlTKIkUC1qvxJRKpeDcocL042fTFMTVTt2pIE4bTBfu/DrFd1roYw7IclqqpRhWJS6hNXCGmehrjH8t2CCJH+7xskGBW0eDvFiW2zYcOvLEPxgVSjDpk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 08:32:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:32:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clk: imx: correct i.MX7D AV PLL num/denom offset
Thread-Topic: [PATCH] clk: imx: correct i.MX7D AV PLL num/denom offset
Thread-Index: AQHU+OX1DkBqqv6CPk2NXEG9vnlY3g==
Date:   Mon, 22 Apr 2019 08:32:45 +0000
Message-ID: <1555921647-21931-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0014d897-ed09-4d1a-d516-08d6c6fd1803
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB3675B6C1D77F5C890E6D582EF5220@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(6116002)(102836004)(8936002)(68736007)(386003)(7416002)(110136005)(478600001)(50226002)(97736004)(6506007)(26005)(52116002)(3846002)(186003)(81166006)(81156014)(8676002)(2906002)(316002)(71190400001)(7736002)(305945005)(71200400001)(53936002)(486006)(14444005)(66556008)(6512007)(36756003)(25786009)(476003)(5660300002)(256004)(66446008)(86362001)(2616005)(2501003)(14454004)(2201001)(6486002)(6436002)(66066001)(4326008)(73956011)(99286004)(66946007)(66476007)(64756008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cUaQUK4w9Wk1YAJr2BsX0jiHnZ/wwRsB6eeT57O8uW3FRMZJ9U3nu6KN2aCMHtplDsMeiLtD/Wp6SvpHoVUO5NA6h6ZWXPjl8KCHa7anqJWYTyzg+8q+G5glWA3cNn4/jjVwn8P2/D02H3TfVwn00i81oouh6dXMgNu6bgLEbWqWeINXPnKUC+vylUXjcVuNJaCQVLZlzZWy1MXLQrgQKFDyzrC/OFa3C1QbdsjbS7GUAvGX8cDSpajuxNEQj5BlExowvMBmdj+E6BVrn3GHvBinBHXnfWdY0wdZUbBcWLSUN5FcefGoC1pemoPCwbT8TrgLkNXjlddG2XcElD3bLb8qm2Il5ykYsOOfnYmM1pqjpT3SgOxK9JchZx5e67u1tLitBRodO2wzOdzCIfbmpCyCkD0RftrcvH+g8N31wWs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0014d897-ed09-4d1a-d516-08d6c6fd1803
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:32:45.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNjb3JkaW5nIHJlZmVyZW5jZSBtYW51YWwsIGkuTVg3RCdzIGF1ZGlvL3ZpZGVvIFBMTCdzDQpu
dW0vZGVub20gcmVnaXN0ZXIgb2Zmc2V0IGFyZSAweDIwLzB4MzAsIHRoZXkgYXJlIGRpZmZlcmVu
dA0KZnJvbSBpLk1YNidzIGF1ZGlvL3ZpZGVvIFBMTCwgY29ycmVjdCBpdCBieSBpbnRyb2R1Y2lu
ZyBuZXcNCm9mZnNldCB2YXJpYWJsZXMgZm9yIGF1ZGlvL3ZpZGVvIFBMTCBhbmQgdXNpbmcgcnVu
dGltZQ0KYXNzaWdubWVudCBiYXNlZCBvbiBQTEwgdHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogQW5z
b24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDdkLmMgfCAgNCArKy0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jIHwgMjkgKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLmggICAgICAg
fCAgMSArDQogMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14N2QuYyBiL2RyaXZlcnMv
Y2xrL2lteC9jbGstaW14N2QuYw0KaW5kZXggY2ZiZDhkNC4uNWI4YTBjNyAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14N2QuYw0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg3ZC5jDQpAQCAtNDE3LDggKzQxNyw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbXg3ZF9jbG9j
a3NfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKmNjbV9ub2RlKQ0KIAljbGtzW0lNWDdEX1BMTF9E
UkFNX01BSU5dID0gaW14X2Nsa19wbGx2MyhJTVhfUExMVjNfRERSX0lNWDcsICJwbGxfZHJhbV9t
YWluIiwgIm9zYyIsIGJhc2UgKyAweDcwLCAweDdmKTsNCiAJY2xrc1tJTVg3RF9QTExfU1lTX01B
SU5dICA9IGlteF9jbGtfcGxsdjMoSU1YX1BMTFYzX0dFTkVSSUMsICJwbGxfc3lzX21haW4iLCAi
b3NjIiwgYmFzZSArIDB4YjAsIDB4MSk7DQogCWNsa3NbSU1YN0RfUExMX0VORVRfTUFJTl0gPSBp
bXhfY2xrX3BsbHYzKElNWF9QTExWM19FTkVUX0lNWDcsICJwbGxfZW5ldF9tYWluIiwgIm9zYyIs
IGJhc2UgKyAweGUwLCAweDApOw0KLQljbGtzW0lNWDdEX1BMTF9BVURJT19NQUlOXSA9IGlteF9j
bGtfcGxsdjMoSU1YX1BMTFYzX0FWLCAicGxsX2F1ZGlvX21haW4iLCAib3NjIiwgYmFzZSArIDB4
ZjAsIDB4N2YpOw0KLQljbGtzW0lNWDdEX1BMTF9WSURFT19NQUlOXSA9IGlteF9jbGtfcGxsdjMo
SU1YX1BMTFYzX0FWLCAicGxsX3ZpZGVvX21haW4iLCAib3NjIiwgYmFzZSArIDB4MTMwLCAweDdm
KTsNCisJY2xrc1tJTVg3RF9QTExfQVVESU9fTUFJTl0gPSBpbXhfY2xrX3BsbHYzKElNWF9QTExW
M19BVl9JTVg3LCAicGxsX2F1ZGlvX21haW4iLCAib3NjIiwgYmFzZSArIDB4ZjAsIDB4N2YpOw0K
KwljbGtzW0lNWDdEX1BMTF9WSURFT19NQUlOXSA9IGlteF9jbGtfcGxsdjMoSU1YX1BMTFYzX0FW
X0lNWDcsICJwbGxfdmlkZW9fbWFpbiIsICJvc2MiLCBiYXNlICsgMHgxMzAsIDB4N2YpOw0KIA0K
IAljbGtzW0lNWDdEX1BMTF9BUk1fTUFJTl9CWVBBU1NdICA9IGlteF9jbGtfbXV4X2ZsYWdzKCJw
bGxfYXJtX21haW5fYnlwYXNzIiwgYmFzZSArIDB4NjAsIDE2LCAxLCBwbGxfYXJtX2J5cGFzc19z
ZWwsIEFSUkFZX1NJWkUocGxsX2FybV9ieXBhc3Nfc2VsKSwgQ0xLX1NFVF9SQVRFX1BBUkVOVCk7
DQogCWNsa3NbSU1YN0RfUExMX0RSQU1fTUFJTl9CWVBBU1NdID0gaW14X2Nsa19tdXhfZmxhZ3Mo
InBsbF9kcmFtX21haW5fYnlwYXNzIiwgYmFzZSArIDB4NzAsIDE2LCAxLCBwbGxfZHJhbV9ieXBh
c3Nfc2VsLCBBUlJBWV9TSVpFKHBsbF9kcmFtX2J5cGFzc19zZWwpLCBDTEtfU0VUX1JBVEVfUEFS
RU5UKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmMgYi9kcml2ZXJz
L2Nsay9pbXgvY2xrLXBsbHYzLmMNCmluZGV4IDlhZjYyZWUuLmU4OTJiOWEgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYzLmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGst
cGxsdjMuYw0KQEAgLTIwLDYgKzIwLDggQEANCiANCiAjZGVmaW5lIFBMTF9OVU1fT0ZGU0VUCQkw
eDEwDQogI2RlZmluZSBQTExfREVOT01fT0ZGU0VUCTB4MjANCisjZGVmaW5lIFBMTF9JTVg3X05V
TV9PRkZTRVQJMHgyMA0KKyNkZWZpbmUgUExMX0lNWDdfREVOT01fT0ZGU0VUCTB4MzANCiANCiAj
ZGVmaW5lIFBMTF9WRjYxMF9OVU1fT0ZGU0VUCTB4MjANCiAjZGVmaW5lIFBMTF9WRjYxMF9ERU5P
TV9PRkZTRVQJMHgzMA0KQEAgLTQ5LDYgKzUxLDggQEAgc3RydWN0IGNsa19wbGx2MyB7DQogCXUz
MgkJZGl2X21hc2s7DQogCXUzMgkJZGl2X3NoaWZ0Ow0KIAl1bnNpZ25lZCBsb25nCXJlZl9jbG9j
azsNCisJdTMyCQludW1fb2Zmc2V0Ow0KKwl1MzIJCWRlbm9tX29mZnNldDsNCiB9Ow0KIA0KICNk
ZWZpbmUgdG9fY2xrX3BsbHYzKF9odykgY29udGFpbmVyX29mKF9odywgc3RydWN0IGNsa19wbGx2
MywgaHcpDQpAQCAtMjE5LDggKzIyMyw4IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNsa19wbGx2
M19hdl9yZWNhbGNfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywNCiAJCQkJCSAgICAgIHVuc2lnbmVk
IGxvbmcgcGFyZW50X3JhdGUpDQogew0KIAlzdHJ1Y3QgY2xrX3BsbHYzICpwbGwgPSB0b19jbGtf
cGxsdjMoaHcpOw0KLQl1MzIgbWZuID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2UgKyBQTExfTlVN
X09GRlNFVCk7DQotCXUzMiBtZmQgPSByZWFkbF9yZWxheGVkKHBsbC0+YmFzZSArIFBMTF9ERU5P
TV9PRkZTRVQpOw0KKwl1MzIgbWZuID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2UgKyBwbGwtPm51
bV9vZmZzZXQpOw0KKwl1MzIgbWZkID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2UgKyBwbGwtPmRl
bm9tX29mZnNldCk7DQogCXUzMiBkaXYgPSByZWFkbF9yZWxheGVkKHBsbC0+YmFzZSkgJiBwbGwt
PmRpdl9tYXNrOw0KIAl1NjQgdGVtcDY0ID0gKHU2NClwYXJlbnRfcmF0ZTsNCiANCkBAIC0yODks
OCArMjkzLDggQEAgc3RhdGljIGludCBjbGtfcGxsdjNfYXZfc2V0X3JhdGUoc3RydWN0IGNsa19o
dyAqaHcsIHVuc2lnbmVkIGxvbmcgcmF0ZSwNCiAJdmFsICY9IH5wbGwtPmRpdl9tYXNrOw0KIAl2
YWwgfD0gZGl2Ow0KIAl3cml0ZWxfcmVsYXhlZCh2YWwsIHBsbC0+YmFzZSk7DQotCXdyaXRlbF9y
ZWxheGVkKG1mbiwgcGxsLT5iYXNlICsgUExMX05VTV9PRkZTRVQpOw0KLQl3cml0ZWxfcmVsYXhl
ZChtZmQsIHBsbC0+YmFzZSArIFBMTF9ERU5PTV9PRkZTRVQpOw0KKwl3cml0ZWxfcmVsYXhlZCht
Zm4sIHBsbC0+YmFzZSArIHBsbC0+bnVtX29mZnNldCk7DQorCXdyaXRlbF9yZWxheGVkKG1mZCwg
cGxsLT5iYXNlICsgcGxsLT5kZW5vbV9vZmZzZXQpOw0KIA0KIAlyZXR1cm4gY2xrX3BsbHYzX3dh
aXRfbG9jayhwbGwpOw0KIH0NCkBAIC0zNTIsOCArMzU2LDggQEAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgY2xrX3BsbHYzX3ZmNjEwX3JlY2FsY19yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LA0KIAlzdHJ1
Y3QgY2xrX3BsbHYzICpwbGwgPSB0b19jbGtfcGxsdjMoaHcpOw0KIAlzdHJ1Y3QgY2xrX3BsbHYz
X3ZmNjEwX21mIG1mOw0KIA0KLQltZi5tZm4gPSByZWFkbF9yZWxheGVkKHBsbC0+YmFzZSArIFBM
TF9WRjYxMF9OVU1fT0ZGU0VUKTsNCi0JbWYubWZkID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2Ug
KyBQTExfVkY2MTBfREVOT01fT0ZGU0VUKTsNCisJbWYubWZuID0gcmVhZGxfcmVsYXhlZChwbGwt
PmJhc2UgKyBwbGwtPm51bV9vZmZzZXQpOw0KKwltZi5tZmQgPSByZWFkbF9yZWxheGVkKHBsbC0+
YmFzZSArIHBsbC0+ZGVub21fb2Zmc2V0KTsNCiAJbWYubWZpID0gKHJlYWRsX3JlbGF4ZWQocGxs
LT5iYXNlKSAmIHBsbC0+ZGl2X21hc2spID8gMjIgOiAyMDsNCiANCiAJcmV0dXJuIGNsa19wbGx2
M192ZjYxMF9tZl90b19yYXRlKHBhcmVudF9yYXRlLCBtZik7DQpAQCAtMzgyLDggKzM4Niw4IEBA
IHN0YXRpYyBpbnQgY2xrX3BsbHYzX3ZmNjEwX3NldF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1
bnNpZ25lZCBsb25nIHJhdGUsDQogCQl2YWwgfD0gcGxsLT5kaXZfbWFzazsJLyogc2V0IGJpdCBm
b3IgbWZpPTIyICovDQogCXdyaXRlbF9yZWxheGVkKHZhbCwgcGxsLT5iYXNlKTsNCiANCi0Jd3Jp
dGVsX3JlbGF4ZWQobWYubWZuLCBwbGwtPmJhc2UgKyBQTExfVkY2MTBfTlVNX09GRlNFVCk7DQot
CXdyaXRlbF9yZWxheGVkKG1mLm1mZCwgcGxsLT5iYXNlICsgUExMX1ZGNjEwX0RFTk9NX09GRlNF
VCk7DQorCXdyaXRlbF9yZWxheGVkKG1mLm1mbiwgcGxsLT5iYXNlICsgcGxsLT5udW1fb2Zmc2V0
KTsNCisJd3JpdGVsX3JlbGF4ZWQobWYubWZkLCBwbGwtPmJhc2UgKyBwbGwtPmRlbm9tX29mZnNl
dCk7DQogDQogCXJldHVybiBjbGtfcGxsdjNfd2FpdF9sb2NrKHBsbCk7DQogfQ0KQEAgLTQyNiw2
ICs0MzAsOCBAQCBzdHJ1Y3QgY2xrICppbXhfY2xrX3BsbHYzKGVudW0gaW14X3BsbHYzX3R5cGUg
dHlwZSwgY29uc3QgY2hhciAqbmFtZSwNCiAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KIA0K
IAlwbGwtPnBvd2VyX2JpdCA9IEJNX1BMTF9QT1dFUjsNCisJcGxsLT5udW1fb2Zmc2V0ID0gUExM
X05VTV9PRkZTRVQ7DQorCXBsbC0+ZGVub21fb2Zmc2V0ID0gUExMX0RFTk9NX09GRlNFVDsNCiAN
CiAJc3dpdGNoICh0eXBlKSB7DQogCWNhc2UgSU1YX1BMTFYzX1NZUzoNCkBAIC00MzMsNiArNDM5
LDggQEAgc3RydWN0IGNsayAqaW14X2Nsa19wbGx2MyhlbnVtIGlteF9wbGx2M190eXBlIHR5cGUs
IGNvbnN0IGNoYXIgKm5hbWUsDQogCQlicmVhazsNCiAJY2FzZSBJTVhfUExMVjNfU1lTX1ZGNjEw
Og0KIAkJb3BzID0gJmNsa19wbGx2M192ZjYxMF9vcHM7DQorCQlwbGwtPm51bV9vZmZzZXQgPSBQ
TExfVkY2MTBfTlVNX09GRlNFVDsNCisJCXBsbC0+ZGVub21fb2Zmc2V0ID0gUExMX1ZGNjEwX0RF
Tk9NX09GRlNFVDsNCiAJCWJyZWFrOw0KIAljYXNlIElNWF9QTExWM19VU0JfVkY2MTA6DQogCQlw
bGwtPmRpdl9zaGlmdCA9IDE7DQpAQCAtNDQwLDYgKzQ0OCw5IEBAIHN0cnVjdCBjbGsgKmlteF9j
bGtfcGxsdjMoZW51bSBpbXhfcGxsdjNfdHlwZSB0eXBlLCBjb25zdCBjaGFyICpuYW1lLA0KIAkJ
b3BzID0gJmNsa19wbGx2M19vcHM7DQogCQlwbGwtPnBvd2VydXBfc2V0ID0gdHJ1ZTsNCiAJCWJy
ZWFrOw0KKwljYXNlIElNWF9QTExWM19BVl9JTVg3Og0KKwkJcGxsLT5udW1fb2Zmc2V0ID0gUExM
X0lNWDdfTlVNX09GRlNFVDsNCisJCXBsbC0+ZGVub21fb2Zmc2V0ID0gUExMX0lNWDdfREVOT01f
T0ZGU0VUOw0KIAljYXNlIElNWF9QTExWM19BVjoNCiAJCW9wcyA9ICZjbGtfcGxsdjNfYXZfb3Bz
Ow0KIAkJYnJlYWs7DQpAQCAtNDU0LDYgKzQ2NSw4IEBAIHN0cnVjdCBjbGsgKmlteF9jbGtfcGxs
djMoZW51bSBpbXhfcGxsdjNfdHlwZSB0eXBlLCBjb25zdCBjaGFyICpuYW1lLA0KIAkJYnJlYWs7
DQogCWNhc2UgSU1YX1BMTFYzX0REUl9JTVg3Og0KIAkJcGxsLT5wb3dlcl9iaXQgPSBJTVg3X0RE
Ul9QTExfUE9XRVI7DQorCQlwbGwtPm51bV9vZmZzZXQgPSBQTExfSU1YN19OVU1fT0ZGU0VUOw0K
KwkJcGxsLT5kZW5vbV9vZmZzZXQgPSBQTExfSU1YN19ERU5PTV9PRkZTRVQ7DQogCQlvcHMgPSAm
Y2xrX3BsbHYzX2F2X29wczsNCiAJCWJyZWFrOw0KIAlkZWZhdWx0Og0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL2lteC9jbGsuaCBiL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KaW5kZXggZWRjMTJk
Ni4uODYzOWE4ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KKysrIGIvZHJp
dmVycy9jbGsvaW14L2Nsay5oDQpAQCAtNzcsNiArNzcsNyBAQCBlbnVtIGlteF9wbGx2M190eXBl
IHsNCiAJSU1YX1BMTFYzX0VORVRfSU1YNywNCiAJSU1YX1BMTFYzX1NZU19WRjYxMCwNCiAJSU1Y
X1BMTFYzX0REUl9JTVg3LA0KKwlJTVhfUExMVjNfQVZfSU1YNywNCiB9Ow0KIA0KIHN0cnVjdCBj
bGsgKmlteF9jbGtfcGxsdjMoZW51bSBpbXhfcGxsdjNfdHlwZSB0eXBlLCBjb25zdCBjaGFyICpu
YW1lLA0KLS0gDQoyLjcuNA0KDQo=
