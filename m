Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91355C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68637206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtU4jQny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgAIMhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:37:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38832 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgAIMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:37:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so7069729ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 04:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ATHHjw+2Gy5yajVd+lnqDYNhxrLs6riTR9Mwxkks8o=;
        b=XtU4jQnydjSlY5UiCiIDnULQB3GGRWkrFSqkjSTah25E1N6OmyawSK0/eVhu3jr8+0
         P+vx5XGy92SaJyqNbn+M9/gPmL1lhk5CJbSaoKVI4LffA4BZfkMtBJCdFMXkF1+wiD/Z
         YDNhXI04n3cAzziqQ8mQr9icPRjEeF2LE6I6t8EJXN4fb/mtwa79D1JGKqmA6sJzuFMY
         pcoHLWIjkNvJBCQkK8JqoIXAcaI1CTybClbKkPq3FeWVYbFpEwh9T5ZEBM8dd4c+0n0f
         kGzweqD9K9LfpH02QBhTyfj4/YR7fNTV0cyfT1h7J1DU6WYIPN4QvmXFvKkBZj8bV0L2
         Ps1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ATHHjw+2Gy5yajVd+lnqDYNhxrLs6riTR9Mwxkks8o=;
        b=QxO0+UDrMquGiqP2dBPKEF0pQ6pIsh1mKaZU/fvYQl7J7zixo5mGkp/IqUc8gjqYxC
         dQe05UZpPYzmphB/BHCIDwKkhvUlOA6NtlU1Rc0Y0cOilw0y4Hg2J6sJYW3hko/JmUUj
         nHFWErD1GDkDr8/vmuM+5BecWAbDd2pl60ntV7J2nOUXU3bTJL3b2vQFjSumLsoMFmfA
         o8jlnNeUnFac305zDDnDis+SN6gJiNFtdbrlRszSMkShjFp3FYj16jsAEaeR1B63IhRW
         /fN1+CwLehtp2oCgKC6XdDuNNLzJIyJH4GgtQjIp2ThmQDlcIHlUOaYCZeCC4BhsqYjQ
         MIxg==
X-Gm-Message-State: APjAAAVVd+a4Cd4ndVzW/Hp++p1NVCOHfiyK5W6e9MIIXB7VlFK8r6Bq
        JsyKTqFFQFA2CBEMxmVenNDcQQ==
X-Google-Smtp-Source: APXvYqy1v3d2ghtjGUWiKLpY1rGIOcgwimh1XzPO0dR+S8rDWD2Crtx18Akdr4phIA9CHYviog6Bmg==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr6601261ljo.86.1578573446657;
        Thu, 09 Jan 2020 04:37:26 -0800 (PST)
Received: from jax.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id u16sm2887724ljo.22.2020.01.09.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:37:25 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 5/5] tee: tee_shm_op_mmap(): use TEE_SHM_USER_MAPPED
Date:   Thu,  9 Jan 2020 13:36:51 +0100
Message-Id: <20200109123651.18520-6-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109123651.18520-1-jens.wiklander@linaro.org>
References: <20200109123651.18520-1-jens.wiklander@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tee_shm_op_mmap() uses the TEE_SHM_USER_MAPPED flag instead of the
TEE_SHM_REGISTER flag to tell if a shared memory object is originating
from registered user space memory.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index c64ec5c5e464..deb22f877881 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -81,7 +81,7 @@ static int tee_shm_op_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	size_t size = vma->vm_end - vma->vm_start;
 
 	/* Refuse sharing shared memory provided by application */
-	if (shm->flags & TEE_SHM_REGISTER)
+	if (shm->flags & TEE_SHM_USER_MAPPED)
 		return -EINVAL;
 
 	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
-- 
2.17.1

