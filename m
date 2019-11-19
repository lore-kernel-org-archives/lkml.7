Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB5EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BD9222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPqjeJEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKSHPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:15:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39629 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfKSHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:15:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so11706554pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=F/DaNK9LjWuKTu4vv+ENnwTZZ+61EjuSFDTlcOkYW/Q=;
        b=ZPqjeJEPInN19j4uu3yHXqRyHKAgF1+j1ngbJGzgSsrdm0L9h8c2/WzSSMA71i8IBF
         iim2951LdF/+s4s++/zHM7ewtwSJrsPH8CfxRXWy81B9K8aC2zCHkzWbmbBYhK/Ght2j
         44KZZaf0ePg8ngJQJ7dI6nlvK4A3i9QDxceT+1NQZ4qI1TVstGkuJfcHM/XM8oZYj+dZ
         TdPUnEKa2SSs5xbIT7T+fCu/hPlxP2AQbjZtiXjAHPxaU6yW9+D49QRuRr4/HeUoP/zc
         PgBNWZO6BhR6kUp447oOhq0hHLg1fnAHrJ/GD8rfVdTjl+83aGpva445tYga3ZjK+PwF
         Sb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F/DaNK9LjWuKTu4vv+ENnwTZZ+61EjuSFDTlcOkYW/Q=;
        b=NFLbdDRbM15ZG84P7vRZispmIRbDu7vRD+iU5De3QpdktySRN4pIrmG5+cLmxjVF3T
         Bopqcr0qZlLVdQ/iXZetMPYUsyUyE53yQxcm2DQzETMCuK/mnMfF8iytEjUzSiEgaeza
         kZ4h15n7072CeXXKV7m0POowYOsQkE5K5nLVf6xT293iiK4Bg/mPGKCvkvtyupXWSsfw
         DuwWRmfWcWOJx8YE/Y5mXwvov5XBflgi0ADUfdYdPKjsEf3ErhTK95ky39oC2RAMcRB1
         3/ycVxIo3eDqF6htpm3JNBIc1fSaA4LGOfgRvZSC+YqRVimt4FTDFqTlxojVxajtQEx+
         PHiA==
X-Gm-Message-State: APjAAAW6Dn0+8xmXFysgVYh+5BtAGyzQEHyASFmjTlQl4Rau9nschnLf
        2OblOdG3/R+P9S+I74BT6iQ2ow==
X-Google-Smtp-Source: APXvYqy73FiWtYGOXC0KQe+L4Z4fwkWzwH04g9KydPTeRVXkC4QM1PG6bW1zHdLcDfB1MW0sG9FxDg==
X-Received: by 2002:a63:553:: with SMTP id 80mr3829352pgf.366.1574147714640;
        Mon, 18 Nov 2019 23:15:14 -0800 (PST)
Received: from localhost.localdomain ([117.252.69.77])
        by smtp.gmail.com with ESMTPSA id u18sm1141839pfn.183.2019.11.18.23.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 23:15:13 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, Volodymyr_Babchuk@epam.com,
        jerome@forissier.org, etienne.carriere@linaro.org,
        vincent.t.cao@intel.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] optee: Fix multi page dynamic shm pool alloc
Date:   Tue, 19 Nov 2019 12:44:26 +0530
Message-Id: <1574147666-19356-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

optee_shm_register() expected pages to be passed as an array of page
pointers rather than as an array of contiguous pages. So fix that via
correctly passing pages as per expectation.

Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
Reported-by: Vincent Cao <vincent.t.cao@intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Vincent Cao <vincent.t.cao@intel.com>
---
 drivers/tee/optee/shm_pool.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index 0332a53..85aa5bb 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -28,8 +28,20 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 	shm->size = PAGE_SIZE << order;
 
 	if (shm->flags & TEE_SHM_DMA_BUF) {
+		unsigned int nr_pages = 1 << order, i;
+		struct page **pages;
+
+		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		if (!pages)
+			return -ENOMEM;
+
+		for (i = 0; i < nr_pages; i++) {
+			pages[i] = page;
+			page++;
+		}
+
 		shm->flags |= TEE_SHM_REGISTER;
-		rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
+		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
 	}
 
-- 
2.7.4

