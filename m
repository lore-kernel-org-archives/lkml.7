Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806BFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A8D21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jqt2f6WY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfEHGFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:05:25 -0400
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:31106
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbfEHGFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGVQKTtk29XmA74Zj+03hkkWomk236lfR0HowWJjf0U=;
 b=Jqt2f6WYt4thWz62dYQdqITVj7kuT9IdVEIfMdwILlUDbXtvlLSK2VXh4Hosu/hFiGP3EvMfwYE/7uVbaILozLUab78GsvePsmS3Gf52aALdmFZQDPI0Xaw4sSl/Kf9c542Zcy7cwIUpHCpt4+vNR54hwbJ+ATNr3TpMX1TMh5c=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4141.eurprd04.prod.outlook.com (52.133.14.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 06:04:39 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 06:04:39 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Suresh Gupta <B42813@freescale.com>
Subject: [PATCH v5 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Topic: [PATCH v5 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Index: AQHVBWPrsnmaeqJdaEa/eR5Ny2mKMg==
Date:   Wed, 8 May 2019 06:04:38 +0000
Message-ID: <20190508060608.33882-2-yinbo.zhu@nxp.com>
References: <20190508060608.33882-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190508060608.33882-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61d51b99-87cb-4132-f03f-08d6d37b0de3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4141;
x-ms-traffictypediagnostic: VI1PR04MB4141:
x-microsoft-antispam-prvs: <VI1PR04MB4141BCF6326DBA060307C550E9320@VI1PR04MB4141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(52116002)(316002)(478600001)(8936002)(386003)(99286004)(102836004)(5660300002)(186003)(3846002)(66446008)(73956011)(66946007)(26005)(66556008)(64756008)(66476007)(71200400001)(256004)(71190400001)(6486002)(6436002)(14454004)(6512007)(305945005)(7736002)(44832011)(6116002)(11346002)(486006)(81156014)(446003)(68736007)(2906002)(54906003)(8676002)(81166006)(66066001)(76176011)(476003)(6506007)(2616005)(86362001)(1076003)(36756003)(6916009)(53936002)(25786009)(4326008)(107886003)(50226002)(2171002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4141;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ExyJtlWYmwqB8VHH1SdyxQH3qZ4/hnY8D1eVIIIVD4pSLztf1eS/5E7ZdbdgzGpTsHgo88igtRPolBI+kGX/0vyrZO3K494ZI2yvQ92W2/fx4MeyfQSX9eqr8xm3SEiJFSNWX4iDz56pkQTLYkjaqu/RnWN+32f4xHBuEpyNhUbsIJ0i9SjBcrMHynWPfg1itDO9SBmvxAu+vQ1rTEO7CWU1/HSjn9xvgT1MrZ9d4ArupcyErbsvNEBSk27nuDbxombREJR844snLNSSYzTI092vFY2KmCKapJ6iw9GJUJs0a4EGsr2wbwhYE3Dd7856dT29VV0bXZmO+WvF+q8G6eGjnL04vLZe/c5Iog2kEXUgWCRGijOcealHwlkwg3H1AwGcOVVT6qrb1CgOGUqdrHHF6XMqQYqe0ijTGknk20Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d51b99-87cb-4132-f03f-08d6d37b0de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 06:04:38.9685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3VyZXNoIEd1cHRhIDxCNDI4MTNAZnJlZXNjYWxlLmNvbT4NCg0KUEhZX0NMS19WQUxJ
RCBiaXQgZm9yIFVUTUkgUEhZIGluIFVTQkRSIGRvZXMgbm90IHNldCBldmVuDQppZiBQSFkgaXMg
cHJvdmlkaW5nIHZhbGlkIGNsb2NrLiBXb3JrYXJvdW5kIGZvciB0aGlzDQppbnZvbHZlcyByZXNl
dHRpbmcgb2YgUEhZIGFuZCBjaGVjayBQSFlfQ0xLX1ZBTElEIGJpdA0KbXVsdGlwbGUgdGltZXMu
IElmIFBIWV9DTEtfVkFMSUQgYml0IGlzIHN0aWxsIG5vdCBzZXQgZXZlbg0KYWZ0ZXIgNSByZXRy
aWVzLCBpdCB3b3VsZCBiZSBzYWZlIHRvIGRlYWNsYXJlIHRoYXQgUEhZDQpjbG9jayBpcyBub3Qg
YXZhaWxhYmxlLg0KVGhpcyBlcnJhdHVtIGlzIGFwcGxpY2FibGUgZm9yIFVTQkRSIGxlc3MgdGhl
biB2ZXIgMi40Lg0KDQpTaWduZWQtb2ZmLWJ5OiBTdXJlc2ggR3VwdGEgPEI0MjgxM0BmcmVlc2Nh
bGUuY29tPg0KU2lnbmVkLW9mZi1ieTogWWluYm8gWmh1IDx5aW5iby56aHVAbnhwLmNvbT4NCi0t
LQ0KQ2hhbmdlIGluIHY1Og0KCQlyZW1vdmUgZGV2X2VyciBmdW5jdGlvbiB1bm5lY2Vzc2FyeSBw
YXJhbWV0ZXJzIA0KDQogZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jIHwgICAzNyArKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogZHJpdmVycy91c2IvaG9zdC9laGNpLWZz
bC5oIHwgICAgMyArKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jIGIv
ZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQppbmRleCAzODY3NGI3Li4xNjM0YWM4IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLWZzbC5jDQorKysgYi9kcml2ZXJzL3VzYi9o
b3N0L2VoY2ktZnNsLmMNCkBAIC0xODMsNiArMTgzLDE3IEBAIHN0YXRpYyBpbnQgZnNsX2VoY2lf
ZHJ2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldHVybiByZXR2YWw7
DQogfQ0KIA0KK3N0YXRpYyBib29sIHVzYl9waHlfY2xrX3ZhbGlkKHN0cnVjdCB1c2JfaGNkICpo
Y2QpDQorew0KKwl2b2lkIF9faW9tZW0gKm5vbl9laGNpID0gaGNkLT5yZWdzOw0KKwlib29sIHJl
dCA9IHRydWU7DQorDQorCWlmICghKGlvcmVhZDMyYmUobm9uX2VoY2kgKyBGU0xfU09DX1VTQl9D
VFJMKSAmIFBIWV9DTEtfVkFMSUQpKQ0KKwkJcmV0ID0gZmFsc2U7DQorDQorCXJldHVybiByZXQ7
DQorfQ0KKw0KIHN0YXRpYyBpbnQgZWhjaV9mc2xfc2V0dXBfcGh5KHN0cnVjdCB1c2JfaGNkICpo
Y2QsDQogCQkJICAgICAgIGVudW0gZnNsX3VzYjJfcGh5X21vZGVzIHBoeV9tb2RlLA0KIAkJCSAg
ICAgICB1bnNpZ25lZCBpbnQgcG9ydF9vZmZzZXQpDQpAQCAtMjI2LDYgKzIzNywxNiBAQCBzdGF0
aWMgaW50IGVoY2lfZnNsX3NldHVwX3BoeShzdHJ1Y3QgdXNiX2hjZCAqaGNkLA0KIAkJLyogZmFs
bCB0aHJvdWdoICovDQogCWNhc2UgRlNMX1VTQjJfUEhZX1VUTUk6DQogCWNhc2UgRlNMX1VTQjJf
UEhZX1VUTUlfRFVBTDoNCisJCS8qIFBIWV9DTEtfVkFMSUQgYml0IGlzIGRlLWZlYXR1cmVkIGZy
b20gYWxsIGNvbnRyb2xsZXINCisJCSAqIHZlcnNpb25zIGJlbG93IDIuNCBhbmQgaXMgdG8gYmUg
Y2hlY2tlZCBvbmx5IGZvcg0KKwkJICogaW50ZXJuYWwgVVRNSSBwaHkNCisJCSAqLw0KKwkJaWYg
KHBkYXRhLT5jb250cm9sbGVyX3ZlciA+IEZTTF9VU0JfVkVSXzJfNCAmJg0KKwkJICAgIHBkYXRh
LT5oYXZlX3N5c2lmX3JlZ3MgJiYgIXVzYl9waHlfY2xrX3ZhbGlkKGhjZCkpIHsNCisJCQlkZXZf
ZXJyKGRldiwgIlVTQiBQSFkgY2xvY2sgaW52YWxpZFxuIik7DQorCQkJcmV0dXJuIC1FSU5WQUw7
DQorCQl9DQorDQogCQlpZiAocGRhdGEtPmhhdmVfc3lzaWZfcmVncyAmJiBwZGF0YS0+Y29udHJv
bGxlcl92ZXIpIHsNCiAJCQkvKiBjb250cm9sbGVyIHZlcnNpb24gMS42IG9yIGFib3ZlICovDQog
CQkJdG1wID0gaW9yZWFkMzJiZShub25fZWhjaSArIEZTTF9TT0NfVVNCX0NUUkwpOw0KQEAgLTI0
OSwxNyArMjcwLDExIEBAIHN0YXRpYyBpbnQgZWhjaV9mc2xfc2V0dXBfcGh5KHN0cnVjdCB1c2Jf
aGNkICpoY2QsDQogCQlicmVhazsNCiAJfQ0KIA0KLQkvKg0KLQkgKiBjaGVjayBQSFlfQ0xLX1ZB
TElEIHRvIGRldGVybWluZSBwaHkgY2xvY2sgcHJlc2VuY2UgYmVmb3JlIHdyaXRpbmcNCi0JICog
dG8gcG9ydHNjDQotCSAqLw0KLQlpZiAocGRhdGEtPmNoZWNrX3BoeV9jbGtfdmFsaWQpIHsNCi0J
CWlmICghKGlvcmVhZDMyYmUobm9uX2VoY2kgKyBGU0xfU09DX1VTQl9DVFJMKSAmDQotCQkgICAg
UEhZX0NMS19WQUxJRCkpIHsNCi0JCQlkZXZfd2FybihoY2QtPnNlbGYuY29udHJvbGxlciwNCi0J
CQkJICJVU0IgUEhZIGNsb2NrIGludmFsaWRcbiIpOw0KLQkJCXJldHVybiAtRUlOVkFMOw0KLQkJ
fQ0KKwlpZiAocGRhdGEtPmhhdmVfc3lzaWZfcmVncyAmJg0KKwkgICAgcGRhdGEtPmNvbnRyb2xs
ZXJfdmVyID4gRlNMX1VTQl9WRVJfMV82ICYmDQorCQkhdXNiX3BoeV9jbGtfdmFsaWQoaGNkKSkg
ew0KKwkJZGV2X3dhcm4oaGNkLT5zZWxmLmNvbnRyb2xsZXIsICJVU0IgUEhZIGNsb2NrIGludmFs
aWRcbiIpOw0KKwkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCiAJZWhjaV93cml0ZWwoZWhjaSwg
cG9ydHNjLCAmZWhjaS0+cmVncy0+cG9ydF9zdGF0dXNbcG9ydF9vZmZzZXRdKTsNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmggYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2kt
ZnNsLmgNCmluZGV4IGNiYzQyMjAuLjlkMThjNmUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9o
b3N0L2VoY2ktZnNsLmgNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuaA0KQEAgLTUw
LDQgKzUwLDcgQEANCiAjZGVmaW5lIFVUTUlfUEhZX0VOICAgICAgICAgICAgICgxPDw5KQ0KICNk
ZWZpbmUgVUxQSV9QSFlfQ0xLX1NFTCAgICAgICAgKDE8PDEwKQ0KICNkZWZpbmUgUEhZX0NMS19W
QUxJRAkJKDE8PDE3KQ0KKw0KKy8qIFJldHJ5IGNvdW50IGZvciBjaGVja2luZyBVVE1JIFBIWSBD
TEsgdmFsaWRpdHkgKi8NCisjZGVmaW5lIFVUTUlfUEhZX0NMS19WQUxJRF9DSEtfUkVUUlkgNQ0K
ICNlbmRpZgkJCQkvKiBfRUhDSV9GU0xfSCAqLw0KLS0gDQoxLjcuMQ0KDQo=
