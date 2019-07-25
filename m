Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD631C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318021851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F7jCysSv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mET74vPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfGYQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:53:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54830 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfGYQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:53:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B3CE460A97; Thu, 25 Jul 2019 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564073599;
        bh=oq2L+B+IIfQIVurBUXqqlX1OqZKCXJuZfTlxNoBprds=;
        h=From:To:Cc:Subject:Date:From;
        b=F7jCysSvZ5X6jKsackR8MHGGlb/Y6gBTMzCrffLWyvFVyt44JyceXwIFhQ0gORkhF
         PW2fTIJQglphyewTFhuwUo9WlZUXDhSEymSnHe8BH0sBMcSHnwFX2gptHHrT5Qo8j0
         7tr70N8ELnazFV0nkg64YaG3+eC65qbUyNC/e/g8=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D6AC60247;
        Thu, 25 Jul 2019 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564073596;
        bh=oq2L+B+IIfQIVurBUXqqlX1OqZKCXJuZfTlxNoBprds=;
        h=From:To:Cc:Subject:Date:From;
        b=mET74vPDzVJOY+TylnVBKCObvz1S02T36cpf5+6oJd24Sih4a6lDBE/cHEptSgpUC
         X8T6z/l8XUKHLBcjplju5VvtPLp5XS5m5cf5EnrgueelGWwn5soXCEIXxT6D9mF1TZ
         ZM8bnvUkPTK6/IR+Fq0gvtAxliiFOm2A9yiSYsSE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D6AC60247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>, Kees Cook <keescook@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Marek <jonathan@marek.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm: Annotate intentional switch statement fall throughs
Date:   Thu, 25 Jul 2019 10:53:08 -0600
Message-Id: <1564073588-27386-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly mark intentional fall throughs in switch statements to keep
-Wimplicit-fallthrough from complaining.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 1671db4..e9c55d1 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -59,6 +59,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			if (priv->lastctx == ctx)
 				break;
+			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
 			/* copy commands into RB: */
 			obj = submit->bos[submit->cmd[i].idx].obj;
@@ -149,6 +150,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			if (priv->lastctx == ctx)
 				break;
+			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
 			OUT_PKT7(ring, CP_INDIRECT_BUFFER_PFE, 3);
 			OUT_RING(ring, lower_32_bits(submit->cmd[i].iova));
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index be39cf0..dc8ec2c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -115,6 +115,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
 			if (priv->lastctx == ctx)
 				break;
+			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
 			OUT_PKT7(ring, CP_INDIRECT_BUFFER_PFE, 3);
 			OUT_RING(ring, lower_32_bits(submit->cmd[i].iova));
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 9acbbc0..048c8be 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -428,6 +428,7 @@ void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 			/* ignore if there has not been a ctx switch: */
 			if (priv->lastctx == ctx)
 				break;
+			/* fall-thru */
 		case MSM_SUBMIT_CMD_BUF:
 			OUT_PKT3(ring, adreno_is_a430(adreno_gpu) ?
 				CP_INDIRECT_BUFFER_PFE : CP_INDIRECT_BUFFER_PFD, 2);
-- 
2.7.4

