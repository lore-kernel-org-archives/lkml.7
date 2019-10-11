Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E381C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E1B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="hKU+uKv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfJKKP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:15:57 -0400
Received: from mail-eopbgr700052.outbound.protection.outlook.com ([40.107.70.52]:48225
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbfJKKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDVxe8BONnbABDf51mBZBeV8Xgv2bupMpmqBFxmBl4BvG/9EEJ6m+LO/CbWZs8fzVBKloRRMr8RKB+m2VqTdYf4NDdCs68WwzPmEceTyPu+494oYkkWvyqXCnmgUdxpt9feWPHAyeR5P0T+p37N4xJFw+GOk2Xe8Ry5yqSTNTL3o3ZYcM5T7JyVFPZT/Uho6tqjLSwDY/beaotN9UIXw27tYvEQqxmhHXxex6QDAFq0ARfpFzl3k1JG6FSlFacN3166Q7xdi2zME+Zpw07Ti957GC8/PFL2mg35KwP2spcSVXBMDKpAtqxdtYUXpyYFiwBNK265rc3KjBDnKrw26wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kd/mIVz3W2eysgjAC1yhh8lBaIu8RNk4mm6ShVDmJA=;
 b=J+EUYbEJ3qKOjaL8Z0Srgc2Hn2X0MPjgiEn4L6DqVifIMihGJpYC42PanVaB7itxiLRn9bcQTKDNLWs0WR3Os34STmxRQClF5YRinaBWE459mT90acTUBW5iFWnWLf5LNxLatK8ft9iE5v1+l+mwgNrZc6V90iFoDJjhFaGV5PIYerLeMXjQnLz5LoYdA0yTc4ErLZbwA47OrEHwZXPaZ+ta0r61Ylr6gvtciSt4auYGgTtMOxRjmLrus28jft6Qzr8V1qhyznfPDYZoMnkMdaIyvtAamYgx/O4RyNFmoEV5yL4POdFLlJh2I1y8G3Fu7/tpj31/3lAFV+5DEghrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kd/mIVz3W2eysgjAC1yhh8lBaIu8RNk4mm6ShVDmJA=;
 b=hKU+uKv5eTUn9PPiJeNppm3dh6EqAM9awTI5lmlO1RQoTTPG7AUNSeNomd5CYtZfLbxaimasbbBZM0ZIvPPvFcXb+8DeIATIs2wrzNkVSAFS8egMZWlX9fugvf5zvIFQWyu8JBMwpJcGr5VbrhziQCF2lvaoGUjg3ZYX7deZ2wA=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4254.namprd11.prod.outlook.com (52.135.38.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 10:15:55 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 10:15:54 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: wfx: fix potential vulnerability to spectre
Thread-Topic: [PATCH] staging: wfx: fix potential vulnerability to spectre
Thread-Index: AQHVgBzd1G9uPB5+okyjo2amDVnWBw==
Date:   Fri, 11 Oct 2019 10:15:54 +0000
Message-ID: <20191011101551.30946-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 450f10f8-ad70-47ad-02f4-08d74e34007e
x-ms-traffictypediagnostic: MN2PR11MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4254B1A7140C7FC9BABC2A2293970@MN2PR11MB4254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(189003)(199004)(6506007)(2351001)(478600001)(26005)(36756003)(2501003)(8936002)(6486002)(102836004)(6116002)(3846002)(186003)(66946007)(71190400001)(91956017)(71200400001)(76116006)(256004)(64756008)(66476007)(66556008)(66446008)(25786009)(486006)(6916009)(2906002)(316002)(2616005)(476003)(54906003)(81156014)(6512007)(6436002)(5640700003)(4326008)(305945005)(5660300002)(14454004)(4744005)(1076003)(86362001)(66066001)(81166006)(1730700003)(8676002)(99286004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4254;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P44ybARlkGV7b9CN5bES/m9Kvkh869SbNkLTju8kroEG7iN6GJRFGeK3gL39dDDXaJxGMeqxayXhwKkkwr3XWKuBjA8K6Q9PTk29wumL8JHd1bBhOABJONt1i5YR523oLsY8AtwFXFnhc1MZQcTeXcfvttT0oXUoXaYxEVEKSH8a2vVN9pN2E22WW3uAL8weDaUTyjJwTXeayOdE6urdK12VAioVbrp2m42DlGkfv7XDhF31DKVs4iSDEaBYo1fW99cTEqfykA4MYdKdp2NSaEkCN3vy2t7Uyv2baEmtnG3SYoy0vFr19NgTgrjMPTdjHNgqUWodxxL7Kw5stmDzqtkE38fnH5rCC0/xZdFLWwMnD5boPFCM9rSYf6YYRpKgciIL/IDRKK0wxqFguwgyYNCPr8oEy011RKcyhdy/hE0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BE71E3776390C4FAA88BB3A0BECD4E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450f10f8-ad70-47ad-02f4-08d74e34007e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 10:15:54.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdXeYd9+F8t3BhtFuOfYjoptuVcrvFgcAJVgEl8uMEyGqhgNVHkHyExCC6eQN19kS+UQq0AVTR/kR10KhYVkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQph
cnJheV9pbmRleF9ub3NwZWMoKSBzaG91bGQgYmUgYXBwbGllZCBhZnRlciBhIGJvdW5kIGNoZWNr
Lg0KDQpGaXhlczogOWJjYTQ1ZjNkNjkyNGYxOWYyOWMwZDAxOWU5NjFhZjNmNDFiZGM5ZSAoInN0
YWdpbmc6IHdmeDogYWxsb3cgdG8gc2VuZCA4MDIuMTEgZnJhbWVzIikNClJlcG9ydGVkLWJ5OiBr
YnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NClJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVu
dGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQ
b3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+DQotLS0NCiBkcml2ZXJzL3N0YWdp
bmcvd2Z4L3dmeC5oIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oIGIvZHJpdmVycy9zdGFnaW5nL3dm
eC93ZnguaA0KaW5kZXggNDg5ODM2ODM3YjBhLi40YzBmMjgzNjAxNWMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5oDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvd2Z4L3dmeC5o
DQpAQCAtMTM4LDYgKzEzOCw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHdmeF92aWYgKndkZXZf
dG9fd3ZpZihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IHZpZl9pZCkNCiAJCWRldl9kYmcod2Rl
di0+ZGV2LCAicmVxdWVzdGluZyBub24tZXhpc3RlbnQgdmlmOiAlZFxuIiwgdmlmX2lkKTsNCiAJ
CXJldHVybiBOVUxMOw0KIAl9DQorCXZpZl9pZCA9IGFycmF5X2luZGV4X25vc3BlYyh2aWZfaWQs
IEFSUkFZX1NJWkUod2Rldi0+dmlmKSk7DQogCWlmICghd2Rldi0+dmlmW3ZpZl9pZF0pIHsNCiAJ
CWRldl9kYmcod2Rldi0+ZGV2LCAicmVxdWVzdGluZyBub24tYWxsb2NhdGVkIHZpZjogJWRcbiIs
IHZpZl9pZCk7DQogCQlyZXR1cm4gTlVMTDsNCi0tIA0KMi4yMC4xDQo=
