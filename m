Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55A2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bDJP/Sno";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="VJnACuyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfDXJtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:49:00 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35992 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbfDXJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:49:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9iUiu002582;
        Wed, 24 Apr 2019 02:48:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=xzSkHxiWDllkDuH30HqLhrLBxm5CG1PfSPR5dXJTpZo=;
 b=bDJP/SnoUHDf1hw/FccdpXl3aXNlGUbNNY4p5OgRU+lMvSFxMaVNkC/OFX2itWiBNbeb
 G+fUguHoqYVPudOKzN+GiWuIVCDJjgl1WAOAoKYRFA13iDTzqeS+i0sEYAD0OywtOdio
 2SIrdVUFH1I7uGRdkqjbpCjFc0ryZnboNWSbvF3O4YOPrDkLh/3JHx5FxTBPLPnN+BGB
 tQ4w11wbrB+/pnc3Craoa7FiMf0vOl1SlXzV/LLc/wXmpN8WVMa+jZLlqjr6K1EYnSp7
 /IWrd7+EkvIKM8WsjlkssTV45mQBR3h/LRZrTeHUtrYvbcNKC+49dkbcmBQWv3tR6Wcg rg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2s2my5r4fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 02:48:42 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 24 Apr
 2019 02:48:41 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 24 Apr 2019 02:48:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzSkHxiWDllkDuH30HqLhrLBxm5CG1PfSPR5dXJTpZo=;
 b=VJnACuyhhxPKtZg2C80fUZer0zwpryBMtftL964wBm7S5jZf7EMPJFkUdELNlTIkb3NhsZZCWdx2+WmCjDfmhizOxUvtcgfcVLP0gGnhbbTKDeuaMByFLgHikuWtR18aNUZIz3WBx4annb42fn6jAE3+lky87S+wHAMTH3JxpWE=
Received: from MN2PR18MB2959.namprd18.prod.outlook.com (20.179.23.22) by
 MN2PR18MB2941.namprd18.prod.outlook.com (20.179.22.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 09:48:36 +0000
Received: from MN2PR18MB2959.namprd18.prod.outlook.com
 ([fe80::795f:6f50:3515:8298]) by MN2PR18MB2959.namprd18.prod.outlook.com
 ([fe80::795f:6f50:3515:8298%7]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 09:48:36 +0000
From:   Kamlakant Patel <kamlakantp@marvell.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Kamlakant Patel <kamlakantp@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] ipmi: add i2c-addr property to ipmi platform device
Thread-Topic: [PATCH] ipmi: add i2c-addr property to ipmi platform device
Thread-Index: AQHU+oLj1eGkHXYECE2vgHs+6GI+SQ==
Date:   Wed, 24 Apr 2019 09:48:36 +0000
Message-ID: <1556099251-11408-1-git-send-email-kamlakantp@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:a03:54::18) To MN2PR18MB2959.namprd18.prod.outlook.com
 (2603:10b6:208:a4::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5996d36-651e-4a55-843f-08d6c89a058a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB2941;
x-ms-traffictypediagnostic: MN2PR18MB2941:
x-microsoft-antispam-prvs: <MN2PR18MB294162B6761BA43123F54FF2D23C0@MN2PR18MB2941.namprd18.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(316002)(66446008)(102836004)(486006)(386003)(4744005)(26005)(52116002)(14454004)(64756008)(6506007)(66476007)(66556008)(478600001)(54906003)(2906002)(36756003)(66946007)(3846002)(6116002)(73956011)(186003)(476003)(2616005)(99286004)(97736004)(71190400001)(71200400001)(8676002)(81156014)(81166006)(4326008)(5660300002)(86362001)(6916009)(6436002)(256004)(305945005)(6486002)(4720700003)(50226002)(25786009)(66066001)(68736007)(8936002)(6512007)(53936002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2941;H:MN2PR18MB2959.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GKQEtuKigirXrctFldjK4PzJYqIm4sSoaAmb2BbQtYGT2UobzfcZuM5ppsAwNF66reVPDpoXaZPIswjG0JWRXz+wmK4rdTkI701Noaop1XIUlG27Qa9FMQ1L+tW+6bh2cbY5KurXmwbDzBLcJ3FgBjTpZ2Ha4O9aty6Buv3cvndbzAzp+yHP1PluwvFzzHXz3Mmnlm4egRcD2PDiSx6h6J9DuC+APtTs5jV3rArS+m/gtIZj3CbICmanfkp9zn6a456iWOuLqEmFpJ95/SQqDTZ4YUMULgRlhAHa/NvGJMUfw//afWIrrVnG6Tys/y7WuHXYovJFNAAyZlf5AwtshZtVyzCOu+Pgb5BjI47gNr4GOMwqX77Whg3b/hTPMZweSNTjmMu7YB7Q4IPHkaH8kDNa4gWegkIPlAS2JxzPsQo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5996d36-651e-4a55-843f-08d6c89a058a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 09:48:36.6549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2941
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2UgbmVlZCAnaTJjLWFkZHInIHByb3BlcnR5IGVudHJ5IGZvciBzc2lmIHRvIHdvcmsuDQpPdGhl
cndpc2UsIGl0IHRob3J3cyBmb2xsb3dpbmcgZXJyb3I6DQoiaXBtaV9zc2lmIGRtaS1pcG1pLXNz
aWYuMDogaXBtaV9zc2lmOiBObyBpMmMtYWRkciBwcm9wZXJ0eSINCg0KU2lnbmVkLW9mZi1ieTog
S2FtbGFrYW50IFBhdGVsIDxrYW1sYWthbnRwQG1hcnZlbGwuY29tPg0KLS0tDQogZHJpdmVycy9j
aGFyL2lwbWkvaXBtaV9wbGF0X2RhdGEuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX3BsYXRfZGF0
YS5jIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtaV9wbGF0X2RhdGEuYw0KaW5kZXggOGYwY2EyYS4u
MTA3NTA3NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWlfcGxhdF9kYXRhLmMN
CisrKyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWlfcGxhdF9kYXRhLmMNCkBAIC0zNCw2ICszNCw4
IEBAIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmlwbWlfcGxhdGZvcm1fYWRkKGNvbnN0IGNoYXIg
Km5hbWUsIHVuc2lnbmVkIGludCBpbnN0LA0KIAkJcC0+cmVnc3BhY2luZyA9IHAtPnJlZ3NpemU7
DQogDQogCXByW3BpZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9VOCgiaXBtaS10eXBlIiwgcC0+dHlw
ZSk7DQorCWlmIChwLT5hZGRyKQ0KKwkJcHJbcGlkeCsrXSA9IFBST1BFUlRZX0VOVFJZX1UxNigi
aTJjLWFkZHIiLCBwLT5hZGRyKTsNCiAJaWYgKHAtPnNsYXZlX2FkZHIpDQogCQlwcltwaWR4Kytd
ID0gUFJPUEVSVFlfRU5UUllfVTgoInNsYXZlLWFkZHIiLCBwLT5zbGF2ZV9hZGRyKTsNCiAJcHJb
cGlkeCsrXSA9IFBST1BFUlRZX0VOVFJZX1U4KCJhZGRyLXNvdXJjZSIsIHAtPmFkZHJfc291cmNl
KTsNCi0tIA0KMS44LjMuMQ0KDQo=
