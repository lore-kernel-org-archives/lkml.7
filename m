Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F0EC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D46120872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="wWimEvPZ";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="K9rwrbop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392000AbfJPJhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:37:13 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9468 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbfJPJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:37:13 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G9ZTVn030901;
        Wed, 16 Oct 2019 02:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=sE1+NrNxilS/mOc+FR4FxLmEPyFSKXkEeSf43jT0DGc=;
 b=wWimEvPZ8uuDr4SjFg//jyJuzu6vYReMqcXu67PelkglXFDGmcQR4FBG6bA4kwObPN1T
 6Fx0ivyauqiYcTQy4xt79uBQueci9OTVeQU1rtxFd0k3UfpOgpSFseBSNJS/Nskgwyys
 W1ICoU8ozybONmTAx7wSWDJ/9oO07LVqKABU79csiY12/+pliovP29IQiDrBbDwk0qZL
 Pe5Ok7ZTO+oDyFnRvlbRKjV7Vo3pasJM/Vb5tA4tagEKx2Wx2mW//bB20Jq4Mxc3OOKe
 ajwqr3IeNc4HqFg+doIyOCbVyCpwyf3lZ6PVrGwN/imX7Vi1l0bwdgayMmnf16at/9Sf 5g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vkebp5x7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 02:37:02 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 02:37:00 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Oct 2019 02:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb5fARw/+BccDJ+hz438wMYJMM7MBdR19Fhv+ZSkp/Zl3JUqSMYZGo3tcGmzXeXDGV+Ivg56i8ewfLO4MQuVtsQUWZxkSSWt9pWmmCwO9dX8wpQq33Ofx0veANKsaNInrFNoFpXfMGaF2tgUgU+JjIDvfa5BpkjCa2ybA2vO1DqNjkyhirHyb/pI3KjUXGRyEmmhnDtNxGVYmbAIMx92yZpkCkdzF/CsPMjtqtJSqCpQ6cQsEbTqR+WOvVRpJMqBz6Rm7INXMBQ48hmi0FUcnkqZeFPjulnaw/jfkTPkOKCe67EemcDvUmpJV05qO17Y6b5fQQP/ApGiM2TVIvLS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE1+NrNxilS/mOc+FR4FxLmEPyFSKXkEeSf43jT0DGc=;
 b=Xym9MB5euKVCN3dSqM25mgrABbuDOs1y6HPGnEY0tyBtIWADCvmfIPhrfrmKvWMDieot5FryOODNq+ehyjZC0npYLFulhnw0EgdaYSG9/HZaubUknew9MLAHSYGMxfm1t0cjhdeSMwAl7o//MXnDfQRtqmo+vajPCj2aIE7hKxZkpR/fDofHr+BnmoZpGm2gNsBmuadhnrwSbtlzSKNV+bOiHgEn/7kJSn/nilJ1U1JzAV8pb+4ZiPEMRjZUzLcasCjtnZB6CMgQw5gZMy1isiUFssuG2oKwGza3zXz+kkxxx24mOzwq9UP3vyol/iav/gmbV5gxEiNVzFZzONyL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE1+NrNxilS/mOc+FR4FxLmEPyFSKXkEeSf43jT0DGc=;
 b=K9rwrbopGkW6HnmR2jIU2KySUhZnIvLXfD9skGpkzp06nq74ysCabolkmC3I9M6sKUNMN3iWq0UeUQAxUkJ9MRXWGHvIXIrzSSDmDz7iNVVRu1TP5hR3O1+F35VgbopuTAuIzWd/vInP+Mf0qmiTnKSixQLV7jUrNI0LwLq1Sq4=
Received: from BN8PR18MB2868.namprd18.prod.outlook.com (20.179.74.155) by
 BN8PR18MB2691.namprd18.prod.outlook.com (20.179.75.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 09:36:58 +0000
Received: from BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::ec84:ac37:d96a:5aa4]) by BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::ec84:ac37:d96a:5aa4%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 09:36:58 +0000
From:   Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH v6 0/2] Add CCPI2 PMU support
Thread-Topic: [PATCH v6 0/2] Add CCPI2 PMU support
Thread-Index: AQHVhAVAxiyb41fRsECU1AYdRma1hw==
Date:   Wed, 16 Oct 2019 09:36:57 +0000
Message-ID: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To BN8PR18MB2868.namprd18.prod.outlook.com
 (2603:10b6:408:a2::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2315d23-52d9-403b-6a40-08d7521c633d
x-ms-traffictypediagnostic: BN8PR18MB2691:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR18MB269103B953153F56B6EA3A97B2920@BN8PR18MB2691.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(110136005)(6512007)(4720700003)(71190400001)(71200400001)(305945005)(26005)(7736002)(99286004)(52116002)(486006)(2201001)(6306002)(2501003)(478600001)(4744005)(54906003)(5660300002)(316002)(4326008)(36756003)(14454004)(966005)(86362001)(256004)(66476007)(66946007)(25786009)(66446008)(64756008)(14444005)(6436002)(6486002)(8936002)(66066001)(81156014)(66556008)(186003)(6506007)(476003)(102836004)(2616005)(50226002)(2906002)(386003)(8676002)(81166006)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2691;H:BN8PR18MB2868.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBOT4UIUFJ9Gk0t18VhldnoSJxyGUvV1+YYzwUNQ43qsg8N908DZnxONFLQ5K7Qi4IgJC0JNmrzHKoNUvW4rmjlAc216NREHrCkeI0e5uTtlsiYeiIYnc5uq/fy0joWAWln/EZsVnLSMrxJAjfVNYuGN8I6mi+Pefnl2iv9vtXUMZetGT0yD0y7sluD7avKyX6Nad/gtmIf7X/zQXQxUDchyqg5tR/mo63J88n71dpOgRoiOEl4Tfsx9kIh2Pr8q7n5fyFQG3zKeLIYz07JCZ6Fzl/ugX6IiY1lD5arkcmZxIBGjI+wonuHdV5ssgZPLXMeGqcD9mUVnFG/lSyzLZcOYT84OzIUayXDjVSTjuKd2CuG/tD3d3yVnHmGUuHfr2GtJa9qn/FQ8dkz0KoRlOhxCHdD2e5epaR4dr8nv74ueAA5BUlCQmWyeDK/66Eh3owsdopk05pKLu+uDb2r8cg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d2315d23-52d9-403b-6a40-08d7521c633d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 09:36:57.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQKWJY66RptFR+g6xRkg1r6zyVTGnjmnoYfWRoEIEdev7f0LS+Kc71RzF0a13dSR3Cfn/cpLtDODGYN+jC8VIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2691
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cavium Coherent Processor Interconnect (CCPI2) PMU
support in ThunderX2 Uncore driver.

v6:
	Rebased to 5.4-rc1

v5:
	Fixed minor bug of v4 (timer callback fuction
	was getting initialized to NULL for all PMUs).

v4:
	Update with review comments [2].
	Changed Counter read to 2 word read since single dword read is misbhehavin=
g(hw issue).

[2] https://lkml.org/lkml/2019/7/23/231

v3: Rebased to 5.3-rc1

v2: Updated with review comments [1]

[1] https://lkml.org/lkml/2019/6/14/965

v1: initial patch


Ganapatrao Prabhakerrao Kulkarni (2):
  Documentation: perf: Update documentation for ThunderX2 PMU uncore
    driver
  drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.

 .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
 drivers/perf/thunderx2_pmu.c                  | 267 +++++++++++++++---
 2 files changed, 245 insertions(+), 42 deletions(-)

--=20
2.17.1

