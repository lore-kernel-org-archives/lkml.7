Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB1C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D39220856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="wi5yPooZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfILJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:44:10 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:50646
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730337AbfILJoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:44:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx1ix7l2kTtvJkZIjxqrxusN5ykxFrcgH6OsptfHejMhCHBxlGIee6WTDkYfr43cAR+20FzCZFPlghwAzZtxzDEWvoCk7kO7Rr2pCqYQKRPiyJGyp+bzGeZEHIsuE2ICl5nh1LJ3mRaTDfOL3fEJ5cAhkrZB5RG2iP5Pi9gA8yRvqWTjGQLFQ+hvosT+80/oloPgBGbXaDidHAgscS1UPDuSM21JkrjXbEoCYoGPmZEYjM38fI5sCneWA1MXr5jp7RlATWfe9TV/6ddZ4PV7Nl+cVlJMf4xQmxq7zAdYrCtwEb/rpNPw1B3EYe+l7StFBrXCyZptZ73YYW7q2LWGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPfX9vBv1jkslcZdOLGRLng21/6SGotu4aPLh1sJXPU=;
 b=iucOlM2MrR5MnpB1y9vNT1VK/8PAI91yGe01DwEbtzdQ+YxGu+LNYCGLCYCKN9xwTuo1PguO7ufnFYW3MCjl2L5kAxS4bBZ5gZhosI18ABccUDkx+By4QywauTlI3m8Hax7AD8TjC5ozy9E3gFOBefGrm4Gxgs3HgkJ+H55TkjYDnQrZAdcVKY8Wt4d9Hqm9xBPmdzU47BJPs+8rDONcAH0UsgHdH915yD8QClYjSVBnl79KhY0rMZyCUQsDUIx+gMuTk9iJIwitSmsuuCjTLHqPYKA3y9Vk5aZ6RSKkORCU89i5UWIN4qfWULn6VaNcfda94vN2tM1RljpTMYnt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPfX9vBv1jkslcZdOLGRLng21/6SGotu4aPLh1sJXPU=;
 b=wi5yPooZVDlPopIokVz7x3bPkNGSBIVtj/KNum4/NADJDo2d2CQtzzJ+y6UT8fStSHacvqAJzdaRqTzl/GAc7YUDQI9DgOriLyWddmH5GLf97epqk2EV/7f4qLwEJ5aIK4Eieqfy3cOjInI7kxO5EXtl9pCNdbCWJhJfOsyjlgk=
Received: from AM6PR0702MB3527.eurprd07.prod.outlook.com (52.133.24.149) by
 AM6PR0702MB3654.eurprd07.prod.outlook.com (52.133.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.7; Thu, 12 Sep 2019 09:44:06 +0000
Received: from AM6PR0702MB3527.eurprd07.prod.outlook.com
 ([fe80::892c:2b90:e54f:ab56]) by AM6PR0702MB3527.eurprd07.prod.outlook.com
 ([fe80::892c:2b90:e54f:ab56%3]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 09:44:06 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Glavinic-Pecotic, Matija (EXT - DE/Ulm)" 
        <matija.glavinic-pecotic.ext@nokia.com>,
        "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Subject: [PATCH 0/3] Fix irq_domain vs. irq user race
Thread-Topic: [PATCH 0/3] Fix irq_domain vs. irq user race
Thread-Index: AQHVaU6eNBKq3/JPJUO/rZ6V9qcpDg==
Date:   Thu, 12 Sep 2019 09:44:06 +0000
Message-ID: <20190912094343.5480-1-alexander.sverdlin@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.2.21]
x-mailer: git-send-email 2.23.0
x-clientproxiedby: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To AM6PR0702MB3527.eurprd07.prod.outlook.com
 (2603:10a6:209:11::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8a274fd-0755-461a-ddc2-08d73765c09a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR0702MB3654;
x-ms-traffictypediagnostic: AM6PR0702MB3654:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0702MB36549A7D177F27880CCE883D88B00@AM6PR0702MB3654.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(64756008)(2501003)(6116002)(110136005)(5660300002)(53936002)(486006)(66066001)(386003)(6506007)(86362001)(6512007)(102836004)(186003)(26005)(316002)(8676002)(476003)(81156014)(2616005)(81166006)(6436002)(50226002)(3846002)(256004)(14444005)(6486002)(54906003)(1076003)(71190400001)(25786009)(66946007)(8936002)(2906002)(66556008)(66446008)(99286004)(4326008)(14454004)(36756003)(52116002)(71200400001)(107886003)(305945005)(66476007)(478600001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3654;H:AM6PR0702MB3527.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8T0g7eVc1eAvx6cqXrOElNCEa88CxhngXuEkifu3RfWbbVKsPPbTmtb3e1VZ1QLg15GgyBdcvKTKbFhV2FWWiqVryzi3tna3eeUPwAaiqja0kZbMsnfsSM/9QGSO2ZC4Uv6n0rcysah5T49HD81b4Ak5M89p63xWAFeGoKV82eN1XVYqlGIkCs+XIfnvW89IZ0mWi8OJPE8VBi4ycPYzGlJYs+PZbTxxJ8TQXYAQnmIJY5POKGf66YQBKvZsw9fduYYTFpbQp2Gyk9jauqkYvXpTimH8l8k3PuOQ+m+WTOz9ju6C/aJSWv5Kl3KLfQNufO9iajAQxKuszeMmtNCxyeFryFZdzK1tGgU9KaO3x+Un2+64hT+ytfhrnbGyI8v0R7DAnUqeC1H2kjCOS3U1cQD8qNq8cOzurS/h52YfOmo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a274fd-0755-461a-ddc2-08d73765c09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 09:44:06.0422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ru5Zvs3LIdrtKRbc+ZqE01cfjOpswJVkeQs5C2a2ekjP1y3kyn4ZQ94mxP3DmHm4AALipJT/7RI+0Q1QdT9BVJpTHdX1Tt7/5D3zabaxFD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Seems that the discovered race was here since adapting the PowerPC code
into genirq in 2012. I was surprized it went unnoticed all this time, but
it turns out, device registration (being it DT or ACPI) is mostly
sequential in kernel. In our case probe deferring was involved and another
independent probe(), so that the fatal sequence probably looked like
following:

CPU0					CPU1

					// probe() of irq-user-device
					// irq_domain not found =3D>
					// -EPROBE_DEFER

// probe of irq_domain,			// probe() of some unrelated device
// including typical in			// leading to re-try of
// drivers/irqchip pattern:		// irq-user-device probe(), calling
irq_domain_create()			of_irq_get()
for (...) irq_create_mapping()		=3D> irq_create_mapping()
	=3D> irq_find_mapping()			=3D> irq_find_mapping()
	=3D> irq_domain_alloc_descs()		=3D> irq_domain_alloc_descs()
	=3D> irq_domain_associate()
						=3D> irq_domain_associate()

irq_domain_associate() uses irq_domain_mutex internally, this doesn't help
however, because parallel calls to irq_create_mapping() return different
virq numbers and either the irq_domain driver is not able to perform
necessary configuration or the mapping the "slave" driver has got is being
overwritten by the controller driver and the virq "slave" got is never
triggered. The test code [1] reproduces the simplified scenario, which
doesn't involve real deferred probe.

As irq_find_mapping() is used in interrupt handlers it cannot take locks.
I didn't want to change the semantics of the exported
irq_domain_associate() (to remove the mutex from it and wrap
irq_find_mapping()-irq_domain_associate() pair into this mutex). Therefore
irq_domain_associate() was modified to detect the collisions and the
callers were modified to deal with this.

The race in irq_create_fwspec_mapping() is distinct, but has the same
nature: making a decision based on the result of unprotected
irq_find_mapping() call.

Alexander Sverdlin (3):
  genirq/irqdomain: Check for existing mapping in irq_domain_associate()
  genirq/irqdomain: Re-check mapping after associate in
    irq_create_mapping()
  genirq/irqdomain: Detect type race in irq_create_fwspec_mapping()

 kernel/irq/irqdomain.c | 90 ++++++++++++++++++++++++++++++----------------=
----
 1 file changed, 54 insertions(+), 36 deletions(-)

[1] Test kernel module:

// SPDX-License-Identifier: GPL-2.0
/**********************************************************************
 * Author: Alexander Sverdlin <alexander.sverdlin@nokia.com>
 *
 * Copyright (c) 2019 Nokia
 *
 * This module is intended to test the discovered race condition in
 * irq_create_mapping() function. The typical use case is when
 * irq_create_mapping() is being called from an IRQ controller driver
 * and of_irq_get() is used in a device driver requesting an IRQ from
 * the particular IRQ controller. But of_irq_get() is calling
 * irq_create_mapping() internally and this is the genuine race.
 **********************************************************************/

#include <linux/atomic.h>
#include <linux/irqdomain.h>
#include <linux/kernel.h>
#include <linux/kthread.h>
#include <linux/module.h>

static unsigned iterations =3D 1000;
module_param(iterations, uint, S_IRUGO);

static struct irq_domain *domain;
static atomic_t sync_begin =3D ATOMIC_INIT(0);
static atomic_t sync_end =3D ATOMIC_INIT(0);

static int icm_thread(void *data)
{
	unsigned *res =3D data;

	while (!kthread_should_stop()) {
		/* Wait until main thread signals start */
		if (!atomic_read(&sync_begin))
			continue;
		*res =3D irq_create_mapping(domain, 0);
		smp_mb__before_atomic();
		atomic_dec(&sync_begin);
		/* Wait until all test threads attepted the mapping */
		while (!kthread_should_stop())
			if (!atomic_read(&sync_begin))
				break;
		atomic_dec(&sync_end);
	}
	return 0;
}

static int irq_create_mapping_race_init(void)
{
	const static struct irq_domain_ops ops;
	struct task_struct *thr[2];
	unsigned irq[ARRAY_SIZE(thr)];
	unsigned i;
	int ret =3D 0;

	domain =3D irq_domain_create_linear(NULL, 2, &ops, NULL);
	if (!domain) {
		pr_err("irq_domain_create_linear() failed\n");
		return -EINVAL;
	}

	for (i =3D 0; i < ARRAY_SIZE(thr); i++)
		thr[i] =3D kthread_run(icm_thread, &irq[i], "icm_thr%u", i);

	for (i =3D 0; i < iterations; i++) {
		unsigned j;

		/* Signal test threads to attempt the mapping */
		atomic_add(ARRAY_SIZE(thr), &sync_end);
		atomic_add(ARRAY_SIZE(thr), &sync_begin);
		/* Wait until all threads have made an iteration */
		while (atomic_read(&sync_end))
			cpu_relax();
		smp_mb__after_atomic();

		for (j =3D 0; j < ARRAY_SIZE(thr); j++)
			if (!irq[j]) {
				pr_err("%s: %s got no virq\n", domain->name,
					thr[j]->comm);
				ret =3D -ENOENT;
				goto stop_threads;
			}

		for (j =3D 1; j < ARRAY_SIZE(thr); j++)
			if (irq[0] !=3D irq[j]) {
				pr_err("%s: %s got virq %u and %s got virq %u\n",
					domain->name, thr[0]->comm, irq[0],
					thr[j]->comm, irq[j]);
				ret =3D -EINVAL;
				goto stop_threads;
			}

		irq_dispose_mapping(irq[0]);
	}

stop_threads:
	for (i =3D 0; i < ARRAY_SIZE(thr); i++)
		kthread_stop(thr[i]);

	irq_domain_remove(domain);

	return ret;
}
module_init(irq_create_mapping_race_init);

static void __exit irq_create_mapping_race_exit(void)
{
}
module_exit(irq_create_mapping_race_exit);

MODULE_AUTHOR("Alexander Sverdlin <alexander.sverdlin@nokia.com>");
MODULE_DESCRIPTION("irq_create_mapping() race test module");
MODULE_LICENSE("GPL");
