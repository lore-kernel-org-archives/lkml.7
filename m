Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0159C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9896E2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="pavYEwy8";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="v5dbHDpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfGDEXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 00:23:07 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58908 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbfGDEXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 00:23:07 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x644KGjD006885;
        Wed, 3 Jul 2019 21:22:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=M+kOm1nHRZaMKmOJ4g7P8i/VlEnHAGFDNyiQNGAdywY=;
 b=pavYEwy805sI6T/oi+AlXWds9AU0V6h0scLAtS1CdTLYGT3cJfS7s+eSkx8qTDopP/VQ
 9kolRH4L232RvU+oxowVxtE5it+Bdv1gQZgLxcznE+B8kv5mH5I713yxhmHXwyP8g+BB
 5vGhlwbPP9aVF6sbKCIMw6Mz6gxTYc2IW7/+PvYHpLp8NaqkIsWA9n0QUWxHuuepKFss
 XqXC8KG3VQB8u89iVPErDalDPOuVnEzz+fHZt/NN4MM5cDh6UlxTBxCysrFwPq+3xxIM
 T+0m9mlYeMI8W3oOy65zEqzUcOLkxqODv8psFTeF3VLnfF3elxuguqkTicnBFqV8htju Zw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2th948087u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 21:22:50 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 3 Jul
 2019 21:22:49 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 3 Jul 2019 21:22:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=nTt7ATZAP94x8J8M312SqyauOmZRrNGGmzMY66XbQMsHC3spSMM2ILVVG8tw+3y8ss1gqFFLQ39S5sn59udIny0J9iWjVthTlQUjiCeq32Ha0DJIuobB7cFlX3BYo4+yMrA27mNB7bza+nIlS57NKrih8w+rJWIhEji/2KuVb04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+kOm1nHRZaMKmOJ4g7P8i/VlEnHAGFDNyiQNGAdywY=;
 b=T0KY61FmQOtDN+/Yf/K6sxEFrgozhqF4wgmrR+c5WYs8eGAH9VzamWiVF6etzSwKCP8xR58uDKkZsXhVtF1e/GURiYgiJMH/E80SkFrGy1iJubjNl+cj9A6YeQ6y2QF4rQhFqlCTFq+IvWpwQWq2yxWwuDRPBs/o4v+lpzHBM0E=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+kOm1nHRZaMKmOJ4g7P8i/VlEnHAGFDNyiQNGAdywY=;
 b=v5dbHDpjqE0guJBSy02HJjTFJkMoTLUsxInQoT8fddken159UxzYbiXf92uRrvXNpRqcwWWZE+BQ7pvNVGkdLEH7roFcmLr7Su0pfi08WOBExLqPLg6EzsT45UQWz8xtIwVD9L38tMBkQ4Vp34I12K507weyB7MsK5iy6YCzpkY=
Received: from MN2PR18MB3055.namprd18.prod.outlook.com (20.178.255.209) by
 MN2PR18MB3118.namprd18.prod.outlook.com (10.255.86.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 4 Jul 2019 04:22:47 +0000
Received: from MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::9574:8e34:cd99:788f]) by MN2PR18MB3055.namprd18.prod.outlook.com
 ([fe80::9574:8e34:cd99:788f%4]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 04:22:47 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Shijith Thotton <sthotton@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH] genirq: update irq stats from NMI handlers
Thread-Topic: [PATCH] genirq: update irq stats from NMI handlers
Thread-Index: AQHVMiAiVz/XkkYfRk2+vKGjBsT7xw==
Date:   Thu, 4 Jul 2019 04:22:47 +0000
Message-ID: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To MN2PR18MB3055.namprd18.prod.outlook.com
 (2603:10b6:208:ff::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5dccded-1151-4e99-9260-08d700374458
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3118;
x-ms-traffictypediagnostic: MN2PR18MB3118:
x-microsoft-antispam-prvs: <MN2PR18MB3118B3D2561843E8A5428D73D9FA0@MN2PR18MB3118.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(107886003)(486006)(53936002)(6116002)(476003)(71190400001)(2501003)(2616005)(71200400001)(66476007)(14454004)(7736002)(3846002)(26005)(305945005)(73956011)(66946007)(2906002)(66446008)(186003)(66556008)(52116002)(64756008)(6506007)(386003)(102836004)(5660300002)(15650500001)(36756003)(14444005)(316002)(6486002)(6436002)(86362001)(6512007)(81166006)(50226002)(68736007)(8936002)(25786009)(4326008)(99286004)(66066001)(54906003)(8676002)(81156014)(110136005)(478600001)(256004)(4720700003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3118;H:MN2PR18MB3055.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Gjv0JqHeqeqzCS83hxPa02aibj70IpnmJRk9F9I9PmeneRFnfXLSFovT7h4gFnqRXzU5YKGmZnoEHA2e9mTRvAVJpGRi+9BLRakkhmQlD7C5C/gaS43vSiDpqUe5/DFaioFqA5WCu4yXJqCLFTY2EsReuc5DVVgTP829J4J9ucK1qGtFUiTQvC+07u4W3wXz3F6DduadktLCkBd7weAv9qutouZ3rT9oM27gV9b3gvekfE3sn4pC9EfLoCvhUWH4m3aFm0gnlGUFPce98aZtTMSxG4aGGV1v0R/PulFt0h9uhCt8O/NUZ1P2416rZiyPl7R/MIEmcg5Zsp7s3pX/ulEYssR0tG83ok1IpftQdMrIsS9gnOt0tIDepGJM7Qr2ID1IoEaTCY/eimPdI8RgyLmgNXYFxQBS4ZLUBPUTcc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dccded-1151-4e99-9260-08d700374458
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 04:22:47.2477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sthotton@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3118
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_02:,,
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

Fixes: 2dcf1fbcad35 ("genirq: Provide NMI handlers")

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 kernel/irq/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 29d6c7d070b4..88d1e054c6ea 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -748,6 +748,8 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 	unsigned int irq =3D irq_desc_get_irq(desc);
 	irqreturn_t res;
=20
+	kstat_incr_irqs_this_cpu(desc);
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
--=20
2.17.0

