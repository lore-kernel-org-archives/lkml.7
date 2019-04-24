Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F37C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC318218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OBtuE2z/";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="qcua6fLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfDXLvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:51:05 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:38144 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbfDXLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:51:05 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OBngE8009296;
        Wed, 24 Apr 2019 04:50:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=LBnehm9twTqRkNe+oVerrAN55sKpcIJFOEg2UQFRvjE=;
 b=OBtuE2z/cWrqe/666qltzJr0FLlYnVcWbiR+8OH9hRH53Ls3acFnGudxoWA9hYsYvRuW
 XDpblkxW5qymPQA4ZK+uO9a3c920qSW8JFHQQtxJqMrszt5Wk9hcHfZVQLs/jjdUImDG
 09SfNQnrzkl7q7+Ec3sFzFAiN/vJSx2R+F4NaB+RcetjG495Xt308/cfCEDLfNPZjyR7
 UKQ+7aZQaz7kicJVR62/6nFXxaz+sGKkqnYaLsMRfSCSbCwVSX6lGAj/fGsgttTP7Mri
 VpaU3HQwE9NSgmdVMV8lJ9js3bjtOZC3aed6tEYD9GGCr2mJ3660/ZVN+lhvPZf7cwGZ JQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2s2nnjg9ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 04:50:46 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 24 Apr
 2019 04:50:45 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 24 Apr 2019 04:50:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBnehm9twTqRkNe+oVerrAN55sKpcIJFOEg2UQFRvjE=;
 b=qcua6fLl8QUvcnKHJtXK14CpNr2OiLaWUNhtcHHb6hcsJXkR/cpwF/4T+cbHX7s1Fiklq6/tOB8GNKejyBq2GgygEx6HCJx4C4phC35QOYhNnVSKUu/epGSTSkakC95DgDNIZFl7Z1swJm7U8z/lhitLwEX5K/yTVgOcqY5Q6T4=
Received: from BN8PR18MB2948.namprd18.prod.outlook.com (20.179.76.22) by
 BN8PR18MB2402.namprd18.prod.outlook.com (20.179.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 11:50:44 +0000
Received: from BN8PR18MB2948.namprd18.prod.outlook.com
 ([fe80::350b:658b:405c:2bf5]) by BN8PR18MB2948.namprd18.prod.outlook.com
 ([fe80::350b:658b:405c:2bf5%4]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 11:50:44 +0000
From:   Kamlakant Patel <kamlakantp@marvell.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Kamlakant Patel <kamlakantp@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH] ipmi:ssif: compare block number correctly for multi-part
 return messages
Thread-Topic: [PATCH] ipmi:ssif: compare block number correctly for multi-part
 return messages
Thread-Index: AQHU+pPy99dQ2rrV3EmqJwCk6stY1A==
Date:   Wed, 24 Apr 2019 11:50:43 +0000
Message-ID: <1556106615-18722-1-git-send-email-kamlakantp@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To BN8PR18MB2948.namprd18.prod.outlook.com
 (2603:10b6:408:a8::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7d3d8a5-973b-4700-9852-08d6c8ab14e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR18MB2402;
x-ms-traffictypediagnostic: BN8PR18MB2402:
x-microsoft-antispam-prvs: <BN8PR18MB240254EE0458E139E2D4EC9CD23C0@BN8PR18MB2402.namprd18.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39850400004)(189003)(199004)(52116002)(316002)(2616005)(102836004)(186003)(86362001)(26005)(6506007)(386003)(54906003)(476003)(25786009)(486006)(97736004)(6486002)(4326008)(478600001)(36756003)(99286004)(14454004)(15650500001)(6436002)(7736002)(66446008)(53936002)(71200400001)(3846002)(6116002)(66066001)(81166006)(8676002)(73956011)(66556008)(64756008)(66476007)(4720700003)(6916009)(71190400001)(68736007)(66946007)(2906002)(8936002)(50226002)(6512007)(305945005)(256004)(14444005)(5660300002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2402;H:BN8PR18MB2948.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JIbWkGMEFGy6F79eu63IQJ5cdZWHHeW3kuo2UfAMWDHwIikzD7pfcUZ76Z9K78p8ZX5EnXOHNX6pT/bscDLeYzFjfSCdEJN/SogySmNcksMj1U/mCPviI2YuP3qHIJE0Gjt0/IuEFHLFWLDW7Oid3ghY8HfcY9lZakyHiHOZowIPMeR/n/TgFxMkKo22U8ChSC/RctKw0H7K2OW8h7qVOrKnVGlh00s/QZZNb97XgY0SbIYohUYMKlyjqHWDOrui5UDZj5X7cJG3/+Cz38LM4hwJAPETB3tkhMMUFNuEXAmRH8cr3/sTDxFlhA/R8uixeaNQUDY4nyOXGlPmIOLkyqFTPRBG3K+T8dzv6A9IxNubQjy/GgjdWGwTNvzK+hRA4wObHBcDPbGz4SaesLk5LO0WxxrDVetZCBiyVC/uS9c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d3d8a5-973b-4700-9852-08d6c8ab14e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 11:50:43.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2402
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNjb3JkaW5nIHRvIGlwbWkgc3BlYywgYmxvY2sgbnVtYmVyIGlzIGEgbnVtYmVyIHRoYXQgaXMg
aW5jcmVtZW50ZWQsDQpzdGFydGluZyB3aXRoIDAsIGZvciBlYWNoIG5ldyBibG9jayBvZiBtZXNz
YWdlIGRhdGEgcmV0dXJuZWQgdXNpbmcgdGhlDQpNaWRkbGUgdHJhbnNhY3Rpb24uDQoNCkhlcmUs
IHRoZSAnYmxvY2tudW0nIGlzIGRhdGFbMF0gd2hpY2ggYWx3YXlzIHN0YXJ0cyBmcm9tIHplcm8o
MCkgYW5kDQonc3NpZl9pbmZvLT5tdWx0aV9wb3MnIHN0YXJ0cyBmcm9tIDEuDQpTbywgd2UgbmVl
ZCB0byBhZGQgKzEgdG8gYmxvY2tudW0gd2hpbGUgY29tcGFyaW5nIHdpdGggbXVsdGlfcG9zLg0K
DQpUaGlzIGNoYW5nZSBmaXhlcyAoImlwbWk6c3NpZjogRml4IGhhbmRsaW5nIG9mIG11bHRpLXBh
cnQgcmV0dXJuDQptZXNzYWdlcyIpLg0KDQpSZXBvcnRlZC1ieTogS2lyYW4gS29sdWt1bHVydSA8
a2lyYW5rQGFtaS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBLYW1sYWthbnQgUGF0ZWwgPGthbWxha2Fu
dHBAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2NoYXIvaXBtaS9pcG1pX3NzaWYuYyB8IDIg
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWlfc3NpZi5jIGIvZHJpdmVycy9jaGFyL2lw
bWkvaXBtaV9zc2lmLmMNCmluZGV4IDhiNWFlYzUuLjJiMDM4NDUgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2NoYXIvaXBtaS9pcG1pX3NzaWYuYw0KKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtaV9z
c2lmLmMNCkBAIC03MjcsNyArNzI3LDcgQEAgc3RhdGljIHZvaWQgbXNnX2RvbmVfaGFuZGxlcihz
dHJ1Y3Qgc3NpZl9pbmZvICpzc2lmX2luZm8sIGludCByZXN1bHQsDQogCQkJLyogRW5kIG9mIHJl
YWQgKi8NCiAJCQlsZW4gPSBzc2lmX2luZm8tPm11bHRpX2xlbjsNCiAJCQlkYXRhID0gc3NpZl9p
bmZvLT5kYXRhOw0KLQkJfSBlbHNlIGlmIChibG9ja251bSAhPSBzc2lmX2luZm8tPm11bHRpX3Bv
cykgew0KKwkJfSBlbHNlIGlmIChibG9ja251bSArIDEgIT0gc3NpZl9pbmZvLT5tdWx0aV9wb3Mp
IHsNCiAJCQkvKg0KIAkJCSAqIE91dCBvZiBzZXF1ZW5jZSBibG9jaywganVzdCBhYm9ydC4gIEJs
b2NrDQogCQkJICogbnVtYmVycyBzdGFydCBhdCB6ZXJvIGZvciB0aGUgc2Vjb25kIGJsb2NrLA0K
LS0gDQoxLjguMy4xDQoNCg==
