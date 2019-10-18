Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DBBCA9ED2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C95D21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504291AbfJRFGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:06:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504043AbfJRFFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D01C7D78D169807BFF5D;
        Fri, 18 Oct 2019 11:19:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 08/33] acpi: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:25 +0800
Message-ID: <20191018031850.48498-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: James Morse <james.morse@arm.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/apei/apei-base.c | 36 +++++++++++++++++------------------
 drivers/acpi/apei/einj.c      |  4 ++--
 drivers/acpi/apei/erst-dbg.c  |  5 ++---
 drivers/acpi/apei/ghes.c      | 25 ++++++++++++------------
 drivers/acpi/apei/hest.c      | 14 +++++++-------
 drivers/acpi/battery.c        |  2 +-
 drivers/acpi/resource.c       |  4 ++--
 7 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 131c35ee9ed3..1bb2a94f49a3 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -170,7 +170,7 @@ int __apei_exec_run(struct apei_exec_context *ctx, u8 action,
 		if (ip == ctx->ip) {
 			if (entry->instruction >= ctx->instructions ||
 			    !ctx->ins_table[entry->instruction].run) {
-				pr_warning(FW_WARN APEI_PFX
+				pr_warn(FW_WARN APEI_PFX
 			"Invalid action table, unknown instruction type: %d\n",
 					   entry->instruction);
 				return -EINVAL;
@@ -211,7 +211,7 @@ static int apei_exec_for_each_entry(struct apei_exec_context *ctx,
 		if (end)
 			*end = i;
 		if (ins >= ctx->instructions || !ins_table[ins].run) {
-			pr_warning(FW_WARN APEI_PFX
+			pr_warn(FW_WARN APEI_PFX
 			"Invalid action table, unknown instruction type: %d\n",
 				   ins);
 			return -EINVAL;
@@ -579,18 +579,18 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	space_id = reg->space_id;
 	*paddr = get_unaligned(&reg->address);
 	if (!*paddr) {
-		pr_warning(FW_BUG APEI_PFX
-			   "Invalid physical address in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+		pr_warn(FW_BUG APEI_PFX
+			"Invalid physical address in GAR [0x%llx/%u/%u/%u/%u]\n",
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 
 	if (access_size_code < 1 || access_size_code > 4) {
-		pr_warning(FW_BUG APEI_PFX
-			   "Invalid access size code in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+		pr_warn(FW_BUG APEI_PFX
+			"Invalid access size code in GAR [0x%llx/%u/%u/%u/%u]\n",
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 	*access_bit_width = 1UL << (access_size_code + 2);
@@ -604,19 +604,19 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 		*access_bit_width = 64;
 
 	if ((bit_width + bit_offset) > *access_bit_width) {
-		pr_warning(FW_BUG APEI_PFX
-			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+		pr_warn(FW_BUG APEI_PFX
+			"Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 
 	if (space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
 	    space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
-		pr_warning(FW_BUG APEI_PFX
-			   "Invalid address space type in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+		pr_warn(FW_BUG APEI_PFX
+			"Invalid address space type in GAR [0x%llx/%u/%u/%u/%u]\n",
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index e430cf4caec2..086373f8ccb1 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -172,7 +172,7 @@ static int einj_get_available_error_type(u32 *type)
 static int einj_timedout(u64 *t)
 {
 	if ((s64)*t < SPIN_UNIT) {
-		pr_warning(FW_WARN "Firmware does not respond in time\n");
+		pr_warn(FW_WARN "Firmware does not respond in time\n");
 		return 1;
 	}
 	*t -= SPIN_UNIT;
@@ -312,7 +312,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	}
 	rc = einj_check_trigger_header(trigger_tab);
 	if (rc) {
-		pr_warning(FW_BUG "Invalid trigger error action table.\n");
+		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index d0f3a46716e9..c740f0faad39 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -118,9 +118,8 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
-		pr_warning(ERST_DBG_PFX
-			   "Record (ID: 0x%llx) length is too long: %zd\n",
-			   id, len);
+		pr_warn(ERST_DBG_PFX
+			"Record (ID: 0x%llx) length is too long: %zd\n", id, len);
 		rc = -EIO;
 		goto out;
 	}
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 777f6f7122b4..8906c80175e6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -235,10 +235,10 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		goto err_unmap_read_ack_addr;
 	error_block_length = generic->error_block_length;
 	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
-		pr_warning(FW_WARN GHES_PFX
-			   "Error status block length is too long: %u for "
-			   "generic hardware error source: %d.\n",
-			   error_block_length, generic->header.source_id);
+		pr_warn(FW_WARN GHES_PFX
+			"Error status block length is too long: %u for "
+			"generic hardware error source: %d.\n",
+			error_block_length, generic->header.source_id);
 		error_block_length = GHES_ESTATUS_MAX_SIZE;
 	}
 	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
@@ -748,8 +748,8 @@ static void ghes_add_timer(struct ghes *ghes)
 	unsigned long expire;
 
 	if (!g->notify.poll_interval) {
-		pr_warning(FW_WARN GHES_PFX "Poll interval is 0 for generic hardware error source: %d, disabled.\n",
-			   g->header.source_id);
+		pr_warn(FW_WARN GHES_PFX "Poll interval is 0 for generic hardware error source: %d, disabled.\n",
+			g->header.source_id);
 		return;
 	}
 	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
@@ -1155,21 +1155,20 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		}
 		break;
 	case ACPI_HEST_NOTIFY_LOCAL:
-		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
-			   generic->header.source_id);
+		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
+			generic->header.source_id);
 		goto err;
 	default:
-		pr_warning(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
-			   generic->notify.type, generic->header.source_id);
+		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
+			generic->notify.type, generic->header.source_id);
 		goto err;
 	}
 
 	rc = -EIO;
 	if (generic->error_block_length <
 	    sizeof(struct acpi_hest_generic_status)) {
-		pr_warning(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
-			   generic->error_block_length,
-			   generic->header.source_id);
+		pr_warn(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
+			generic->error_block_length, generic->header.source_id);
 		goto err;
 	}
 	ghes = ghes_new(generic);
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 267bdbf6a7bf..822402480f7d 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -92,15 +92,15 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 	for (i = 0; i < hest_tab->error_source_count; i++) {
 		len = hest_esrc_len(hest_hdr);
 		if (!len) {
-			pr_warning(FW_WARN HEST_PFX
-				   "Unknown or unused hardware error source "
-				   "type: %d for hardware error source: %d.\n",
-				   hest_hdr->type, hest_hdr->source_id);
+			pr_warn(FW_WARN HEST_PFX
+				"Unknown or unused hardware error source "
+				"type: %d for hardware error source: %d.\n",
+				hest_hdr->type, hest_hdr->source_id);
 			return -EINVAL;
 		}
 		if ((void *)hest_hdr + len >
 		    (void *)hest_tab + hest_tab->header.length) {
-			pr_warning(FW_BUG HEST_PFX
+			pr_warn(FW_BUG HEST_PFX
 		"Table contents overflow for hardware error source: %d.\n",
 				hest_hdr->source_id);
 			return -EINVAL;
@@ -164,8 +164,8 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 		ghes_dev = ghes_arr->ghes_devs[i];
 		hdr = *(struct acpi_hest_header **)ghes_dev->dev.platform_data;
 		if (hdr->source_id == hest_hdr->source_id) {
-			pr_warning(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
-				   hdr->source_id);
+			pr_warn(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
+				hdr->source_id);
 			return -EIO;
 		}
 	}
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 558fedf8a7a1..8f0e0c8d8c3d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1176,7 +1176,7 @@ static const struct file_operations acpi_battery_alarm_fops = {
 
 static int acpi_battery_add_fs(struct acpi_device *device)
 {
-	pr_warning(PREFIX "Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
+	pr_warn(PREFIX "Deprecated procfs I/F for battery is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_battery_dir);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 2a3e392751e0..3b4448972374 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -413,8 +413,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
 		if (triggering != trig || polarity != pol) {
-			pr_warning("ACPI: IRQ %d override to %s, %s\n", gsi,
-				   t ? "level" : "edge", p ? "low" : "high");
+			pr_warn("ACPI: IRQ %d override to %s, %s\n", gsi,
+				t ? "level" : "edge", p ? "low" : "high");
 			triggering = trig;
 			polarity = pol;
 		}
-- 
2.20.1

