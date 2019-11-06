Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31EE2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="q13agy6I";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="UPrh9Kno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfKFBCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:02:03 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21424 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730054AbfKFBCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:02:02 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA61092t028449;
        Tue, 5 Nov 2019 17:01:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=BVp8qUxRE121/tm+T2vAbDt1Z1MHkG+jRqNO0T9Q5w8=;
 b=q13agy6I5i1iqfD4YnmPGa8TRm0fGQOqEK9hygBoBc45bW9VrN0JewgjzkthxpRQ7zj6
 zSFPJ47PWjWFoIWNjOVyfOzyFYSxBwBsbMDUW15xCeggpRXiOZvW/7rVrD+4HLmfGsaO
 U2JONSYsKHgrghhu1RIvDn7BYyTB6zqPTo9ZlLv09U64MNU1rOMo4ZswGQKV69knFqKM
 OxuVIUgT0G/0GSATL3GINC4ss4QAbrxdzkpdWt4UNxw7sNzuxXNy7pGDabYyENosdug5
 EbhrwYJ5sFRN540nvVP0TVd3pBFgm/e6RbqiLJWEGX6XTlj2fX/xjuX8l8Eoxd9bzslp zg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2w3eud17ea-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 17:01:41 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 5 Nov
 2019 17:01:40 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 5 Nov 2019 17:01:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxLmRvOp5oZwxO+fRusbj/pIBLSll9g7aCGpgjB/9xKjTPMswUZWJ1mHpUATDKmnRAHlANynr549QaPTKsB7QL7H8gYzg0JFs6qbpnN4fGefyiGgFoLVwqe99dUxDWw4S3yN3yRS22ANLZpE9h/cGUZWtdDog4ps/xkwGnW8iTrfwFq9lCDZyVWGcrIbZ8poOmg0yo1i22NgsMENhnVo7oI1Rwk2y9YYbwpkHQqaqN+L1On8S/oQox+6KF6WVbujc3C5cEBFzr9tHiWm2Jh/I9bDIfLajJ3qokqpwKYG+8s6tkKqVhwZnDPQIOu/JQGHzLXXh7dumH72V6L3WD51xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVp8qUxRE121/tm+T2vAbDt1Z1MHkG+jRqNO0T9Q5w8=;
 b=VflQ/2/2yTGvxqUr+0gMNZWBp+ekRr7g+PcJEBOXZPUZlOb8RlOibrOOjYsUco0BvyBliR6K2xOhuj+gX8GNt7VKw5Xb+834YfgAPxH0zEXPDsvCivJSOo8wqyrwAm+ejAdTr8sRFi8I7exRHSAh0+9BrhI0eonuZMwp/1ygQ1JFy+omYAl87m6kTDnAQjekZoA7ztkMSl+r6e6q4kmcTa+tSow02D4yF0HxkvL6qVQRVyaqEpQhsaYWWUrgNl7rstBkaFAAlLbe8/OYDRpPrZjGk9B2rmuBkNgeAFh/qAgi2h0O+0WR598HxnQwajQQ6Lz4QBRwmnGWai56QKswMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVp8qUxRE121/tm+T2vAbDt1Z1MHkG+jRqNO0T9Q5w8=;
 b=UPrh9KnoJpgdk55a6MmcoazMm1XscpdoM+FrihQVhNzWsku83IgwQha2w0+lN65cgi9EIx1E7F3GjWKsEKaJWAi4ChK6G65AHiIIfHk29h0IlvnoKFO4HliYcb9j1No9Tib3p08qCUzasG4/9/OLX+n/B5kw5P/QEqDZ0ZaCYik=
Received: from BN8PR18MB2868.namprd18.prod.outlook.com (20.179.74.155) by
 BN8PR18MB2804.namprd18.prod.outlook.com (20.179.73.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 01:01:39 +0000
Received: from BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::431:e92e:ca76:f241]) by BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::431:e92e:ca76:f241%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:01:39 +0000
From:   Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH 0/2] Workaround for ThunderX2 erratum 221
Thread-Topic: [PATCH 0/2] Workaround for ThunderX2 erratum 221
Thread-Index: AQHVlD2+Hbd68lyaXEuRVf5Y/wFAFw==
Date:   Wed, 6 Nov 2019 01:01:39 +0000
Message-ID: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To BN8PR18MB2868.namprd18.prod.outlook.com
 (2603:10b6:408:a2::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e681de9a-873d-475f-003f-08d76254e112
x-ms-traffictypediagnostic: BN8PR18MB2804:
x-microsoft-antispam-prvs: <BN8PR18MB280492D82BC5ED5E5F6BD1C3B2790@BN8PR18MB2804.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(4744005)(8676002)(99286004)(81166006)(81156014)(2906002)(316002)(2501003)(50226002)(8936002)(54906003)(110136005)(3846002)(6116002)(36756003)(476003)(25786009)(14454004)(186003)(478600001)(26005)(102836004)(66066001)(386003)(6506007)(486006)(2201001)(2616005)(86362001)(66556008)(71200400001)(71190400001)(256004)(14444005)(7736002)(305945005)(4720700003)(52116002)(66446008)(64756008)(6486002)(66476007)(66946007)(6436002)(4326008)(6512007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2804;H:BN8PR18MB2868.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gdPAi0IudJncwAfHg3+ydnPPFyFxgek/aHbqJCznAPxBbNDAXxnjjxkheGlr09As5JdFV4BLn6MaXLn63Ak88vFWBrOmOoa2wfmgJaPApZmVXndcRPcQooW0EUVWsC3L2u4Wyh2ZmBh0iYzonDE+f2shifTwEmmyJg2ZVTqe9rNlh4Ay7qr4xz9q/G5ML2D3ZgE4kVZP03ntWcBbhapH5TySTt+8NzAYRPVqyQjmDW1P7zxMqMUWi6Noa1dqOX9+5xcHUDxld8dtgtpGRQ8ccdh5m4u8PcfU0qDG9ySY13J/7BCXw4Rt8yv07WYddGp06sO8AKQQU6HTEdhA8pGjh2pAnERFEgTzBVJMC4kTCUvEX65eKogoQ6EDyTFj+OmwaXhILHN2K8H6n5Jq2U9ljTTslrsDgGPWwxbbFXNtrVluweTRoidorIDnujAWkyGD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e681de9a-873d-475f-003f-08d76254e112
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:01:39.1091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PK8DoYlw8CL9xo8CTeKpVGq0Q7G//xt9sFMHdXPA8JEn5gikxzQVb9ehfRoaEQQan6DSpVu+QFW3GTvANX5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2804
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_09:2019-11-05,2019-11-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This erratum is found when system hang reported by internal
benchmarking team while they were trying ThunderX2 PMU uncore
events along with cpu/memory intensive applications like stream,
SPECjbb, SPECInt, etc.

The workaround is to disable event multiplexing.

The current Perf core does not provide any provision to PMUs
to disable event multiplexing. In first patch, adding PMU
capability to disable event multiplexing in perf core.
In second patch, setting the capability to disable for
the ThunderX2 UNCORE PMUs.

Ganapatrao Prabhakerrao Kulkarni (2):
  perf/core: Adding capability to disable PMUs event multiplexing
  Thunderx2, uncore: Add workaround for ThunderX2 erratum 221

 Documentation/admin-guide/perf/thunderx2-pmu.rst | 9 +++++++++
 drivers/perf/thunderx2_pmu.c                     | 3 ++-
 include/linux/perf_event.h                       | 1 +
 kernel/events/core.c                             | 8 ++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

--=20
2.17.1

