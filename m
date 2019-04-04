Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDEBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6F3206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JIV13VVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfDDNQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:16:30 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:8771
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbfDDNQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHjejYiceE8RzVpb/RFeExgBmpcCfw79KkIchQNxDZs=;
 b=JIV13VVzR//bbtE7aSfKZzcbGmadATzKwMz6SAmF4/ukEt34EsdbSN+nr99X1foogIhomscPPQy5kQ5+f86dYRyUqFJ/XNATPHo0rUNoiMRcoDw5P2vXEvWVZPWHMTx1m9yy2FnDIU8/1px+ahE5m+w6oONN8a5VoMT2SZ+pKT8=
Received: from BN6PR12MB1649.namprd12.prod.outlook.com (10.172.18.146) by
 BN6PR12MB1907.namprd12.prod.outlook.com (10.175.101.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 13:16:27 +0000
Received: from BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d420:fe90:981a:aa0d]) by BN6PR12MB1649.namprd12.prod.outlook.com
 ([fe80::d420:fe90:981a:aa0d%9]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 13:16:27 +0000
From:   "Singh, Sandeep" <Sandeep.Singh@amd.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH] pinctrl: Added IRQF_SHARED flag for amd-pinctrl driver
Thread-Topic: [PATCH] pinctrl: Added IRQF_SHARED flag for amd-pinctrl driver
Thread-Index: AQHU6uib/lf8xdJg9U+7MBo6lkycdg==
Date:   Thu, 4 Apr 2019 13:16:26 +0000
Message-ID: <1554383739-16050-1-git-send-email-Sandeep.Singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To BN6PR12MB1649.namprd12.prod.outlook.com
 (2603:10b6:405:5::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc52c21d-de9f-4344-f59d-08d6b8ffbe03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR12MB1907;
x-ms-traffictypediagnostic: BN6PR12MB1907:
x-microsoft-antispam-prvs: <BN6PR12MB1907A1BF21D8D9B74EC3200BE0500@BN6PR12MB1907.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(36756003)(4744005)(81156014)(53936002)(486006)(14444005)(3846002)(110136005)(386003)(256004)(106356001)(6506007)(102836004)(4326008)(86362001)(2616005)(14454004)(105586002)(25786009)(316002)(478600001)(72206003)(26005)(6116002)(52116002)(2201001)(97736004)(6486002)(6436002)(54906003)(6512007)(99286004)(476003)(5660300002)(81166006)(186003)(7736002)(2501003)(8936002)(71190400001)(305945005)(66066001)(50226002)(8676002)(71200400001)(68736007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1907;H:BN6PR12MB1649.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DcXKS5DMHmWTfvNSOHsS+V21aZQsRKQe4Rfsdfno5n4LJQQTfCePa58B34AH+nZsLotObGyYjEkFSCusuS7oyIb4iocxsX6xeSzA5zWlvmKC6BbU7bzUa2YZLScCKaGYb1RRqocQyRA+WgQI4mx/RSC7IDH6vs5CGqV64bdf9MT68QgutGM79Bkfh847cDdQiXq7JXbGB+L0Mfpyly0gNxDvGYrkUuAyrXxZKkYt9ywf20YhRIZBSSQyl1aOW6bfmx3xXb6O93AdkW6hifbHONDYX+Ee3Wu0jwnKKoe69EUi4kDy5dzaJNg+NUyPfi6cjwmj8VmPKbLD4Avt0jsuwnxTlrs6tf8lHa+YxwLgeUyqRNz2NqHv1ktcEu9lWYsUYd8LomApr+XI7LYkvHbwFSjfGSOjJoXab6ky+LjUf9g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52c21d-de9f-4344-f59d-08d6b8ffbe03
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 13:16:26.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2FuZGVlcCBTaW5naCA8c2FuZGVlcC5zaW5naEBhbWQuY29tPg0KDQpTb21lIG9mIHRo
ZSBBTUQgcmVmZXJlbmNlIGJvYXJkcyB1c2VkIHNpbmdsZSBHUElPIGxpbmUgZm9yDQptdWx0aXBs
ZSBkZXZpY2VzLiBTbyBhZGRlZCBJUlFGX1NIQVJFRCBmbGFnIGluIGFtZCBwaW5jdHJsIGRyaXZl
ci4NCg0KDQpTaWduZWQtb2ZmLWJ5OiBTYW5kZWVwIFNpbmdoIDxTYW5kZWVwLlNpbmdoQGFtZC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBTaHlhbSBTdW5kYXIgUyBLIDxTaHlhbS1zdW5kYXIuUy1rQGFt
ZC5jb20+DQpjYzogTmVoYWwgU2hhaCA8TmVoYWwtYmFrdWxjaGFuZHJhLlNoYWhAYW1kLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvcGluY3RybC9waW5jdHJsLWFtZC5jIHwgNCArKy0tDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGluY3RybC9waW5jdHJsLWFtZC5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYW1k
LmMNCmluZGV4IDJhN2Q2MzguLmQ4MzRjMWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BpbmN0cmwv
cGluY3RybC1hbWQuYw0KKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYW1kLmMNCkBAIC05
MzAsOCArOTMwLDggQEAgc3RhdGljIGludCBhbWRfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KIAkJZ290byBvdXQyOw0KIAl9DQogDQotCXJldCA9IGRldm1fcmVxdWVz
dF9pcnEoJnBkZXYtPmRldiwgaXJxX2Jhc2UsIGFtZF9ncGlvX2lycV9oYW5kbGVyLCAwLA0KLQkJ
CSAgICAgICBLQlVJTERfTU9ETkFNRSwgZ3Bpb19kZXYpOw0KKwlyZXQgPSBkZXZtX3JlcXVlc3Rf
aXJxKCZwZGV2LT5kZXYsIGlycV9iYXNlLCBhbWRfZ3Bpb19pcnFfaGFuZGxlciwNCisJCQkgICAg
ICAgSVJRRl9TSEFSRUQsIEtCVUlMRF9NT0ROQU1FLCBncGlvX2Rldik7DQogCWlmIChyZXQpDQog
CQlnb3RvIG91dDI7DQogDQotLSANCjIuNy40DQoNCg==
