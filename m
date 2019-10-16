Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DFFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CC920872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="pnCk7QO6";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="epMkp9xW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392014AbfJPJhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:37:16 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:27872 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbfJPJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:37:13 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G9Zei4031114;
        Wed, 16 Oct 2019 02:37:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=E0tQHxYTU7wGp1xuTZTix/rEzce41OQ3IF7xlkyhkoQ=;
 b=pnCk7QO6DOoH1vyfQefapJJQXLP1hCFb3qaasoQu3owZ4PkZ0KLD3jXM+jnLFoscduBI
 QK5PFA+Bw9w0GvygykvDCe2Ed1zXeHDRK3PAP0TqXjZWkmBqWaVnZ6WkS3L7rtTe3u2G
 SiwVrnmUxmszvVpXzu3QzU9VI6VSMD9ZDLA+pqWHU4ybP7wDIGB8H4+VbhihwLI4qKWK
 Pcg8coETSgDf+tvxPRF2x/lGckY53jVGiQnNuRg5n1CUKLEs+i6qwl/MZANsno0QEeIm
 YLGJlDo2amYjW6PmqPr1oTU5U3byJOmCENkpGLMcYx+T2TUqSwGlx3WXkqH0gjuSshZE YA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vkebp5x7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 02:37:03 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 02:37:01 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Oct 2019 02:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3gAYIZp4cQpJkREZE1z5Wm+MpeElWNhoVuSrxJgoBs5vF7DNeLPDG+lYQMGjGUUxSxMdr8kDiuC8xTRaPF4Dm1+4Y6FOV5klE7XKA/RQf6lEkBFpyfJZg4RaJ347r4wMlWtWJuxT49/abtKaXeL1sfSDLWKIN+Dp0tcG5/d2fFOHAneuJm88bEpir5lTmwKS0jqMojzGsPOJpDNnPShtIOLfCEef4GZZ8lj789oi1HMN+DKRqYPgjlPcqyVPAcK8yetKxaVY1W3n31ZXnFKqqaU+84qUIxjdCQU50vquM0e7CPbkBYzzLiehnfbpYLVrwxAsPHusV4B+8nww0Au5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0tQHxYTU7wGp1xuTZTix/rEzce41OQ3IF7xlkyhkoQ=;
 b=UeE0o962R+860RnPIHAF0MHSes8kmN1ztOnEcmMueVXbPdZkGu3tl6BzxjiEDp2bO9dbk1x6P/ghFyWDbn+mh2ZiVdjTWp2rnwMTMj4u7JPJZWuCrpNs8esYJJ1L5ydzrb2wkyWqbgY8so8M9uC4JcVmK1EdhkqaRCUad3ynN7KHK3kQ+sjqJ7U7iXyAKVVbA2g1oNJOHKd1cpsi0GSd6Hh2QushKORbwQzbMZG1Fbv8yK69O6+oDBk71I2ctQs4T/lq9ljOKeDBaoRdzoP9zUceVnkWo2F16zc3PyApQA3zU3JzG6EVN1qjvdzuRQaR9bMOrkFNw8OanC+DsvTcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0tQHxYTU7wGp1xuTZTix/rEzce41OQ3IF7xlkyhkoQ=;
 b=epMkp9xWDJ1aMNi2VB5rq5Gju+K759nAUuKpJpFyCS8qvNXoc5O50HxI97Rdm/ix47O4Lxlt3LUMj6rJMO4sb+IfvFqI5xyS80A81Ay58Lqmojz7OJemJGmd81wnT14dX0GpEIr9P8q9j50qb2iC1KygKw/XGWfBTxZjGD6qyNs=
Received: from BN8PR18MB2868.namprd18.prod.outlook.com (20.179.74.155) by
 BN8PR18MB2691.namprd18.prod.outlook.com (20.179.75.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 09:36:59 +0000
Received: from BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::ec84:ac37:d96a:5aa4]) by BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::ec84:ac37:d96a:5aa4%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 09:36:59 +0000
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
Subject: [PATCH v6 1/2] Documentation: perf: Update documentation for
 ThunderX2 PMU uncore driver
Thread-Topic: [PATCH v6 1/2] Documentation: perf: Update documentation for
 ThunderX2 PMU uncore driver
Thread-Index: AQHVhAVBFz8G4YJoSEiA68kocErUlA==
Date:   Wed, 16 Oct 2019 09:36:59 +0000
Message-ID: <1571218608-15933-2-git-send-email-gkulkarni@marvell.com>
References: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
In-Reply-To: <1571218608-15933-1-git-send-email-gkulkarni@marvell.com>
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
x-ms-office365-filtering-correlation-id: 03b4b900-f3b2-455a-0e1f-08d7521c6449
x-ms-traffictypediagnostic: BN8PR18MB2691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR18MB269167FD6243B517965A82AAB2920@BN8PR18MB2691.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(110136005)(6512007)(4720700003)(71190400001)(71200400001)(305945005)(26005)(7736002)(99286004)(52116002)(486006)(2201001)(2501003)(478600001)(54906003)(5660300002)(316002)(4326008)(36756003)(14454004)(76176011)(86362001)(256004)(66476007)(66946007)(25786009)(66446008)(64756008)(6436002)(6486002)(8936002)(66066001)(81156014)(66556008)(186003)(6506007)(476003)(102836004)(2616005)(446003)(50226002)(2906002)(386003)(8676002)(11346002)(81166006)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2691;H:BN8PR18MB2868.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKrM8nxk3ny7oW5Es2xXNFSMvK8scAzSkXQmZe0miumXUiGNPOawW81jrZKZDoNcJi5PszgWPrTHlfWo7CYohIKSaUFl+HLYzwr4VOduXEp7D4BToJ02FhTPefQz/tlDfpMY0ARTqNLPhEP6gC9Th8N3fqnO/ZY7TnC9J08loaGic4u5O01immjD8rvYwUkGZUQpes3SU+JkH1z33JjV3wDOP+0APqdQP2btiKkKrjmTFf2ZecqQraQLwr+s+ToQr/8KxS8HQVi0lTrAD2I8mCiJ4DEd+PEHj5Cwi46oQRQzqoNXXA3Sb0D+qG54MmZ+NWffW8/5bq69WIOTbhuk/J3VxWFZvt10MtMhEB1Y8qWG0/8hSU4tyycYtzoAFVmSzZEH3feFx6ttsXNZ5UwKMkfLi3ZhMIdXoX803y5QrWM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b4b900-f3b2-455a-0e1f-08d7521c6449
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 09:36:59.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r85peYG8a2H2Qiwy+iA4sZKDMull5Ddsc2snjgg8BTTHrUXQmDURr07kTGBO8pauzMsWq78QV2iOjwZqiIKSQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2691
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Cavium Coherent Processor Interconnect (CCPI2) PMU.

Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
---
 .../admin-guide/perf/thunderx2-pmu.rst        | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/perf/thunderx2-pmu.rst b/Documentati=
on/admin-guide/perf/thunderx2-pmu.rst
index 08e33675853a..01f158238ae1 100644
--- a/Documentation/admin-guide/perf/thunderx2-pmu.rst
+++ b/Documentation/admin-guide/perf/thunderx2-pmu.rst
@@ -3,24 +3,26 @@ Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNC=
ORE)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The ThunderX2 SoC PMU consists of independent, system-wide, per-socket
-PMUs such as the Level 3 Cache (L3C) and DDR4 Memory Controller (DMC).
+PMUs such as the Level 3 Cache (L3C), DDR4 Memory Controller (DMC) and
+Cavium Coherent Processor Interconnect (CCPI2).
=20
 The DMC has 8 interleaved channels and the L3C has 16 interleaved tiles.
 Events are counted for the default channel (i.e. channel 0) and prorated
 to the total number of channels/tiles.
=20
-The DMC and L3C support up to 4 counters. Counters are independently
-programmable and can be started and stopped individually. Each counter
-can be set to a different event. Counters are 32-bit and do not support
-an overflow interrupt; they are read every 2 seconds.
+The DMC and L3C support up to 4 counters, while the CCPI2 supports up to 8
+counters. Counters are independently programmable to different events and
+can be started and stopped individually. None of the counters support an
+overflow interrupt. DMC and L3C counters are 32-bit and read every 2 secon=
ds.
+The CCPI2 counters are 64-bit and assumed not to overflow in normal operat=
ion.
=20
 PMU UNCORE (perf) driver:
=20
 The thunderx2_pmu driver registers per-socket perf PMUs for the DMC and
-L3C devices.  Each PMU can be used to count up to 4 events
-simultaneously. The PMUs provide a description of their available events
-and configuration options under sysfs, see
-/sys/devices/uncore_<l3c_S/dmc_S/>; S is the socket id.
+L3C devices.  Each PMU can be used to count up to 4 (DMC/L3C) or up to 8
+(CCPI2) events simultaneously. The PMUs provide a description of their
+available events and configuration options under sysfs, see
+/sys/devices/uncore_<l3c_S/dmc_S/ccpi2_S/>; S is the socket id.
=20
 The driver does not support sampling, therefore "perf record" will not
 work. Per-task perf sessions are also not supported.
--=20
2.17.1

