Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8883C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C2720643
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Zl20Wzrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfDYMgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:36:17 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:17639 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:36:15 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="32237112"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:36:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:36:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBQ+hpUZ4QZBYGADbXck0DQ1fR4QKfN34rUXcaGzFmE=;
 b=Zl20Wzrsp907BKck2HaKkIZ18/SgBLU6cxiEpASQgeck1P2e6L6L7A5QUGj51KAxoPytIYGpkjLOt4RDLG2g2osuEJoNMiW/mKDrt1R8IcfywyeaJKh16fj71OJL0dwj/I2UVM92ua7lxsSUpXgEMR9TjZRavWdHVoZNA40m310=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1726.namprd11.prod.outlook.com (10.169.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 12:36:09 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:36:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [RESEND][PATCH v3 1/6] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Topic: [RESEND][PATCH v3 1/6] drm: atmel-hlcdc: add config option for
 clock selection
Thread-Index: AQHU+2N1sGOMkyXnMEKr+b1W9DZg6A==
Date:   Thu, 25 Apr 2019 12:36:09 +0000
Message-ID: <1556195748-11106-2-git-send-email-claudiu.beznea@microchip.com>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0024.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::34) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95308f69-1d43-4bf6-3938-08d6c97a97fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1726;
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-microsoft-antispam-prvs: <MWHPR11MB1726854544A9083BD3556471873D0@MWHPR11MB1726.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(81156014)(7416002)(81166006)(97736004)(2201001)(53936002)(5660300002)(8676002)(2501003)(2906002)(86362001)(50226002)(305945005)(6436002)(68736007)(6486002)(72206003)(107886003)(71190400001)(14454004)(6512007)(8936002)(478600001)(186003)(66066001)(76176011)(26005)(14444005)(256004)(476003)(7736002)(71200400001)(486006)(110136005)(54906003)(6506007)(386003)(6116002)(102836004)(66476007)(66446008)(66946007)(66556008)(36756003)(73956011)(64756008)(11346002)(4326008)(446003)(52116002)(316002)(99286004)(3846002)(2616005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1726;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fcDt9x1xm80RcQNFJbf25rIIhp1OnBBrUQd8epPKkdVKtEluE50Cw2+xS4vT4t647H4Ev3fktOecS3uLaigQzi/uSLG1V41HkVmzbqAJSfVlb+XlMqwJJP++dUbrV4I5ymXdxu+11UpGjD3aXlwRVMnYjbmKeONr8qKrCKI1SSm57bkVD157fq8HTvAzgQZGHJqp0lfchI7BRsHd8Cg73hbAcCUy5zim90+ICJxN8dmYwQmecx4wupLgqAKBvQTDg2N64IcGJOMpwdjb6Av9do/dDRd1X65zGHD6b0E7OSrIdGWR/gQ0rh6JclMSGThH1yqzJHGXMlPL/kWoKiEnYCJhlpOjXNf3H21kIo7r0cib/KghNlJjOxontzE0pcpmLz+0WoqiAZn8wKxJOF/I0B8a/AOJ5CF9Kfs0gse548k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 95308f69-1d43-4bf6-3938-08d6c97a97fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:36:09.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClNB
TTl4NjAgTENEIENvbnRyb2xsZXIgaGFzIG5vIG9wdGlvbiB0byBzZWxlY3QgY2xvY2sgc291cmNl
IGFzIHByZXZpb3VzDQpjb250cm9sbGVycyBoYXZlLiBUbyBiZSBhYmxlIHRvIHVzZSB0aGUgc2Ft
ZSBkcml2ZXIgZXZlbiBmb3IgdGhpcyBMQ0QNCmNvbnRyb2xsZXIgYWRkIGEgY29uZmlnIG9wdGlv
biB0byBrbm93IGlmIGNvbnRyb2xsZXIgc3VwcG9ydHMgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpSZXZpZXdlZC1i
eTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyB8IDEyICsrKysrKystLS0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5oICAgfCAgMiArKw0KIDIgZmls
ZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCmluZGV4IDgwNzBhNTU4
ZDdiMS4uOTU3ZTZkMmZiMDBmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhs
Y2RjL2F0bWVsX2hsY2RjX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2Rj
L2F0bWVsX2hsY2RjX2NydGMuYw0KQEAgLTc4LDcgKzc4LDggQEAgc3RhdGljIHZvaWQgYXRtZWxf
aGxjZGNfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1fY3J0YyAqYykNCiAJdW5zaWduZWQg
bG9uZyBtb2RlX3JhdGU7DQogCXN0cnVjdCB2aWRlb21vZGUgdm07DQogCXVuc2lnbmVkIGxvbmcg
cHJhdGU7DQotCXVuc2lnbmVkIGludCBjZmc7DQorCXVuc2lnbmVkIGludCBtYXNrID0gQVRNRUxf
SExDRENfQ0xLRElWX01BU0sgfCBBVE1FTF9ITENEQ19DTEtQT0w7DQorCXVuc2lnbmVkIGludCBj
ZmcgPSAwOw0KIAlpbnQgZGl2Ow0KIA0KIAl2bS52ZnJvbnRfcG9yY2ggPSBhZGotPmNydGNfdnN5
bmNfc3RhcnQgLSBhZGotPmNydGNfdmRpc3BsYXk7DQpAQCAtMTAxLDcgKzEwMiwxMCBAQCBzdGF0
aWMgdm9pZCBhdG1lbF9obGNkY19jcnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpj
KQ0KIAkJICAgICAoYWRqLT5jcnRjX2hkaXNwbGF5IC0gMSkgfA0KIAkJICAgICAoKGFkai0+Y3J0
Y192ZGlzcGxheSAtIDEpIDw8IDE2KSk7DQogDQotCWNmZyA9IEFUTUVMX0hMQ0RDX0NMS1NFTDsN
CisJaWYgKCFjcnRjLT5kYy0+ZGVzYy0+Zml4ZWRfY2xrc3JjKSB7DQorCQljZmcgfD0gQVRNRUxf
SExDRENfQ0xLU0VMOw0KKwkJbWFzayB8PSBBVE1FTF9ITENEQ19DTEtTRUw7DQorCX0NCiANCiAJ
cHJhdGUgPSAyICogY2xrX2dldF9yYXRlKGNydGMtPmRjLT5obGNkYy0+c3lzX2Nsayk7DQogCW1v
ZGVfcmF0ZSA9IGFkai0+Y3J0Y19jbG9jayAqIDEwMDA7DQpAQCAtMTMyLDkgKzEzNiw3IEBAIHN0
YXRpYyB2b2lkIGF0bWVsX2hsY2RjX2NydGNfbW9kZV9zZXRfbm9mYihzdHJ1Y3QgZHJtX2NydGMg
KmMpDQogDQogCWNmZyB8PSBBVE1FTF9ITENEQ19DTEtESVYoZGl2KTsNCiANCi0JcmVnbWFwX3Vw
ZGF0ZV9iaXRzKHJlZ21hcCwgQVRNRUxfSExDRENfQ0ZHKDApLA0KLQkJCSAgIEFUTUVMX0hMQ0RD
X0NMS1NFTCB8IEFUTUVMX0hMQ0RDX0NMS0RJVl9NQVNLIHwNCi0JCQkgICBBVE1FTF9ITENEQ19D
TEtQT0wsIGNmZyk7DQorCXJlZ21hcF91cGRhdGVfYml0cyhyZWdtYXAsIEFUTUVMX0hMQ0RDX0NG
RygwKSwgbWFzaywgY2ZnKTsNCiANCiAJY2ZnID0gMDsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
dG1lbC1obGNkYy9hdG1lbF9obGNkY19kYy5oDQppbmRleCA3MGJkNTQwZDY0NGUuLjAxNTVlZmI5
YzQ0MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNk
Y19kYy5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfZGMu
aA0KQEAgLTMyOCw2ICszMjgsNyBAQCBhdG1lbF9obGNkY19sYXllcl90b19wbGFuZShzdHJ1Y3Qg
YXRtZWxfaGxjZGNfbGF5ZXIgKmxheWVyKQ0KICAqIEBtYXhfaHB3OiBtYXhpbXVtIGhvcml6b250
YWwgYmFjay9mcm9udCBwb3JjaCB3aWR0aA0KICAqIEBjb25mbGljdGluZ19vdXRwdXRfZm9ybWF0
czogdHJ1ZSBpZiBSR0JYWFggb3V0cHV0IGZvcm1hdHMgY29uZmxpY3Qgd2l0aA0KICAqCQkJCWVh
Y2ggb3RoZXIuDQorICogQGZpeGVkX2Nsa3NyYzogdHJ1ZSBpZiBjbG9jayBzb3VyY2UgaXMgZml4
ZWQNCiAgKiBAbGF5ZXJzOiBhIGxheWVyIGRlc2NyaXB0aW9uIHRhYmxlIGRlc2NyaWJpbmcgYXZh
aWxhYmxlIGxheWVycw0KICAqIEBubGF5ZXJzOiBsYXllciBkZXNjcmlwdGlvbiB0YWJsZSBzaXpl
DQogICovDQpAQCAtMzQwLDYgKzM0MSw3IEBAIHN0cnVjdCBhdG1lbF9obGNkY19kY19kZXNjIHsN
CiAJaW50IG1heF92cHc7DQogCWludCBtYXhfaHB3Ow0KIAlib29sIGNvbmZsaWN0aW5nX291dHB1
dF9mb3JtYXRzOw0KKwlib29sIGZpeGVkX2Nsa3NyYzsNCiAJY29uc3Qgc3RydWN0IGF0bWVsX2hs
Y2RjX2xheWVyX2Rlc2MgKmxheWVyczsNCiAJaW50IG5sYXllcnM7DQogfTsNCi0tIA0KMi43LjQN
Cg0K
