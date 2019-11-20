Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97783C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6478221850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="oRf7pEXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKTGiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:38:52 -0500
Received: from mail-eopbgr760082.outbound.protection.outlook.com ([40.107.76.82]:23205
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbfKTGiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:38:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF601UzsXr1zZkeImYU6yLPYe9V71slsdugft9MounrIbz30N3RwGxdG+DzpM6sIneMqMHo0Ab3g/A0K8necQXs0oTP0GszDf/G1wCMVxdmOgxr+wAFggSWT8NkxNnUZwTs3f6lddAxTZsvhkKQ5iso7Mr1VOQp6sQj8+4IeE8S2UOY539XDA8xA3CnIRUIPzyiKJvxV6zfIGfN2Kb2a8+AyEkb46xplHA08FdkqJEM8DCyl3SW4lJwa44PjLjCG8nE0oIJ1h5g4tZ5UIfsbseKAvrmU4mEvIjYGClIldsqz+71pk/fi64fcfb09kwGWmicldD7W4zkCyWU5Z7dP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5qvjxbY16pVTR1ymaK/jx5egw9CaF/bLnmFCeJiYJM=;
 b=lSz3lMCdVp8yqzznheICJXi41jte7FBXSsz0S3Aj+Mc9adsUPDKdG24hKL7JXGg1FgdPq0bbhnU9kjyFOGJ+8Ylc8UFqhwnUASiM0CwzYk2oGP9VSAD4+BjUGn6JBQZsZ7KZoD6qXxAHlZYsWVmAV1wj50x7N8Djyqho+hKycyDF9z6VD5vx6+WqvhsEZg4KthEFLWWTJfETB5zIx0hvaW8pbtFRBtkQUe1A6oQw2HGXreQxl111gAkRZM8g8p0UV0PtW5MBDipMCCwE9fUYwDqJgK4MsFyfUXZo+D6sswgnIB2jLerCAzuOjFyPIskeM7G19/Nf1RyNWz/i5ZuCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5qvjxbY16pVTR1ymaK/jx5egw9CaF/bLnmFCeJiYJM=;
 b=oRf7pEXiFw8gF3Rt5R4js5cTXTRsDXMno0/+yGLA793XM/LyNYqO+o6sM/0gHqslGouXzCTvMCXpyelmih4aeuRfGvNIUM9zEgHL+nr5owbxSxVfmBTmOYmgfUrgwonkoHAhBMRDuxwubi0TyE7QuzcwuWmow/SoBifPUTtNivE=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4648.namprd03.prod.outlook.com (20.179.90.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Wed, 20 Nov 2019 06:38:47 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a8f6:f5d6:f438:ec61]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a8f6:f5d6:f438:ec61%3]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 06:38:47 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: Remove soft_lockup_hrtimer_cnt and related code
Thread-Topic: [PATCH] watchdog: Remove soft_lockup_hrtimer_cnt and related
 code
Thread-Index: AQHVn20pt1bfgUsCsEeZCjfgrKg0kw==
Date:   Wed, 20 Nov 2019 06:38:47 +0000
Message-ID: <20191120142522.0e82c985@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d990f83-467e-435e-febb-08d76d844bed
x-ms-traffictypediagnostic: BYAPR03MB4648:
x-microsoft-antispam-prvs: <BYAPR03MB46485FFFE0BF447BA3ECA899ED4F0@BYAPR03MB4648.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:72;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(396003)(366004)(346002)(199004)(189003)(6506007)(99286004)(256004)(305945005)(6512007)(9686003)(52116002)(26005)(4326008)(478600001)(110136005)(66476007)(14454004)(7736002)(386003)(66946007)(66446008)(64756008)(66556008)(8676002)(81166006)(66066001)(86362001)(81156014)(1076003)(71200400001)(6486002)(8936002)(186003)(50226002)(102836004)(486006)(316002)(5660300002)(6116002)(25786009)(2906002)(6436002)(3846002)(476003)(71190400001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4648;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsDC7XT9B3cNzkRg4YYP00kcWSzZDFtrHKCIJdgG0hSOk0ekf1oZhPo/z4XY8u842eNT2VRsK6ro+r7OlyKZRGY4P9tdI+rEOlSDHpMJtY4TsZ2bvhm2YkDVtGuFUg/aX+Y5dqJNO8z+3+R4r9IM3nSpxsFKC/RLHRu0Fh+71H5ap9b8iaxpCEOvLZ3jB2k82f+epwI2OcLmdulVbG3xu1qKdA4DuECkwXrCfbvTkVoGC5qcQtu9cquVjNAlekZvMcCIAdjQ31RT2e6XhG1Z7Emv8gYS/ESbMh6HmSLVSVZ1gSA/BJIAHXJDKtaClgMEj1dWp57xCuonrwrvHNCY1OZMgaPe4vPlrHnp1TNq8PeECMRXDiCeLCrJkXRJHoILzOkSgSJzsZ3pciudYTfBug3h6WABRjU7ZApFCr2Yv8sU6i64OCeu/4YN14LJMy4V
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9D10F31A2D3354287EC2097F24FCE76@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d990f83-467e-435e-febb-08d76d844bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 06:38:47.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+HS2rclZN28y8vhyOTSnO4mzx1t4N6CE3LfsQeO2R+zju22thOx423G4iKDz3j1N7UrfNc+bSXRmXCMN/hT4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u"
threads with cpu_stop_work"), the percpu soft_lockup_hrtimer_cnt is
not used any more, so remove it and related code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 kernel/watchdog.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..0621301ae8cf 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -173,7 +173,6 @@ static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer)=
;
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
 static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
@@ -350,8 +349,6 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_=
stop_work);
  */
 static int softlockup_fn(void *data)
 {
-	__this_cpu_write(soft_lockup_hrtimer_cnt,
-			 __this_cpu_read(hrtimer_interrupts));
 	__touch_watchdog();
 	complete(this_cpu_ptr(&softlockup_completion));
=20
--=20
2.24.0

