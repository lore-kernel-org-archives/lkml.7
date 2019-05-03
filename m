Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5EC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF4208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hD1F31YL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfECLTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:19:49 -0400
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:40769
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbfECLTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxMPa5mcyYpaJZoYrtdn9sDzSXY9ZtnHJbTos7wWymw=;
 b=hD1F31YLYYCDJW3TEP1v+xqDNH40ev163j81fWHFPLuvYeiAB8iLP7gd7GlbkF4pu/qP5P9bYmATjleRypBDoIdsdHqGgfAQcbVoA7ql62WG9wsF8UTefBOUJFRKOqi7SFECMwAw9uebPH1PUYuSc1sxkXaBVaHXxlq4Mmpcx7A=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5859.eurprd04.prod.outlook.com (20.178.202.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 11:19:32 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 11:19:32 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] scripts/gdb: Cleanup error handling in list helpers
Thread-Topic: [PATCH 1/2] scripts/gdb: Cleanup error handling in list helpers
Thread-Index: AQHVAaIUVmCD1Tl5NEapbpBu30VdQQ==
Date:   Fri, 3 May 2019 11:19:31 +0000
Message-ID: <c1d3fd4db13d999a3ba57f5bbc1924862d824f61.1556881728.git.leonard.crestez@nxp.com>
References: <cover.1556881728.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1556881728.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To AM0PR04MB6434.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0a6053-7668-4592-4616-08d6cfb936b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5859;
x-ms-traffictypediagnostic: AM0PR04MB5859:
x-microsoft-antispam-prvs: <AM0PR04MB58597512F9575FF28A439B27EE350@AM0PR04MB5859.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(478600001)(256004)(66066001)(14454004)(6436002)(386003)(11346002)(446003)(66946007)(6512007)(2616005)(110136005)(316002)(476003)(6486002)(8676002)(66476007)(66556008)(64756008)(66446008)(99286004)(53936002)(3846002)(81156014)(81166006)(54906003)(118296001)(36756003)(6116002)(68736007)(8936002)(50226002)(44832011)(73956011)(2906002)(486006)(305945005)(76176011)(52116002)(4326008)(102836004)(6506007)(25786009)(5660300002)(186003)(26005)(7736002)(86362001)(71200400001)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5859;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vMM7cP3o7tnaHo5j9IJXNho6qG1LlRjcUctAnah1jqj+XJ1KkRV7dEBMeXEbZQAtrL/aNg1o06J5i35NENwcEMtfcqq2VzpES8aLVMA/XH5JBBc7Xu7IXWmyvcFZcleyObrkR/0jM0URpYzqnByci6Kmin9Zep5PhoPXVj75BFU6zC0afimO/b/xh/EF54wXMaZgIknoE9bjyWYlvAamBpdEU8Opx49SMqclc3YoK6PSpvfqHOSwuXVtfFJQ/M0wWSZE//wd+zCF2zBAI4mATDskZkY+uJsyYjsY9CkY3MIAxc0Tc+KA4oB87fkYahNfw/6NB70ayQaoCoDjxJK4L1TnHD2de/shgpOSfltBjoVGsWQGAzOU5g2xPCXjay+Qtvw6lkrgWsXXPsxMocAOXEo3Aj3Utvo2ZR+CQpmm2no=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a6053-7668-4592-4616-08d6cfb936b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 11:19:31.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5859
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW4gaW5jb3JyZWN0IGFyZ3VtZW50IHRvIGxpc3RfZm9yX2VhY2ggaXMgYW4gaW50ZXJuYWwgZXJy
b3IgaW4gZ2RiDQpzY3JpcHRzIHNvIGEgVHlwZUVycm9yIHNob3VsZCBiZSByYWlzZWQuIFRoZSBn
ZGIuR2RiRXJyb3IgZXhjZXB0aW9uIHR5cGUNCmlzIGludGVuZGVkIGZvciB1c2VyIGVycm9ycyBz
dWNoIGFzIGluY29ycmVjdCBpbnZvY2F0aW9uLg0KDQpEcm9wIHRoZSB0eXBlIGFzc2VydGlvbiBp
biBsaXN0X2Zvcl9lYWNoX2VudHJ5IGJlY2F1c2UgbGlzdF9mb3JfZWFjaCBpc24ndA0KZ29pbmcg
dG8gc3VkZGVubHkgeWllbGQgc29tZXRoaW5nIGVsc2UuDQoNCkFwcGxpZXMgdG8gYm90aCBsaXN0
IGFuZCBobGlzdA0KDQpTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jl
c3RlekBueHAuY29tPg0KLS0tDQogc2NyaXB0cy9nZGIvbGludXgvbGlzdHMucHkgfCAxMCArKy0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL3NjcmlwdHMvZ2RiL2xpbnV4L2xpc3RzLnB5IGIvc2NyaXB0cy9nZGIv
bGludXgvbGlzdHMucHkNCmluZGV4IDU1MzU2YjY2ZjhlYS4uYzQ4N2RkZjA5ZDM4IDEwMDY0NA0K
LS0tIGEvc2NyaXB0cy9nZGIvbGludXgvbGlzdHMucHkNCisrKyBiL3NjcmlwdHMvZ2RiL2xpbnV4
L2xpc3RzLnB5DQpAQCAtMjIsNDUgKzIyLDM5IEBAIGhsaXN0X25vZGUgPSB1dGlscy5DYWNoZWRU
eXBlKCJzdHJ1Y3QgaGxpc3Rfbm9kZSIpDQogDQogZGVmIGxpc3RfZm9yX2VhY2goaGVhZCk6DQog
ICAgIGlmIGhlYWQudHlwZSA9PSBsaXN0X2hlYWQuZ2V0X3R5cGUoKS5wb2ludGVyKCk6DQogICAg
ICAgICBoZWFkID0gaGVhZC5kZXJlZmVyZW5jZSgpDQogICAgIGVsaWYgaGVhZC50eXBlICE9IGxp
c3RfaGVhZC5nZXRfdHlwZSgpOg0KLSAgICAgICAgcmFpc2UgZ2RiLkdkYkVycm9yKCJNdXN0IGJl
IHN0cnVjdCBsaXN0X2hlYWQgbm90IHt9Ig0KKyAgICAgICAgcmFpc2UgVHlwZUVycm9yKCJNdXN0
IGJlIHN0cnVjdCBsaXN0X2hlYWQgbm90IHt9Ig0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC5mb3JtYXQoaGVhZC50eXBlKSkNCiANCiAgICAgbm9kZSA9IGhlYWRbJ25leHQnXS5kZXJlZmVy
ZW5jZSgpDQogICAgIHdoaWxlIG5vZGUuYWRkcmVzcyAhPSBoZWFkLmFkZHJlc3M6DQogICAgICAg
ICB5aWVsZCBub2RlLmFkZHJlc3MNCiAgICAgICAgIG5vZGUgPSBub2RlWyduZXh0J10uZGVyZWZl
cmVuY2UoKQ0KIA0KIA0KIGRlZiBsaXN0X2Zvcl9lYWNoX2VudHJ5KGhlYWQsIGdkYnR5cGUsIG1l
bWJlcik6DQogICAgIGZvciBub2RlIGluIGxpc3RfZm9yX2VhY2goaGVhZCk6DQotICAgICAgICBp
ZiBub2RlLnR5cGUgIT0gbGlzdF9oZWFkLmdldF90eXBlKCkucG9pbnRlcigpOg0KLSAgICAgICAg
ICAgIHJhaXNlIFR5cGVFcnJvcigiVHlwZSB7fSBmb3VuZC4gRXhwZWN0ZWQgc3RydWN0IGxpc3Rf
aGVhZCAqLiINCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgLmZvcm1hdChub2RlLnR5cGUp
KQ0KICAgICAgICAgeWllbGQgdXRpbHMuY29udGFpbmVyX29mKG5vZGUsIGdkYnR5cGUsIG1lbWJl
cikNCiANCiANCiBkZWYgaGxpc3RfZm9yX2VhY2goaGVhZCk6DQogICAgIGlmIGhlYWQudHlwZSA9
PSBobGlzdF9oZWFkLmdldF90eXBlKCkucG9pbnRlcigpOg0KICAgICAgICAgaGVhZCA9IGhlYWQu
ZGVyZWZlcmVuY2UoKQ0KICAgICBlbGlmIGhlYWQudHlwZSAhPSBobGlzdF9oZWFkLmdldF90eXBl
KCk6DQotICAgICAgICByYWlzZSBnZGIuR2RiRXJyb3IoIk11c3QgYmUgc3RydWN0IGhsaXN0X2hl
YWQgbm90IHt9Ig0KKyAgICAgICAgcmFpc2UgVHlwZUVycm9yKCJNdXN0IGJlIHN0cnVjdCBobGlz
dF9oZWFkIG5vdCB7fSINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAuZm9ybWF0KGhlYWQu
dHlwZSkpDQogDQogICAgIG5vZGUgPSBoZWFkWydmaXJzdCddLmRlcmVmZXJlbmNlKCkNCiAgICAg
d2hpbGUgbm9kZS5hZGRyZXNzOg0KICAgICAgICAgeWllbGQgbm9kZS5hZGRyZXNzDQogICAgICAg
ICBub2RlID0gbm9kZVsnbmV4dCddLmRlcmVmZXJlbmNlKCkNCiANCiANCiBkZWYgaGxpc3RfZm9y
X2VhY2hfZW50cnkoaGVhZCwgZ2RidHlwZSwgbWVtYmVyKToNCiAgICAgZm9yIG5vZGUgaW4gaGxp
c3RfZm9yX2VhY2goaGVhZCk6DQotICAgICAgICBpZiBub2RlLnR5cGUgIT0gaGxpc3Rfbm9kZS5n
ZXRfdHlwZSgpLnBvaW50ZXIoKToNCi0gICAgICAgICAgICByYWlzZSBUeXBlRXJyb3IoIlR5cGUg
e30gZm91bmQuIEV4cGVjdGVkIHN0cnVjdCBobGlzdF9oZWFkICouIg0KLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAuZm9ybWF0KG5vZGUudHlwZSkpDQogICAgICAgICB5aWVsZCB1dGlscy5j
b250YWluZXJfb2Yobm9kZSwgZ2RidHlwZSwgbWVtYmVyKQ0KIA0KIA0KIGRlZiBsaXN0X2NoZWNr
KGhlYWQpOg0KICAgICBuYiA9IDANCi0tIA0KMi4xNy4xDQoNCg==
