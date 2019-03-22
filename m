Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34D82196F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256870;
	bh=yXfe8MBOurN2Cn3XFpvCcl1/QPU8hE3nCEHMYeRvhu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SeoMcrtWXcfzKy3SoJLbhwVbsy8P1faroc1YEFz3kRrbv+035Dy6f0rzB19vCnGXp
	 qBm0sDt2Bedwb1rxp94T7v8/C+cP1+S427g5FE6kEqEaZ84nrkqZJRqpZ5fSq36iHI
	 hCb8M5YgOnd5wqPgjB7x3g1Q/DxGBGZqLLydypuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfCVMO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389898AbfCVMO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E0332083D;
        Fri, 22 Mar 2019 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256865;
        bh=yXfe8MBOurN2Cn3XFpvCcl1/QPU8hE3nCEHMYeRvhu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv2TybLVLs0RYbraqTs3plJeJ/mceSWUKsmzu0vWpXt+Y+e891YgjjYWqvbWZV6rX
         RtDd9RZh/EjhTTgzj/9CGn3vCn8ny4kUzvtS0pwVvN1xb694b4ZF8MfOYMC4Lb+DOW
         jFs1sh7q7TcqLxpgwHzdIr+yDgnm/3cPc2MQKMX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Grzegorz Burzynski <grzegorz.burzynski@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.0 028/238] acpi/nfit: Fix bus command validation
Date:   Fri, 22 Mar 2019 12:14:07 +0100
Message-Id: <20190322111259.889044947@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit ebe9f6f19d80d8978d16078dff3d5bd93ad8d102 upstream.

Commit 11189c1089da "acpi/nfit: Fix command-supported detection" broke
ND_CMD_CALL for bus-level commands. The "func = cmd" assumption is only
valid for:

    ND_CMD_ARS_CAP
    ND_CMD_ARS_START
    ND_CMD_ARS_STATUS
    ND_CMD_CLEAR_ERROR

The function number otherwise needs to be pulled from the command
payload for:

    NFIT_CMD_TRANSLATE_SPA
    NFIT_CMD_ARS_INJECT_SET
    NFIT_CMD_ARS_INJECT_CLEAR
    NFIT_CMD_ARS_INJECT_GET

Update cmd_to_func() for the bus case and call it in the common path.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Cc: <stable@vger.kernel.org>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Grzegorz Burzynski <grzegorz.burzynski@intel.com>
Tested-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -415,7 +415,7 @@ static int cmd_to_func(struct nfit_mem *
 	if (call_pkg) {
 		int i;
 
-		if (nfit_mem->family != call_pkg->nd_family)
+		if (nfit_mem && nfit_mem->family != call_pkg->nd_family)
 			return -ENOTTY;
 
 		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
@@ -424,6 +424,10 @@ static int cmd_to_func(struct nfit_mem *
 		return call_pkg->nd_command;
 	}
 
+	/* In the !call_pkg case, bus commands == bus functions */
+	if (!nfit_mem)
+		return cmd;
+
 	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
 	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
 		return cmd;
@@ -454,17 +458,18 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
+	if (cmd == ND_CMD_CALL)
+		call_pkg = buf;
+	func = cmd_to_func(nfit_mem, cmd, call_pkg);
+	if (func < 0)
+		return func;
+
 	if (nvdimm) {
 		struct acpi_device *adev = nfit_mem->adev;
 
 		if (!adev)
 			return -ENOTTY;
 
-		if (cmd == ND_CMD_CALL)
-			call_pkg = buf;
-		func = cmd_to_func(nfit_mem, cmd, call_pkg);
-		if (func < 0)
-			return func;
 		dimm_name = nvdimm_name(nvdimm);
 		cmd_name = nvdimm_cmd_name(cmd);
 		cmd_mask = nvdimm_cmd_mask(nvdimm);
@@ -475,12 +480,9 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	} else {
 		struct acpi_device *adev = to_acpi_dev(acpi_desc);
 
-		func = cmd;
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
-		dsm_mask = cmd_mask;
-		if (cmd == ND_CMD_CALL)
-			dsm_mask = nd_desc->bus_dsm_mask;
+		dsm_mask = nd_desc->bus_dsm_mask;
 		desc = nd_cmd_bus_desc(cmd);
 		guid = to_nfit_uuid(NFIT_DEV_BUS);
 		handle = adev->handle;


