Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7774E21B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256867;
	bh=bfuWdqeEb8aFJwwNtm6ZM9g06aLfUDMNwN9XoNxUYQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c6H9F5CVYYAZdZbJkppnQg4GafE8hrzKW+of9k1gsoOp0f7wcFW8fzI2Cs8trt0oy
	 wu43sjSBVJPEJblkCH+SiOeelrXXJXF4WuNCBJI3wfx8rLGDdQvh1HwMsfztXXyMVP
	 LkgjeuW5EQgtW9DSVplvNjLsXhQYUfHG2v7S86SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389900AbfCVMOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389869AbfCVMOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44937218A5;
        Fri, 22 Mar 2019 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256858;
        bh=bfuWdqeEb8aFJwwNtm6ZM9g06aLfUDMNwN9XoNxUYQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zj7YxAkPR8qBiu1Wx6dGaQhcNbGV32E6tnsfFChqnOqGrqPY1BR29NOIuGoLjLaM5
         0SI03iqIvK8kAEMtkNAkQiSYPO3yUkK/ZhnEGaN8P3hM/MDw5aFlouOQty0ZR+ZLOU
         H8qnXbaw9Ipq1XiwV87AduCjzChApcv8ZtBCS2+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.0 026/238] nfit: Fix nfit_intel_shutdown_status() command submission
Date:   Fri, 22 Mar 2019 12:14:05 +0100
Message-Id: <20190322111259.740446487@linuxfoundation.org>
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

commit f596c8844fe1d0022007ae6c7a377361fb653eff upstream.

The implementation is broken in all the ways the unit test did not touch:

1/ The local definition of in_buf and in_obj violated C99 initializer
   expectations for zeroing. By only initializing 2 out of the three
   struct members the compiler was free to zero-initialize the remaining
   entry even though the aliased location in the union was initialized.

2/ The implementation made assumptions about the state of the 'smart'
   payload after command execution that are satisfied by
   acpi_nfit_ctl(), but not acpi_evaluate_dsm().

3/ populate_shutdown_status() is skipped on Intel NVDIMMs due to the early
   return for skipping the common _LS{I,R,W} enabling.

4/ The input length should be zero.

This breakage was missed due to the unit test implementation only
testing the case where nfit_intel_shutdown_status() returns a valid
payload.

Much of this complexity would be saved if acpi_nfit_ctl() could be used, but
that currently requires a 'struct nvdimm *' argument and one is not created
until later in the init process. The health result is needed before the device
is created because the payload gates whether the nmemX/nfit/dirty_shutdown
property is visible in sysfs.

Cc: <stable@vger.kernel.org>
Fixes: 0ead11181fe0 ("acpi, nfit: Collect shutdown status")
Reported-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1759,14 +1759,14 @@ static bool acpi_nvdimm_has_method(struc
 
 __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 {
+	struct device *dev = &nfit_mem->adev->dev;
 	struct nd_intel_smart smart = { 0 };
 	union acpi_object in_buf = {
-		.type = ACPI_TYPE_BUFFER,
-		.buffer.pointer = (char *) &smart,
-		.buffer.length = sizeof(smart),
+		.buffer.type = ACPI_TYPE_BUFFER,
+		.buffer.length = 0,
 	};
 	union acpi_object in_obj = {
-		.type = ACPI_TYPE_PACKAGE,
+		.package.type = ACPI_TYPE_PACKAGE,
 		.package.count = 1,
 		.package.elements = &in_buf,
 	};
@@ -1781,8 +1781,15 @@ __weak void nfit_intel_shutdown_status(s
 		return;
 
 	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
-	if (!out_obj)
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
+			|| out_obj->buffer.length < sizeof(smart)) {
+		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
+				dev_name(dev));
+		ACPI_FREE(out_obj);
 		return;
+	}
+	memcpy(&smart, out_obj->buffer.pointer, sizeof(smart));
+	ACPI_FREE(out_obj);
 
 	if (smart.flags & ND_INTEL_SMART_SHUTDOWN_VALID) {
 		if (smart.shutdown_state)
@@ -1793,7 +1800,6 @@ __weak void nfit_intel_shutdown_status(s
 		set_bit(NFIT_MEM_DIRTY_COUNT, &nfit_mem->flags);
 		nfit_mem->dirty_shutdown = smart.shutdown_count;
 	}
-	ACPI_FREE(out_obj);
 }
 
 static void populate_shutdown_status(struct nfit_mem *nfit_mem)
@@ -1915,18 +1921,19 @@ static int acpi_nfit_add_dimm(struct acp
 		| 1 << ND_CMD_SET_CONFIG_DATA;
 	if (family == NVDIMM_FAMILY_INTEL
 			&& (dsm_mask & label_mask) == label_mask)
-		return 0;
-
-	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
-			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
-		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
-		set_bit(NFIT_MEM_LSR, &nfit_mem->flags);
-	}
-
-	if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)
-			&& acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
-		dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
-		set_bit(NFIT_MEM_LSW, &nfit_mem->flags);
+		/* skip _LS{I,R,W} enabling */;
+	else {
+		if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
+				&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
+			dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
+			set_bit(NFIT_MEM_LSR, &nfit_mem->flags);
+		}
+
+		if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)
+				&& acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
+			dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
+			set_bit(NFIT_MEM_LSW, &nfit_mem->flags);
+		}
 	}
 
 	populate_shutdown_status(nfit_mem);


