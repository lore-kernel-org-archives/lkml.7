Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA7E20578
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qSilSRE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfH0PnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:43:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:44544 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfH0PnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:43:21 -0400
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 11:43:21 EDT
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RFKocC028632;
        Tue, 27 Aug 2019 08:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=j7Q0No8D5W0sFNY28Ubi/+izvY/U8Szi3zsIxyKOsFE=;
 b=qSilSRE6U88nIKMEft80YF8Lvs+ZX+uFtX8ZY9dfadrnDznEYIDTnMjFLH2tZbyIBfBX
 taVZlODN9tZ75VlaiFPPEJNwQwfmfg5ft/phhtw7SOHXPijrnrCbWPmOlaw+NFIn8Uis
 a4E5BDA5Q9R+/2FJXe1WVRmt+hBGqZGY2wmL6uAgMn/4XsJBCruL6pWym/FpuZZx7KxA
 PZgR2vMGS64HgugNw3DHOYYuxJaJbyB5j2sUNOFeJ10jE9rPEh8C6OJCOQQkGolKYZhl
 0hiI0XcQjP/wJFcEV82pJ2yPUE/s3XNTwJrN0dtf1PAf2CnYseW/rsnof8fd8E8kCY9M KA== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2056.outbound.protection.outlook.com [104.47.40.56])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uk155nt8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 08:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAw+NaOecDRSwdvUim1odNZq1Oin1Vc/e/p2Gg6rL/O8+MS49fDOQIdp/FsQ7FZQ7+/ly2+h/WK/gJPH7QYyG3Lb0MRlgdRkpWgDIdeV8/UX4VTtb5tJfvj3Jjk/kbmXORom3R9jwQwQjBvcIjDCTW2o7ZWaMbN1CrCcC+Txkp7Y126dGEOCRm3OmS1vGll16hFiCsiBKRvBwq6E3LNY6HVjTrdVwtTVyoymRMxT+XyIWyxbCghHtlDRzhoSdHQCOtZa71am1zGi5Tbc+iUwKSn0MFHTqHe17IgbIdPcrkjxsWWaCKCIzUI7t+anBTpFfym6TDFlL2IYxmZ/KmyjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7Q0No8D5W0sFNY28Ubi/+izvY/U8Szi3zsIxyKOsFE=;
 b=AHgGhjE7bbUYHilYZ0qdUKbQSqv8rTcZCfXO+Jywf2tlIK9REQDEHCwqc8PeHzcKxNOPsBD0xkcn12aT5uC5pBVhDDPJFdvcR8VLjU7kbuJ/i2yrTznNy6ulDv2J5SCUdaTRnHYRzN3TkTI1vPDapwbyFi/HoOnvV99Xhu7+gOrauuBl5U7UBSw0lOPnn7L3KFDM1q7Fh26OakTsHo7Unea25I/ozxsIxucKTkm887LL8xshnfL+QJIFTlTm2pyRELBbGrG1BlpmkM8KF9wUP774I0pNha12FQKYFmfg70XMRGBRVsz16e8XsNDzUKHB7AiLT6vkfuQcROEzQNiYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB5620.namprd02.prod.outlook.com (20.177.241.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 15:20:57 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::c9b1:7869:4f3f:713f]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::c9b1:7869:4f3f:713f%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 15:20:57 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matej Genci <matej.genci@nutanix.com>
Subject: [PATCH] virtio: Change typecasts in vring_init()
Thread-Topic: [PATCH] virtio: Change typecasts in vring_init()
Thread-Index: AQHVXOsGnWphIXIpHkCP5ncx23ivmQ==
Date:   Tue, 27 Aug 2019 15:20:57 +0000
Message-ID: <20190827152000.53920-1-matej.genci@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To BL0PR02MB3634.namprd02.prod.outlook.com
 (2603:10b6:207:3e::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [192.146.154.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ab3b74e-beea-40b7-5dcf-08d72b0228b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB5620;
x-ms-traffictypediagnostic: BL0PR02MB5620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR02MB562039B67F7C90141424E721FBA00@BL0PR02MB5620.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:486;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(50226002)(2201001)(2501003)(53936002)(486006)(66066001)(4326008)(66946007)(86362001)(44832011)(256004)(2616005)(36756003)(25786009)(3846002)(6116002)(110136005)(71190400001)(71200400001)(66556008)(66446008)(64756008)(186003)(52116002)(107886003)(26005)(476003)(99286004)(6512007)(8676002)(6506007)(386003)(1076003)(7736002)(305945005)(81166006)(14454004)(478600001)(2906002)(5660300002)(6436002)(102836004)(66476007)(8936002)(6486002)(316002)(81156014)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB5620;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IFM+eBm7WN9Nv017xwru52TLJXQZmxWPOGqBVTymOFMsfxt0vAZooABXWqoRiShIXUBnuxBb1VLuLgyJh7qnXAdFX9WX+dEtmxh+7C8xpvnOPBKcA1q7KgjcSr55fQI8c460IlHwBzS4wV91bEN7AYirvXben2CuVOVFgryM+P4lKd5r/fyuYeHWVzet8pAYtkGn69nrAbwgu5YnUCvYvFCntXmojRsKT7yekfLP1jb3UVRskyOs/iCDBYHYcuyOmqITR5+K1fJrUw3EhHjQSHPOVEvJ2DXsy9V9j8ZWqhs9q+Ke+kbMDLDnD+8RmT/eehlPQpwUSQrZgzH+A2co7fNmu2RqK3PQz5v5BugmW0oApt50yGCKWy1AbSXFJZj/4zIks1UrgrJ2+P95sooF9K5KHnchhei4h4MYebMN4+E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab3b74e-beea-40b7-5dcf-08d72b0228b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 15:20:57.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3V+/UAIE6EIF9ZZ2UX6wlW6CU4dxazsLFEW9TaasgzYttL/zPBiA6ocvPaYqazpKGFz32g37XoM9vjhwvCU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5620
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_03:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29tcGlsZXJzIHN1Y2ggYXMgZysrIDcuMyBjb21wbGFpbiBhYm91dCBhc3NpZ25pbmcgdm9pZCog
dmFyaWFibGUgdG8NCmEgbm9uLXZvaWQqIHZhcmlhYmxlIChsaWtlIHN0cnVjdCBwb2ludGVycykg
YW5kIHBvaW50ZXIgYXJpdGhtZXRpY3MNCm9uIHZvaWQqLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYXRl
aiBHZW5jaSA8bWF0ZWouZ2VuY2lAbnV0YW5peC5jb20+DQotLS0NCiBpbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3JpbmcuaCB8IDkgKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcmluZy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgNCmluZGV4
IDRjNGUyNGMyOTFhNS4uMmMzMzliOWUyOTIzIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19yaW5nLmgNCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmluZy5o
DQpAQCAtMTY4LDEwICsxNjgsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIHZyaW5nX2luaXQoc3Ry
dWN0IHZyaW5nICp2ciwgdW5zaWduZWQgaW50IG51bSwgdm9pZCAqcCwNCiAJCQkgICAgICB1bnNp
Z25lZCBsb25nIGFsaWduKQ0KIHsNCiAJdnItPm51bSA9IG51bTsNCi0JdnItPmRlc2MgPSBwOw0K
LQl2ci0+YXZhaWwgPSBwICsgbnVtKnNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyk7DQotCXZyLT51
c2VkID0gKHZvaWQgKikoKCh1aW50cHRyX3QpJnZyLT5hdmFpbC0+cmluZ1tudW1dICsgc2l6ZW9m
KF9fdmlydGlvMTYpDQotCQkrIGFsaWduLTEpICYgfihhbGlnbiAtIDEpKTsNCisJdnItPmRlc2Mg
PSAoc3RydWN0IHZyaW5nX2Rlc2MgKilwOw0KKwl2ci0+YXZhaWwgPSAoc3RydWN0IHZyaW5nX2F2
YWlsICopKCh1aW50cHRyX3QpcA0KKwkJKyBudW0qc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKSk7
DQorCXZyLT51c2VkID0gKHN0cnVjdCB2cmluZ191c2VkICopKCgodWludHB0cl90KSZ2ci0+YXZh
aWwtPnJpbmdbbnVtXQ0KKwkJKyBzaXplb2YoX192aXJ0aW8xNikgKyBhbGlnbi0xKSAmIH4oYWxp
Z24gLSAxKSk7DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgdnJpbmdfc2l6ZSh1bnNp
Z25lZCBpbnQgbnVtLCB1bnNpZ25lZCBsb25nIGFsaWduKQ0KLS0gDQoyLjIyLjANCg0K
