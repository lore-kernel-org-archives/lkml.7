Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE62C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D009E208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469196;
	bh=kZlyWVfDQ/Il/ZTXyaCcECiQi49gcTd2X7UKT7IULYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xs8DxBDDsW+XE1yG39RKY78WMp05DuBetCxtgherKTIdJSE0TO/LQCNMUK6RKkZyB
	 s7MZgE9CepgRLU/d8IZr5BBlefgy0ldSSqqWQLrvo15NSO47eMJJrYVrKM+Fm3eYus
	 FuH8XNRuNLu/qTFtif2ynieXT9fkRP1ROia8RAQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfL0RxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:53:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfL0Rmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E132173E;
        Fri, 27 Dec 2019 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468575;
        bh=kZlyWVfDQ/Il/ZTXyaCcECiQi49gcTd2X7UKT7IULYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRtqvqAktjBMPULcz8XwlXizIn2F5J7R7PXoVf6msmzZ/Ru6ysn9W2gKJwtst4Vqe
         bpmj2pEUpFS6iwgNgKjH55AAT3L33tCji8raOKo9SDciJK/o5t1TnUxFBotxLZ4gDS
         BcxEMRBLUsgbuoZd+Zo/5N/Wf1nkOPGimJ8lRIVY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Greg Kurz <groug@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 099/187] ocxl: Fix potential memory leak on context creation
Date:   Fri, 27 Dec 2019 12:39:27 -0500
Message-Id: <20191227174055.4923-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Barrat <fbarrat@linux.ibm.com>

[ Upstream commit 913e73c77d48aeeb50c16450a653dca9c71ae2e2 ]

If we couldn't fully init a context, we were leaking memory.

Fixes: b9721d275cc2 ("ocxl: Allow external drivers to use OpenCAPI contexts")
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191209105513.8566-1-fbarrat@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/ocxl/context.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 994563a078eb..de8a66b9d76b 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -10,18 +10,17 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
 	int pasid;
 	struct ocxl_context *ctx;
 
-	*context = kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
-	if (!*context)
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
 		return -ENOMEM;
 
-	ctx = *context;
-
 	ctx->afu = afu;
 	mutex_lock(&afu->contexts_lock);
 	pasid = idr_alloc(&afu->contexts_idr, ctx, afu->pasid_base,
 			afu->pasid_base + afu->pasid_max, GFP_KERNEL);
 	if (pasid < 0) {
 		mutex_unlock(&afu->contexts_lock);
+		kfree(ctx);
 		return pasid;
 	}
 	afu->pasid_count++;
@@ -43,6 +42,7 @@ int ocxl_context_alloc(struct ocxl_context **context, struct ocxl_afu *afu,
 	 * duration of the life of the context
 	 */
 	ocxl_afu_get(afu);
+	*context = ctx;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ocxl_context_alloc);
-- 
2.20.1

