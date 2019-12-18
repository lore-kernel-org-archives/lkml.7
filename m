Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3558C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A046D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="e2KRehgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLRFba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 00:31:30 -0500
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:6265
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfLRFba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6z273NeJGzwTJURyJ14swecRoUxEll85/mjg1sxzUrmE5aq0hojDoCZ9ZZnFNviIMbLNawM7iOxygPCjK3tsdV8lFiz14aTzhLEiJhhleaAmL9F8nw98NKELkzDLMQFT203VlkradhQNbWlryF7SQDqNpEd/MGyf9yLRJ/TflpX2780/IxKbVNf6sYwKRlXkr2yLEw3hfNYfD+1Vyji2ACX876ZDmNYzVJr3joSTF5c0MarukjNCSEfZ+mf8rvMzE3hdJd0+oano+tUGDXx9y691m3TCGQQh1H4BxJVVMgIGTcoXkWWEIdCTCa3HKIWPd/gkzIkUUlK/AbBGvxq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpalgQktecBMBU5cgbYalCI7X0kvEE2yeUTplt/MfvA=;
 b=FrD4JGEP1ShcoygtaTU11OobEymIEuPC1M3OpjmqBs64OSZfpm0C76m2eqEdl2YsnQHvFP6WkEhtlmwzdUQj3MJHvPblbrzlqCRjuiW7IEKDFfxbjpuQGTQJGcSZTry3dI2ZUQy5us1ffNjLI9waz5ETfsKjF4FNczhVIOD6Amei4xuiF+vJsdUnB7pCChq2Vg5l9adPaEMYbTu8lcuA2qHQSu+iPI4uB/dL6oEGMVFaWwazISFI8o1lcIWq6/0S8Opymq0pOpkoiFPv+3r8G4Qtig/qK+jLPGZl0HVvQa86wGtXpE/CSMIcmjSpN6SAS91ks4tivFjCQo4cRknnpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpalgQktecBMBU5cgbYalCI7X0kvEE2yeUTplt/MfvA=;
 b=e2KRehgqDxhH5fQpU0FyLXGAEs/u1IFrO0ykiNtptpoqIysQ8lb22te9Kcmr6rskdxAyfeoNiWWc0R3ffQVPqokwG95qVL0qjb93+yL8jACtnl+6gPKHGwTFGPifHBtlXtfP5P+6KorkTP6iaL5tZI6rk6qjShtQoE8s3EkNm+I=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB3783.namprd03.prod.outlook.com (20.176.253.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Wed, 18 Dec 2019 05:31:26 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 05:31:25 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] watchdog: Remove soft_lockup_hrtimer_cnt and related code
Thread-Topic: [PATCH v2] watchdog: Remove soft_lockup_hrtimer_cnt and related
 code
Thread-Index: AQHVtWRj/flJZpZGKkW+cjf3i9EWlg==
Date:   Wed, 18 Dec 2019 05:31:25 +0000
Message-ID: <20191218131720.4146aea2@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92955a9a-3620-4a49-8785-08d7837b862b
x-ms-traffictypediagnostic: BYAPR03MB3783:
x-microsoft-antispam-prvs: <BYAPR03MB37837A3AE6C1F7657C608C43ED530@BYAPR03MB3783.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(1076003)(2906002)(8676002)(478600001)(5660300002)(186003)(81166006)(86362001)(4326008)(6486002)(8936002)(81156014)(316002)(110136005)(66946007)(9686003)(64756008)(66446008)(66476007)(26005)(66556008)(6512007)(52116002)(6506007)(71200400001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3783;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZ44qJio9jAaO7UHUIDC4Mt3WaQgCHRFv9Wf0ztOT3K0q64FGARXPLjk9Ud0bc9HWBw0ergHkYqcrAgT6ZfW5IWOp3jHdnGUdSL5O4qdNNcQt/kuw57fuovpKWgI4Vkxipugg+QCZYPwXW9fzAL4scmvvhcWOcPebnn363KPgsD0eudyQ/n2mWr01bC1OL0khQyEnrrLAOwGg3cNpVRvgYHpsZKlUKiZcJXglD4mmwwOSwGgeNc+BXw0eGQZPqZwJNQyO0H/je5lmqXbHwxZYSP3EwmlfLDTEMgLgCODq2Sdt+320DmmEHJgg6SjBKWQtRSHrQ7EhqPos8hu38y/MAW0TGXAPjH6LC6JdgalYgulGwQ0X5Iva/aiysa7wQg0WcM2PmrfQ6MZLDNHynoC3W+7egwGnOx5DccG6drgE4i4xZN0vjEQHBoAaUg5KIpWElhZOc1TnIgK8scZbbIzX7BJuSk/Y3Ib5/q4sIFRcky5Bev0hAxu78mP+sXn4RtM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1E9C66EBD380A4392434456BB9A8326@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92955a9a-3620-4a49-8785-08d7837b862b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 05:31:25.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmgR/bSYb7l1RwqmZHjhSYYu3ZPkvTWcKe6R6fbfQtm6/iiBRm31Ocuo1ihxD5mxbLkdT9/uktgbEtysR2qf6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u"
threads with cpu_stop_work"), the percpu soft_lockup_hrtimer_cnt is
not used any more, so remove it and related code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1
 - rebase on v5.5-rc1

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
2.24.1

