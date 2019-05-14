Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CFFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B592147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="OSyyyXqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfENNAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:00:51 -0400
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:7552
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbfENNAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8VStLgA89ouOHIIEim0imZKPXUc63UfwSv4OqaC0oA=;
 b=OSyyyXqEovQAK6aURVSkae1trTte8Ho4GLcc94f0DVplGG/1sf8bnemEBEuu3uUBL7blsD+TpKpI4msb9k1E8HSjgg/fnSwYhq160tK0MiWB6vtit6m6rvgx/K0a8lWADW7yWI9XXyqURvYFGD3PnYo87crhlsu9UY//BhqhIhc=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB4349.eurprd08.prod.outlook.com (20.179.27.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 14 May 2019 13:00:45 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf%3]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 13:00:45 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: aic7xxx: Remove NULL check before kfree()
Thread-Topic: [PATCH] scsi: aic7xxx: Remove NULL check before kfree()
Thread-Index: AQHVClUKYE83rLAf7k+RpVZjvlURaQ==
Date:   Tue, 14 May 2019 13:00:44 +0000
Message-ID: <20190514130036.7629-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR06CA0033.eurprd06.prod.outlook.com
 (2603:10a6:206:2::46) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f5ffe2-dbe2-417e-aa5e-08d6d86c2d18
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB4349;
x-ms-traffictypediagnostic: VI1PR08MB4349:
x-microsoft-antispam-prvs: <VI1PR08MB43494E18368657EABCF798D9B3080@VI1PR08MB4349.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(136003)(376002)(346002)(366004)(199004)(189003)(386003)(6506007)(102836004)(305945005)(5640700003)(6436002)(66946007)(26005)(316002)(7736002)(6512007)(66446008)(64756008)(66556008)(3846002)(66476007)(73956011)(2906002)(6486002)(52116002)(476003)(2616005)(2351001)(6916009)(25786009)(4326008)(53936002)(186003)(6116002)(486006)(44832011)(86362001)(71190400001)(71200400001)(74482002)(50226002)(256004)(14444005)(66066001)(2501003)(1076003)(5660300002)(68736007)(8676002)(99286004)(14454004)(36756003)(8936002)(508600001)(81156014)(81166006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4349;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 41xKvH6KafAl+f7CqrPuTBb9oSK7NidnUunvOm5iiVK4opyV5EWTObqi/q/hJ29n0+IW1NhKMdBaMS7wYYZsk9M6dI3Ws+Wfjic6uROwYh7ZHNooBAwSlKzKyca8d64cQ79+36O1YkslF7bDIB3cY1z/85vQOdhW5g8CVD96ywHfYw09Y6fAaeGQ5CcobDCy9qg1G4NVzBRvmznpui//WwUPq8iaEWNi/hmlbkrM7ZcsflmjQoeyAcsNnXWbOCWnjBoFQA+Ypz0EAOHQB9Y7PvNM3cxUJErGoWlmZ6m7xFcoQ45km+GaJl6gbcUWpTDwbQVLRUJ04MuxhoYs/OPM/DUTsdkA4VzGriEGPxdo+w4h2Fd+YCD0xkshNsLr9SuI2AMhs4EkSx4OfhbPeWzQazcvtW2Pc6QuorJnB1n84uc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f5ffe2-dbe2-417e-aa5e-08d6d86c2d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 13:00:44.8865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2luZWxsZSB3YXJuaW5nIGJ5IHJlbW92aW5nIE5VTEwgY2hl
Y2sgYmVmb3JlDQpjYWxsaW5nIGtmcmVlKCk6DQoNCk5VTEwgY2hlY2sgYmVmb3JlIHNvbWUgZnJl
ZWluZyBmdW5jdGlvbnMgaW4gbm90IG5lZWRlZC4NCg0KU2lnbmVkLW9mZi1ieTogUXVlbnRpbiBE
ZXNsYW5kZXMgPHF1ZW50aW4uZGVzbGFuZGVzQGl0ZGV2LmNvLnVrPg0KLS0tDQogZHJpdmVycy9z
Y3NpL2FpYzd4eHgvYWljN3h4eF9jb3JlLmMgfCAxNiArKysrKy0tLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3Njc2kvYWljN3h4eC9haWM3eHh4X2NvcmUuYyBiL2RyaXZlcnMvc2NzaS9haWM3
eHh4L2FpYzd4eHhfY29yZS5jDQppbmRleCAzOTkzZjE1ZTdmZjYuLmZhZTQ0MjRkNDQ0MiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L2FpYzd4eHhfY29yZS5jDQorKysgYi9kcml2
ZXJzL3Njc2kvYWljN3h4eC9haWM3eHh4X2NvcmUuYw0KQEAgLTIxOTIsOSArMjE5Miw3IEBAIGFo
Y19mcmVlX3RzdGF0ZShzdHJ1Y3QgYWhjX3NvZnRjICphaGMsIHVfaW50IHNjc2lfaWQsIGNoYXIg
Y2hhbm5lbCwgaW50IGZvcmNlKQ0KIA0KIAlpZiAoY2hhbm5lbCA9PSAnQicpDQogCQlzY3NpX2lk
ICs9IDg7DQotCXRzdGF0ZSA9IGFoYy0+ZW5hYmxlZF90YXJnZXRzW3Njc2lfaWRdOw0KLQlpZiAo
dHN0YXRlICE9IE5VTEwpDQotCQlrZnJlZSh0c3RhdGUpOw0KKwlrZnJlZShhaGMtPmVuYWJsZWRf
dGFyZ2V0c1tzY3NpX2lkXSk7DQogCWFoYy0+ZW5hYmxlZF90YXJnZXRzW3Njc2lfaWRdID0gTlVM
TDsNCiB9DQogI2VuZGlmDQpAQCAtNDQ3NCw4ICs0NDcyLDcgQEAgYWhjX3NldF91bml0KHN0cnVj
dCBhaGNfc29mdGMgKmFoYywgaW50IHVuaXQpDQogdm9pZA0KIGFoY19zZXRfbmFtZShzdHJ1Y3Qg
YWhjX3NvZnRjICphaGMsIGNoYXIgKm5hbWUpDQogew0KLQlpZiAoYWhjLT5uYW1lICE9IE5VTEwp
DQotCQlrZnJlZShhaGMtPm5hbWUpOw0KKwlrZnJlZShhaGMtPm5hbWUpOw0KIAlhaGMtPm5hbWUg
PSBuYW1lOw0KIH0NCiANCkBAIC00NTM2LDEwICs0NTMzLDggQEAgYWhjX2ZyZWUoc3RydWN0IGFo
Y19zb2Z0YyAqYWhjKQ0KIAkJa2ZyZWUoYWhjLT5ibGFja19ob2xlKTsNCiAJfQ0KICNlbmRpZg0K
LQlpZiAoYWhjLT5uYW1lICE9IE5VTEwpDQotCQlrZnJlZShhaGMtPm5hbWUpOw0KLQlpZiAoYWhj
LT5zZWVwX2NvbmZpZyAhPSBOVUxMKQ0KLQkJa2ZyZWUoYWhjLT5zZWVwX2NvbmZpZyk7DQorCWtm
cmVlKGFoYy0+bmFtZSk7DQorCWtmcmVlKGFoYy0+c2VlcF9jb25maWcpOw0KICNpZm5kZWYgX19G
cmVlQlNEX18NCiAJa2ZyZWUoYWhjKTsNCiAjZW5kaWYNCkBAIC00OTQ0LDggKzQ5MzksNyBAQCBh
aGNfZmluaV9zY2JkYXRhKHN0cnVjdCBhaGNfc29mdGMgKmFoYykNCiAJY2FzZSAwOg0KIAkJYnJl
YWs7DQogCX0NCi0JaWYgKHNjYl9kYXRhLT5zY2JhcnJheSAhPSBOVUxMKQ0KLQkJa2ZyZWUoc2Ni
X2RhdGEtPnNjYmFycmF5KTsNCisJa2ZyZWUoc2NiX2RhdGEtPnNjYmFycmF5KTsNCiB9DQogDQog
c3RhdGljIHZvaWQNCi0tIA0KMi4xNy4xDQoNCg==
