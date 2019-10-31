Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A38CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEA02190F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyvmGq/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJaNIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:08:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:08:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id j30so548246pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Cqtq1IsBvtgaQwOqUXmWPFyxcxq2W1VJqxtqgd6DBaU=;
        b=jyvmGq/AZbhexcviyS38XwiyXODIyJx+96AloAXfuIf/GSvQGpp1jbggAPZkwrDfGG
         +KAqmp9H8ABVy2hahkyNpPuk6spAfau+upjKsCfoeIiay7dAJzn5kzEBzyQfUsuQfYUE
         6tp5pziaMcynKbntx2SeIl1FPld3QxkCiwBlWeJLRdGOvkz1LNMu8uNX2GP/tJKTr8mf
         vexk+iyl4JDS3D8Vysl7IDbMbT9ldnIikCyXLtS+FYmHgBOZSZS1FkeLVor+Qmz3w4pE
         7ltY+VlPzSxe4PEhOTL5g3eF8864B0Lc7uehwz8xyTfRJGia7kY14twmsrWz0b4+22ER
         ozcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cqtq1IsBvtgaQwOqUXmWPFyxcxq2W1VJqxtqgd6DBaU=;
        b=nRVcg2nC6SOL+EokH5flxM3kVploO5GrWHzzXUKwIxscC7xT+2yNna2Dx1GM0BnRCf
         UuNeUFwi3kGo+Wf3wbOkdM8ABu3ylKGTZHjMfWd8BJLPSoshgn+zTGzDu4ki+Qqpev2o
         Nhxf4BcBvtiw9WF7NrvIxdtTc1sev9eiIfhIMNJGpAjwiVQEUBUJtq5vgXfS76riVUlW
         3evUHICsjTvkv2oVPjD8juGJBTHuuuvFegz0jMN8qBhbkQK/PbY7qNemgA81xFNOPyB9
         t1wK80zJD+c+3qAa1+1MG7Apn+4iSI/dZ13A2XlsTENs4yyDRbYJkK6d27Hyg3hLSzZM
         19FQ==
X-Gm-Message-State: APjAAAUgLUTg/wHh2AIMb8Jz1DUUXOqKy0MHW2EvYYCS0pkWJDbt9JWq
        EYhFERl/BcamP571+ZM07j1pIw==
X-Google-Smtp-Source: APXvYqwj+Ln6KWNlOc5SgRGbAAnmp4XLHEGdDDgD7iVHec57NVXWYlXI4XtUSIIWd2DLr1IdFqdSlA==
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr7525331pjs.5.1572527293515;
        Thu, 31 Oct 2019 06:08:13 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.143])
        by smtp.gmail.com with ESMTPSA id 12sm8085940pjm.11.2019.10.31.06.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 06:08:12 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, Volodymyr_Babchuk@epam.com
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] tee: optee: Fix dynamic shm pool allocations
Date:   Thu, 31 Oct 2019 18:37:54 +0530
Message-Id: <1572527274-21925-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of dynamic shared memory pool, kernel memory allocated using
dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
during optee_open_session() or optee_invoke_func().

So fix dmabuf_mgr pool allocations via an additional call to
optee_shm_register().

Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Depends on patch: https://lkml.org/lkml/2019/7/30/506 that adds support
to allow registration of kernel buffers with OP-TEE.

 drivers/tee/optee/shm_pool.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index de1d9b8..0332a53 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -17,6 +17,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 {
 	unsigned int order = get_order(size);
 	struct page *page;
+	int rc = 0;
 
 	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!page)
@@ -26,12 +27,21 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->paddr = page_to_phys(page);
 	shm->size = PAGE_SIZE << order;
 
-	return 0;
+	if (shm->flags & TEE_SHM_DMA_BUF) {
+		shm->flags |= TEE_SHM_REGISTER;
+		rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
+					(unsigned long)shm->kaddr);
+	}
+
+	return rc;
 }
 
 static void pool_op_free(struct tee_shm_pool_mgr *poolm,
 			 struct tee_shm *shm)
 {
+	if (shm->flags & TEE_SHM_DMA_BUF)
+		optee_shm_unregister(shm->ctx, shm);
+
 	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
 	shm->kaddr = NULL;
 }
-- 
2.7.4

