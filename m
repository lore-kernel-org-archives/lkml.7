Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6B8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3A82080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBR0GiSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfJaSqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:46:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43679 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbfJaSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:46:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id a18so1936472plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fT2QZouQmQ2Ctrmo6ejwMTUc59KuMwwwRwqJVgbyZyY=;
        b=yBR0GiSVnWg50XjdcAlI/ULSEky12wxmCJywQBEnNlUGiXIlpfedN2UqEsTHg0DQle
         HIkGcEMry7uKcbhlUGk7RvBVupzYaY4B4Xscr5b9OTl18yRZAvd8RJMgZuBU8jv55ROM
         t9YsrAINhQZHgrUSVVShm7WS5BvhvGP953XEVCVK+OixISTdil/fhZgR3oW5CEk6NAx7
         p5u8AZzAiAEqui/EhnSS657cwdAa2YrXb/qOv3tY/KbcxPePoKQsrATr2uPO/Ca0iCpk
         +6nh7YLe9rykgNXcpOejFqVDGxuJuTv7rrL9M5YKRLfXCcQm1pyJJK9PEk4JCmq/jKYL
         J4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fT2QZouQmQ2Ctrmo6ejwMTUc59KuMwwwRwqJVgbyZyY=;
        b=Awof+Ta/V7/Yc8nQakSExhnlldPUvuJb36+jLzJ2qSHcDd4c3S8A62pwHGYVMr3tQH
         TpuQMNYE6z6veHgGrjJd0wqy2rRi+KUhTaHSD1v6p5GEF0VNAtFQdJCGaIca8PByxIqo
         FVWWTQASqAg9Erht0zM4iTnNB7CEN2MlcRhJQB3l9/uj6mdNdoS1QALe7e3yM+JUmhD0
         1OqZQhSuBoS4w4U5+DmXOHxbQoCLlNyVLe27ofb//gDHnYUeUps9WBLFTKbNVcOlqoqY
         9SNW+JuIVtG+rsKYUJxDlqIcl7w/CK5s6xnbBbCT74khBidpfPQ/Em/XLj0XyE4dTBjq
         a19Q==
X-Gm-Message-State: APjAAAV5gvAB34d/iYRJMDBGwivmxzCLzIiEmIe9olHvM/Defu+DOjCj
        WsWQ8XaliTnDyKBUfjcngsrQgQ==
X-Google-Smtp-Source: APXvYqydnhztG7Zn5savEmyRjUPgXSQxujWqyG2+Z+TY/QPSCddnTuNUmT7c1tDuxBy5fGWU199tJg==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr7999842pla.8.1572547598423;
        Thu, 31 Oct 2019 11:46:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b82sm3950874pfb.33.2019.10.31.11.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:46:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/2] remoteproc: qcom_q6v5_mss: Validate each segment during loading
Date:   Thu, 31 Oct 2019 11:46:32 -0700
Message-Id: <20191031184632.2938295-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
References: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code used to sync with the MBA after each segment loaded and this is
still what's done downstream. So reduce the delta towards downstream by
switching to a model where the content is iteratively validated.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 74 ++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index f4a02105d539..bdf1dd00b89b 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -358,23 +358,29 @@ static void q6v5_pds_disable(struct q6v5 *qproc, struct device **pds,
 }
 
 static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int *current_perm,
-				   bool remote_owner, phys_addr_t addr,
+				   bool local, bool remote, phys_addr_t addr,
 				   size_t size)
 {
-	struct qcom_scm_vmperm next;
+	struct qcom_scm_vmperm next[2];
+	int perms = 0;
 
 	if (!qproc->need_mem_protection)
 		return 0;
-	if (remote_owner && *current_perm == BIT(QCOM_SCM_VMID_MSS_MSA))
-		return 0;
-	if (!remote_owner && *current_perm == BIT(QCOM_SCM_VMID_HLOS))
-		return 0;
 
-	next.vmid = remote_owner ? QCOM_SCM_VMID_MSS_MSA : QCOM_SCM_VMID_HLOS;
-	next.perm = remote_owner ? QCOM_SCM_PERM_RW : QCOM_SCM_PERM_RWX;
+	if (local) {
+		next[perms].vmid = QCOM_SCM_VMID_HLOS;
+		next[perms].perm = QCOM_SCM_PERM_RWX;
+		perms++;
+	}
+
+	if (remote) {
+		next[perms].vmid = QCOM_SCM_VMID_MSS_MSA;
+		next[perms].perm = QCOM_SCM_PERM_RW;
+		perms++;
+	}
 
 	return qcom_scm_assign_mem(addr, ALIGN(size, SZ_4K),
-				   current_perm, &next, 1);
+				   current_perm, next, perms);
 }
 
 static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
@@ -681,7 +687,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw)
 
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
-	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, true, phys, size);
+	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true, phys, size);
 	if (ret) {
 		dev_err(qproc->dev,
 			"assigning Q6 access to metadata failed: %d\n", ret);
@@ -699,7 +705,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw)
 		dev_err(qproc->dev, "MPSS header authentication failed: %d\n", ret);
 
 	/* Metadata authentication done, remove modem access */
-	xferop_ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, phys, size);
+	xferop_ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, true, false, phys, size);
 	if (xferop_ret)
 		dev_warn(qproc->dev,
 			 "mdt buffer not reclaimed system may become unstable\n");
@@ -786,7 +792,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 	}
 
 	/* Assign MBA image access in DDR to q6 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false, true,
 				      qproc->mba_phys, qproc->mba_size);
 	if (ret) {
 		dev_err(qproc->dev,
@@ -820,8 +826,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
 
 reclaim_mba:
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
-						qproc->mba_phys,
+	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+						false, qproc->mba_phys,
 						qproc->mba_size);
 	if (xfermemop_ret) {
 		dev_err(qproc->dev,
@@ -888,7 +894,7 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 	/* In case of failure or coredump scenario where reclaiming MBA memory
 	 * could not happen reclaim it here.
 	 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true, false,
 				      qproc->mba_phys,
 				      qproc->mba_size);
 	WARN_ON(ret);
@@ -915,6 +921,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	phys_addr_t boot_addr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
+	u32 code_length;
 	bool relocate = false;
 	char *fw_name;
 	size_t fw_name_len;
@@ -965,9 +972,19 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	}
 
 	/* Try to reset ownership back to Linux */
-	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false,
+	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true, false,
 				qproc->mpss_phys, qproc->mpss_size);
 
+	/* Share ownership between Linux and MSS, during segment loading */
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true, true,
+				      qproc->mpss_phys, qproc->mpss_size);
+	if (ret) {
+		dev_err(qproc->dev,
+			"assigning Q6 access to mpss memory failed: %d\n", ret);
+		ret = -EAGAIN;
+		goto release_firmware;
+	}
+
 	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
 	qproc->mpss_reloc = mpss_reloc;
 	/* Load firmware segments */
@@ -1016,10 +1033,24 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			       phdr->p_memsz - phdr->p_filesz);
 		}
 		size += phdr->p_memsz;
+
+		code_length = readl(qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
+		if (!code_length) {
+			boot_addr = relocate ? qproc->mpss_phys : min_addr;
+			writel(boot_addr, qproc->rmb_base + RMB_PMI_CODE_START_REG);
+			writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
+		}
+		writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
+
+		ret = readl(qproc->rmb_base + RMB_MBA_STATUS_REG);
+		if (ret < 0) {
+			dev_err(qproc->dev, "MPSS authentication failed: %d\n", ret);
+			goto release_firmware;
+		}
 	}
 
 	/* Transfer ownership of modem ddr region to q6 */
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, true,
+	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false, true,
 				      qproc->mpss_phys, qproc->mpss_size);
 	if (ret) {
 		dev_err(qproc->dev,
@@ -1028,11 +1059,6 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 		goto release_firmware;
 	}
 
-	boot_addr = relocate ? qproc->mpss_phys : min_addr;
-	writel(boot_addr, qproc->rmb_base + RMB_PMI_CODE_START_REG);
-	writel(RMB_CMD_LOAD_READY, qproc->rmb_base + RMB_MBA_COMMAND_REG);
-	writel(size, qproc->rmb_base + RMB_PMI_CODE_LENGTH_REG);
-
 	ret = q6v5_rmb_mba_wait(qproc, RMB_MBA_AUTH_COMPLETE, 10000);
 	if (ret == -ETIMEDOUT)
 		dev_err(qproc->dev, "MPSS authentication timed out\n");
@@ -1096,8 +1122,8 @@ static int q6v5_start(struct rproc *rproc)
 		goto reclaim_mpss;
 	}
 
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, false,
-						qproc->mba_phys,
+	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, true,
+						false, qproc->mba_phys,
 						qproc->mba_size);
 	if (xfermemop_ret)
 		dev_err(qproc->dev,
-- 
2.23.0

