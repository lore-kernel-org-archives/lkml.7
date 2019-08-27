Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A42C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3285F2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Xq531Xbh";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ZUasNuDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfH0KAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:00:32 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33496 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727633AbfH0KA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:00:29 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7R9nwhs032750;
        Tue, 27 Aug 2019 03:00:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=/iU7iI3pKjLZg0eGCen/fo3NUic6/+D10tVKPiqxUuc=;
 b=Xq531Xbh20tHWxuX0UYtzsIe6viBdh7ZEkwlGlDtnClfz4wjOZyfIByDVrrOaivD/A1Z
 KsBJVgvdMKeX+tPkvn7xDWzv96RYRHYLs+6WXyrTgO1aA+0VW0JTWV35Cwo0F2OZYqK2
 2N0MeU6liIpOabUHU6Ws1VShZ9NTnl+H9MMjb+dwjnjFuJQwGYa0nbEis4zTak3N1JHZ
 XzKSXYz4ll0vP6H8gAwxCb/vPGPujzpE3SMUn+yE7+XEh8onHaxaNEmkraEM2/5mcKng
 jlellzpFDczwVflyG6c/HgYFRS7bHy54ipFxHIAkD5fdmfG+6cYF2qbLGXuna9pqn9K+ zQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uk2kq2xs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 03:00:16 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 27 Aug
 2019 03:00:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 27 Aug 2019 03:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8n99jig14zNvWwyAU2XbAy3+QzlgFqsNz0JbFtAv1aZUpJ5CoiVGrQBF/DRcq/sE00H0dtl2kdCR/E9DKSvfXvBbHxay+W2eMuVyQ8wD3U8niznWunkA9QUAddGyLjvX5B8wHaF4zgOhYXxPntF9g/AkOiafqNg3sHdXaUN/QD/4TLNanUL9KdjCa3nUOtuLxfOemwbpxS9VTh5SB273PqCSEdDcpRffZ2nmLPBNFGhIZu4Hfnqqg9o/rrqMzgs8gzhtnSVOMx+m8ZqyDy9fO+eCykbyhSj0i+F3dq6C1LOk2GUPXRCuN8jmBmDLg4AfVDqyTgRZ7gWG+jzQmz6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iU7iI3pKjLZg0eGCen/fo3NUic6/+D10tVKPiqxUuc=;
 b=RU4uywvB5tKgyaPxcXfzoToxZgjNWJgkYi91+OdTquOxP3nhTgdMFFhnxRQ/Z3iTU3VTjrwCCbKdgUxnG/SMIxwgkNGydYMbIrlYhEikRaIjXStG42+pFFrepUWAS78qZKO6H7casuAu172109wfFh/NYWYTeH8gRrcOivkBzAJYnJ+ZWyyrlfNuKWWeicIxnguZiJ3tx67x2YyvmMZ1PIQAakRqFgdaR4AgDloo/4/IKsJtzx0VcgWe+af3Ut9AGETPn+ylZRC01Z43BFjrOvvUYOSqDLVjWtN8F8MBcuMwmYbdCxoorzSaffl5y2nYNnjOuZQsucDc89U/JqGL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iU7iI3pKjLZg0eGCen/fo3NUic6/+D10tVKPiqxUuc=;
 b=ZUasNuDOAdL5UjHjn38FFcsbGTnR1udXVSoUVdqrVweF6dc7mw9/ajxuFSD01Rp6GD9fLAzQTV0D7kQDMx1la0hAVpNR7M+Ux+RddcU+BkWH+OPGQku4DQbn7I+uqgJoSGUkSUtyJi+lvvC9mZi7XGTV75zJRIX0uiMHXZcv6YQ=
Received: from DM5PR18MB1355.namprd18.prod.outlook.com (10.175.223.16) by
 DM5PR18MB1675.namprd18.prod.outlook.com (10.175.224.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 10:00:13 +0000
Received: from DM5PR18MB1355.namprd18.prod.outlook.com
 ([fe80::3cbf:34d2:5b36:e127]) by DM5PR18MB1355.namprd18.prod.outlook.com
 ([fe80::3cbf:34d2:5b36:e127%12]) with mapi id 15.20.2199.021; Tue, 27 Aug
 2019 10:00:13 +0000
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
Subject: [PATCH v4 0/2] Add CCPI2 PMU support
Thread-Topic: [PATCH v4 0/2] Add CCPI2 PMU support
Thread-Index: AQHVXL44UOusZkT+Ik+fktleifcBOA==
Date:   Tue, 27 Aug 2019 10:00:13 +0000
Message-ID: <1566899990-18277-1-git-send-email-gkulkarni@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To DM5PR18MB1355.namprd18.prod.outlook.com
 (2603:10b6:3:14a::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97eebb8e-6b6b-40f7-408a-08d72ad55a6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR18MB1675;
x-ms-traffictypediagnostic: DM5PR18MB1675:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB1675EC05E4B297033A71B6B2B2A00@DM5PR18MB1675.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7736002)(8936002)(6306002)(305945005)(4720700003)(8676002)(50226002)(81166006)(81156014)(66476007)(66446008)(5660300002)(64756008)(66556008)(6486002)(4326008)(966005)(2501003)(102836004)(14454004)(386003)(6506007)(26005)(186003)(6436002)(99286004)(6512007)(52116002)(86362001)(2201001)(110136005)(53936002)(256004)(486006)(54906003)(316002)(6116002)(3846002)(4744005)(66946007)(25786009)(476003)(71190400001)(71200400001)(14444005)(36756003)(66066001)(478600001)(2616005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1675;H:DM5PR18MB1355.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h1Xg4CbwAKfBDOhll5JtQ/EXfrS0jZjIT0+k2zZxopN8bgVAlgQn4ceE7hMB0ZpqgLitg9ZS+PDfORsmQI1PajhTy2m/C5y+jPlvErDzYRfJz9P55CiDiPVlKbk7sz76HX74crHYNwINE93JoDORL1UI2GPOnZr0qhGlleFFQbMaH65M/uFM3HjtbIF+8nKzBF3ZsqBrQ/+57lJCJcbakEoiceOBqo3aNCAB+SVtEZixhwJCc62e1eZuA52mLwqkt9npRgUtcf/Iir0kDHcHE8DgI1qfRrk5t/AoSqZQKXH+X2W1G1nWh+9Tp0goKCCv/nAr34/7n6glfAPN8Uz5o2uBKoNEBuYFTg/5SP76mkY3py/XuCem5GJEoDru8GQc7uN2ws5NkQ+oEW9sKklxXzZBn+b69vey8d8FiSt4c6U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eebb8e-6b6b-40f7-408a-08d72ad55a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 10:00:13.3004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rh3yi0c2uVUqNgPPbXUl5bRh5lM4bJ4XnNk9mpr1BEnWBM4gZDEyMDYRz9aJ3gvXK6XSR6tHHmhBkXvjxVkp5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1675
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_01:2019-08-26,2019-08-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cavium Coherent Processor Interconnect (CCPI2) PMU
support in ThunderX2 Uncore driver.

v4:
	Update with review comments [2].
	Changed Counter read to 2 word read since single dword read is misbhehavin=
g(hw issue).

[2] https://lkml.org/lkml/2019/7/23/231

v3: Rebased to 5.3-rc1

v2: Updated with review comments [1]

[1] https://lkml.org/lkml/2019/6/14/965

v1: initial patch

Ganapatrao Kulkarni (2):
  Documentation: perf: Update documentation for ThunderX2 PMU uncore
    driver
  drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.

 .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
 drivers/perf/thunderx2_pmu.c                  | 258 +++++++++++++++---
 2 files changed, 236 insertions(+), 42 deletions(-)

--=20
2.17.1

