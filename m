Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6904220652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzEvZanV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfDLMmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:42:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:42:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so10842576wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtiCIOGJbpetmNauUuADurp0zYc9EegkkeLw32lYeSA=;
        b=xzEvZanVT79m5MWuHTzfz7vv69dJwTK+pnx3OwrE18qjBCtFX97YwjQwclB7x6bZ0P
         xei7b5jkVq3rTr2Uza9U+7mZVdyhsd/NbwxGFLcyLGGCCspqDDmSX/l9KoBqTJRDMqvs
         Rqa/RYXI8isUzlnKebm+vMk7ejqhsC3kxE1yTBNprujU78e1zQq9gZADS24Dk6zAhyKj
         ARdmv9Bx0TSeLcC7+ydCpRsWIKKtq2SHOIJe6Hv8Uxl8LytJb5Islt5eoRtBmVDzVB4g
         Utvm9mOqFLMoGa0czz3fxoRGHc4Zmta/a2EXhW9xEl+kn125P0DrzKBBx8EjTxHgXTCp
         LmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtiCIOGJbpetmNauUuADurp0zYc9EegkkeLw32lYeSA=;
        b=TWK/YuXKBSRFDkGWTgXvx5hity2Z8GeyyzzNOxjgTbk8a5CeHJ+V2vIkUfcgUzEw6p
         NATHfbjDEahfppk8UIf7Nq+U3RltKL54v/jwMz3U6pLuol+px8/tvynmUURgQ+z6tMUi
         ZETNqZKllTD+c7aTjychjVOOf13hCMYel/kcg9aBQdklkxCwWVhxHH6AL11h5rn3a5k5
         3XQitoIEP1FUa9FQNQJWId8oM42cyB254Nti8aSCRvnrbKUVXJwpL9QOWVSjp+aRUDw4
         p34k2z5wgRyR85TdlnwWDGau2UQRjRLhDe3PON7kG8QhYd8b2z94q4xv0AreFf/fGB27
         1RJQ==
X-Gm-Message-State: APjAAAU0vIIvS6RMgGVToKInXAaPZExyCTf+pWJIf7JCIlC6paejb3mL
        t0+Msr6EMBkdrZyZ/5aiRni+Cg==
X-Google-Smtp-Source: APXvYqwZvHjpxR5ggLBb1SJLMj+El+GYcuFslTE4qF1NW+OIX8NferHXjLYKw7JV1Eqn/J4cFehrdQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr10838569wmh.32.1555072931323;
        Fri, 12 Apr 2019 05:42:11 -0700 (PDT)
Received: from localhost.localdomain (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id f1sm37362781wrt.87.2019.04.12.05.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 05:42:10 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: qcom: scm: extend 64bit function identifiers
Date:   Fri, 12 Apr 2019 14:42:06 +0200
Message-Id: <20190412124206.8214-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As specified in the SMC Calling Convention, each service call range of
function identifiers depends on the owner of such service call.
At the moment, these ranges are restricted to SiP (Silicon vendor
Providers).

The following commit extends the qcom_scm_call API to allow other
clients (ie. OEMs) to add new functions to the Qualcomm 64bit yielding
call interface.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/firmware/qcom_scm-64.c | 48 ++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 688525dd4aee..b0194cb42765 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -75,12 +75,13 @@ static DEFINE_MUTEX(qcom_scm_lock);
  * @dev:	device
  * @svc_id:	service identifier
  * @cmd_id:	command identifier
+ * @owner:	SMC owner
  * @desc:	Descriptor structure containing arguments and return values
  *
  * Sends a command to the SCM and waits for the command to finish processing.
  * This should *only* be called in pre-emptible context.
 */
-static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
+static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id, u32 owner,
 			 const struct qcom_scm_desc *desc,
 			 struct arm_smccc_res *res)
 {
@@ -129,8 +130,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 		mutex_lock(&qcom_scm_lock);
 
 		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
-					 qcom_smccc_convention,
-					 ARM_SMCCC_OWNER_SIP, fn_id);
+					 qcom_smccc_convention, owner, fn_id);
 
 		quirk.state.a6 = 0;
 
@@ -215,7 +215,7 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
-			    &desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -242,8 +242,8 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 	desc.args[9] = req[4].val;
 	desc.arginfo = QCOM_SCM_ARGS(10);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP, &desc,
-			    &res);
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 	*resp = res.a1;
 
 	return ret;
@@ -278,8 +278,8 @@ bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-				QCOM_SCM_PAS_IS_SUPPORTED_CMD,
-				&desc, &res);
+			    QCOM_SCM_PAS_IS_SUPPORTED_CMD, ARM_SMCCC_OWNER_SIP,
+			    &desc, &res);
 
 	return ret ? false : !!res.a1;
 }
@@ -296,7 +296,7 @@ int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_INIT_IMAGE_CMD,
-				&desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -314,7 +314,7 @@ int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
 	desc.arginfo = QCOM_SCM_ARGS(3);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MEM_SETUP_CMD,
-				&desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -329,8 +329,8 @@ int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
-				QCOM_SCM_PAS_AUTH_AND_RESET_CMD,
-				&desc, &res);
+			    QCOM_SCM_PAS_AUTH_AND_RESET_CMD,
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -345,7 +345,7 @@ int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_SHUTDOWN_CMD,
-			&desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -360,8 +360,8 @@ int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	desc.args[1] = 0;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET, &desc,
-			    &res);
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET,
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -377,7 +377,7 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_REMOTE_STATE,
-			    &desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -403,7 +403,7 @@ int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				     QCOM_SCM_VAL, QCOM_SCM_VAL);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
-			    QCOM_MEM_PROT_ASSIGN_ID,
+			    QCOM_MEM_PROT_ASSIGN_ID, ARM_SMCCC_OWNER_SIP,
 			    &desc, &res);
 
 	return ret ? : res.a1;
@@ -420,7 +420,7 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_RESTORE_SEC_CFG,
-			    &desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -436,7 +436,8 @@ int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
-			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE, &desc, &res);
+			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE,
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	if (size)
 		*size = res.a1;
@@ -458,7 +459,8 @@ int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
 				     QCOM_SCM_VAL);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
-			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT, &desc, &res);
+			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT,
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 
 	/* the pg table has been initialized already, ignore the error */
 	if (ret == -EPERM)
@@ -477,7 +479,7 @@ int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
 	return qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_DLOAD_MODE,
-			     &desc, &res);
+			     ARM_SMCCC_OWNER_SIP, &desc, &res);
 }
 
 int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
@@ -491,7 +493,7 @@ int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
 	ret = qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_READ,
-			    &desc, &res);
+			    ARM_SMCCC_OWNER_SIP, &desc, &res);
 	if (ret >= 0)
 		*val = res.a1;
 
@@ -508,5 +510,5 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
 	return qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
-			     &desc, &res);
+			     ARM_SMCCC_OWNER_SIP, &desc, &res);
 }
-- 
2.21.0

