Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA638C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA090227B9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="w95q/KPV";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="HQDCxY3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbfGWJQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:16:43 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6086 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729835AbfGWJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:16:42 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6N9G1Sp008728;
        Tue, 23 Jul 2019 02:16:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=qt8c3ElhlGngqt0QiopqkG6QiD7qwns2bpsje14B8To=;
 b=w95q/KPVhtJF4NAp+Zoq6MLrwBvrapQmoE6NPPbuWsS6PARP4MDbpLbP4w8VdS5qGOjg
 HpzBWYTHGWuwYArMFMs+anK8cuFLSih3HxW+AW9eNFti3ToEXLePPo34XyS7U8iRKt4H
 Dym9GyS+e3xvuWZEA7UGDLf6mRGP6bOzt/04jOI2frz8bmeSTpXJ6MSd7pH2Fa1QL3/H
 Bpw1RRLbs2z7Z2T9SfZ5smZN+OoPwxb2+NKAScIeIjZeFcKl1pZbQRnIUk649yX6dx30
 4iZFhy2NsfJhEGGIqMAcBQR6g2skpE8BjPAwuOPFH9K9+U3Jc5QULqLY1HMvGlY7FcXv 4Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tv0ap31k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Jul 2019 02:16:30 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 23 Jul
 2019 02:16:29 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 23 Jul 2019 02:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crwgaoNOivTI8Tg69Qv+sFIBnSM3GRb3TipoZZtYtZNZhzYjxTKRC1CebQUpf7Tb0hIHDdJs7hK3IVYaPt2/q+hhhwCdA94EoVxmR0LaV+Pe9e/zthZNvKY0bWBooxToQ86s5cXR5JygBEQENolbZke9f+BpLh0A0Iu6AO4xIcgnWbrjJNVWnw7KMc4pFcxPhh+aYrN+kPjU8lM1LtXMgRKpeSEyt06fizcfF4uGhYwC2TmiOzZ5P2h3+hZ9O1U5qvyrETV5r9Ui6QQPuf0bdUT1K9md9KqIXvBswBi7r7HmDNmPFTSt2cXBNYh/dFoQ7LvUQQkkTMoUBXaI7k5K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt8c3ElhlGngqt0QiopqkG6QiD7qwns2bpsje14B8To=;
 b=hnh0iRW3zfMP1zuaoMR1RaSkapnJXIsLgN4+I1Io13ehN5RG5kggIZ0YM2K4vqIrf/mSkIRF33d9n/FZshgbSJb+jjKbKMPE3L+P8slbdr+CuKONS4P9WUon/chj8uDFG2N0Ps05UOrrSYkquKTjHe8Y18iIRxxHN2KJr1Z6FrHbpS1HWgecA7+k1V0uHEQRvPVkDgBHqFeG4cpd8Nndejtbbef88hj7F+AMrad9MUjKK6d1g8A7ZXdvjim8bydSbLKkb2HvHkI/rmyQyTMRMMuoDnGhduL6fYur9RIPiJHBuQA9mx5l3VzYbw1TsPaTD3kRqzGpbRSFHIGrfX47cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt8c3ElhlGngqt0QiopqkG6QiD7qwns2bpsje14B8To=;
 b=HQDCxY3uZ8Qg1fWyazuk3e54DcbGxO5XrVQZVRLh6+s36mGviDbpa7suhQ4b5W8Lg2ERmBWAWCqqsX6WpZipW2IRpdWvGPQS/akJlTQeqGbYGqktq+kxzfCMz+j00qgc2EI/A5DDQmv7hsuoQxDBVRgQXUTINnMbFWAwG5CXWNc=
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com (10.164.205.31) by
 MWHPR1801MB1824.namprd18.prod.outlook.com (10.164.206.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 23 Jul 2019 09:16:27 +0000
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::5a8:540b:6bb7:fa20]) by MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::5a8:540b:6bb7:fa20%7]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 09:16:27 +0000
From:   Ganapatrao Kulkarni <gkulkarni@marvell.com>
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
Subject: [PATCH v3 0/2] Add CCPI2 PMU support
Thread-Topic: [PATCH v3 0/2] Add CCPI2 PMU support
Thread-Index: AQHVQTdOEmxlzAzPyk6oJIT2KNx3fg==
Date:   Tue, 23 Jul 2019 09:16:27 +0000
Message-ID: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To MWHPR1801MB2030.namprd18.prod.outlook.com
 (2603:10b6:301:69::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07582b69-399d-4b05-1f49-08d70f4e70df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR1801MB1824;
x-ms-traffictypediagnostic: MWHPR1801MB1824:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR1801MB1824801D5978E4A4EC95C931B2C70@MWHPR1801MB1824.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(2616005)(36756003)(6436002)(8676002)(476003)(6486002)(6506007)(5660300002)(68736007)(102836004)(2906002)(7736002)(6116002)(2501003)(66946007)(3846002)(66476007)(66556008)(8936002)(305945005)(64756008)(66446008)(186003)(26005)(386003)(52116002)(81166006)(81156014)(50226002)(966005)(6306002)(71200400001)(71190400001)(4744005)(256004)(2201001)(99286004)(14444005)(486006)(478600001)(54906003)(110136005)(316002)(14454004)(4720700003)(66066001)(53936002)(86362001)(25786009)(6512007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1801MB1824;H:MWHPR1801MB2030.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k180eUyD83aMxP6evTKZNRSN8rvfQFdx0Mseq2pg6C7z5FXpLqVd7xvZ2bzkfuqfjGHCfOsWYyXbpabJfiNj/mxPI8Tx/9vzdtlFJnvgd8CKlaGhTFnn+OWLDyoTwpa0ybbDjjEkf0coYq2xoqPno3G1L0jvqiRKPKB8xP3Ttfnk5KZIcR5Zu4sgMa7iteUlZsMi1Zp4H0zW+Fi+F6QVjBTvb3DwwXHpEl5Eih73+MbmF1AQalYQdLIml8jY21WpY1B1iPTghAUKRXo+H/xoW8JZ5tJ2NpSiexB3EKWG3hvQcKi8lT5zYhltfVMajG1sqArMqzzQhQRJ1XvwwGgVje+R88nCFaKmWlKNKaIDYojRkfScw7gXI9ExqaClRofYpajc77QqdBBZsrodtArE7RmVkYXuDL+xYG1XpmaQpOs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07582b69-399d-4b05-1f49-08d70f4e70df
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 09:16:27.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkulkarni@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB1824
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-23_05:2019-07-23,2019-07-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cavium Coherent Processor Interconnect (CCPI2) PMU
support in ThunderX2 Uncore driver.

v3: Rebased to 5.3-rc1

v2: Updated with review comments [1]

[1] https://lkml.org/lkml/2019/6/14/965

v1: initial patch

Ganapatrao Kulkarni (2):
  Documentation: perf: Update documentation for ThunderX2 PMU uncore
    driver
  drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.

 .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
 drivers/perf/thunderx2_pmu.c                  | 248 +++++++++++++++---
 2 files changed, 225 insertions(+), 43 deletions(-)

--=20
2.17.1

