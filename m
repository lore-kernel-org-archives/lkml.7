Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EFEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D36A21556
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLJMNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:13:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58063 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLJMNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:13:30 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5435d2d466e1b89a; Tue, 10 Dec 2019 13:13:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC v2][PATCH 9/9] intel_idle: Add module parameter to prevent ACPI _CST from being used
Date:   Tue, 10 Dec 2019 13:13:14 +0100
Message-ID: <2442105.UMyhRX9LH8@kreacher>
In-Reply-To: <35821518.IbFVMVmUy3@kreacher>
References: <35821518.IbFVMVmUy3@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new module parameter called "no_acpi" to the intel_idle driver
to allow the driver to be prevented from using ACPI _CST via kernel
command line.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1138,6 +1138,10 @@ static bool intel_idle_max_cstate_reache
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 #include <acpi/processor.h>
 
+static bool no_acpi __read_mostly;
+module_param(no_acpi, bool, 0444);
+MODULE_PARM_DESC(no_acpi, "Do not use ACPI _CST for building the idle states list");
+
 static struct acpi_processor_power acpi_state_table;
 
 /**
@@ -1167,6 +1171,11 @@ static bool intel_idle_acpi_cst_extract(
 {
 	unsigned int cpu;
 
+	if (no_acpi) {
+		pr_debug("Not allowed to use ACPI _CST\n");
+		return false;
+	}
+
 	for_each_possible_cpu(cpu) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 



