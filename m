Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7541C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61942218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DZ/AxJvK";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="a3HyxTC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfGEJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:14:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5432 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727565AbfGEJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:14:22 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6596Al3025365;
        Fri, 5 Jul 2019 02:13:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=MqZZx+Ge4fy7O3dFBb/YPhkgSVbb+nuO5J26wkKavmY=;
 b=DZ/AxJvKHKPcwGqfZ2gh/UJfPABZmdE6+5//BEEm1jWbwcilG2J0skk3qnXkM/fpwiJ8
 4JgnYXKSCb9h5CDYDNrgfY9usf6+3yWMCbVKaxKYaP1Gk9kjn0YIAGpsT47lnUMKnlsv
 CgwhOFjs1RG++KlTQdgt7hhS10ykY1lqitmg7UHQjMC1ftK1zh4R31ooj0A3PRkF0mVJ
 pHs12QszSsgPYcCPYlqpUiuh2+8exY8MGCaFDXKcLlwRS2qE85XZljsjnS8oVF1UDtEQ
 V0Arl9rRdVX4fiMoQzSh1K+RdekX6iMe3FDvwL0u17bxMu8ju1z5AZgXct+KpP6ZUaND 7w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2thjyrb61a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 02:13:04 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 5 Jul
 2019 02:13:02 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 02:13:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqZZx+Ge4fy7O3dFBb/YPhkgSVbb+nuO5J26wkKavmY=;
 b=a3HyxTC2CDway2R0nN0CG7Sjz79XC1fkJiH1tkQWmxsTLyrDXbGAQ3QVmRQWaY+h5gLdnn8IVb7qzwc9pxoNk76XqSDf0/9PqNhYn05Zv+nK0n+AXhqSP6vh0alb/Unp+xnMPRHB5N4/6ZWpj+BeUWhdctb11cDOdgunrL43inY=
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com (10.164.205.31) by
 MWHPR1801MB1982.namprd18.prod.outlook.com (10.164.205.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 09:12:57 +0000
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::5a8:540b:6bb7:fa20]) by MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::5a8:540b:6bb7:fa20%7]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 09:12:57 +0000
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
Subject: [PATCH v2 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Thread-Topic: [PATCH v2 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Thread-Index: AQHVMxHVv/rN6Otw0UOLbFRk8BYAYw==
Date:   Fri, 5 Jul 2019 09:12:57 +0000
Message-ID: <1562317967-16329-3-git-send-email-gkulkarni@marvell.com>
References: <1562317967-16329-1-git-send-email-gkulkarni@marvell.com>
In-Reply-To: <1562317967-16329-1-git-send-email-gkulkarni@marvell.com>
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
x-ms-office365-filtering-correlation-id: ac658a02-8218-45e7-720c-08d70128f7f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR1801MB1982;
x-ms-traffictypediagnostic: MWHPR1801MB1982:
x-microsoft-antispam-prvs: <MWHPR1801MB1982E643942C35747DABA6B2B2F50@MWHPR1801MB1982.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39850400004)(396003)(346002)(136003)(189003)(199004)(14454004)(2616005)(446003)(11346002)(30864003)(6436002)(66066001)(2501003)(4720700003)(36756003)(4326008)(50226002)(53946003)(256004)(14444005)(478600001)(3846002)(6116002)(76176011)(52116002)(7736002)(99286004)(486006)(476003)(186003)(6512007)(305945005)(25786009)(26005)(386003)(6506007)(6486002)(102836004)(54906003)(110136005)(71200400001)(71190400001)(5660300002)(53936002)(8936002)(68736007)(316002)(81166006)(86362001)(2201001)(81156014)(73956011)(8676002)(64756008)(66946007)(66556008)(66446008)(2906002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1801MB1982;H:MWHPR1801MB2030.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vq69PiWqTUkv4cXEzZ5PRisxy+Xl2ToVa27RkgF2fEZFY63ZDGyJwaCimeCOf3GOD0GwzWs7Ky0y7pVaiY5uExHRE6OKTdrO5+pptHj55IL4tU5uA07INFop6qKp7G9vWNUAnxuAFrMoeuVxuJDzT+ftA3MtEqjNY50RCP4RIcnxB1PAEGFuf7qJQCB7qo2/EmzcZ7A4L4+8fbPjcWRlLX/i2MOkwafJUGZhingpfKph/CIv8WNqUZhr0HUnHM1uxyyTjFEMwbVTbWxaTpgujDVjJmlMrSPIKqO3Q5DtEhAd32sZc1ivD79ez3FlvxFiVkEbKWMbaqZWL5hiay+3GOz7vNRbjWQrLN8CseuUbJX89PZ5N9MYL0RvsORaBRvOgFgKJaPsaNadBwxntmEiQEqn8X6SpnF78Wtq1scCVk4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac658a02-8218-45e7-720c-08d70128f7f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 09:12:57.1468
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

CCPI2 is a low-latency high-bandwidth serial interface for connecting
ThunderX2 processors. This patch adds support to capture CCPI2 perf events.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
---
 drivers/perf/thunderx2_pmu.c | 248 ++++++++++++++++++++++++++++++-----
 1 file changed, 214 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 43d76c85da56..af5bf35e0f24 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -17,22 +17,31 @@
  */
=20
 #define TX2_PMU_MAX_COUNTERS		4
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
+
 /* L3C event IDs */
 #define L3_EVENT_READ_REQ		0xD
 #define L3_EVENT_WRITEBACK_REQ		0xE
@@ -51,15 +60,23 @@
 #define DMC_EVENT_READ_TXNS		0xF
 #define DMC_EVENT_MAX			0x10
=20
+#define CCPI2_EVENT_REQ_PKT_SENT	0x3D
+#define CCPI2_EVENT_SNOOP_PKT_SENT	0x65
+#define CCPI2_EVENT_DATA_PKT_SENT	0x105
+#define CCPI2_EVENT_GIC_PKT_SENT	0x12D
+#define CCPI2_EVENT_MAX			0x200
+
 enum tx2_uncore_type {
 	PMU_TYPE_L3C,
 	PMU_TYPE_DMC,
+	PMU_TYPE_CCPI2,
 	PMU_TYPE_INVALID,
 };
=20
+
 /*
- * pmu on each socket has 2 uncore devices(dmc and l3c),
- * each device has 4 counters.
+ * pmu on each socket has 3 uncore devices(dmc, l3ci and ccpi2),
+ * dmc and l3c has 4 counters and ccpi2 8.
  */
 struct tx2_uncore_pmu {
 	struct hlist_node hpnode;
@@ -69,12 +86,14 @@ struct tx2_uncore_pmu {
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
-	struct perf_event *events[TX2_PMU_MAX_COUNTERS];
+	struct perf_event **events;
 	struct device *dev;
 	struct hrtimer hrtimer;
 	const struct attribute_group **attr_groups;
@@ -92,7 +111,21 @@ static inline struct tx2_uncore_pmu *pmu_to_tx2_pmu(str=
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
@@ -104,6 +137,11 @@ static struct attribute *dmc_pmu_format_attrs[] =3D {
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
@@ -114,6 +152,11 @@ static const struct attribute_group dmc_pmu_format_att=
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
@@ -164,6 +207,19 @@ static struct attribute *dmc_pmu_events_attrs[] =3D {
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
@@ -174,6 +230,11 @@ static const struct attribute_group dmc_pmu_events_att=
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
@@ -213,11 +274,23 @@ static const struct attribute_group *dmc_pmu_attr_gro=
ups[] =3D {
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
 }
=20
+static inline u32 reg_readq(unsigned long addr)
+{
+	return readq((void __iomem *)addr);
+}
+
 static inline void reg_writel(u32 val, unsigned long addr)
 {
 	writel(val, (void __iomem *)addr);
@@ -245,33 +318,58 @@ static void init_cntr_base_l3c(struct perf_event *eve=
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
@@ -284,10 +382,17 @@ static inline void uncore_stop_event_l3c(struct perf_=
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
@@ -302,9 +407,14 @@ static void uncore_start_event_dmc(struct perf_event *=
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
@@ -312,6 +422,31 @@ static void uncore_stop_event_dmc(struct perf_event *e=
vent)
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
+	/* Bit [09:00] to set event id, set level and type to 1 */
+	reg_writel((3 << 10) |
+			GET_EVENTID(event, emask), hwc->config_base);
+	/* reset[4], enable[0] and start[1] counters */
+	reg_writel(0x13, hwc->event_base + CCPI2_PERF_CTL);
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
 	s64 prev, delta, new =3D 0;
@@ -319,20 +454,30 @@ static void tx2_uncore_event_update(struct perf_event=
 *event)
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
+		new =3D reg_readq(hwc->event_base + CCPI2_COUNTER_DATA_L);
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
@@ -351,6 +496,7 @@ static enum tx2_uncore_type get_tx2_pmu_type(struct acp=
i_device *adev)
 	} devices[] =3D {
 		{"CAV901D", PMU_TYPE_L3C},
 		{"CAV901F", PMU_TYPE_DMC},
+		{"CAV901E", PMU_TYPE_CCPI2},
 		{"", PMU_TYPE_INVALID}
 	};
=20
@@ -380,7 +526,8 @@ static bool tx2_uncore_validate_event(struct pmu *pmu,
  * Make sure the group of events can be scheduled at once
  * on the PMU.
  */
-static bool tx2_uncore_validate_event_group(struct perf_event *event)
+static bool tx2_uncore_validate_event_group(struct perf_event *event,
+		int max_counters)
 {
 	struct perf_event *sibling, *leader =3D event->group_leader;
 	int counters =3D 0;
@@ -403,7 +550,7 @@ static bool tx2_uncore_validate_event_group(struct perf=
_event *event)
 	 * If the group requires more counters than the HW has,
 	 * it cannot ever be scheduled.
 	 */
-	return counters <=3D TX2_PMU_MAX_COUNTERS;
+	return counters <=3D max_counters;
 }
=20
=20
@@ -439,7 +586,7 @@ static int tx2_uncore_event_init(struct perf_event *eve=
nt)
 	hwc->config =3D event->attr.config;
=20
 	/* Validate the group */
-	if (!tx2_uncore_validate_event_group(event))
+	if (!tx2_uncore_validate_event_group(event, tx2_pmu->max_counters))
 		return -EINVAL;
=20
 	return 0;
@@ -456,8 +603,9 @@ static void tx2_uncore_event_start(struct perf_event *e=
vent, int flags)
 	tx2_pmu->start_event(event, flags);
 	perf_event_update_userpage(event);
=20
-	/* Start timer for first event */
-	if (bitmap_weight(tx2_pmu->active_counters,
+	/* Start timer for first non ccpi2 event */
+	if (tx2_pmu->type !=3D PMU_TYPE_CCPI2 &&
+			bitmap_weight(tx2_pmu->active_counters,
 				tx2_pmu->max_counters) =3D=3D 1) {
 		hrtimer_start(&tx2_pmu->hrtimer,
 			ns_to_ktime(tx2_pmu->hrtimer_interval),
@@ -495,7 +643,8 @@ static int tx2_uncore_event_add(struct perf_event *even=
t, int flags)
 	if (hwc->idx < 0)
 		return -EAGAIN;
=20
-	tx2_pmu->events[hwc->idx] =3D event;
+	if (tx2_pmu->events)
+		tx2_pmu->events[hwc->idx] =3D event;
 	/* set counter control and data registers base address */
 	tx2_pmu->init_cntr_base(event, tx2_pmu);
=20
@@ -510,14 +659,17 @@ static void tx2_uncore_event_del(struct perf_event *e=
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
-	tx2_pmu->events[hwc->idx] =3D NULL;
+	if (tx2_pmu->events)
+		tx2_pmu->events[hwc->idx] =3D NULL;
 	hwc->idx =3D -1;
 }
=20
@@ -580,8 +732,12 @@ static int tx2_uncore_pmu_add_dev(struct tx2_uncore_pm=
u *tx2_pmu)
 			cpu_online_mask);
=20
 	tx2_pmu->cpu =3D cpu;
-	hrtimer_init(&tx2_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	tx2_pmu->hrtimer.function =3D tx2_hrtimer_callback;
+	/* CCPI2 counters are 64 bit counters, no overflow  */
+	if (tx2_pmu->type !=3D PMU_TYPE_CCPI2) {
+		hrtimer_init(&tx2_pmu->hrtimer,
+				CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		tx2_pmu->hrtimer.function =3D tx2_hrtimer_callback;
+	}
=20
 	ret =3D tx2_uncore_pmu_register(tx2_pmu);
 	if (ret) {
@@ -654,8 +810,10 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(=
struct device *dev,
 	switch (tx2_pmu->type) {
 	case PMU_TYPE_L3C:
 		tx2_pmu->max_counters =3D TX2_PMU_MAX_COUNTERS;
+		tx2_pmu->counters_mask =3D 0x3;
 		tx2_pmu->prorate_factor =3D TX2_PMU_L3_TILES;
 		tx2_pmu->max_events =3D L3_EVENT_MAX;
+		tx2_pmu->events_mask =3D 0x1f;
 		tx2_pmu->hrtimer_interval =3D TX2_PMU_HRTIMER_INTERVAL;
 		tx2_pmu->attr_groups =3D l3c_pmu_attr_groups;
 		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
@@ -663,11 +821,15 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev=
(struct device *dev,
 		tx2_pmu->init_cntr_base =3D init_cntr_base_l3c;
 		tx2_pmu->start_event =3D uncore_start_event_l3c;
 		tx2_pmu->stop_event =3D uncore_stop_event_l3c;
+		tx2_pmu->events =3D devm_kzalloc(dev, tx2_pmu->max_counters *
+				sizeof(*tx2_pmu->events), GFP_KERNEL);
 		break;
 	case PMU_TYPE_DMC:
 		tx2_pmu->max_counters =3D TX2_PMU_MAX_COUNTERS;
+		tx2_pmu->counters_mask =3D 0x3;
 		tx2_pmu->prorate_factor =3D TX2_PMU_DMC_CHANNELS;
 		tx2_pmu->max_events =3D DMC_EVENT_MAX;
+		tx2_pmu->events_mask =3D 0x1f;
 		tx2_pmu->hrtimer_interval =3D TX2_PMU_HRTIMER_INTERVAL;
 		tx2_pmu->attr_groups =3D dmc_pmu_attr_groups;
 		tx2_pmu->name =3D devm_kasprintf(dev, GFP_KERNEL,
@@ -675,6 +837,23 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(=
struct device *dev,
 		tx2_pmu->init_cntr_base =3D init_cntr_base_dmc;
 		tx2_pmu->start_event =3D uncore_start_event_dmc;
 		tx2_pmu->stop_event =3D uncore_stop_event_dmc;
+		tx2_pmu->events =3D devm_kzalloc(dev, tx2_pmu->max_counters *
+				sizeof(*tx2_pmu->events), GFP_KERNEL);
+		break;
+	case PMU_TYPE_CCPI2:
+		/* CCPI2 has 8 counters */
+		tx2_pmu->max_counters =3D 8;
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
+		tx2_pmu->events =3D NULL;
 		break;
 	case PMU_TYPE_INVALID:
 		devm_kfree(dev, tx2_pmu);
@@ -744,7 +923,8 @@ static int tx2_uncore_pmu_offline_cpu(unsigned int cpu,
 	if (cpu !=3D tx2_pmu->cpu)
 		return 0;
=20
-	hrtimer_cancel(&tx2_pmu->hrtimer);
+	if (tx2_pmu->type !=3D PMU_TYPE_CCPI2)
+		hrtimer_cancel(&tx2_pmu->hrtimer);
 	cpumask_copy(&cpu_online_mask_temp, cpu_online_mask);
 	cpumask_clear_cpu(cpu, &cpu_online_mask_temp);
 	new_cpu =3D cpumask_any_and(
--=20
2.17.1

