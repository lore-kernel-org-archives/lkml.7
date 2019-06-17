Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AC72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806572;
	bh=s5RU2z2EeN8CvBgLSIQwUVZ59OMSqmNvSR+IMSGrvgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PKhYJqix/oSZUk64s9dPqgSxuw9GBext77SaE9QtteL9xsacXUWEdPUwpH6D0XkTC
	 GD5yss6cRuJ/GbKtOaxI4GeiDWZccAFAjBLXCgIOtK5MRoCUH5i6uknKsnmLmTQr+u
	 BGcsx2Q7wg0CGrLbuL23fWfV+kow+l8+poaYn7mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfFQVWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbfFQVWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10439206B7;
        Mon, 17 Jun 2019 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806565;
        bh=s5RU2z2EeN8CvBgLSIQwUVZ59OMSqmNvSR+IMSGrvgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jj/rwIPv/Kc+78bufKe+uKBJcuE/dYqyli+Rpq3G6elQAmuyFNwIm3FXuvuihcqNg
         8+z6tH5NQBOPmKFJ+rcsIztEnkHCzLsuhrdjt01x8Q2D4le+1Kh4447UIfGclJETTP
         B7qhmvb6ObQNZV0FCbmtvhXnVEjNJ9jew1QMezbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.1 041/115] drm/i915/dmc: protect against reading random memory
Date:   Mon, 17 Jun 2019 23:09:01 +0200
Message-Id: <20190617210802.120521623@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit 326fb6dd1483c985a6ef47db3fa8788bb99e8b83 upstream.

While loading the DMC firmware we were double checking the headers made
sense, but in no place we checked that we were actually reading memory
we were supposed to. This could be wrong in case the firmware file is
truncated or malformed.

Before this patch:
	# ls -l /lib/firmware/i915/icl_dmc_ver1_07.bin
	-rw-r--r-- 1 root root  25716 Feb  1 12:26 icl_dmc_ver1_07.bin
	# truncate -s 25700 /lib/firmware/i915/icl_dmc_ver1_07.bin
	# modprobe i915
	# dmesg| grep -i dmc
	[drm:intel_csr_ucode_init [i915]] Loading i915/icl_dmc_ver1_07.bin
	[drm] Finished loading DMC firmware i915/icl_dmc_ver1_07.bin (v1.7)

i.e. it loads random data. Now it fails like below:
	[drm:intel_csr_ucode_init [i915]] Loading i915/icl_dmc_ver1_07.bin
	[drm:csr_load_work_fn [i915]] *ERROR* Truncated DMC firmware, rejecting.
	i915 0000:00:02.0: Failed to load DMC firmware i915/icl_dmc_ver1_07.bin. Disabling runtime power management.
	i915 0000:00:02.0: DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915

Before reading any part of the firmware file, validate the input first.

Fixes: eb805623d8b1 ("drm/i915/skl: Add support to load SKL CSR firmware.")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190605235535.17791-1-lucas.demarchi@intel.com
(cherry picked from commit bc7b488b1d1c71dc4c5182206911127bc6c410d6)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_csr.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/gpu/drm/i915/intel_csr.c
+++ b/drivers/gpu/drm/i915/intel_csr.c
@@ -300,10 +300,17 @@ static u32 *parse_csr_fw(struct drm_i915
 	u32 dmc_offset = CSR_DEFAULT_FW_OFFSET, readcount = 0, nbytes;
 	u32 i;
 	u32 *dmc_payload;
+	size_t fsize;
 
 	if (!fw)
 		return NULL;
 
+	fsize = sizeof(struct intel_css_header) +
+		sizeof(struct intel_package_header) +
+		sizeof(struct intel_dmc_header);
+	if (fsize > fw->size)
+		goto error_truncated;
+
 	/* Extract CSS Header information*/
 	css_header = (struct intel_css_header *)fw->data;
 	if (sizeof(struct intel_css_header) !=
@@ -363,6 +370,9 @@ static u32 *parse_csr_fw(struct drm_i915
 	/* Convert dmc_offset into number of bytes. By default it is in dwords*/
 	dmc_offset *= 4;
 	readcount += dmc_offset;
+	fsize += dmc_offset;
+	if (fsize > fw->size)
+		goto error_truncated;
 
 	/* Extract dmc_header information. */
 	dmc_header = (struct intel_dmc_header *)&fw->data[readcount];
@@ -394,6 +404,10 @@ static u32 *parse_csr_fw(struct drm_i915
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
 	nbytes = dmc_header->fw_size * 4;
+	fsize += nbytes;
+	if (fsize > fw->size)
+		goto error_truncated;
+
 	if (nbytes > csr->max_fw_size) {
 		DRM_ERROR("DMC FW too big (%u bytes)\n", nbytes);
 		return NULL;
@@ -407,6 +421,10 @@ static u32 *parse_csr_fw(struct drm_i915
 	}
 
 	return memcpy(dmc_payload, &fw->data[readcount], nbytes);
+
+error_truncated:
+	DRM_ERROR("Truncated DMC firmware, rejecting.\n");
+	return NULL;
 }
 
 static void intel_csr_runtime_pm_get(struct drm_i915_private *dev_priv)


