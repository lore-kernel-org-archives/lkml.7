Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF5BC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E012521D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611225;
	bh=zqd0Xs81UrAk7v3S1WB4SCmtWVy6g8W6FdI68lwJIk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ELC2JfVL8xokAccWHhNpbpQjNEdxMRnyqyp/F4YNNUWbZ/nrKz8RtkaKXzE3lA/o4
	 eSwx7qdqX0yV7PgYcq4sylUXmxj4VWYx3zW8b2VnJj3zFfi98kAv6UgvoBmkdw+joU
	 3++7XuOVyN6rxlg/LTGFg3FgR/l1XttOr6sY8ga4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfKMCNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbfKMB5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74669222D4;
        Wed, 13 Nov 2019 01:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610250;
        bh=zqd0Xs81UrAk7v3S1WB4SCmtWVy6g8W6FdI68lwJIk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqda6ELryAStnwyFi1XLW1VCKDFzjReyZJ8vD7GVtx4Ye0NtAQIavay6XpoPC1sjY
         XTUCPRJ2HOO42fe6GcLKilR73tsBmSL6G6KJl9lrXCchDJeiKFJj6f217QdesmiraC
         0Aps4O2Na3KJx7TNjSAKNTa/SwoS1DuQBjvPPNic=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 4.14 047/115] ACPICA: Never run _REG on system_memory and system_IO
Date:   Tue, 12 Nov 2019 20:55:14 -0500
Message-Id: <20191113015622.11592-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

[ Upstream commit 8b1cafdcb4b75c5027c52f1e82b47ebe727ad7ed ]

These address spaces are defined by the ACPI spec to be
"always available", and thus _REG should never be run on them.
Provides compatibility with other ACPI implementations.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/acevents.h |  2 ++
 drivers/acpi/acpica/aclocal.h  |  2 +-
 drivers/acpi/acpica/evregion.c | 17 +++++++++++++++--
 drivers/acpi/acpica/evrgnini.c |  6 +-----
 drivers/acpi/acpica/evxfregn.c |  1 -
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index a2adfd42f85cc..bfddcd989974f 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -245,6 +245,8 @@ acpi_ev_default_region_setup(acpi_handle handle,
 
 acpi_status acpi_ev_initialize_region(union acpi_operand_object *region_obj);
 
+u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node);
+
 /*
  * evsci - SCI (System Control Interrupt) handling/dispatch
  */
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 0d45b8bb16789..b10e92de7dd84 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -429,9 +429,9 @@ struct acpi_simple_repair_info {
 /* Info for running the _REG methods */
 
 struct acpi_reg_walk_info {
-	acpi_adr_space_type space_id;
 	u32 function;
 	u32 reg_run_count;
+	acpi_adr_space_type space_id;
 };
 
 /*****************************************************************************
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 28b447ff92df6..3a3277f982923 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -677,6 +677,19 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 
 	ACPI_FUNCTION_TRACE(ev_execute_reg_methods);
 
+	/*
+	 * These address spaces do not need a call to _REG, since the ACPI
+	 * specification defines them as: "must always be accessible". Since
+	 * they never change state (never become unavailable), no need to ever
+	 * call _REG on them. Also, a data_table is not a "real" address space,
+	 * so do not call _REG. September 2018.
+	 */
+	if ((space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) ||
+	    (space_id == ACPI_ADR_SPACE_SYSTEM_IO) ||
+	    (space_id == ACPI_ADR_SPACE_DATA_TABLE)) {
+		return_VOID;
+	}
+
 	info.space_id = space_id;
 	info.function = function;
 	info.reg_run_count = 0;
@@ -738,8 +751,8 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 	}
 
 	/*
-	 * We only care about regions.and objects that are allowed to have address
-	 * space handlers
+	 * We only care about regions and objects that are allowed to have
+	 * address space handlers
 	 */
 	if ((node->type != ACPI_TYPE_REGION) && (node != acpi_gbl_root_node)) {
 		return (AE_OK);
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 93ec528bcd9a9..3b48f1ecb55b1 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -50,9 +50,6 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evrgnini")
 
-/* Local prototypes */
-static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_system_memory_region_setup
@@ -67,7 +64,6 @@ static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node);
  * DESCRIPTION: Setup a system_memory operation region
  *
  ******************************************************************************/
-
 acpi_status
 acpi_ev_system_memory_region_setup(acpi_handle handle,
 				   u32 function,
@@ -347,7 +343,7 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
  *
  ******************************************************************************/
 
-static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
+u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 {
 	acpi_status status;
 	struct acpi_pnp_device_id *hid;
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index beba9d56a0d87..742a9fe6e235d 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -227,7 +227,6 @@ acpi_remove_address_space_handler(acpi_handle device,
 				 */
 				region_obj =
 				    handler_obj->address_space.region_list;
-
 			}
 
 			/* Remove this Handler object from the list */
-- 
2.20.1

