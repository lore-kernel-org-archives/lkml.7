Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E417C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EED21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578089313;
	bh=d3/j7z2yjI7lEIuDxbgdAHv52WUhDcszZmPvZvTiEp8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LshsfKMTg9JHSX7aE1IoG24FZjnm0Vwc6MbpuFQ8WlFxRiLCi/247okS9/6z10f7M
	 lCgsHDSXLZDSfzWNDrpq6cHYy6XMNCI3GDz33Rj7liCP/cGmkt/kyxh5+GaM+h/SvI
	 1NGOyE0+iqO4nvFzR5SK3a++X0Y9rKgEcUeXy4p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgACWIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgACWIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:08:32 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B1821835;
        Fri,  3 Jan 2020 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578089311;
        bh=d3/j7z2yjI7lEIuDxbgdAHv52WUhDcszZmPvZvTiEp8=;
        h=From:To:Cc:Subject:Date:From;
        b=Nie4K1gpZcU3az/rdhD9XkV6Ern8kdkfy421SNl/iDVQ/g5YQU2nnA+BgHq2hfB6O
         8Mp9BFQYnwT9pHO7Mlu6zQfgIF32nWIgb374YZmzW5x2ZrQAn0a7NtNVMq0L+EivJS
         FZGa096PHMarzvD+4BRZ9ZmwCzetosVMomxg1jls=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] firmware: scm: Add stubs for OCMEM and restore_sec_cfg_available
Date:   Fri,  3 Jan 2020 23:08:25 +0100
Message-Id: <20200103220825.28710-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add few more stubs (for OCMEM-related functions and
qcom_scm_restore_sec_cfg_available()) in case of !CONFIG_QCOM_SCM.
These are actually not necessary for builds but provide them for
completeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/qcom_scm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index d05ddac9a57e..2c1d20312ce0 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -105,6 +105,11 @@ static inline bool qcom_scm_is_available(void) { return false; }
 static inline bool qcom_scm_hdcp_available(void) { return false; }
 static inline int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 				    u32 *resp) { return -ENODEV; }
+static inline bool qcom_scm_ocmem_lock_available(void) { return false; }
+static inline int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset,
+				      u32 size, u32 mode) { return -ENODEV; }
+static inline int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset,
+					u32 size) { return -ENODEV; }
 static inline bool qcom_scm_pas_supported(u32 peripheral) { return false; }
 static inline int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
 					  size_t size) { return -ENODEV; }
@@ -121,6 +126,7 @@ static inline void qcom_scm_cpu_power_down(u32 flags) {}
 static inline u32 qcom_scm_get_version(void) { return 0; }
 static inline u32
 qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
+static inline bool qcom_scm_restore_sec_cfg_available(void) { return false; }
 static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
-- 
2.17.1

