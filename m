Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00AFC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726322075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kakw92oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfFENVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:21:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43844 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfFENUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:20:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so5148017lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8udFRfvbZ6fXOojTQ4C0YPBDnze74Ovvj+f7jr19Fw=;
        b=kakw92oc5wH+oxJ6ODpgbLaUIoQW9h/zUc9x9pUca+W4hUS2xJ0UItvFLf9VQu8CIc
         1szBRsbJ0awE7LTjIq4G2XLFuR6NA7/GMra+3MrrKql34p3S1K/0BW9XeVMFhQYKCTzz
         GDEEbdIwXdjGoo65Q5GIPn9ATH2Pplj3ZlximgzKWmvhwJO5uL4xt3wvQPWA9XCOdqby
         pldooEWZ4PPz+4lA99qqmGvqQJJB+5gPWnOAnNelCPYCw6w7kQYvm1e9sfZN8Rio0xT9
         oX8uoCH8Mn8GL0cCRgeiLGtGD9Z2H3fzWi6Nd6Ib1p80OBQKGvSmhpjPo8Pw9YT+Zszq
         pj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8udFRfvbZ6fXOojTQ4C0YPBDnze74Ovvj+f7jr19Fw=;
        b=jsf2oxb1OAe4uBqb/OsV4ECggOQgP6MZHjD01VH2s0F9HauW5XQm+EVDFDcDwTTh6G
         eTms6sD0zCVr2m+s9rxXu/ioCqaKmIoL15OerpNPELmWGW5lX+u+oY0yd0ZS8R74+qc3
         P9zVDzlpqtFGLGS7dfsektWZ4Y7yFjdWcBKiEYabnH3tqm2MHggCVEs99w9mRMlG0Hhi
         o6o46qnZwX47sxuoz7PcGmMJxGQ5k0CA9g1hpABhhaqddfAUGPO63owsXc9MjDyK9clx
         1KFCewQIWUwkp4Ffpa4jLTM1nvlDJL/z9gqUdJVjsjevUc09ykDbWUz8Kt75hczsq1f+
         9lNA==
X-Gm-Message-State: APjAAAVFEEM1IJxnSm7g8LUaVr2Yxo2io8TIgF1nRv/8do5bkAhQNEY/
        BRc2mo5G4BtuOCTG1vFCj0Ftvg==
X-Google-Smtp-Source: APXvYqxUNjdEnl96GlRKiWrA7aDQd1EXYbFqh9DMeeWi0M9W28w5vnZ2wm2F2zFOSdm42p7PRe2ZeA==
X-Received: by 2002:a19:2753:: with SMTP id n80mr20327221lfn.127.1559740815723;
        Wed, 05 Jun 2019 06:20:15 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id t3sm1893259lfk.59.2019.06.05.06.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:20:15 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next 2/7] net: page_pool: add helper function to unmap dma addresses
Date:   Wed,  5 Jun 2019 16:20:04 +0300
Message-Id: <20190605132009.10734-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
References: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On a previous patch dma addr was stored in 'struct page'.
Use that to unmap DMA addresses used by network drivers

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/net/page_pool.h | 1 +
 net/core/page_pool.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index b885d86cb7a1..ad218cef88c5 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -110,6 +110,7 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
 void page_pool_destroy(struct page_pool *pool);
+void page_pool_unmap_page(struct page_pool *pool, struct page *page);
 
 /* Never call this directly, use helpers below */
 void __page_pool_put_page(struct page_pool *pool,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5b2252c6d49b..205af7bd6d09 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -190,6 +190,13 @@ static void __page_pool_clean_page(struct page_pool *pool,
 	page->dma_addr = 0;
 }
 
+/* unmap the page and clean our state */
+void page_pool_unmap_page(struct page_pool *pool, struct page *page)
+{
+	__page_pool_clean_page(pool, page);
+}
+EXPORT_SYMBOL(page_pool_unmap_page);
+
 /* Return a page to the page allocator, cleaning up our state */
 static void __page_pool_return_page(struct page_pool *pool, struct page *page)
 {
-- 
2.17.1

