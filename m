Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE95C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37FE218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="vxl/pCNe";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="O0zjgkiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfDXKem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:34:42 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43768 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfDXKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:34:41 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OAYJdQ012161;
        Wed, 24 Apr 2019 03:34:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=rfxODGp1qGBUYUk+cw2V4uDqOK6gMQRLkJCDsm1Lxlo=;
 b=vxl/pCNejWdHiMjT059TWx3JtNZk3R44zEaUrVwA7WQO83dRjNbysO8M4qulrcAqEXn7
 BO5ahHFc4uo/X84RWSbH2xZFIERHh7BjkMMVcAWKEcuhpP03UF5hUP0RTdqnEG0WierW
 1nXx2onit9o/wST+GFAEQL80N4bRgPdoJuoq+1lVGnDOkGPEVsTqpEZbUhpW7N60DG2M
 QxYUzXKeHB+XaQM2VG15ZFS+vETySTHwP9OZp8kFVL2vmvrOvFtfqrLo+08Xj91xDOZW
 Ty1zpDdF/yvS2V+vZMPWuVdJy3KGlpWI4c4ypOFUh4SeGbG2RRMt3825Pxvl8YNj8I71 1g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2s2my5r97a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 03:34:19 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 24 Apr
 2019 03:34:19 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 24 Apr 2019 03:34:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfxODGp1qGBUYUk+cw2V4uDqOK6gMQRLkJCDsm1Lxlo=;
 b=O0zjgkiZaK1T9j3SvjVA1HoGFsYBh2s84il/feowTqhf0XgOJHjrH15gLNZEuIboBQ8gmTVLF3fiytto9wyoYbECpGrEMBqvNHQwDyQD8xS/59kFur3ladBf4iL0Yz5roLxyjwH5t5sOtPtm8FNzyvMU/4lt5pAnKB2OoA/TQ5s=
Received: from BN8PR18MB2948.namprd18.prod.outlook.com (20.179.76.22) by
 BN8PR18MB2369.namprd18.prod.outlook.com (20.179.66.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 10:34:14 +0000
Received: from BN8PR18MB2948.namprd18.prod.outlook.com
 ([fe80::350b:658b:405c:2bf5]) by BN8PR18MB2948.namprd18.prod.outlook.com
 ([fe80::350b:658b:405c:2bf5%4]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 10:34:14 +0000
From:   Kamlakant Patel <kamlakantp@marvell.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Kamlakant Patel <kamlakantp@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] ipmi: fix slave-addr property add to ipmi platform device
Thread-Topic: [PATCH] ipmi: fix slave-addr property add to ipmi platform
 device
Thread-Index: AQHU+olCorsZ0oAmBUC9bF6GbTHVPA==
Date:   Wed, 24 Apr 2019 10:34:14 +0000
Message-ID: <1556102007-14083-1-git-send-email-kamlakantp@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To BN8PR18MB2948.namprd18.prod.outlook.com
 (2603:10b6:408:a8::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 657f56b0-99b0-46a2-a7c3-08d6c8a06522
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR18MB2369;
x-ms-traffictypediagnostic: BN8PR18MB2369:
x-microsoft-antispam-prvs: <BN8PR18MB236959D2CC39A921D7AF1561D23C0@BN8PR18MB2369.namprd18.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(66066001)(50226002)(7736002)(4720700003)(6916009)(14454004)(73956011)(81156014)(66476007)(4326008)(478600001)(66556008)(54906003)(81166006)(6506007)(26005)(97736004)(64756008)(66946007)(25786009)(386003)(66446008)(256004)(5660300002)(476003)(6436002)(36756003)(8676002)(2616005)(71190400001)(8936002)(86362001)(68736007)(486006)(99286004)(71200400001)(6486002)(316002)(102836004)(186003)(3846002)(2906002)(6116002)(6512007)(52116002)(305945005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2369;H:BN8PR18MB2948.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5xm0fX2E8pZdqj4Yrvvg4TZDcW0+BoKk80HsuL6PC44QgVQHixBdDBdjvPEJeyqt9pXurF1ClNrns+Fbi0kbV2Fb52dlhb9yhUmV96klU5GpaaH+thJUm2EERdVFUGAs1uIjIOffCwHfXhMWa0JlZECKWnl7ai4ufPY4KcowQTHgqWP+fgCOjnSEd+zFV/iPzYsABp4wN0iKk3bn4isSJ0u+wKBz+NXc2Wtms8r+sGstGyv6L8wl1SuJTLP9+8WU3dnLO9E9NXuxsGux8bIgjMZ047+On21T+lfes8riAtr/XoQKXhdO68aKdalx7zuHPiYB+qC+b1L+V4bFrOoyib/psqj207qNNj9RH6Pqxpudc8wdLrx88I25klAc2x9VLdEgGuUbs+kyKaajJwQFZch5UvT8N7/wDDAlmNSkQZk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 657f56b0-99b0-46a2-a7c3-08d6c8a06522
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 10:34:14.1069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2369
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIGNoZWNrIGZvciBwLT5zbGF2ZV9hZGRyIHdoaWxlIGFkZGluZyAnc2xhdmUtYWRkcicg
cHJvcGVydHkgZW50cnkNCnNpbmNlIGl0IGNhbiBiZSAwLg0KQ3VycmVudGx5LCBpdCB0aHJvd3Mg
Zm9sbG93aW5nIGVycm9yOg0KImlwbWlfc3NpZiBkbWktaXBtaS1zc2lmLjA6IGlwbWlfc3NpZjog
ZGV2aWNlIGhhcyBubyBzbGF2ZS1hZGRyDQpwcm9wZXJ0eSINCg0KVGhpcyBwYXRjaCBmaXhlcyB0
aGUgaXNzdWUuDQoNClNpZ25lZC1vZmYtYnk6IEthbWxha2FudCBQYXRlbCA8a2FtbGFrYW50cEBt
YXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2hhci9pcG1pL2lwbWlfcGxhdF9kYXRhLmMgfCAz
ICstLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWlfcGxhdF9kYXRhLmMgYi9kcml2ZXJz
L2NoYXIvaXBtaS9pcG1pX3BsYXRfZGF0YS5jDQppbmRleCA4ZjBjYTJhLi4yYjYyMTA0IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtaV9wbGF0X2RhdGEuYw0KKysrIGIvZHJpdmVy
cy9jaGFyL2lwbWkvaXBtaV9wbGF0X2RhdGEuYw0KQEAgLTM0LDggKzM0LDcgQEAgc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqaXBtaV9wbGF0Zm9ybV9hZGQoY29uc3QgY2hhciAqbmFtZSwgdW5zaWdu
ZWQgaW50IGluc3QsDQogCQlwLT5yZWdzcGFjaW5nID0gcC0+cmVnc2l6ZTsNCiANCiAJcHJbcGlk
eCsrXSA9IFBST1BFUlRZX0VOVFJZX1U4KCJpcG1pLXR5cGUiLCBwLT50eXBlKTsNCi0JaWYgKHAt
PnNsYXZlX2FkZHIpDQotCQlwcltwaWR4KytdID0gUFJPUEVSVFlfRU5UUllfVTgoInNsYXZlLWFk
ZHIiLCBwLT5zbGF2ZV9hZGRyKTsNCisJcHJbcGlkeCsrXSA9IFBST1BFUlRZX0VOVFJZX1U4KCJz
bGF2ZS1hZGRyIiwgcC0+c2xhdmVfYWRkcik7DQogCXByW3BpZHgrK10gPSBQUk9QRVJUWV9FTlRS
WV9VOCgiYWRkci1zb3VyY2UiLCBwLT5hZGRyX3NvdXJjZSk7DQogCWlmIChwLT5yZWdzaGlmdCkN
CiAJCXByW3BpZHgrK10gPSBQUk9QRVJUWV9FTlRSWV9VOCgicmVnLXNoaWZ0IiwgcC0+cmVnc2hp
ZnQpOw0KLS0gDQoxLjguMy4xDQoNCg==
