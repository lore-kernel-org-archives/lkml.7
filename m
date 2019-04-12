Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB25C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFD52083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZFJS3PHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDLKT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:19:56 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:60505 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:19:52 -0400
X-IronPort-AV: E=Sophos;i="5.60,340,1549954800"; 
   d="scan'208";a="29792645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Apr 2019 03:19:52 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Apr 2019 03:19:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdezC86ZmpzMyWPpEH1Cs31OEIomGxRPFZpAXTnUe1s=;
 b=ZFJS3PHUksiC1V6+CJ5ZXhoDCUF15nL9+Eo6Ti8eu2uW4szRWj9dm1UFDutmHedWN+pvBzICGhQziR9F4YxTy/4sr7WGqZ7nbzaalszPXViDXaqKUGLlCXHWsmnfYrM0Kaeo2YqauirL1nmkOV63FHcoYqAfKZE1Ut9BZTBWMhI=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1947.namprd11.prod.outlook.com (10.175.88.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Fri, 12 Apr 2019 10:19:50 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 10:19:50 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <mchehab@kernel.org>,
        <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 3/3] media: atmel: atmel-isc: fix asd memory allocation
Thread-Topic: [PATCH 3/3] media: atmel: atmel-isc: fix asd memory allocation
Thread-Index: AQHU8RlCk4yC9UUXy0av/TaU4uWanQ==
Date:   Fri, 12 Apr 2019 10:19:49 +0000
Message-ID: <1555064098-19310-4-git-send-email-eugen.hristev@microchip.com>
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
x-ms-office365-filtering-correlation-id: e657cb9f-1ef6-4a87-7acb-08d6bf306517
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1947;
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB1947986C710464850570DA8EE8280@DM5PR11MB1947.namprd11.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(105586002)(54906003)(102836004)(36756003)(50226002)(26005)(14454004)(2906002)(97736004)(66066001)(6486002)(6436002)(6506007)(386003)(305945005)(7736002)(2501003)(81166006)(5660300002)(8676002)(446003)(8936002)(81156014)(107886003)(256004)(486006)(4326008)(478600001)(76176011)(110136005)(106356001)(68736007)(316002)(86362001)(3846002)(71200400001)(52116002)(72206003)(2616005)(476003)(25786009)(6116002)(186003)(6512007)(71190400001)(99286004)(11346002)(2201001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1947;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sFSLpebleuBx3qxTxACDE21nSJeGDPuziWFjnc+8ktCZBfcCok8X1+UE8JcQ7iHNjY0MijhF0jIbDUZ7YIbok8mSmYbncL/JaDgQTf9gQTK27mGouA0fmurfG4QlgS8CTNDjpKBRQXb5PlGVi0tNiX+apeNMBi13+kD+rVJWwODzLpbu0ff65s29b8EztgM8KGxWUp6bvdMf+aW5j0TP7rsWfh20J2tzTy8QD529B/pYCaTBnWlhA2H9RhnXjzq8Gq94JefCDj6lVPGC5WnHL7D4TWbUyQVsHk7l14qx90FZ1hF6z9uXWKq9xGWP9UaZ24DkrMp8R9/urpD43SUUEgELG004yv1JMMqrNB1WWOFxdYqSbYbboJxGR3fxCvfFUSzYh2Rv1W/0lKqOwyeGb3Oi0xvPYRZ75sdQpqEo47M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e657cb9f-1ef6-4a87-7acb-08d6bf306517
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 10:19:49.9160
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

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpUaGUg
c3Vic3lzdGVtIHdpbGwgZnJlZSB0aGUgYXNkIG1lbW9yeSBvbiBub3RpZmllciBjbGVhbnVwLCBp
ZiB0aGUgYXNkIGlzDQphZGRlZCB0byB0aGUgbm90aWZpZXIuDQpIb3dldmVyIHRoZSBtZW1vcnkg
aXMgZnJlZWQgdXNpbmcga2ZyZWUuDQpUaHVzLCB3ZSBjYW5ub3QgYWxsb2NhdGUgdGhlIGFzZCB1
c2luZyBkZXZtXyoNClRoaXMgY2FuIGxlYWQgdG8gY3Jhc2hlcyBhbmQgcHJvYmxlbXMuDQpUbyB0
ZXN0IHRoaXMgaXNzdWUsIGp1c3QgcmV0dXJuIGFuIGVycm9yIGF0IHByb2JlLCBidXQgY2xlYW51
cCB0aGUNCm5vdGlmaWVyIGJlZm9yZWhhbmQuDQoNCkZpeGVzOiAxMDYyNjc0NDRmICgiW21lZGlh
XSBhdG1lbC1pc2M6IGFkZCB0aGUgSW1hZ2UgU2Vuc29yIENvbnRyb2xsZXIgY29kZSIpDQpTaWdu
ZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQot
LS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIHwgOCArKysrKyst
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYw0KaW5kZXggYWVmOTBkYi4uOGUw
NzJhOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNj
LmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCkBAIC0y
MTY4LDggKzIxNjgsMTEgQEAgc3RhdGljIGludCBpc2NfcGFyc2VfZHQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgaXNjX2RldmljZSAqaXNjKQ0KIAkJCWJyZWFrOw0KIAkJfQ0KIA0KLQkJc3Vi
ZGV2X2VudGl0eS0+YXNkID0gZGV2bV9remFsbG9jKGRldiwNCi0JCQkJICAgICBzaXplb2YoKnN1
YmRldl9lbnRpdHktPmFzZCksIEdGUF9LRVJORUwpOw0KKwkJLyogYXNkIHdpbGwgYmUgZnJlZWQg
YnkgdGhlIHN1YnN5c3RlbSBvbmNlIGl0J3MgYWRkZWQgdG8gdGhlDQorCQkgKiBub3RpZmllciBs
aXN0DQorCQkgKi8NCisJCXN1YmRldl9lbnRpdHktPmFzZCA9IGt6YWxsb2Moc2l6ZW9mKCpzdWJk
ZXZfZW50aXR5LT5hc2QpLA0KKwkJCQkJICAgICBHRlBfS0VSTkVMKTsNCiAJCWlmICghc3ViZGV2
X2VudGl0eS0+YXNkKSB7DQogCQkJb2Zfbm9kZV9wdXQocmVtKTsNCiAJCQlyZXQgPSAtRU5PTUVN
Ow0KQEAgLTIzMTMsNiArMjMxNiw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfaXNjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJCQkJICAgICBzdWJkZXZfZW50aXR5LT5hc2Qp
Ow0KIAkJaWYgKHJldCkgew0KIAkJCWZ3bm9kZV9oYW5kbGVfcHV0KHN1YmRldl9lbnRpdHktPmFz
ZC0+bWF0Y2guZndub2RlKTsNCisJCQlrZnJlZShzdWJkZXZfZW50aXR5LT5hc2QpOw0KIAkJCWdv
dG8gY2xlYW51cF9zdWJkZXY7DQogCQl9DQogDQotLSANCjIuNy40DQoNCg==
