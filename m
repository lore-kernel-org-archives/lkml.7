Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F888C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D161B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FhV5wTi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfDILHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:07:39 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:34760 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDILHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:07:37 -0400
X-IronPort-AV: E=Sophos;i="5.60,329,1549954800"; 
   d="scan'208";a="27942131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Apr 2019 04:07:36 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 9 Apr 2019 04:07:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n99EWyiTvBtCILfSi0zxi0Yx+ZnntcY5VbriHshfLKQ=;
 b=FhV5wTi3+CUhxmtSKGiDBc4QJlMpFeaJrn1FAmB4EGWSLkDo8L9rShZ/e5RAlgrW4VIAT13EelZv4SjPFCxcO6mnTMo7233QpeEo+yg/bULjrDyK9qdqCVaVOrS+srlLn/7T7+/rV+QTfYgaY3Ftp/vrEiq7cc/O7aFZ47lu5Qo=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0011.namprd11.prod.outlook.com (10.164.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Tue, 9 Apr 2019 11:07:34 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 11:07:34 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>
CC:     <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 6/7] media: atmel: atmel-isc: fix INIT_WORK misplacement
Thread-Topic: [PATCH 6/7] media: atmel: atmel-isc: fix INIT_WORK misplacement
Thread-Index: AQHU7sRuujfNEyp180Gaiz10JjafeA==
Date:   Tue, 9 Apr 2019 11:07:33 +0000
Message-ID: <1554807715-2353-7-git-send-email-eugen.hristev@microchip.com>
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:28::22) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c4bbb17-4bdc-4e73-61ba-08d6bcdb90f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB0011;
x-ms-traffictypediagnostic: DM5PR11MB0011:
x-microsoft-antispam-prvs: <DM5PR11MB00117BE1A2036B3F0AE78F5DE82D0@DM5PR11MB0011.namprd11.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(256004)(81166006)(66066001)(486006)(8676002)(36756003)(446003)(476003)(5660300002)(81156014)(50226002)(8936002)(71200400001)(71190400001)(2616005)(11346002)(6512007)(106356001)(105586002)(7736002)(305945005)(478600001)(4326008)(2201001)(186003)(99286004)(76176011)(6486002)(107886003)(68736007)(97736004)(72206003)(110136005)(14454004)(316002)(53936002)(52116002)(26005)(54906003)(6436002)(6506007)(6116002)(2501003)(2906002)(3846002)(386003)(25786009)(102836004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0011;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5j9Y8MbnzVokzvC7S8m2M1WUOzoEt0HBvUwLmjrTfoVZbhjb5241IK2mWP1fiA46qyGmnq/0ikkPJ2D0TZbjVUDZHFoRoq0K8aOUBnvfFzJlJBjB3OhW6vzCzmCG9GFbHXM+JwOxfmBkhC24zncs2bR6ITmJnCrh+AcH+8A/5+wqHP3mPDq4gufjhNlCSmT8ePzlwmH2nC90zU/jQApdKKGqqjlodYVjFBpuaXXMQK38nf7/z9Cd+ta0SZw1D9arm6K1/qlMudjcBUTjj7A3vxF7qlbfw6h9jd4AMcKNziypYF4j+X5zZtr6m1Ymv8VJeRYM9zJwe6ovdiToIK7uQawX1L9PYSlncWS25uKKkwXCGq0p6wGaq0mBIlIsl/4EPJF2jmN9dKqOCU5emlzY3SadTPRLom7Bj+t+yzVxdlU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4bbb17-4bdc-4e73-61ba-08d6bcdb90f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 11:07:33.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0011
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
aXNjLmMgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQppbmRleCA5
MDJiZDdlLi40ODY1MmMwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9hdG1lbC1pc2MuYw0KKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1p
c2MuYw0KQEAgLTIyMzcsNiArMjIzNyw4IEBAIHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRl
KHN0cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVyICpub3RpZmllcikNCiAJc3RydWN0IHZiMl9xdWV1
ZSAqcSA9ICZpc2MtPnZiMl92aWRxOw0KIAlpbnQgcmV0Ow0KIA0KKwlJTklUX1dPUksoJmlzYy0+
YXdiX3dvcmssIGlzY19hd2Jfd29yayk7DQorDQogCXJldCA9IHY0bDJfZGV2aWNlX3JlZ2lzdGVy
X3N1YmRldl9ub2RlcygmaXNjLT52NGwyX2Rldik7DQogCWlmIChyZXQgPCAwKSB7DQogCQl2NGwy
X2VycigmaXNjLT52NGwyX2RldiwgIkZhaWxlZCB0byByZWdpc3RlciBzdWJkZXYgbm9kZXNcbiIp
Ow0KQEAgLTIyOTEsOCArMjI5Myw2IEBAIHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRlKHN0
cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVyICpub3RpZmllcikNCiAJCXJldHVybiByZXQ7DQogCX0N
CiANCi0JSU5JVF9XT1JLKCZpc2MtPmF3Yl93b3JrLCBpc2NfYXdiX3dvcmspOw0KLQ0KIAkvKiBS
ZWdpc3RlciB2aWRlbyBkZXZpY2UgKi8NCiAJc3Ryc2NweSh2ZGV2LT5uYW1lLCBBVE1FTF9JU0Nf
TkFNRSwgc2l6ZW9mKHZkZXYtPm5hbWUpKTsNCiAJdmRldi0+cmVsZWFzZQkJPSB2aWRlb19kZXZp
Y2VfcmVsZWFzZV9lbXB0eTsNCi0tIA0KMi43LjQNCg0K
