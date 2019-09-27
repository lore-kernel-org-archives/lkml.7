Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0E3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692721920
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="tjaJ3RT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfI0PAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:00:46 -0400
Received: from mail-eopbgr130133.outbound.protection.outlook.com ([40.107.13.133]:26241
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfI0PAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrLp+1SW6upOmQ3X+edMXhtw2nuFqPb/SZlsO/y1lsM6FkrEJIi+fviMWIeR1hy7aDUz0hegquWaCPKlMgl7FMHZkYH0ybaztCC0vOoSaMsL/MiDHHP5JbNPFC74OuQcMJobf+xUMaBQ/w2chC3zv4um3qX0j0bq0J8GSyaMlpsOU6YzeXtrxS09Tq70LSlX4MJwIlD+2HpDStysuwa67ClmlgqqSVwsOalFeF4dXokTW67AzaXBzjni4KS7ZogMsEfqRzyMaDgLEnIvQd+aBiFocIAp46UmQO/95LFjWBUYz5wFn7fT5kB3o5O/kbPCIwyI6EW2bDvb8sL+iYUrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b59dKrnzN9cgZ0NoxXhYI0vAboBlJrGoT7+mkMZ82i0=;
 b=fNkvug8BSJaSouJHnO9Ukq2vV6ZTzhbGsYLdv38ybCSWfn4E13fhQ6nLWmIpKwK+WN9uLsMmRR4pvyJxcJJwhDFUJTzWRo731YThqVtOEoDgCvi8fyq75QwYzcYpp2GBYCLn90Zk56jC2qXy7JwLLLkMLpdK24I5taNQXXZbPGduKX93a/pG8mV1lUuierzFpW3y0JqbRyoojM71rdB/Aadvt6q+efTLCYYIfYFlyVE15HceRFCRi4azei/mJcVZ+RNdlH56yC1jHascCBydHhBSruPJMi1tvLok/3AWzmxxWouyIYUZoamb0vqTs+9vDL4D2Fuz2CvvVwjj9vKNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b59dKrnzN9cgZ0NoxXhYI0vAboBlJrGoT7+mkMZ82i0=;
 b=tjaJ3RT4qAuREsK80Pp9wl5FKmpNxbSZxZ0u0nC5Y3cW8NzNBQSy9ZqNQ7YBXVWSbxvj+FKtJZLnG9L4CtbpX+tmKjuFAf6H+s7Db6l/6AzMaNFxcqy3uKePCRDSDJhqR9Z8LJ9sHBVJzawFVHOVeF1CnIEqo7coXOeSpmD4+wk=
Received: from AM6PR0702MB3527.eurprd07.prod.outlook.com (52.133.24.149) by
 AM6PR0702MB3749.eurprd07.prod.outlook.com (52.133.19.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 27 Sep 2019 15:00:42 +0000
Received: from AM6PR0702MB3527.eurprd07.prod.outlook.com
 ([fe80::7497:742a:1167:30dc]) by AM6PR0702MB3527.eurprd07.prod.outlook.com
 ([fe80::7497:742a:1167:30dc%6]) with mapi id 15.20.2305.013; Fri, 27 Sep 2019
 15:00:42 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Glavinic-Pecotic, Matija (EXT - DE/Ulm)" 
        <matija.glavinic-pecotic.ext@nokia.com>,
        "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Subject: [PATCH v2 0/3] Fix irq_domain vs. irq user race
Thread-Topic: [PATCH v2 0/3] Fix irq_domain vs. irq user race
Thread-Index: AQHVdURVGk4z3H5Yck6AwfIUam8zlg==
Date:   Fri, 27 Sep 2019 15:00:42 +0000
Message-ID: <20190927150025.26481-1-alexander.sverdlin@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.181]
x-mailer: git-send-email 2.23.0
x-clientproxiedby: HE1PR0102CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::19) To AM6PR0702MB3527.eurprd07.prod.outlook.com
 (2603:10a6:209:11::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b2f3ac3-c3de-4bfc-497f-08d7435b7784
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM6PR0702MB3749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0702MB3749AC67DD29BC61149B32CD88810@AM6PR0702MB3749.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(54534003)(2616005)(2906002)(6436002)(71190400001)(71200400001)(50226002)(7736002)(6512007)(4326008)(14454004)(478600001)(107886003)(52116002)(6486002)(25786009)(305945005)(66066001)(102836004)(3846002)(386003)(81156014)(256004)(6116002)(14444005)(186003)(486006)(8936002)(86362001)(8676002)(99286004)(316002)(81166006)(66556008)(5660300002)(66946007)(6506007)(1076003)(66476007)(36756003)(66446008)(110136005)(54906003)(26005)(2501003)(64756008)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3749;H:AM6PR0702MB3527.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOIJNnBYww0FL5aZmY6f+j92+HYWLutEiuF5cwUOmR7EoCzntJTO4+nLCvrKDu1+BefJC80zyUpl5vNKq8sbH3wmD8BYeo4SVLUzkrpzmDI5DEjQB1iITiW10YkLsjQ9y9ivDnpxX79UUX0lHhxr8m6S7qE7O+OHIk1DctD5WnqJ20QX1wUYIgm3k4g5mQXnjJoNKGiNKlcNrCVxE7KvKTKjW8scB4xtN2fKQ11V6T4lJ6PZ6X0CQyrY6sx5vqb/zZFNDla4jo9+GmQ17+wonVa1VSgkHjnmEn4YBACO64khgbLTOijDqh3GsBendnzClZX/y9e+BQRGSL/CicDigxesj81kDd4v6nx7hZ6pLuPv5g1G0rxWXoXkosfYDv3/cmU1un0RadwUi9h+a9KpuO1MLTnEhBoVlXPcpozmI6A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2f3ac3-c3de-4bfc-497f-08d7435b7784
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 15:00:42.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nLoSbBsHMB13Dv01TjsrFOqQCd4lTqps6tK8nFddJKrJXKm1/3DbSMecbed9dBjKXjAsbPh5FX/cTZVbKk4w7ZUUvc6YZqp0xN6f0wiZzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3749
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

 kernel/irq/irqdomain.c | 88 +++++++++++++++++++++++++++++-----------------=
----
 1 file changed, 52 insertions(+), 36 deletions(-)

Changelog:
v2:
	- EBUSY -> EEXIST
	- Only try to find existing mapping if irq_domain_associate() found
	  one

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
