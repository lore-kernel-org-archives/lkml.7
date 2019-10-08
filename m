Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A798C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3696421721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="iVGa9kJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfJHJmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:42:52 -0400
Received: from mail-eopbgr750041.outbound.protection.outlook.com ([40.107.75.41]:58942
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729375AbfJHJmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKF+Wu92kHoSXZ50t7xBFQxZEDkWFdmbgUfwDhJmaRTaGH3fPntolN6eKHDTLeRY4hCsutIEKtAirV7tWr1MYb79/8HBj5xBkh0DgI3y4qKcd1SDZib0bJO14h/rtnTk76O1Rf+6Y6ZgPeSHlRDkRZDWGB+3Wr2NLzXljEzgCdrLt79ZnxT274zvZ8WyoWg94nIBiBAiCnGGbYN8JZkADQksa05QhKcNDcQJOn1pS2SI61qgdxkQKoQeuxLJLbYVNEfy3fEw0f1V0k8G6oGqkWRl6Ukyz87Gbx2RVgLBfsYKQSjB6gBtQVPN6CmsBcITcy8FxxPKJuFR4omAZeSBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQh//04/KkYBgMmQJlnWgPoDRlqzOyaMtXKm8YZaRok=;
 b=R9mqogJEI+QKNaZFOoCMDFN8lB08tzoPxCgz6RJU4ilZm1bVF8i6T/BR+5Eae4f83ESkqYlpVTPiRhVqClpxgbFONnH3yu356MjjGAW4ZZmFLkW17HqKiqTJcY966hIVQO6X6QAXK7Lf32U57393+YAA8cgpV910QUsIo3bL7kt0aYlffyeKTL2qqG7qr8YeX1EmKlI+PT4Ui4SXPPXtnQ1+RNhfjK0rQ1F3YAMhoWoPtN9AsdzfdbWnnBT6c/VSno8DELGKxfsWDc+5nXOlzJvNI7EK0z+jSBw3Ilc7ZxhUC4LH0k/LUzR7VpftvESR8yIN1agQnz5pf4p5P/ZItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQh//04/KkYBgMmQJlnWgPoDRlqzOyaMtXKm8YZaRok=;
 b=iVGa9kJ60xHW5hWFyyC+qmrnbV6jcyQZ/+Xm67KH+1M+1xPrxkVKsj2byjskgjtH+mLTXPV6vUc3LrGM5kom2wBpaiDQ808ENvpJYHBp1RIAyQR3cyQDwt0xBK+TzbStXwtrBQ8acrZDIQrA/X26pQyYeO9Wmlyzn1vCOtYyTRw=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4333.namprd11.prod.outlook.com (10.255.90.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 09:42:47 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 09:42:47 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>
Subject: [PATCH 0/7] Fix various compilation issues with wfx driver
Thread-Topic: [PATCH 0/7] Fix various compilation issues with wfx driver
Thread-Index: AQHVfby9LEc5HCPngkKgSgv6JOlnAQ==
Date:   Tue, 8 Oct 2019 09:42:47 +0000
Message-ID: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d304cbb3-1af8-4d73-a540-08d74bd3e0ba
x-ms-traffictypediagnostic: MN2PR11MB4333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB433329FCDB9BD225BCEAC463939A0@MN2PR11MB4333.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39850400004)(199004)(189003)(54906003)(66574012)(1076003)(6436002)(6512007)(5640700003)(25786009)(305945005)(66066001)(4744005)(316002)(7736002)(99286004)(2351001)(6506007)(8936002)(86362001)(2501003)(71200400001)(71190400001)(102836004)(6486002)(14454004)(8676002)(6916009)(81166006)(81156014)(478600001)(1730700003)(4326008)(76116006)(26005)(14444005)(64756008)(66556008)(476003)(256004)(66476007)(66446008)(186003)(107886003)(3846002)(66946007)(2616005)(6116002)(486006)(2906002)(36756003)(91956017)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4333;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AepbYwdLIUekzUC0f8Lef+YAPJX0hMzuk/fuah3LLlcZdKduouWGLRxOybtvz0sLz2VfUi/NiGWKGcPabPq3PxI2DbJjQlzgmg5gszw04TPLCrB76MlblrSCnKaFvU5Cy7V7np9imWb1nmyniHyPbLSzye8h0g5Cyt532fR+S0K4G13/tbfmsQ5PtoDjGEskzDh60sX7git2R+kneL5Z24GG110YsbjjrAlk16U6oqKK8xyFEg4ZjKwSitr13jv5POFJ6T166Q62hhjWxZGQeBNhlsRQTHYkhOfMkDhSE3GSzO1OWv5DKsuWpSKAQ15TBBw47ZonKB9BnaaErYv+NGQdzXNddGF9nQdB7RPI1A5Go60sqoYv6QLVMhrZOnC+tlOTkY9pivz4L7BtdU3/uaNT9FCgJ0bxCQ32bINsG10=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA2A2F350E400445B7FE59D293663CA1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d304cbb3-1af8-4d73-a540-08d74bd3e0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 09:42:47.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Vqt/vznhCAEV7UmWfPxc6PqFE/Y5tNeiEAMVobup8cuuQVnw/lOrqJneqcnG1UjxYp8K2atCPxV8Q+pEE3VAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpN
b3N0IG9mIHByb2JsZW1zIGFyZSByZWxhdGVkIHRvIGJpZy1lbmRpYW4gYXJjaGl0ZWN0dXJlcy4N
Cg0KSsOpcsO0bWUgUG91aWxsZXIgKDcpOg0KICBzdGFnaW5nOiB3Zng6IHNpbXBsaWZ5IG1lbW9y
eSBhbGxvY2F0aW9uIGluIHdmeF91cGRhdGVfZmlsdGVyaW5nKCkNCiAgc3RhZ2luZzogd2Z4OiBy
ZW1vdmUgbWlzdXNlZCBjYWxsIHRvIGNwdV90b19sZTE2KCkNCiAgc3RhZ2luZzogd2Z4OiBsZTE2
X3RvX2NwdXMoKSB0YWtlcyBhIHJlZmVyZW5jZSBhcyBwYXJhbWV0ZXINCiAgc3RhZ2luZzogd2Z4
OiBjb3JyZWN0bHkgY2FzdCBkYXRhIG9uIGJpZy1lbmRpYW4gdGFyZ2V0cw0KICBzdGFnaW5nOiB3
Zng6IGZpeCBjb3B5X3t0byxmcm9tfV91c2VyKCkgdXNhZ2UNCiAgc3RhZ2luZzogd2Z4OiBkcm9w
IGNhbGxzIHRvIEJVR19PTigpDQogIHN0YWdpbmc6IHdmeDogYXZvaWQgbmFtZXNwYWNlIGNvbnRh
bWluYXRpb24NCg0KIGRyaXZlcnMvc3RhZ2luZy93ZngvYmguYyAgICAgICAgIHwgIDggKysrLS0t
LQ0KIGRyaXZlcnMvc3RhZ2luZy93ZngvYnVzX3NkaW8uYyAgIHwgIDQgKystLQ0KIGRyaXZlcnMv
c3RhZ2luZy93ZngvZGF0YV90eC5jICAgIHwgNDAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0NCiBkcml2ZXJzL3N0YWdpbmcvd2Z4L2RhdGFfdHguaCAgICB8ICAyICstDQogZHJpdmVy
cy9zdGFnaW5nL3dmeC9kZWJ1Zy5jICAgICAgfCAgNSArKy0tDQogZHJpdmVycy9zdGFnaW5nL3dm
eC9oaWZfdHhfbWliLmggfCAyMyArKysrKysrKysrKystLS0tLS0NCiBkcml2ZXJzL3N0YWdpbmcv
d2Z4L2tleS5jICAgICAgICB8IDMyICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBkcml2ZXJz
L3N0YWdpbmcvd2Z4L3F1ZXVlLmMgICAgICB8ICA2ICsrLS0tDQogZHJpdmVycy9zdGFnaW5nL3dm
eC9zY2FuLmMgICAgICAgfCAgMiArLQ0KIGRyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmMgICAgICAg
IHwgMjEgKysrKysrKy0tLS0tLS0tLS0NCiAxMCBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25z
KCspLCA2OSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIwLjENCg==
