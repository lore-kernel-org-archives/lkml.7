Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F6520872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BED26fWl";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="P0vG7GuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392026AbfJPJhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:37:20 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26756 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392003AbfJPJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:37:19 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G9Zei5031114;
        Wed, 16 Oct 2019 02:37:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=ODNSfJbmsKBvTurA4VvB1m6nSH3ns9jDvfzHN042Hiw=;
 b=BED26fWl2+uek1GKAHyECAcEXGQwMLcHlCHHlHggOWhym14ted/vETRwxtnf0n19dwhZ
 f1pAJHxB0zMc1c9PgGOq5woVrHLPWJ+GjztlsXmV+q4hr9mpu4PXzUjDtrLmYbauMhvg
 YkEBaQSi9sHDn2MWJpy83e+jrpsy7RmOb3VyYHSDPxgDJhbsZBSYkii36cHnoOEjEapo
 jQb3oET99ASV5n/uGYdXbRZqBMbh0tmb2kNUTlQYTMYeaWdv5dilAWLR07mu8dsvKFXN
 cOD/fveMXHG3L2x9PxkCXbZQv5VAUuIx36s2CtlP1TwAVqSrltWqNmQw4PTj99ltADgB QA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vkebp5x7v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 02:37:04 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 16 Oct
 2019 02:37:02 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Oct 2019 02:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9GI2o/8zmsh/y5u/k8L0FbbRFSPsLlRuxSSS+qa8oG7frNo0SxGHLkrPd5YTFXtJxY8scEixNzGXHU2H/ML+A6+tW9tijH6eIitonRG48XerXwE+OdRzLRsX8Gz2POBttLtKYon0kNmjE+Mzkr/ULJxQ/IfffqVh1IjU/0kGfZXqjaQYXyo4cw2OwY+uy/k6ok+hWDd/YNqhd23J4QXs5OnnOcuUmtUxnsQrjEan1bRYFEbhdpdq0EU/wZgqrVeGll8kdmDHD57CACjfew3QKaQZf+b+kFMvpkH0KczePxMwmLd47t3m1DCtyyrurZPZMq4yUGI8tMYgGX4Cahshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODNSfJbmsKBvTurA4VvB1m6nSH3ns9jDvfzHN042Hiw=;
 b=WyEpEv2xfHbUYnWWeiF6zNF6ax+z+8nB5vjKxS1vqI/31bKFXIqsEFgPnCGnV5y2VW6q3QwaKTJ9NNir0wG8QM3Nzv2BLTvME0WPmQw+pda4fmK/JRgc3RE4RVeB9cyEvdYTQueuyhOd73humDtBGe1rnIZzrPunssP3I+6Xm3yOAlMOGoZhIYzsSGLTDiIbkimXzNsduZj6WGfazZhak3N7eXMg/joJMB9pBKKwO9aKlQ7XuQv4kD2XwN3eP0r3E0ZF4J+aBXI/gu/UhMUsFXqKLRBva/mDhlmTvumnhCiQ6JkiGuZ7vgE16WgkFxVmC3bv+s3zTNnGZ7VOMeeMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODNSfJbmsKBvTurA4VvB1m6nSH3ns9jDvfzHN042Hiw=;
 b=P0vG7GuLjJU5yiLmgV2c2uq52vLqijajLu8CO3lD2oPkv6JBR1fvwwDkIfz0f2yrmdPkkEhorYy4BwKwOWnsXnu9ObjINn/s4Eh3P/nwq5B6itXCnems0EYSra80OES8PxVudFi8kImQG8SBkeEWPyIf6NbSw664GKuXa2hPVEs=
Received: from BN8PR18MB2868.namprd18.prod.outlook.com (20.179.74.155) by
 BN8PR18MB2691.namprd18.prod.outlook.com (20.179.75.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 09:37:00 +0000
Received: from BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::ec84:ac37:d96a:5aa4]) by BN8PR18MB2868.namprd18.prod.outlook.com
 ([fe80::ec84:ac37:d96a:5aa4%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 09:37:00 +0000
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
Subject: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Thread-Topic: [PATCH v6 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Thread-Index: AQHVhAVCI6+RWkm3aEi3rZ7R7ZMAlg==
Date:   Wed, 16 Oct 2019 09:37:00 +0000
Message-ID: <1571218608-15933-3-git-send-email-gkulkarni@marvell.com>
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
x-ms-office365-filtering-correlation-id: 119e8431-7393-42c0-279b-08d7521c650f
x-ms-traffictypediagnostic: BN8PR18MB2691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR18MB2691DA8A220BC065D6BA9B15B2920@BN8PR18MB2691.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(110136005)(6512007)(4720700003)(71190400001)(71200400001)(305945005)(26005)(7736002)(99286004)(52116002)(486006)(2201001)(2501003)(478600001)(54906003)(5660300002)(316002)(4326008)(36756003)(30864003)(14454004)(76176011)(86362001)(256004)(66476007)(66946007)(25786009)(66446008)(64756008)(14444005)(6436002)(6486002)(8936002)(66066001)(81156014)(66556008)(186003)(6506007)(476003)(102836004)(2616005)(446003)(50226002)(2906002)(386003)(8676002)(11346002)(81166006)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR18MB2691;H:BN8PR18MB2868.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TfPrOfgGmT/vqfqpDm1G9MVOMOKBXcvRkE8fhiq/Wdce+durg6ZmFlj+F6PhvNXLizxXPoXYH7lR89RsHfPmTYg014YAcOXHCISEQhLvbk5Wm7qF8gWVnNgy4n6ibfPo9mBzLeHHBiU9RISk7MJPWNyiFlXm69NDUPyVKVI1C51yzY09R97ePFY8e49QL7OCzoHOgYUQ+z3hVhzsdtFK8lS3PeXe8k9LlN8DW7SklrhZN04ywxsdhFfk+YePnb7G+FYWHq9INjFKvNRWheDylQRmAbOGIdQamNIxMla0RYHhSH8q8JpRMSQFwAj5TS/ZV/WmcnjfxRyhUzjjIJ54ATxwhi4OCIQiFv9R20XDZIiTISM+vFQBnl7px2EUiV5emn1bVUapdcMaA1gSjv0yw+j1FPT/eu/4ABagsj59WIo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 119e8431-7393-42c0-279b-08d7521c650f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 09:37:00.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nq/yCgEKpxDpm0D1IG/B+HQ5CUuIAw8zjIQVwxxUJC0cCurXhbf8cd63oDIULKQLzNkigEAHpF5WA8G6EFG+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR18MB2691
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_03:2019-10-15,2019-10-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCPI2 is a low-latency high-bandwidth serial interface for inter socket
connectivity of ThunderX2 processors.

CCPI2 PMU supports up to 8 counters per socket. Counters are
independently programmable to different events and can be started and
stopped individually. The CCPI2 counters are 64-bit and do not overflow
in normal operation.

Signed-off-by: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
---
 drivers/perf/thunderx2_pmu.c | 267 ++++++++++++++++++++++++++++++-----
 1 file changed, 234 insertions(+), 33 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 43d76c85da56..51b31d6ff2c4 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -16,23 +16,36 @@
  * they need to be sampled before overflow(i.e, at every 2 seconds).
  */
=20
-#define TX2_PMU_MAX_COUNTERS		4
+#define TX2_PMU_DMC_L3C_MAX_COUNTERS	4
+#define TX2_PMU_CCPI2_MAX_COUNTERS	8
+#define TX2_PMU_MAX_COUNTERS		TX2_PMU_CCPI2_MAX_COUNTERS
+
+
 #define TX2_PMU_DMC_CHANNELS		8
 #define TX2_PMU_L3_TILES		16
=20
 #define TX2_PMU_HRTIMER_INTERVAL	(2 * NSEC_PER_SEC)
-#define GET_EVENTID(ev)			((ev->hw.config) & 0x1f)
-#define GET_COUNTERID(ev)		((ev->hw.idx) & 0x3)
+#define GET_EVENTID(ev, mask)		((ev->hw.config) & mask)
+#define GET_COUNTERID(ev, mask)		((ev->hw.idx) & mask)
  /* 1 byte per counter(4 counters).
   * Event id is encoded in bits [5:1] of a byte,
   */
 #define DMC_EVENT_CFG(idx, val)		((val) << (((idx) * 8) + 1))
=20
+/* bits[3:0] to select counters, are indexed from 8 to 15. */
+#define CCPI2_COUNTER_OFFSET		8
+
 #define L3C_COUNTER_CTL			0xA8
 #define L3C_COUNTER_DATA		0xAC
 #define DMC_COUNTER_CTL			0x234
 #define DMC_COUNTER_DATA		0x240
=20
+#define CCPI2_PERF_CTL			0x108
+#define CCPI2_COUNTER_CTL		0x10C
+#define CCPI2_COUNTER_SEL		0x12c
+#define CCPI2_COUNTER_DATA_L		0x130
+#define CCPI2_COUNTER_DATA_H		0x134
+
 /* L3C event IDs */
 #define L3_EVENT_READ_REQ		0xD
 #define L3_EVENT_WRITEBACK_REQ		0xE
@@ -51,15 +64,28 @@
 #define DMC_EVENT_READ_TXNS		0xF
 #define DMC_EVENT_MAX			0x10
=20
+#define CCPI2_EVENT_REQ_PKT_SENT	0x3D
+#define CCPI2_EVENT_SNOOP_PKT_SENT	0x65
+#define CCPI2_EVENT_DATA_PKT_SENT	0x105
+#define CCPI2_EVENT_GIC_PKT_SENT	0x12D
+#define CCPI2_EVENT_MAX			0x200
+
+#define CCPI2_PERF_CTL_ENABLE		BIT(0)
+#define CCPI2_PERF_CTL_START		BIT(1)
+#define CCPI2_PERF_CTL_RESET		BIT(4)
+#define CCPI2_EVENT_LEVEL_RISING_EDGE	BIT(10)
+#define CCPI2_EVENT_TYPE_EDGE_SENSITIVE	BIT(11)
+
 enum tx2_uncore_type {
 	PMU_TYPE_L3C,
 	PMU_TYPE_DMC,
+	PMU_TYPE_CCPI2,
 	PMU_TYPE_INVALID,
 };
=20
 /*
- * pmu on each socket has 2 uncore devices(dmc and l3c),
- * each device has 4 counters.
+ * Each socket has 3 uncore devices associated with a PMU. The DMC and
+ * L3C have 4 32-bit counters and the CCPI2 has 8 64-bit counters.
  */
 struct tx2_uncore_pmu {
 	struct hlist_node hpnode;
@@ -69,8 +95,10 @@ struct tx2_uncore_pmu {
 	int node;
 	int cpu;
 	u32 max_counters;
+	u32 counters_mask;
 	u32 prorate_factor;
 	u32 max_events;
+	u32 events_mask;
 	u64 hrtimer_interval;
 	void __iomem *base;
 	DECLARE_BITMAP(active_counters, TX2_PMU_MAX_COUNTERS);
@@ -79,6 +107,7 @@ struct tx2_uncore_pmu {
 	struct hrtimer hrtimer;
 	const struct attribute_group **attr_groups;
 	enum tx2_uncore_type type;
+	enum hrtimer_restart (*hrtimer_callback)(struct hrtimer *cb);
 	void (*init_cntr_base)(struct perf_event *event,
 			struct tx2_uncore_pmu *tx2_pmu);
 	void (*stop_event)(struct perf_event *event);
@@ -92,7 +121,21 @@ static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(str=
uct pmu *pmu)
 	return container_of(pmu, struct tx2_uncore_pmu, pmu);
 }
=20
-PMU_FORMAT_ATTR(event,	"config:0-4");
+#define TX2_PMU_FORMAT_ATTR(_var, _name, _format)			\
+static ssize_t								\
+__tx2_pmu_##_var##_show(struct device *dev,				\
+			       struct device_attribute *attr,		\
+			       char *page)				\
+{									\
+	BUILD_BUG_ON(sizeof(_format) >=3D PAGE_SIZE);			\
+	return sprintf(page, _format "\n");				\
+}									\
+									\
+static struct device_attribute format_attr_##_var =3D			\
+	__ATTR(_name, 0444, __tx2_pmu_##_var##_show, NULL)
+
+TX2_PMU_FORMAT_ATTR(event, event, "config:0-4");
+TX2_PMU_FORMAT_ATTR(event_ccpi2, event, "config:0-9");
=20
 static struct attribute *l3c_pmu_format_attrs[] =3D {
 	&format_attr_event.attr,
@@ -104,6 +147,11 @@ static struct attribute *dmc_pmu_format_attrs[] =3D {
 	NULL,
 };
=20
+static struct attribute *ccpi2_pmu_format_attrs[] =3D {
+	&format_attr_event_ccpi2.attr,
+	NULL,
+};
+
 static const struct attribute_group l3c_pmu_format_attr_group =3D {
 	.name =3D "format",
 	.attrs =3D l3c_pmu_format_attrs,
@@ -114,6 +162,11 @@ static const struct attribute_group dmc_pmu_format_att=
r_group =3D {
 	.attrs =3D dmc_pmu_format_attrs,
 };
=20
+static const struct attribute_group ccpi2_pmu_format_attr_group =3D {
+	.name =3D "format",
+	.attrs =3D ccpi2_pmu_format_attrs,
+};
+
 /*
  * sysfs event attributes
  */
@@ -164,6 +217,19 @@ static struct attribute *dmc_pmu_events_attrs[] =3D {
 	NULL,
 };
=20
+TX2_EVENT_ATTR(req_pktsent, CCPI2_EVENT_REQ_PKT_SENT);
+TX2_EVENT_ATTR(snoop_pktsent, CCPI2_EVENT_SNOOP_PKT_SENT);
+TX2_EVENT_ATTR(data_pktsent, CCPI2_EVENT_DATA_PKT_SENT);
+TX2_EVENT_ATTR(gic_pktsent, CCPI2_EVENT_GIC_PKT_SENT);
+
+static struct attribute *ccpi2_pmu_events_attrs[] =3D {
+	&tx2_pmu_event_attr_req_pktsent.attr.attr,
+	&tx2_pmu_event_attr_snoop_pktsent.attr.attr,
+	&tx2_pmu_event_attr_data_pktsent.attr.attr,
+	&tx2_pmu_event_attr_gic_pktsent.attr.attr,
+	NULL,
+};
+
 static const struct attribute_group l3c_pmu_events_attr_group =3D {
 	.name =3D "events",
 	.attrs =3D l3c_pmu_events_attrs,
@@ -174,6 +240,11 @@ static const struct attribute_group dmc_pmu_events_att=
r_group =3D {
 	.attrs =3D dmc_pmu_events_attrs,
 };
=20
+static const struct attribute_group ccpi2_pmu_events_attr_group =3D {
+	.name =3D "events",
+	.attrs =3D ccpi2_pmu_events_attrs,
+};
+
 /*
  * sysfs cpumask attributes
  */
@@ -213,6 +284,13 @@ static const struct attribute_group *dmc_pmu_attr_grou=
ps[] =3D {
 	NULL
 };
=20
+static const struct attribute_group *ccpi2_pmu_attr_groups[] =3D {
+	&ccpi2_pmu_format_attr_group,
+	&pmu_cpumask_attr_group,
+	&ccpi2_pmu_events_attr_group,
+	NULL
+};
+
 static inline u32 reg_readl(unsigned long addr)
 {
 	return readl((void __iomem *)addr);
@@ -245,33 +323,58 @@ static void init_cntr_base_l3c(struct perf_event *eve=
nt,
 		struct tx2_uncore_pmu *tx2_pmu)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
+	u32 cmask;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	cmask =3D tx2_pmu->counters_mask;
=20
 	/* counter ctrl/data reg offset at 8 */
 	hwc->config_base =3D (unsigned long)tx2_pmu->base
-		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event));
+		+ L3C_COUNTER_CTL + (8 * GET_COUNTERID(event, cmask));
 	hwc->event_base =3D  (unsigned long)tx2_pmu->base
-		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event));
+		+ L3C_COUNTER_DATA + (8 * GET_COUNTERID(event, cmask));
 }
=20
 static void init_cntr_base_dmc(struct perf_event *event,
 		struct tx2_uncore_pmu *tx2_pmu)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
+	u32 cmask;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	cmask =3D tx2_pmu->counters_mask;
=20
 	hwc->config_base =3D (unsigned long)tx2_pmu->base
 		+ DMC_COUNTER_CTL;
 	/* counter data reg offset at 0xc */
 	hwc->event_base =3D (unsigned long)tx2_pmu->base
-		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event));
+		+ DMC_COUNTER_DATA + (0xc * GET_COUNTERID(event, cmask));
+}
+
+static void init_cntr_base_ccpi2(struct perf_event *event,
+		struct tx2_uncore_pmu *tx2_pmu)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+	u32 cmask;
+
+	cmask =3D tx2_pmu->counters_mask;
+
+	hwc->config_base =3D (unsigned long)tx2_pmu->base
+		+ CCPI2_COUNTER_CTL + (4 * GET_COUNTERID(event, cmask));
+	hwc->event_base =3D  (unsigned long)tx2_pmu->base;
 }
=20
 static void uncore_start_event_l3c(struct perf_event *event, int flags)
 {
-	u32 val;
+	u32 val, emask;
 	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	emask =3D tx2_pmu->events_mask;
=20
 	/* event id encoded in bits [07:03] */
-	val =3D GET_EVENTID(event) << 3;
+	val =3D GET_EVENTID(event, emask) << 3;
 	reg_writel(val, hwc->config_base);
 	local64_set(&hwc->prev_count, 0);
 	reg_writel(0, hwc->event_base);
@@ -284,10 +387,17 @@ static inline void uncore_stop_event_l3c(struct perf_=
event *event)
=20
 static void uncore_start_event_dmc(struct perf_event *event, int flags)
 {
-	u32 val;
+	u32 val, cmask, emask;
 	struct hw_perf_event *hwc =3D &event->hw;
-	int idx =3D GET_COUNTERID(event);
-	int event_id =3D GET_EVENTID(event);
+	struct tx2_uncore_pmu *tx2_pmu;
+	int idx, event_id;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	cmask =3D tx2_pmu->counters_mask;
+	emask =3D tx2_pmu->events_mask;
+
+	idx =3D GET_COUNTERID(event, cmask);
+	event_id =3D GET_EVENTID(event, emask);
=20
 	/* enable and start counters.
 	 * 8 bits for each counter, bits[05:01] of a counter to set event type.
@@ -302,9 +412,14 @@ static void uncore_start_event_dmc(struct perf_event *=
event, int flags)
=20
 static void uncore_stop_event_dmc(struct perf_event *event)
 {
-	u32 val;
+	u32 val, cmask;
 	struct hw_perf_event *hwc =3D &event->hw;
-	int idx =3D GET_COUNTERID(event);
+	struct tx2_uncore_pmu *tx2_pmu;
+	int idx;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	cmask =3D tx2_pmu->counters_mask;
+	idx =3D GET_COUNTERID(event, cmask);
=20
 	/* clear event type(bits[05:01]) to stop counter */
 	val =3D reg_readl(hwc->config_base);
@@ -312,27 +427,72 @@ static void uncore_stop_event_dmc(struct perf_event *=
event)
 	reg_writel(val, hwc->config_base);
 }
=20
+static void uncore_start_event_ccpi2(struct perf_event *event, int flags)
+{
+	u32 emask;
+	struct hw_perf_event *hwc =3D &event->hw;
+	struct tx2_uncore_pmu *tx2_pmu;
+
+	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
+	emask =3D tx2_pmu->events_mask;
+
+	/* Bit [09:00] to set event id.
+	 * Bits [10], set level to rising edge.
+	 * Bits [11], set type to edge sensitive.
+	 */
+	reg_writel((CCPI2_EVENT_TYPE_EDGE_SENSITIVE |
+			CCPI2_EVENT_LEVEL_RISING_EDGE |
+			GET_EVENTID(event, emask)), hwc->config_base);
+
+	/* reset[4], enable[0] and start[1] counters */
+	reg_writel(CCPI2_PERF_CTL_RESET |
+			CCPI2_PERF_CTL_START |
+			CCPI2_PERF_CTL_ENABLE,
+			hwc->event_base + CCPI2_PERF_CTL);
+	local64_set(&event->hw.prev_count, 0ULL);
+}
+
+static void uncore_stop_event_ccpi2(struct perf_event *event)
+{
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	/* disable and stop counter */
+	reg_writel(0, hwc->event_base + CCPI2_PERF_CTL);
+}
+
 static void tx2_uncore_event_update(struct perf_event *event)
 {
-	s64 prev, delta, new =3D 0;
+	u64 prev, delta, new =3D 0;
 	struct hw_perf_event *hwc =3D &event->hw;
 	struct tx2_uncore_pmu *tx2_pmu;
 	enum tx2_uncore_type type;
 	u32 prorate_factor;
+	u32 cmask, emask;
=20
 	tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
 	type =3D tx2_pmu->type;
+	cmask =3D tx2_pmu->counters_mask;
+	emask =3D tx2_pmu->events_mask;
 	prorate_factor =3D tx2_pmu->prorate_factor;
-
-	new =3D reg_readl(hwc->event_base);
-	prev =3D local64_xchg(&hwc->prev_count, new);
-
-	/* handles rollover of 32 bit counter */
-	delta =3D (u32)(((1UL << 32) - prev) + new);
+	if (type =3D=3D PMU_TYPE_CCPI2) {
+		reg_writel(CCPI2_COUNTER_OFFSET +
+				GET_COUNTERID(event, cmask),
+				hwc->event_base + CCPI2_COUNTER_SEL);
+		new =3D reg_readl(hwc->event_base + CCPI2_COUNTER_DATA_H);
+		new =3D (new << 32) +
+			reg_readl(hwc->event_base + CCPI2_COUNTER_DATA_L);
+		prev =3D local64_xchg(&hwc->prev_count, new);
+		delta =3D new - prev;
+	} else {
+		new =3D reg_readl(hwc->event_base);
+		prev =3D local64_xchg(&hwc->prev_count, new);
+		/* handles rollover of 32 bit counter */
+		delta =3D (u32)(((1UL << 32) - prev) + new);
+	}
=20
 	/* DMC event data_transfers granularity is 16 Bytes, convert it to 64 */
 	if (type =3D=3D PMU_TYPE_DMC &&
-			GET_EVENTID(event) =3D=3D DMC_EVENT_DATA_TRANSFERS)
+			GET_EVENTID(event, emask) =3D=3D DMC_EVENT_DATA_TRANSFERS)
 		delta =3D delta/4;
=20
 	/* L3C and DMC has 16 and 8 interleave channels respectively.
@@ -351,6 +511,7 @@ static enum tx2_uncore_type get_tx2_pmu_type(struct acp=
i_device *adev)
 	} devices[] =3D {
 		{"CAV901D", PMU_TYPE_L3C},
 		{"CAV901F", PMU_TYPE_DMC},
+		{"CAV901E", PMU_TYPE_CCPI2},
 		{"", PMU_TYPE_INVALID}
 	};
=20
@@ -380,7 +541,8 @@ static bool tx2_uncore_validate_event(struct pmu *pmu,
  * Make sure the group of events can be scheduled at once
  * on the PMU.
  */
-static bool tx2_uncore_validate_event_group(struct perf_event *event)
+static bool tx2_uncore_validate_event_group(struct perf_event *event,
+		int max_counters)
 {
 	struct perf_event *sibling, *leader =3D event->group_leader;
 	int counters =3D 0;
@@ -403,7 +565,7 @@ static bool tx2_uncore_validate_event_group(struct perf=
_event *event)
 	 * If the group requires more counters than the HW has,
 	 * it cannot ever be scheduled.
 	 */
-	return counters <=3D TX2_PMU_MAX_COUNTERS;
+	return counters <=3D max_counters;
 }
=20
=20
@@ -439,7 +601,7 @@ static int tx2_uncore_event_init(struct perf_event *eve=
nt)
 	hwc->config =3D event->attr.config;
=20
 	/* Validate the group */
-	if (!tx2_uncore_validate_event_group(event))
+	if (!tx2_uncore_validate_event_group(event, tx2_pmu->max_counters))
 		return -EINVAL;
=20
 	return 0;
@@ -456,6 +618,10 @@ static void tx2_uncore_event_start(struct perf_event *=
event, int flags)
 	tx2_pmu->start_event(event, flags);
 	perf_event_update_userpage(event);
=20
+	/* No hrtimer needed for CCPI2, 64-bit counters */
+	if (!tx2_pmu->hrtimer_callback)
+		return;
+
 	/* Start timer for first event */
 	if (bitmap_weight(tx2_pmu->active_counters,
 				tx2_pmu->max_counters) =3D=3D 1) {
@@ -510,15 +676,23 @@ static void tx2_uncore_event_del(struct perf_event *e=
vent, int flags)
 {
 	struct tx2_uncore_pmu *tx2_pmu =3D pmu_to_tx2_pmu(event->pmu);
 	struct hw_perf_event *hwc =3D &event->hw;
+	u32 cmask;
=20
+	cmask =3D tx2_pmu->counters_mask;
 	tx2_uncore_event_stop(event, PERF_EF_UPDATE);
=20
 	/* clear the assigned counter */
-	free_counter(tx2_pmu, GET_COUNTERID(event));
+	free_counter(tx2_pmu, GET_COUNTERID(event, cmask));
=20
 	perf_event_update_userpage(event);
 	tx2_pmu->events[hwc->idx] =3D NULL;
 	hwc->idx =3D -1;
+
+	if (!tx2_pmu->hrtimer_callback)
+		return;
+
+	if (bitmap_empty(tx2_pmu->active_counters, tx2_pmu->max_counters))
+		hrtimer_cancel(&tx2_pmu->hrtimer);
 }
=20
 static void tx2_uncore_event_read(struct perf_event *event)
@@ -580,8 +754,12 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pm=
u *tx2_pmu)
 			cpu_online_mask);
=20
 	tx2_pmu->cpu =3D cpu;
-	hrtimer_init(&tx2_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	tx2_pmu->hrtimer.function =3D tx2_hrtimer_callback;
+
+	if (tx2_pmu->hrtimer_callback) {
+		hrtimer_init(&tx2_pmu->hrtimer,
+				CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		tx2_pmu->hrtimer.function =3D tx2_pmu->hrtimer_callback;
+	}
=20
 	ret =3D tx2_uncore_pmu_register(tx2_pmu);
 	if (ret) {
@@ -653,10 +831,13 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev=
(struct device *dev,
=20
 	switch (tx2_pmu->type) {
 	case PMU_TYPE_L3C:
-		tx2_pmu->max_counters =3D TX2_PMU_MAX_COUNTERS;
+		tx2_pmu->max_counters =3D TX2_PMU_DMC_L3C_MAX_COUNTERS;
+		tx2_pmu->counters_mask =3D 0x3;
 		tx2_pmu->prorate_factor =3D TX2_PMU_L3_TILES;
 		tx2_pmu->max_events =3D L3_EVENT_MAX;
+		tx2_pmu->events_mask =3D 0x1f;
 		tx2_pmu->hrtimer_interval =3D TX2_PMU_HRTIMER_INTERVAL;
+		tx2_pmu->hrtimer_callback =3D tx2_hrtimer_callback;
 		tx2_pmu->attr_groups =3D l3c_pmu_attr_groups;
 		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_l3c_%d", tx2_pmu->node);
@@ -665,10 +846,13 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev=
(struct device *dev,
 		tx2_pmu->stop_event =3D uncore_stop_event_l3c;
 		break;
 	case PMU_TYPE_DMC:
-		tx2_pmu->max_counters =3D TX2_PMU_MAX_COUNTERS;
+		tx2_pmu->max_counters =3D TX2_PMU_DMC_L3C_MAX_COUNTERS;
+		tx2_pmu->counters_mask =3D 0x3;
 		tx2_pmu->prorate_factor =3D TX2_PMU_DMC_CHANNELS;
 		tx2_pmu->max_events =3D DMC_EVENT_MAX;
+		tx2_pmu->events_mask =3D 0x1f;
 		tx2_pmu->hrtimer_interval =3D TX2_PMU_HRTIMER_INTERVAL;
+		tx2_pmu->hrtimer_callback =3D tx2_hrtimer_callback;
 		tx2_pmu->attr_groups =3D dmc_pmu_attr_groups;
 		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
 				"uncore_dmc_%d", tx2_pmu->node);
@@ -676,6 +860,21 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(=
struct device *dev,
 		tx2_pmu->start_event =3D uncore_start_event_dmc;
 		tx2_pmu->stop_event =3D uncore_stop_event_dmc;
 		break;
+	case PMU_TYPE_CCPI2:
+		/* CCPI2 has 8 counters */
+		tx2_pmu->max_counters =3D TX2_PMU_CCPI2_MAX_COUNTERS;
+		tx2_pmu->counters_mask =3D 0x7;
+		tx2_pmu->prorate_factor =3D 1;
+		tx2_pmu->max_events =3D CCPI2_EVENT_MAX;
+		tx2_pmu->events_mask =3D 0x1ff;
+		tx2_pmu->attr_groups =3D ccpi2_pmu_attr_groups;
+		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
+				"uncore_ccpi2_%d", tx2_pmu->node);
+		tx2_pmu->init_cntr_base =3D init_cntr_base_ccpi2;
+		tx2_pmu->start_event =3D uncore_start_event_ccpi2;
+		tx2_pmu->stop_event =3D uncore_stop_event_ccpi2;
+		tx2_pmu->hrtimer_callback =3D NULL;
+		break;
 	case PMU_TYPE_INVALID:
 		devm_kfree(dev, tx2_pmu);
 		return NULL;
@@ -744,7 +943,9 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 	if (cpu !=3D tx2_pmu->cpu)
 		return 0;
=20
-	hrtimer_cancel(&tx2_pmu->hrtimer);
+	if (tx2_pmu->hrtimer_callback)
+		hrtimer_cancel(&tx2_pmu->hrtimer);
+
 	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
 	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
 	new_cpu =3D cpumask_any_and(
--=20
2.17.1

