Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03686C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B9121D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="b7UM0S4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfJKMOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:14:21 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:59989
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbfJKMOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH5dT6pqgeW5oKRbICzgoIBVpfWWNMoJgIM8Yywe+BsgoV28FgHcVi04ZdXSQFESweO5Ag8LLO9pv2h3cW8AMYhY+I6vDH0fPnGTLhvZJbPo0HZZpRnM9WlrX6m8ClqaOcJYVfX5wgyc869qTdqt94jDPaU3EOnYv1XllGlk+t9pSoCGQ1kCw2iNmYQBztLr1JhG50QqkGrK1C8+PqQdj4jrLwUk9M71knzOxBJ4xZ8AeW21mpBauMDxTX8DAk+Nd+j/8NtLdPXRpa3EaJYk37bW+3B6YWOJsneqxCObOqtxg+K9J7qgEVuBXSba0OrKVK3gg6lercgm+uWiQEDkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hsFAWCXEPTbBXNtEVihJWw7q45V70Vh4pUybGUqMto=;
 b=PoBrRY9jaZ6bluGnn1ex+u3K6sMPGKmumOCTUXbD0MHGvposozOtzNiugedMq4A14Ua4x1TtK2iBZadLnd7kq46w53e5hov8LezjcKTJT+EHsu9vbDzX/O/581ghsiMWb9TWt8yet+VyiZfaPpKcC+AcaQS+dEoyT6exL/f4fhMjGScqRkiDWn3H5Vqjug372Xx6nwk+/RgMZ/rfs8IgYdCeU9PZk3AjxmGAkVrQ/zWWw3xEY8rjXNCHhN55t/7W6j5ud/Pl+bwTMoCG8b867DgY6oiqFYQAzeAYibowPQ/sYr54asWkhdwBWKraCLls0B1f3VCRz80OWETAJPb5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hsFAWCXEPTbBXNtEVihJWw7q45V70Vh4pUybGUqMto=;
 b=b7UM0S4h/OPi+5izBKfp559JgEvTZ4TOlVcP4ni5bDSyJdvv/7l5EPsIxE8WxZZKLy2hSjgeZBOoq4pKqxjdENopBOcxTd82bMg8q6pRrRVyuYGzkyaLL+fYJsgWpsUtvYvmYsJUrhLzoLN9Hvo/Wjh1GI0h8/C2+v9TNpUVvOc=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3645.namprd11.prod.outlook.com (20.178.254.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 11 Oct 2019 12:14:17 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 12:14:17 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: wfx: fix potential vulnerability to spectre
Thread-Topic: [PATCH v2] staging: wfx: fix potential vulnerability to spectre
Thread-Index: AQHVgC1n2gVmWWSn1Eqm8kerAEDUqg==
Date:   Fri, 11 Oct 2019 12:14:17 +0000
Message-ID: <20191011121415.7607-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aec35ace-e261-459d-b79b-08d74e448a00
x-ms-traffictypediagnostic: MN2PR11MB3645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB36451A7B39D84301B581F77793970@MN2PR11MB3645.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:108;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(396003)(376002)(346002)(189003)(199004)(2501003)(14454004)(99286004)(5640700003)(6486002)(25786009)(186003)(6506007)(26005)(476003)(5660300002)(102836004)(478600001)(486006)(316002)(6916009)(305945005)(7736002)(54906003)(256004)(66066001)(6116002)(2351001)(8676002)(3846002)(36756003)(1076003)(1730700003)(71190400001)(71200400001)(8936002)(2906002)(4744005)(86362001)(4326008)(2616005)(6436002)(66946007)(66476007)(66556008)(66446008)(64756008)(81166006)(81156014)(76116006)(91956017)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3645;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYm2W1nu8K/heqB9cBYExm3USJShK0q/HQHMQf9UsjaDTpf5rcAjPzGVQwp6EHRwmtJ4cJNq5p5c74G+L6DjV3jIwlkOgkT+tPxvd+tYPtr3gkTWEC0FH+xPsjxAId/sF14zFSK4GMknAcuOAQP4ZA4Wx+Jf/IY9noFe2iII6DLflQEOjpxEDE4n5m/LjuY+6VSjETZO9tijDQCoVoaYdo3sxO2zkNJ01NLBN9M+5Wkul4PYHkKVBVzmvpMb+REwqmVUcqbLK+LDczMDy6uN1uGdOn1cOIr7WD9cUXBMxARBi7LapT4AM6gRE/J2YO/5hpqOP2ylc3AQFPcVrd23nH0d36oTt1fo+0da52tuchg1+n9C0uasnk6AO3SXzSvvaB8LhyeD0HqpMMyrd+78vNJo7PFgh2L2N8vN0VCW7Js=
Content-Type: text/plain; charset="utf-8"
Content-ID: <405F61B0BE9C8347B058C226DC640832@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec35ace-e261-459d-b79b-08d74e448a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 12:14:17.5690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aHjoXyCcOl9PHEwxtv+CRylhj5mCeA0+ByNI9PIeeI5SOIH1KlkPjcojOyVawxPyOQYC4V6D4dl62qM2Bt38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQph
cnJheV9pbmRleF9ub3NwZWMoKSBzaG91bGQgYmUgYXBwbGllZCBhZnRlciBhIGJvdW5kIGNoZWNr
Lg0KDQpGaXhlczogOWJjYTQ1ZjNkNjkyICgic3RhZ2luZzogd2Z4OiBhbGxvdyB0byBzZW5kIDgw
Mi4xMSBmcmFtZXMiKQ0KUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPg0KUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNv
bT4NClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJAc2ls
YWJzLmNvbT4NCi0tLQ0KdjI6IGN1dCBkb3duIGNvbW1pdC1pZCB0byAxMiBjaGFyYWN0ZXJzDQoN
CiBkcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oIGIvZHJp
dmVycy9zdGFnaW5nL3dmeC93ZnguaA0KaW5kZXggNDg5ODM2ODM3YjBhLi40YzBmMjgzNjAxNWMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oDQorKysgYi9kcml2ZXJzL3N0
YWdpbmcvd2Z4L3dmeC5oDQpAQCAtMTM4LDYgKzEzOCw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0
IHdmeF92aWYgKndkZXZfdG9fd3ZpZihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IHZpZl9pZCkN
CiAJCWRldl9kYmcod2Rldi0+ZGV2LCAicmVxdWVzdGluZyBub24tZXhpc3RlbnQgdmlmOiAlZFxu
IiwgdmlmX2lkKTsNCiAJCXJldHVybiBOVUxMOw0KIAl9DQorCXZpZl9pZCA9IGFycmF5X2luZGV4
X25vc3BlYyh2aWZfaWQsIEFSUkFZX1NJWkUod2Rldi0+dmlmKSk7DQogCWlmICghd2Rldi0+dmlm
W3ZpZl9pZF0pIHsNCiAJCWRldl9kYmcod2Rldi0+ZGV2LCAicmVxdWVzdGluZyBub24tYWxsb2Nh
dGVkIHZpZjogJWRcbiIsIHZpZl9pZCk7DQogCQlyZXR1cm4gTlVMTDsNCi0tIA0KMi4yMC4xDQo=
