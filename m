Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963F8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608ED2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfCLVu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:50:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:14251 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfCLVu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:50:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 14:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="133785247"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007.fm.intel.com with ESMTP; 12 Mar 2019 14:50:28 -0700
Subject: [PATCH] acpi/nfit: Always dump _DSM output payload
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Mar 2019 14:37:49 -0700
Message-ID: <155242666957.581839.11006696811038518218.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic-debug statements for command payload output only get emitted
when the command is not ND_CMD_CALL. Move the output payload dumping
ahead of the early return path for ND_CMD_CALL.

Fixes: 31eca76ba2fc9 ("...whitelisted dimm command marshaling mechanism")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a22e2f2bbb75..c9367e78521b 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -546,6 +546,12 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		goto out;
 	}
 
+	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
+			cmd_name, out_obj->buffer.length);
+	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
+			out_obj->buffer.pointer,
+			min_t(u32, 128, out_obj->buffer.length), true);
+
 	if (call_pkg) {
 		call_pkg->nd_fw_size = out_obj->buffer.length;
 		memcpy(call_pkg->nd_payload + call_pkg->nd_size_in,
@@ -564,12 +570,6 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		return 0;
 	}
 
-	dev_dbg(dev, "%s cmd: %s output length: %d\n", dimm_name,
-			cmd_name, out_obj->buffer.length);
-	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
-			out_obj->buffer.pointer,
-			min_t(u32, 128, out_obj->buffer.length), true);
-
 	for (i = 0, offset = 0; i < desc->out_num; i++) {
 		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i, buf,
 				(u32 *) out_obj->buffer.pointer,

