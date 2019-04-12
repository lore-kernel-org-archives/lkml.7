Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183CFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB826218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ge+rXSdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDLKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:19:51 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:60505 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:19:50 -0400
X-IronPort-AV: E=Sophos;i="5.60,340,1549954800"; 
   d="scan'208";a="29792643"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 12 Apr 2019 03:19:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Apr 2019 03:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmfYvnqDDdveQXhLG7K4xfbnSATFnPRs+Ljzcnumuew=;
 b=ge+rXSdzI1M8Fln9v729V3w0IFMyPyCgZP6lgDIhxhFUlFC2rD+taLpjTCQeM+YTuIQVOtzSdO3kN0swmYKxTQC7pDC1SRgaDU8que0uymwwwKkegPQnWHuOsK05W9YDyAGNvJ/Jup/e12UBqK/6Iwo/aMRg02VtG6CsmkX67Ok=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1947.namprd11.prod.outlook.com (10.175.88.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Fri, 12 Apr 2019 10:19:46 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 10:19:46 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <mchehab@kernel.org>,
        <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/3] media: atmel: atmel-isc: fix INIT_WORK misplacement
Thread-Topic: [PATCH 2/3] media: atmel: atmel-isc: fix INIT_WORK misplacement
Thread-Index: AQHU8RlAswvvLxh+TkKT8iU+bXVupw==
Date:   Fri, 12 Apr 2019 10:19:46 +0000
Message-ID: <1555064098-19310-3-git-send-email-eugen.hristev@microchip.com>
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::40) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d467acd5-cc23-456c-fb92-08d6bf30633a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1947;
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB194707939362310C8C7B2281E8280@DM5PR11MB1947.namprd11.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(105586002)(54906003)(102836004)(36756003)(50226002)(26005)(14454004)(2906002)(97736004)(66066001)(6486002)(6436002)(6506007)(386003)(305945005)(7736002)(2501003)(81166006)(5660300002)(8676002)(446003)(8936002)(81156014)(107886003)(256004)(486006)(4326008)(478600001)(76176011)(110136005)(106356001)(68736007)(316002)(86362001)(3846002)(71200400001)(52116002)(72206003)(2616005)(476003)(25786009)(6116002)(186003)(6512007)(71190400001)(99286004)(11346002)(2201001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1947;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PAK1VIB696z5+4ANTKqPv7GAmGcfExry6MbeL7bn+rw5IZKiVBkiR422eShkIjwMLWMT5spDIkQRGSiBbcPWEbtsj9jUVdUL8Ur1yz3i75QxIa1Amsuk2FXSChD2AEUWTzkU63AIw4P3xyyXItrucEvkdILHxPwXTx6lW7axF/fBS9XcCuByeEICuYRRb3kpseX6Zez9RnkDcPUMH2ObKnk1kHSlSUCMrq9B6ns7Q+KqKWD+HUN0oFNDaTWK9IIdkBi5ZQQFSv9DbjTzTR67+u4bf+mHHO1WjkQzRj0MVJmj2v+I1r26PCn8RzBhYp3oiKjP8G5kUsc6XCFhMERdEL2qDGkfNN2E/Inaev3w0KyLNrGecwC1Zgxt1xD+/sJvNSUVmVZWH9irjtOLOb0UGNLn83mJVTvdwCvA2U1viPY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d467acd5-cc23-456c-fb92-08d6bf30633a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 10:19:46.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpJbiBj
YXNlIHRoZSBjb21wbGV0aW9uIGZ1bmN0aW9uIGZhaWxlcywgdW5iaW5kIHdpbGwgYmUgY2FsbGVk
DQp3aGljaCB3aWxsIGNhbGwgY2FuY2VsX3dvcmsgZm9yIGF3Yl93b3JrLg0KVGhpcyB3aWxsIHRy
aWdnZXIgYSBXQVJOIG1lc3NhZ2UgZnJvbSB0aGUgd29ya3F1ZXVlLg0KVG8gYXZvaWQgdGhpcywg
bW92ZSB0aGUgSU5JVF9XT1JLIGNhbGwgYXQgdGhlIHN0YXJ0IG9mIHRoZSBjb21wbGV0aW9uDQpm
dW5jdGlvbi4gVGhpcyB3YXkgdGhlIHdvcmsgaXMgYWx3YXlzIGluaXRpYWxpemVkLCB3aGljaCBj
b3JyZXNwb25kcw0KdG8gdGhlICdhbHdheXMgY2FuY2VsZWQnIHVuYmluZCBjb2RlLg0KDQpGaXhl
czogOTNkNGEyNmMzZCAoIlttZWRpYV0gYXRtZWwtaXNjOiBhZGQgdGhlIGlzYyBwaXBlbGluZSBm
dW5jdGlvbiIpDQpTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1p
Y3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlz
Yy5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwt
aXNjLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQppbmRleCBl
YTc1MjBhLi5hZWY5MGRiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9hdG1lbC1pc2MuYw0KKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1p
c2MuYw0KQEAgLTE5OTgsNiArMTk5OCw4IEBAIHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRl
KHN0cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVyICpub3RpZmllcikNCiAJc3RydWN0IHZiMl9xdWV1
ZSAqcSA9ICZpc2MtPnZiMl92aWRxOw0KIAlpbnQgcmV0Ow0KIA0KKwlJTklUX1dPUksoJmlzYy0+
YXdiX3dvcmssIGlzY19hd2Jfd29yayk7DQorDQogCXJldCA9IHY0bDJfZGV2aWNlX3JlZ2lzdGVy
X3N1YmRldl9ub2RlcygmaXNjLT52NGwyX2Rldik7DQogCWlmIChyZXQgPCAwKSB7DQogCQl2NGwy
X2VycigmaXNjLT52NGwyX2RldiwgIkZhaWxlZCB0byByZWdpc3RlciBzdWJkZXYgbm9kZXNcbiIp
Ow0KQEAgLTIwNTEsOCArMjA1Myw2IEBAIHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRlKHN0
cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVyICpub3RpZmllcikNCiAJCXJldHVybiByZXQ7DQogCX0N
CiANCi0JSU5JVF9XT1JLKCZpc2MtPmF3Yl93b3JrLCBpc2NfYXdiX3dvcmspOw0KLQ0KIAkvKiBS
ZWdpc3RlciB2aWRlbyBkZXZpY2UgKi8NCiAJc3Ryc2NweSh2ZGV2LT5uYW1lLCBBVE1FTF9JU0Nf
TkFNRSwgc2l6ZW9mKHZkZXYtPm5hbWUpKTsNCiAJdmRldi0+cmVsZWFzZQkJPSB2aWRlb19kZXZp
Y2VfcmVsZWFzZV9lbXB0eTsNCi0tIA0KMi43LjQNCg0K
