Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF46C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D37218BB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gvDCDQzo";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="f5OMHV8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGEH5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:57:47 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16104 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfGEH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:57:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x657tP3H001598;
        Fri, 5 Jul 2019 00:56:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hANK4Rn8H539ugz+gNIMv2tZNOtAOeYjC5INbzDlbwU=;
 b=gvDCDQzoOYZkQqhkhgTu/KCMtsm2iGGWbIJPBvtJFl4/BSqJlyo3oJhW70ia85vS0xmj
 fuZpC287ysRzDV/U/mT3GdvyOAuhz2edySbaljMBxoScqFcC6cmvR9eWzR+ac/R6Qq4S
 Uz5HrbHybCWwa1xlmxo9kpeJarvGROJXLMLdqMEe1qro1qvPltPPmcv6Oaa8DbkHPDdr
 GM+P21x9m+WBdq+oObms64sWfSQxWlHN4RBtXGi2dcCWg2JwBUrjzAeUrTBZKAs2GvKa
 NYQBXluWkBi/qeoRcgZxRoaI7LkAM+2HN+6cBCGgF6ZC6vCKedbAFctxrdqzETDwPc7F dQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2thjyraww4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 00:56:27 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 5 Jul
 2019 00:56:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 00:56:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hANK4Rn8H539ugz+gNIMv2tZNOtAOeYjC5INbzDlbwU=;
 b=f5OMHV8eMRPfTAvgH0QaedDImlqIse4D/OV10NV9J/Vihgru7YJj9qvahbSKAm77GYyfT6S1ZKfZW+qogKxEV0tAFZ9xtevFLX88MnSXaBzMf2GcbaOrDAwhyy7xwoeGfMz/5qV+CuxalZhCA9kyARvLxoanuMm5Dp5lpMpr6/g=
Received: from MN2PR18MB3055.namprd18.prod.outlook.com (20.178.255.209) by
 MN2PR18MB3117.namprd18.prod.outlook.com (10.255.86.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 07:56:21 +0000
Received: from MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::600f:38e6:1583:487d]) by MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::600f:38e6:1583:487d%7]) with mapi id 15.20.2052.019; Fri, 5 Jul 2019
 07:56:21 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>
CC:     Shijith Thotton <sthotton@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        George Cherian <gcherian@marvell.com>
Subject: [PATCH v2] genirq: update irq stats from NMI handlers
Thread-Topic: [PATCH v2] genirq: update irq stats from NMI handlers
Thread-Index: AQHVMwciauGSRMuvEU240iVDoNUQJw==
Date:   Fri, 5 Jul 2019 07:56:20 +0000
Message-ID: <1562313336-11888-1-git-send-email-sthotton@marvell.com>
References: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
In-Reply-To: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To MN2PR18MB3055.namprd18.prod.outlook.com
 (2603:10b6:208:ff::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92b21098-7645-4af8-58fb-08d7011e4489
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3117;
x-ms-traffictypediagnostic: MN2PR18MB3117:
x-microsoft-antispam-prvs: <MN2PR18MB3117C21225627DEFBFA3C700D9F50@MN2PR18MB3117.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:580;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39850400004)(366004)(199004)(189003)(14454004)(110136005)(66476007)(52116002)(6506007)(54906003)(4720700003)(25786009)(7736002)(66446008)(66556008)(64756008)(107886003)(15650500001)(186003)(102836004)(73956011)(66946007)(71200400001)(81166006)(81156014)(71190400001)(386003)(53936002)(305945005)(478600001)(316002)(68736007)(4326008)(256004)(14444005)(66066001)(76176011)(36756003)(6512007)(6116002)(86362001)(486006)(476003)(3846002)(2616005)(446003)(2906002)(11346002)(6436002)(6486002)(8936002)(26005)(8676002)(50226002)(99286004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3117;H:MN2PR18MB3055.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vn/T+tNopTKfUdcpWVcQwl3/G4Yf6oBOlOp60VK3L/U5Q/Pdjg22+ndkDgHhJw78BJoRUhoObZc4Oatx6WMATaB7y0/AcKW0eDvPoxXn+AjJdvSYge7nwU3fSrdTdL/pqeUZeIGxyiFf7R2mpgmHKr+Eeort1J19Rd0BYb2vBrc2HNcRbjKEcnDOI0yLwMVMbJNUz1IbZQzJRCf8uG9qkRVzfGr+vIT8DA5rwW3R7Xp3F1J/LADntkJ8MknOREcLFzlidwlchw6qZ870cRX69Wppx4uCJJFm3ARyCQAzaign0/XnVhIr3ARNRYAMNryOPGqoWl2tjEvP8jC+AOZ3y3bxItcs/rF9U4V8PjDVhAqgwOtYI98a6QrdqCiD9oQWzhxmM6zFxabDAO7G4WMs5QFHumAcDtOHFVLlK5MHQCU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b21098-7645-4af8-58fb-08d7011e4489
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 07:56:20.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sthotton@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3117
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NMI handlers handle_percpu_devid_fasteoi_nmi() and
handle_fasteoi_nmi() added by commit 2dcf1fbcad35 ("genirq: Provide NMI
handlers") do not update the interrupt counts. Due to that the NMI
interrupt count does not show up correctly in /proc/interrupts.

Update the functions to fix this. With this change, we can see stats of
the perf NMI interrupts on arm64.

As NMI handlers can't update tot_count in irq descriptor, kstat_irqs()
has been updated not to return tot_count for NMI.

Fixes: 2dcf1fbcad35 ("genirq: Provide NMI handlers")

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
Changes since v1:
- Don't touch tot_count from NMI handler.
- Update kstat_irqs() to not return tot_count for NMI.

 kernel/irq/chip.c    | 4 ++++
 kernel/irq/irqdesc.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 29d6c7d070b4..04c850fb70cb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -748,6 +748,8 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 	unsigned int irq =3D irq_desc_get_irq(desc);
 	irqreturn_t res;
=20
+	__kstat_incr_irqs_this_cpu(desc);
+
 	trace_irq_handler_entry(irq, action);
 	/*
 	 * NMIs cannot be shared, there is only one action.
@@ -962,6 +964,8 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *d=
esc)
 	unsigned int irq =3D irq_desc_get_irq(desc);
 	irqreturn_t res;
=20
+	__kstat_incr_irqs_this_cpu(desc);
+
 	trace_irq_handler_entry(irq, action);
 	res =3D action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 	trace_irq_handler_exit(irq, action, res);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index c52b737ab8e3..9149dde5a7b0 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -946,6 +946,11 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
 }
=20
+static bool irq_is_nmi(struct irq_desc *desc)
+{
+	return desc->istate & IRQS_NMI;
+}
+
 /**
  * kstat_irqs - Get the statistics for an interrupt
  * @irq:	The interrupt number
@@ -963,7 +968,8 @@ unsigned int kstat_irqs(unsigned int irq)
 	if (!desc || !desc->kstat_irqs)
 		return 0;
 	if (!irq_settings_is_per_cpu_devid(desc) &&
-	    !irq_settings_is_per_cpu(desc))
+	    !irq_settings_is_per_cpu(desc) &&
+	    !irq_is_nmi(desc))
 	    return desc->tot_count;
=20
 	for_each_possible_cpu(cpu)
--=20
2.17.0

