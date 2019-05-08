Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A989DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F52B21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ato9ysgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfEHGFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:05:22 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:3088
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbfEHGFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpeZCp1ZplV19AO3dEl5NELaJLD6by4v5QQpk1RDHlU=;
 b=Ato9ysgZv5fWfIXvOgm98ITczXgacPSCMQAjxbD9UcjwKTnlROwNQ5S2eFlbTOj8kleH7mf7nanVC/5KYAI55fGydKFSp06k8FtnWPPmRzt/ofnjtl87hmwyK5I1umUjqzcGYXxSxI1htukRVwyANzXdKU/Kmi+hzxVJ3fW0A0A=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4141.eurprd04.prod.outlook.com (52.133.14.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 06:04:47 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::8015:ec84:d721:b566%5]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 06:04:47 +0000
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
        Suresh Gupta <suresh.gupta@freescale.com>
Subject: [PATCH v5 4/5] usb: host: Stops USB controller init if PLL fails to
 lock
Thread-Topic: [PATCH v5 4/5] usb: host: Stops USB controller init if PLL fails
 to lock
Thread-Index: AQHVBWPwtPsu0fLjhE+qRODS4vtH+w==
Date:   Wed, 8 May 2019 06:04:47 +0000
Message-ID: <20190508060608.33882-4-yinbo.zhu@nxp.com>
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
x-ms-office365-filtering-correlation-id: 131968bf-08a6-417b-edea-08d6d37b12e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4141;
x-ms-traffictypediagnostic: VI1PR04MB4141:
x-microsoft-antispam-prvs: <VI1PR04MB4141C44D4ACC28AC237FC602E9320@VI1PR04MB4141.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(68736007)(446003)(54906003)(2906002)(6116002)(81156014)(11346002)(486006)(476003)(6506007)(2616005)(66066001)(81166006)(8676002)(76176011)(7736002)(305945005)(44832011)(6916009)(36756003)(2171002)(50226002)(107886003)(53936002)(4326008)(25786009)(86362001)(1076003)(8936002)(186003)(5660300002)(3846002)(52116002)(99286004)(102836004)(316002)(386003)(478600001)(256004)(71190400001)(71200400001)(14444005)(14454004)(6512007)(6486002)(6436002)(66446008)(73956011)(66946007)(26005)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4141;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S3BvBkG5ABbCkZIzG6isQi9G4ER8x/hNghmhMrY0wVd+dlvW/Ol1T2r3hK7oytVLc0WI92XGWxGJYC5KntyAIrLecNDzJrm1/2r+EVaBXYuz5xdUDJrxkSzFZVQXQSV3K8D+qxuSK2t1LWDAYsO7kCN0D7kWndmxn7wymvvHtvTMSXWVJP3lzBg/kQFioINdsIXC0GPUud3XF78skoRJiviZKpBCJDHiqTmgRO2aibq8+f0ouHCvhbh/pHQI1kUi8PC+afXQWmfA70bP61I3jpClpRsSO4JLB8Q3Axab0iqPFaKr0zew5HnFo5YHQXWi+wf7ZxCUMSAa0dP5Vx9pt0zi3ELxYBkahSnFmd6mzFRoKGEZJvrf3fWGQ6jow9ymEccmGIpxSBE1kF7/RptpKk+v65VAqa2jJIueksFluMY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131968bf-08a6-417b-edea-08d6d37b12e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 06:04:47.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFtbmVlayBNZWhyZXNoIDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxlLmNvbT4NCg0K
VVNCIGVycmF0dW0tQTAwNjkxOCB3b3JrYXJvdW5kIHRyaWVzIHRvIHN0YXJ0IGludGVybmFsIFBI
WSBpbnNpZGUNCnVib290ICh3aGVuIFBMTCBmYWlscyB0byBsb2NrKS4gSG93ZXZlciwgaWYgdGhl
IHdvcmthcm91bmQgYWxzbw0KZmFpbHMsIHRoZW4gVVNCIGluaXRpYWxpemF0aW9uIGlzIGFsc28g
c3RvcHBlZCBpbnNpZGUgTGludXguDQpFcnJhdHVtLUEwMDY5MTggd29ya2Fyb3VuZCBmYWlsdXJl
IGNyZWF0ZXMgImZzbCxlcnJhdHVtX2EwMDY5MTgiDQpub2RlIGluIGRldmljZS10cmVlLiBQcmVz
ZW5jZSBvZiB0aGlzIG5vZGUgaW4gZGV2aWNlLXRyZWUgaXMNCnVzZWQgdG8gc3RvcCBVU0IgY29u
dHJvbGxlciBpbml0aWFsaXphdGlvbiBpbiBMaW51eA0KDQpTaWduZWQtb2ZmLWJ5OiBSYW1uZWVr
IE1laHJlc2ggPHJhbW5lZWsubWVocmVzaEBmcmVlc2NhbGUuY29tPg0KU2lnbmVkLW9mZi1ieTog
U3VyZXNoIEd1cHRhIDxzdXJlc2guZ3VwdGFAZnJlZXNjYWxlLmNvbT4NClNpZ25lZC1vZmYtYnk6
IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5jb20+DQotLS0NCkNoYW5nZSBpbiB2NToNCgkJdXNl
IGRldl93YXJuKCkgaW5zdGVhZCBvZiBwcl93YXJuKCkNCg0KIGRyaXZlcnMvdXNiL2hvc3QvZWhj
aS1mc2wuYyAgICAgIHwgICAgNSArKysrKw0KIGRyaXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1v
Zi5jIHwgICAgMyArKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYyBiL2Ry
aXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYw0KaW5kZXggMTYzNGFjOC4uOTA1NTBhNiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYw0KKysrIGIvZHJpdmVycy91c2IvaG9z
dC9laGNpLWZzbC5jDQpAQCAtMjM2LDYgKzIzNiwxMSBAQCBzdGF0aWMgaW50IGVoY2lfZnNsX3Nl
dHVwX3BoeShzdHJ1Y3QgdXNiX2hjZCAqaGNkLA0KIAkJcG9ydHNjIHw9IFBPUlRfUFRTX1BUVzsN
CiAJCS8qIGZhbGwgdGhyb3VnaCAqLw0KIAljYXNlIEZTTF9VU0IyX1BIWV9VVE1JOg0KKwkJaWYg
KHBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNjkxOCkgew0KKwkJCWRldl93YXJuKGRldiwgIlVT
QiBQSFkgY2xvY2sgaW52YWxpZFxuIik7DQorCQkJcmV0dXJuIC1FSU5WQUw7DQorCQl9DQorDQog
CWNhc2UgRlNMX1VTQjJfUEhZX1VUTUlfRFVBTDoNCiAJCS8qIFBIWV9DTEtfVkFMSUQgYml0IGlz
IGRlLWZlYXR1cmVkIGZyb20gYWxsIGNvbnRyb2xsZXINCiAJCSAqIHZlcnNpb25zIGJlbG93IDIu
NCBhbmQgaXMgdG8gYmUgY2hlY2tlZCBvbmx5IGZvcg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2hvc3QvZnNsLW1waC1kci1vZi5jIGIvZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMN
CmluZGV4IDRmOGI4YTAuLjc2MmI5NzYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2Zz
bC1tcGgtZHItb2YuYw0KKysrIGIvZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMNCkBA
IC0yMjQsMTMgKzIyNCwxNCBAQCBzdGF0aWMgaW50IGZzbF91c2IyX21waF9kcl9vZl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvZmRldikNCiAJCW9mX3Byb3BlcnR5X3JlYWRfYm9vbChu
cCwgImZzbCx1c2ItZXJyYXR1bS1hMDA1Mjc1Iik7DQogCXBkYXRhLT5oYXNfZnNsX2VycmF0dW1f
YTAwNTY5NyA9DQogCQlvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJmc2wsdXNiX2VycmF0dW0t
YTAwNTY5NyIpOw0KKwlwZGF0YS0+aGFzX2ZzbF9lcnJhdHVtX2EwMDY5MTggPQ0KKwkJb2ZfcHJv
cGVydHlfcmVhZF9ib29sKG5wLCAiZnNsLHVzYl9lcnJhdHVtLWEwMDY5MTgiKTsNCiANCiAJaWYg
KG9mX2dldF9wcm9wZXJ0eShucCwgImZzbCx1c2JfZXJyYXR1bV8xNCIsIE5VTEwpKQ0KIAkJcGRh
dGEtPmhhc19mc2xfZXJyYXR1bV8xNCA9IDE7DQogCWVsc2UNCiAJCXBkYXRhLT5oYXNfZnNsX2Vy
cmF0dW1fMTQgPSAwOw0KIA0KLQ0KIAkvKg0KIAkgKiBEZXRlcm1pbmUgd2hldGhlciBwaHlfY2xr
X3ZhbGlkIG5lZWRzIHRvIGJlIGNoZWNrZWQNCiAJICogYnkgcmVhZGluZyBwcm9wZXJ0eSBpbiBk
ZXZpY2UgdHJlZQ0KLS0gDQoxLjcuMQ0KDQo=
