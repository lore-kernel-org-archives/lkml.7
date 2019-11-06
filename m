Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73217C5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5512087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 01:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="xS5Jxajz";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="ZoHVl/Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfKFBCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:02:11 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57716 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729882AbfKFBCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 20:02:11 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA611805020368;
        Tue, 5 Nov 2019 17:01:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=YSMG0ikR7PMMYVxuHfwLRQol141O7TgoCv863BMEqaM=;
 b=xS5JxajzDMd9uehRQoggGC2GpGO92wRa8nbmMHGHWZYTqDUjfThQf47/8OXrldkTt+4P
 WuirrKAmDVsl0sFkGGv3DDfGEuNIne92A+HOn/WX4f3pxM8z3rBwduT0eNdzD/0j+IBY
 cr9FJd6Le54sMxqX7NwjpP2byITGyNGx3dRU/ECFmzEiBNPGpFp8uZwDW5tmfJtypqs+
 WZ7UD/RIn+fTnLN5T/D94FBI0QsGmTs20sZJE8hRE23wwN32mKLSExSZNsBCwJ2al/1+
 zoOzyNELbAsDiaGFjMWVGpsaXhgdp7n5RMtS/eloCFiAIuy19YYG8PeXe/+hYVTE93nt FA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w19amw1vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 17:01:44 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 5 Nov
 2019 17:01:42 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 5 Nov 2019 17:01:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZGx1GqwyAv31I5/lAq6y5JJ1RrSYIvOSRK3B6eqxz40wq/Y0G6vk0tJceG4p4GQBQ7rkO/ugAVg4q7k7ichCYB2o/TV3dhpU6tG+JSLJhcVIV9Bb9EqW8FEhqYbSetSqiyC1HfEbzbgyh9Ph0RNyUeQEPHitd32+J2lCOkVvTgJKLGr3ksPn8Z08WeyzcaCdHE6K2nhjyyawqxD1bWHQZpcvArMFJElFzUjEa/PXHk15t0PkyuxtqNpxxTYJ+6TxUd5CBOPHlwBa6JgQBUqadzfgp3KuYV+8C3YtyeG/hQIPFD1LvQmG9r43OEOIwioTCm8PmaExqGcf5q1ZaCAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSMG0ikR7PMMYVxuHfwLRQol141O7TgoCv863BMEqaM=;
 b=H4ClsBybPaeB5W7+wY4jrPzuPvXU89sLD51VjBBQsodJDjJhzIvKS4N1QBZTi51EDJsLyP7LnF7Mx0KAUVKWvk8jPiXCtYHa7xg+r1jdyD2z7dRaJ5XZL6bIWrnbZvsZNg268a49OU6lyk5soJRA9FHlcLyR9cpvJBnuntqE8MBWwVXRnomOVmuKdDZTXQuJvk0nL07U3r0hKtyXu1+nTnGuGWM/iSwvBFuKsSM987mcSMenLe67fJlzu9Om2WZ0mE3ZnJfzgYm3WLI6TKfu6wIBHe/iSjW8CuFezNh719H+YTle95iuX/XATs/HDf+LhtM9gXdKNykf593CYzWAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSMG0ikR7PMMYVxuHfwLRQol141O7TgoCv863BMEqaM=;
 b=ZoHVl/AevnzlNqNDtpAjcL/QEU6IfNvm0SkLN1NNTRceqkajW6u/2mQe0puD7jKTaRo0U9917bb6Dhtr2pa468fMgL7y+Azis5ijQNJ7V7l8012y+ISoLcm1c44wDswLNUQ8ZK99kpFgRRXn8cEYXjsyHOg0M8jRu+ZIrjZtPRA=
Received: from BN8PR18MB2868.namprd18.prod.outlook.com (20.179.74.155) by
 BN8PR18MB2804.namprd18.prod.outlook.com (20.179.73.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 01:01:41 +0000
Received: from BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::431:e92e:ca76:f241]) by BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::431:e92e:ca76:f241%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:01:41 +0000
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
Subject: [PATCH 2/2] Thunderx2, uncore: Add workaround for ThunderX2 erratum
 221
Thread-Topic: [PATCH 2/2] Thunderx2, uncore: Add workaround for ThunderX2
 erratum 221
Thread-Index: AQHVlD3AjQ2M+OHOJkedwuU0meShQQ==
Date:   Wed, 6 Nov 2019 01:01:41 +0000
Message-ID: <1573002091-9744-3-git-send-email-gkulkarni@marvell.com>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
In-Reply-To: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
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
x-ms-office365-filtering-correlation-id: 261687f8-5ae6-44fd-0b7c-08d76254e26a
x-ms-traffictypediagnostic: BN8PR18MB2804:
x-microsoft-antispam-prvs: <BN8PR18MB28043AB4506181715A023788B2790@BN8PR18MB2804.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(189003)(8676002)(99286004)(81166006)(81156014)(2906002)(316002)(2501003)(50226002)(8936002)(54906003)(110136005)(3846002)(6116002)(36756003)(476003)(25786009)(14454004)(186003)(478600001)(26005)(102836004)(66066001)(386003)(6506007)(486006)(2201001)(2616005)(86362001)(11346002)(66556008)(446003)(71200400001)(71190400001)(256004)(14444005)(7736002)(305945005)(4720700003)(52116002)(66446008)(64756008)(6486002)(66476007)(66946007)(76176011)(6436002)(4326008)(6512007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2804;H:BN8PR18MB2868.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJLe4N0C4S2ke/xOEQWApotGVNBPEFCSytIQH565FjeI3Rd6Kj4OZH4s5Pe0j8+hvGPYfUTTfJi2Zqs6ro4swuej8O34EI6c+1EbVzPzH63K0cQtVovurVpYh/Y9OAN0+b+nSe4xTyMvPEwlRMe/DoqRAzkC90SSEw26VEoVxXKFmiJWEn5b2vpn7rSQln5mOBQ1yjL9EGBRTCQ57Jz02N+j30TK0d4VdL8f9XOw6+4jZ+8QAc5+Lb63C4VdtqkUdfy4bjG9tmtRLkYxPruGOcpshg3GQqR0LAXFvhuaQUXd6lkoLJt411IwBFzVMiXQ6HN85anx6lRFKcgZ+KDk6uVptDfydJC7M4JRZIBZB8Z3L8jakMm2SjcYfg/naSWvXYOlKz4fFMEINJirWi5PHyDtFpcAgtHtAMbbHH1enNWcaQ8xe58Nr/Pqm5K6mjEv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 261687f8-5ae6-44fd-0b7c-08d76254e26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:01:41.3768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOhc+LIf+BBCWLq/NAspvyflXcsu6wxQNsnL7MU1IMuhUU2PfGEeAdVbqraxhZE5befKQngI17vsKYh5CCoQ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2804
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_09:2019-11-05,2019-11-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf tried with more events than the PMU supported counters, the perf
core uses event multiplexing to accommodate all events. This results in
burst of PMU register read and writes and causes the system hang, when
executed along with the CPU intensive applications.

Adding software workaround by disabling event multiplexing.

Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
---
 Documentation/admin-guide/perf/thunderx2-pmu.rst | 9 +++++++++
 drivers/perf/thunderx2_pmu.c                     | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/thunderx2-pmu.rst b/Documentati=
on/admin-guide/perf/thunderx2-pmu.rst
index 08e33675853a..fff65382c887 100644
--- a/Documentation/admin-guide/perf/thunderx2-pmu.rst
+++ b/Documentation/admin-guide/perf/thunderx2-pmu.rst
@@ -40,3 +40,12 @@ Examples::
   uncore_l3c_0/read_hit/,\
   uncore_l3c_0/inv_request/,\
   uncore_l3c_0/inv_hit/ sleep 1
+
+ThunderX2 erratum 221:
+When perf tried with more events than the PMU supported counters, the perf=
 core
+uses event multiplexing to accommodate all events. This results in burst o=
f PMU
+registers read and write and leading to system hang when executed along wi=
th
+CPU intensive applications.
+
+
+Disabling PMUs event multiplexing capability.
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 43d76c85da56..c443be8bd449 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -563,7 +563,8 @@ static int tx2_uncore_pmu_register(
 		.start		=3D tx2_uncore_event_start,
 		.stop		=3D tx2_uncore_event_stop,
 		.read		=3D tx2_uncore_event_read,
-		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE,
+		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE |
+					PERF_PMU_CAP_NO_MUX_EVENTS,
 	};
=20
 	tx2_pmu->pmu.name =3D devm_kasprintf(dev, GFP_KERNEL,
--=20
2.17.1

