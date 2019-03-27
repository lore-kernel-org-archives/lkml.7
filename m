Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C0120651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfC0PMq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:12:46 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:56629 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfC0PMp (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Wed, 27 Mar 2019 11:12:45 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 27 Mar 2019 09:12:44 -0600
Message-Id: <5C9B92EA020000780022227B@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 27 Mar 2019 09:12:42 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Stefano Stabellini" <sstabellini@kernel.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>
Cc:     "xen-devel" <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/Xen: streamline (and fix) PV CPU enumeration
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started out with me noticing that "dom0_max_vcpus=<N>" with <N>
larger than the number of physical CPUs reported through ACPI tables
would not bring up the "excess" vCPU-s.

Noticing that xen_fill_possible_map() gets called way too early, whereas
xen_filter_cpu_maps() gets called too late (after per-CPU areas were
already set up), and further observing that each of the functions serves
only one of Dom0 or DomU, it looked like it was better to simplify this.
Use the .get_smp_config hook instead, uniformly for Dom0 and DomU.
xen_fill_possible_map() can be dropped altogether, while
xen_filter_cpu_maps() gets re-purposed but not otherwise changed.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/xen/enlighten_pv.c |    4 ----
 arch/x86/xen/smp_pv.c       |   26 ++++++--------------------
 2 files changed, 6 insertions(+), 24 deletions(-)

--- 5.1-rc2/arch/x86/xen/enlighten_pv.c
+++ 5.1-rc2-xen-x86-Dom0-more-vCPUs/arch/x86/xen/enlighten_pv.c
@@ -1381,10 +1381,6 @@ asmlinkage __visible void __init xen_sta
 
 		xen_acpi_sleep_register();
 
-		/* Avoid searching for BIOS MP tables */
-		x86_init.mpparse.find_smp_config = x86_init_noop;
-		x86_init.mpparse.get_smp_config = x86_init_uint_noop;
-
 		xen_boot_params_init_edd();
 	}
 
--- 5.1-rc2/arch/x86/xen/smp_pv.c
+++ 5.1-rc2-xen-x86-Dom0-more-vCPUs/arch/x86/xen/smp_pv.c
@@ -146,28 +146,12 @@ int xen_smp_intr_init_pv(unsigned int cp
 	return rc;
 }
 
-static void __init xen_fill_possible_map(void)
-{
-	int i, rc;
-
-	if (xen_initial_domain())
-		return;
-
-	for (i = 0; i < nr_cpu_ids; i++) {
-		rc = HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL);
-		if (rc >= 0) {
-			num_processors++;
-			set_cpu_possible(i, true);
-		}
-	}
-}
-
-static void __init xen_filter_cpu_maps(void)
+static void __init _get_smp_config(unsigned int early)
 {
 	int i, rc;
 	unsigned int subtract = 0;
 
-	if (!xen_initial_domain())
+	if (early)
 		return;
 
 	num_processors = 0;
@@ -217,7 +201,6 @@ static void __init xen_pv_smp_prepare_bo
 	loadsegment(es, __USER_DS);
 #endif
 
-	xen_filter_cpu_maps();
 	xen_setup_vcpu_info_placement();
 
 	/*
@@ -503,5 +486,8 @@ static const struct smp_ops xen_smp_ops
 void __init xen_smp_init(void)
 {
 	smp_ops = xen_smp_ops;
-	xen_fill_possible_map();
+
+	/* Avoid searching for BIOS MP tables */
+	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.get_smp_config = _get_smp_config;
 }





