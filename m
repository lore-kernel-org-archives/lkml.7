Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B64C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240B218C5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SqOzIjS8";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="j7h9ExJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfGEJOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:14:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13054 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727565AbfGEJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:14:32 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6596Al2025365;
        Fri, 5 Jul 2019 02:13:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=1fvGHigX+JPbD17m06eLJdyTZyDdNNkwbNVO9U/U+Uw=;
 b=SqOzIjS8/YV+997kE368ssNutPLoKWBKmGBrn6R7KbjR3sU3qQTALlINnYLaDQ7bCA3Q
 U0KvSWlnMMY4B4Tz8Zfc7kcTFifoQNbCH+K0Ji3eMmhLoaLy87t/ivXoVRrHygt6OXUh
 kP9mFelqvLgP1/d8d062FLp5UrySUasMGssW0RR8DtDN4608BSA1SUfjmKHzI9BHTCC7
 YLu6eGIDSvSIJPKfXteromWlJ1H3W7592micSVRHqzVZKNJbBnuDPq8DZImNcwpA66Cl
 7OTE8G3BMWAsJFM0uIr2n5KlfEXB0JUPz7b6G1bugidjBfyewhM8ZCqevMT2BlQB7Bm6 Xg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2thjyrb616-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 02:13:03 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 5 Jul
 2019 02:13:01 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 02:13:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fvGHigX+JPbD17m06eLJdyTZyDdNNkwbNVO9U/U+Uw=;
 b=j7h9ExJglelgMPdnu2pQ1STeeEG92SJC2PwoXPW/PcYQkhsQAkzqPg0bbr5yf4nPoEwHVsgbFfrJQ3LwQxe+LpL+0CQ2n7efxXfm7lk3m3Fm4mDQZOb96Cu85qICWTOrF6BRS1eRGSZf3hNzg1gjRnsZ4o+McwwdG04njV102sY=
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com (10.164.205.31) by
 MWHPR1801MB1982.namprd18.prod.outlook.com (10.164.205.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 09:12:55 +0000
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::5a8:540b:6bb7:fa20]) by MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::5a8:540b:6bb7:fa20%7]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 09:12:55 +0000
From:   Ganapatrao Kulkarni <gkulkarni@marvell.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        "rrichter@marvell.coma" <rrichter@marvell.coma>,
        Jan Glauber <jglauber@marvell.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: [PATCH v2 0/2] Add CCPI2 PMU support
Thread-Topic: [PATCH v2 0/2] Add CCPI2 PMU support
Thread-Index: AQHVMxHU8ANznhvUkUSheWYP9y2KJA==
Date:   Fri, 5 Jul 2019 09:12:55 +0000
Message-ID: <1562317967-16329-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:74::44) To MWHPR1801MB2030.namprd18.prod.outlook.com
 (2603:10b6:301:69::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0bc1f7d-7a41-4620-fc48-08d70128f707
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR1801MB1982;
x-ms-traffictypediagnostic: MWHPR1801MB1982:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR1801MB1982735BFCD59BD8C48ECF87B2F50@MWHPR1801MB1982.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39850400004)(396003)(346002)(136003)(189003)(199004)(14454004)(2616005)(4744005)(6436002)(66066001)(2501003)(4720700003)(36756003)(4326008)(50226002)(256004)(14444005)(478600001)(3846002)(6116002)(966005)(52116002)(7736002)(99286004)(486006)(476003)(6306002)(186003)(6512007)(305945005)(25786009)(26005)(386003)(6506007)(6486002)(102836004)(54906003)(110136005)(71200400001)(71190400001)(5660300002)(53936002)(8936002)(68736007)(316002)(81166006)(86362001)(2201001)(81156014)(73956011)(8676002)(64756008)(66946007)(66556008)(66446008)(2906002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1801MB1982;H:MWHPR1801MB2030.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KiBH4Ki+SBNtSwq6lQoG3/ZbGpsFbjZoocvMqzn7iU+91du0WrvpQICSSiFeaWrXtzQ571/56BBwAu6ZmONdo+AR1w/qMnDI6ZCu4KV1JJayRnpczpntPKvlK1EccDaa2zRRRQi3BJski2K16zDsw4Yp4e8br/p6l42FOh2Wd7tBldfvxQCu2o65BI56ONnu9CHUjQtC7xNZ99gRVZW/HZrMSCw2JPZzKyvGqW/FAZHgn+gEj6fZ4P2kRu16A7NHZff8qREDCYGK0IwIdIaOLuy1vbHKy+MsrtESa1Hu80nmSrkqxdeuWSHwYEjez87fIJ0H6Sg5hoTM0SwdkzC6BpcHfD464ULBR6VaaKvNrKX2Vcpt90oPXEJZK7Kw8BXtgnRjJ/Ap9l0osqcw27ftuEaeCN83AQsDWW95rmAyZm4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bc1f7d-7a41-4620-fc48-08d70128f707
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 09:12:55.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkulkarni@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1982
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cavium Coherent Processor Interconnect (CCPI2) PMU
support in ThunderX2 Uncore driver.

v2: Updated with review comments [1]

[1] https://lkml.org/lkml/2019/6/14/965

v1: initial patch

Ganapatrao Kulkarni (2):
  Documentation: perf: Update documentation for ThunderX2 PMU uncore
    driver
  drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.

 Documentation/perf/thunderx2-pmu.txt |  20 ++-
 drivers/perf/thunderx2_pmu.c         | 248 +++++++++++++++++++++++----
 2 files changed, 225 insertions(+), 43 deletions(-)

--=20
2.17.1

