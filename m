Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB62C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52FE206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bp88UjzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfL3NXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:23:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3NXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 08:23:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so14626665plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yQ0XqDfWaNn49iz4/YwQRuqIfvGGfSfCl8SQr3BmSiU=;
        b=bp88UjzGfmaxyhcgYeMQu9JQs7CyINU4KpCz69ZBA33EFcfqZ3bBwj77b4A7xjVT8K
         G/JSWwJ5LwpT06V9/HnGaBgF1/ghxNFTznc0Hk4Tq0Ys5Yk2M5KzCXm/5q6146+PEf3x
         48LNLkIOF/CEDytxMux57yf6pF+12ar2314Ma1OicGl49NyYaIL7W4fqGaZvZPmVULld
         0/erZk2bCZpJ0ytPR0APcu70Pkced0wzqPMQOkum1ptJdlHWIXfbHbk/bCmzBkKgOPDe
         wKTqM3gg8cvhasgGiO4YNXA8ZSiGj1nFESlUmDUxMkoVbDEvIy6Fl9DumrmMUDOof6MV
         lu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yQ0XqDfWaNn49iz4/YwQRuqIfvGGfSfCl8SQr3BmSiU=;
        b=toHPYikiNsPPhd+ArSswVPW52ZsZGy6p74iWqXcshJntroUUrqlzRxHUPhskb+Ir+m
         71xUjBNx1AlSlCSdGfKxfHW9s5MW/BnMXNzpWD03C5dmJ1dE7UcpbtTV5FQL2Q+WbLZi
         a6nV6o+3rZoj7PmNncAqV/w+XmfljdbvOZ80chC1vpLKstHMwlPpgolpvwTxU11Vz/rh
         rZAOWRUvBdvtYoevx6rjS2/nRZnJA1oXhEKHNjf6GFKUr/DxJA000TQkjWxy6Udp4bI0
         Vtht294rH3sd4eoOkabSEyh6WO0FDq1peko4ogor30aE6PnnbB+xdhxBeM2pfz7n9PB8
         Aohg==
X-Gm-Message-State: APjAAAUCbXWt5x8sRKb3fnx/BvXvX2nTyWO3Y6FWnXf8c4Uf/a1w7uNv
        pYY2Vo6aE9yWBmqLhagcybTETA==
X-Google-Smtp-Source: APXvYqxFXQp6tDzQrtuyXDmxOuhHiwY/btoJz7sMhmM/m7OX2B/kr9WHhTqRFUJSCgMFZrP6Wbxyug==
X-Received: by 2002:a17:90a:3244:: with SMTP id k62mr47006483pjb.43.1577712203838;
        Mon, 30 Dec 2019 05:23:23 -0800 (PST)
Received: from localhost.localdomain ([45.114.75.108])
        by smtp.gmail.com with ESMTPSA id o19sm25133156pjr.2.2019.12.30.05.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2019 05:23:22 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, Volodymyr_Babchuk@epam.com,
        jerome@forissier.org, etienne.carriere@linaro.org,
        vincent.t.cao@intel.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] optee: Fix multi page dynamic shm pool alloc
Date:   Mon, 30 Dec 2019 18:52:40 +0530
Message-Id: <1577712160-7445-1-git-send-email-sumit.garg@linaro.org>
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

Changes in v2:
- Fix memory leak for "pages" pointer.

 drivers/tee/optee/shm_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index 0332a53..d767eeb 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -28,9 +28,22 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
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
+		kfree(pages);
 	}
 
 	return rc;
-- 
2.7.4

