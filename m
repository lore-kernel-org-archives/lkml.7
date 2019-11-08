Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA7CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA421924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0Eck43b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfKHL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:27:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37844 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfKHL1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:27:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so4383982pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1QFtqzKg2ixpAmWo62ifCiTiHn31FCP9xZyuBEbe8lo=;
        b=l0Eck43b/1EVOGX/WInrm0EECdVDDccSPSN7ISAhH5c2x69BdaSwsuvjSpnY90CaKH
         IzbWTKyt+0S8G9zcIL6Z4AtJfLq1Exg3YQ+vMjCD+GN1IlhchQZ3m1HcgwDZlSIRQ+a9
         QCQ7dl8cv3qSBxIViCmYKzB2VoH8zoHIx+RYrTRp3anfx4N/h0ZDS3HR5lqJSW3D7NUd
         Y7Egxer5hrdvAVH3hBaia8dmEidY11BrQMcqWgkGC4PRKvIzQVfZcXdoy9YKuuIp2CoU
         fH6yzt2MN/+cs1zSU4H4hQOWof+J5yuhvJKlfLQBLY9LPC7c6rf0ddNqaH62kftFJ3bc
         rXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1QFtqzKg2ixpAmWo62ifCiTiHn31FCP9xZyuBEbe8lo=;
        b=Fk6Yd1Eo1xzYJ1Be3Bgf3yA1NM7MyF0nHqKOujonfHgBKt1yFyXCnwURpNY9TiKHuY
         TV988T9LQkN2hLIvMNWd8Symp+e6enuDd5eUdFy4MJH9tgi36IsgI4v5wRCUGBG4ZD88
         SF2Tp3Hh8mbZxOWo2Qmn7B+3unjdYHh7jtbOBXnFLAIxjLI8/FC9cIAfHD3d+T/+kiNU
         lKhnMKw9A/ulnsnOY3P2QB3T6m+I1SJJXNcxLZrP6JKmixo9GjyvdInGCNSZJDUYA4dk
         AdYkJRqNAHIBN/E92i/HdjYVdd+iWQE8Z558d914fpqsYw47lB5vZWWIa9CibjZUxA6N
         FnJA==
X-Gm-Message-State: APjAAAXXYD6ImrdkGC9uOS9tI/9blZ9XG8rXE25AR0opuBE13Sn12y1f
        7JQ8aIXuUT8ZlOcuv2ZXELCS3A==
X-Google-Smtp-Source: APXvYqwmIDzwk1fRutiWl2g+f7BsL569BQ6nqn4n4X1haMj85au9jq9xMfBCLtpoIvSKipk3+VGuQg==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr13056144pjh.60.1573212463142;
        Fri, 08 Nov 2019 03:27:43 -0800 (PST)
Received: from localhost.localdomain ([117.252.68.208])
        by smtp.gmail.com with ESMTPSA id f26sm5263973pgf.22.2019.11.08.03.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 03:27:42 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org, Volodymyr_Babchuk@epam.com
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        etienne.carriere@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v2] tee: optee: Fix dynamic shm pool allocations
Date:   Fri,  8 Nov 2019 16:57:14 +0530
Message-Id: <1573212434-25526-1-git-send-email-sumit.garg@linaro.org>
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

Also, allow kernel pages to be registered as shared memory with OP-TEE.

Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
Merge the dependency patch: https://lkml.org/lkml/2019/10/31/431

 drivers/tee/optee/call.c     |  7 +++++++
 drivers/tee/optee/shm_pool.c | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 13b0269..cf2367b 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -554,6 +554,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
+	/*
+	 * Allow kernel address to register with OP-TEE as kernel
+	 * pages are configured as normal memory only.
+	 */
+	if (virt_addr_valid(start))
+		return 0;
+
 	down_read(&mm->mmap_sem);
 	rc = __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
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

