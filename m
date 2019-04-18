Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D048C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D64218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610501;
	bh=Yd483WQDUOqCEWr1PfMoQRdh+X9xT1n4LNNnaBSLP5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yn6ntIXzPQMgkXjxk5kRGh775KowWI1h6na2E63KB/uBm9rOpZB9NoiXQphDwY0Mc
	 nKarWDH09C17du5GFEaW2TjGxTDEg2K7AQ4o/qeczpzomG+LXo7AI6IB+upEwI+4RZ
	 ihb4smlvVs5ykaDxQj+LLAmkWmXIT2CnO+U2nEPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390602AbfDRSBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390589AbfDRSBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FC5217FA;
        Thu, 18 Apr 2019 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610495;
        bh=Yd483WQDUOqCEWr1PfMoQRdh+X9xT1n4LNNnaBSLP5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWeRNYJGCrIVxwbtk5TCFQcCO7EFgboq5+c8TiQ2WQ+CIL6VDjp+z7CxuUCYfxfb4
         B0JGERnKhUZYC4SWU+9vk7/HEEf6pw2VJ9X11HUnJTaVTK2Pwl/2WvTI1ePFOHyV0T
         mcpMBxDNlMc2JplAnUDCjEFEQi8pdzHAcXA0bZ7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/110] ACPI: EC / PM: Disable non-wakeup GPEs for suspend-to-idle
Date:   Thu, 18 Apr 2019 19:57:11 +0200
Message-Id: <20190418160445.865813857@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f941d3e41da7f86bdb9dcc1977c2bcc6b89bfe47 ]

There are systems in which non-wakeup GPEs fire during the "noirq"
suspend stage of suspending devices and that effectively prevents the
system that tries to suspend to idle from entering any low-power
state at all.  If the offending GPE fires regularly and often enough,
the system appears to be suspended, but in fact it is in a tight loop
over "noirq" suspend and "noirq" resume of devices all the time.

To prevent that from happening, disable all non-wakeup GPEs except
for the EC GPE for suspend-to-idle (the EC GPE is special, because
on some systems it has to be enabled for power button wakeup events
to be generated as expected).

Fixes: 147a7d9d25ca (ACPI / PM: Do not reconfigure GPEs for suspend-to-idle)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201987
Reported-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c       | 12 ++++++++++++
 drivers/acpi/internal.h |  2 ++
 drivers/acpi/sleep.c    | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d4e5610e09c5..9d66a47d32fb 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1034,6 +1034,18 @@ void acpi_ec_unblock_transactions(void)
 		acpi_ec_start(first_ec, true);
 }
 
+void acpi_ec_mark_gpe_for_wake(void)
+{
+	if (first_ec && !ec_no_wakeup)
+		acpi_mark_gpe_for_wake(NULL, first_ec->gpe);
+}
+
+void acpi_ec_set_gpe_wake_mask(u8 action)
+{
+	if (first_ec && !ec_no_wakeup)
+		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
+}
+
 void acpi_ec_dispatch_gpe(void)
 {
 	if (first_ec)
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 530a3f675490..f59d0b9e2683 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -188,6 +188,8 @@ int acpi_ec_ecdt_probe(void);
 int acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
+void acpi_ec_mark_gpe_for_wake(void);
+void acpi_ec_set_gpe_wake_mask(u8 action);
 void acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 754d59f95500..74c489047f57 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -940,6 +940,8 @@ static int lps0_device_attach(struct acpi_device *adev,
 
 		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
 				  bitmask);
+
+		acpi_ec_mark_gpe_for_wake();
 	} else {
 		acpi_handle_debug(adev->handle,
 				  "_DSM function 0 evaluation failed\n");
@@ -968,11 +970,16 @@ static int acpi_s2idle_prepare(void)
 	if (lps0_device_handle) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
 	}
 
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
 
+	/* Change the configuration of GPEs to avoid spurious wakeup. */
+	acpi_enable_all_wakeup_gpes();
+	acpi_os_wait_events_complete();
 	return 0;
 }
 
@@ -1017,10 +1024,14 @@ static void acpi_s2idle_sync(void)
 
 static void acpi_s2idle_restore(void)
 {
+	acpi_enable_all_runtime_gpes();
+
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
 
 	if (lps0_device_handle) {
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
 	}
-- 
2.19.1



