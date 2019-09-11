Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1FC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C5B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ttr6WyXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfIKMuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:50:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:59726 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbfIKMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:49:59 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BCdqXt023202;
        Wed, 11 Sep 2019 05:49:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=PEkV2NhP8+ON1lL/IeTgq9uHu9jHG2myqWEb/auvoEQ=;
 b=ttr6WyXX9wluS84HzWk1p54skXlcurW8l7cAbr9SPpTBA/twBWb1QVHuH7olOVSnjYYJ
 Ct8mctJ19fTWk4AtG0r69N+SyvadPFdmgUUaffxv78+urLN9VGxQRut7+oraUr5E9kIT
 vu/K3QMp3VMXLQ0Dmf19pWLjOG543Wd4cs8GO4NonkXGRMkV6Q++UEt2RZHd2c51g5Mw
 PP0/rw4Q2F5J0qCXr7FfHdko7FBA4UFg1UulKV1YT6aLdLhYLHlBUbTwPQepcO9B3Xhh
 +4tRyROWkhxJvHJphR2M4TzfIiY9DotVQVjPhB4A6mkeS0uHSHXbgRPWJzaWvhvKm8YK 3g== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uva3889wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 05:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNmJdGqdXpwjamSN4hu/8+jXg2GE5jYOASgUGAWKxVttUgUE6PK8tKgFLLJ+nNpB7HpcY/43gk4bIxx0h5/5iF22eIK464icsuYmxpdZkRpGP0mpJ2rjVvi503/KuGWfSKDDf3lkB3t10B5AhJnXXU2912GaIBkThCZ2Kl15QakXw1kh6xaWixNCNLN6qLoBsAILq42T96ZbeGoPCcuwW5ZGlzrXTGm9xINHk6NAQikLZ4HP68jHOAn/gGY/9LsLs50rnmNitQ31SVHnyLfPukm43GLtt4O27arRIJdXKJ6a0n1/mafxtmZjXYzQc4BlXnVneykN1fKAgrRS/beypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEkV2NhP8+ON1lL/IeTgq9uHu9jHG2myqWEb/auvoEQ=;
 b=kROOt+IjSonmNmS0T/TxwVzKCgHK468cZgwpSk/XZGTbgHGRlmRUIO0jlBCOln13yiMRq68KhkLii6bAqpBlp1BurZkW1oM2l2IqqMl90pPyEQbVuzp8Mabl1XE2htW2T6PGWTqKzcjUxv/o5kAZVqeBfdaqSmDtaGHqNpa1A9Fq3h6CH7bjqsVaZfz9X4tYbZQ1cpWeaOStnr94FQoE5bit9vop1ahZwyyy/Mt5wnVwJ45MJmqWdG/0pJWnONFoFT+/LXwgWOg5PqCTZygBaAqDB5jdI2oTtxE6ZZj6eWoUCmITDUdHDqAwDPIvxgTR5yfZP4Ee0sbuYnEx+fv8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Wed, 11 Sep 2019 12:49:53 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55%7]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 12:49:53 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matej Genci <matej.genci@nutanix.com>
Subject: [PATCH v3] virtio: add VIRTIO_RING_NO_LEGACY
Thread-Topic: [PATCH v3] virtio: add VIRTIO_RING_NO_LEGACY
Thread-Index: AQHVaJ9oYc4AfcbucEeOU9jzRiMzkg==
Date:   Wed, 11 Sep 2019 12:49:53 +0000
Message-ID: <20190911124942.243713-1-matej.genci@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To BL0PR02MB3634.namprd02.prod.outlook.com
 (2603:10b6:207:3e::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [192.146.154.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78e890ba-a3c1-4917-3a69-08d736b68a97
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB3634;
x-ms-traffictypediagnostic: BL0PR02MB3634:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR02MB3634A7C2E20069A379B0D0CFFBB10@BL0PR02MB3634.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(189003)(81156014)(64756008)(486006)(1076003)(6116002)(478600001)(25786009)(5660300002)(26005)(66066001)(53936002)(476003)(2616005)(6512007)(110136005)(71200400001)(316002)(66946007)(66556008)(71190400001)(2906002)(2201001)(81166006)(66446008)(86362001)(2501003)(66476007)(256004)(50226002)(6486002)(186003)(102836004)(107886003)(8676002)(44832011)(386003)(6506007)(36756003)(7736002)(14454004)(3846002)(99286004)(52116002)(6436002)(305945005)(4326008)(8936002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB3634;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j1jJ6MV3/050SLHezFJcuujLoZ/0qzFiBswePu1eig57wMm/S85kptYsNJ18UQqQX2rJz6B3erRTD5Z19wjSXq/dVdzsh+BqDWTKi/4MdYWK2QVksQA+7PiWbsZUNCHemPyz8ggLnbOEd4SIQJe/KtaZz2H95i2WN5mk6MgIzHdNEtxVOfakgD4TE0/ZYGTLMaHBTjWC4FZqN0ltYWS+1TqlAVgKFHfT9KoO952Ej8wxuGZgY4rir1y9nDN9zCFrICuAdc/EJo+7rA2R4/4XEjAf1hFPzM8onXdDv2K+PRvxfgHPxdSu4Z0vudlWGco3aTKPWzmdybbcoMeZbiyG3pt57KTOZ4tp773SHwEahYPijmSLyCAaltVC59zwMnw4nPWsFSlIc+IUkAEcjyxN7tLgajM24GWroCz//5YzooA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e890ba-a3c1-4917-3a69-08d736b68a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 12:49:53.5817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lvfi1Gp4ujNyu/TS6yJj8TZLzp5SCrRleCz/rHIWMSiS0cJ1MSTrOZ7L7ObHgj15plqO+6ccWiSHP7ImiF2gqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3634
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_08:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1hY3JvIHRvIGRpc2FibGUgbGVnYWN5IHZyaW5nIGZ1bmN0aW9ucy4NCg0KU2lnbmVkLW9m
Zi1ieTogTWF0ZWogR2VuY2kgPG1hdGVqLmdlbmNpQG51dGFuaXguY29tPg0KLS0tDQoNCnYzOiBS
ZW1vdmVkIHN0cnVjdCB2cmluZyBmcm9tIGluc2lkZSB0aGUgI2lmbmRlZiBzaW5jZQ0KICAgIGlu
Y2x1ZGUvbGludXgvdnJpbmcuaCBkZXBlbmRzIG9uIGl0cyBkZWZpbml0aW9uLg0KDQotLS0NCiBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIHwgMSArDQogaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19yaW5nLmggICB8IDQgKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYw0KaW5kZXggN2FiY2M1MDgzOGI4
Li5kYjkzY2VkZDI2MmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21v
ZGVybi5jDQorKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jDQpAQCAtMTYs
NiArMTYsNyBAQA0KIA0KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KICNkZWZpbmUgVklSVElP
X1BDSV9OT19MRUdBQ1kNCisjZGVmaW5lIFZJUlRJT19SSU5HX05PX0xFR0FDWQ0KICNpbmNsdWRl
ICJ2aXJ0aW9fcGNpX2NvbW1vbi5oIg0KIA0KIC8qDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19yaW5nLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3JpbmcuaA0K
aW5kZXggNGM0ZTI0YzI5MWE1Li5mYjNlNTczYmRkMzcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX3JpbmcuaA0KKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19y
aW5nLmgNCkBAIC0xMzUsNiArMTM1LDggQEAgc3RydWN0IHZyaW5nIHsNCiAjZGVmaW5lIFZSSU5H
X1VTRURfQUxJR05fU0laRSA0DQogI2RlZmluZSBWUklOR19ERVNDX0FMSUdOX1NJWkUgMTYNCiAN
CisjaWZuZGVmIFZJUlRJT19SSU5HX05PX0xFR0FDWQ0KKw0KIC8qIFRoZSBzdGFuZGFyZCBsYXlv
dXQgZm9yIHRoZSByaW5nIGlzIGEgY29udGludW91cyBjaHVuayBvZiBtZW1vcnkgd2hpY2ggbG9v
a3MNCiAgKiBsaWtlIHRoaXMuICBXZSBhc3N1bWUgbnVtIGlzIGEgcG93ZXIgb2YgMi4NCiAgKg0K
QEAgLTE4MSw2ICsxODMsOCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIHZyaW5nX3NpemUodW5z
aWduZWQgaW50IG51bSwgdW5zaWduZWQgbG9uZyBhbGlnbikNCiAJCSsgc2l6ZW9mKF9fdmlydGlv
MTYpICogMyArIHNpemVvZihzdHJ1Y3QgdnJpbmdfdXNlZF9lbGVtKSAqIG51bTsNCiB9DQogDQor
I2VuZGlmIC8qIFZJUlRJT19SSU5HX05PX0xFR0FDWSAqLw0KKw0KIC8qIFRoZSBmb2xsb3dpbmcg
aXMgdXNlZCB3aXRoIFVTRURfRVZFTlRfSURYIGFuZCBBVkFJTF9FVkVOVF9JRFggKi8NCiAvKiBB
c3N1bWluZyBhIGdpdmVuIGV2ZW50X2lkeCB2YWx1ZSBmcm9tIHRoZSBvdGhlciBzaWRlLCBpZg0K
ICAqIHdlIGhhdmUganVzdCBpbmNyZW1lbnRlZCBpbmRleCBmcm9tIG9sZCB0byBuZXdfaWR4LA0K
LS0gDQoyLjIyLjANCg0K
