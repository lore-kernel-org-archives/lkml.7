Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4FAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C22425F72
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wU1WwXoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE3SVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:21:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37163 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfE3SUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:20:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so5783537lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8udFRfvbZ6fXOojTQ4C0YPBDnze74Ovvj+f7jr19Fw=;
        b=wU1WwXoEjKxZ3uqM80S4B/iacjxdOKTanw/C0MhErCrltoOGbqOgl6D3+r1s/I5MDs
         43CeGw6Y6RckooIj+upDJFUOq/x8S44sRl4IecU2CAs9bIntSdh8qHidWHvG+s5sZZwr
         tMo1h8S1ts9QZr8NNUvE3T9naG3R4FHAPT23kfi5+VV7aUci43qWu5ZZWJKAHQleHoEy
         /ajuUGqlAVxb3HPheATiiuEdAXwo7PokCTbdy4XNP9sZTvD5RheyUk1vZwg8Azp9xD2i
         pnBXFBTfRa7tQ02r91dRnH9CWokN/c7+ti7EZKQlpvZEfndG6pFqlRF4421kR1+T9DU1
         CSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8udFRfvbZ6fXOojTQ4C0YPBDnze74Ovvj+f7jr19Fw=;
        b=LD3801oK8dwNL55At8p3UNM5Ih45hHkrgTUkvTHssE2RNEfwEfnfLyziWliTPuQtle
         ciPDdWyC1jhxnGGnte0Cr/8L3qT3JXrED60jKGOlpBGF6wgFPMeHA5x0hyxWNrOwJJDh
         AAY4H8aDyUHEqSozCYqkiZwdUwV/ZLWvpu7ssmjy+AynniAQzFdeH68ZV+6IdcPmxtEf
         Ntc6w4j70VwQP+IHBlm1pXR/YEiqfOJEYs+HXD0KFMW9lt0xSnPLibBTql5Icx5wPzAQ
         ONwftsK+9d4V3iTGGYA53IZ9dsDkvTFN7kgu4D1yAWiBqOi13xizOZTgh3B+pSdXgxoJ
         Zv0w==
X-Gm-Message-State: APjAAAXoL/7PWSfA/ITejNTvkbVMD5xbYcNRg7k7Ij/pA52OXtSmaLZV
        J4TMzK8xcXxil473m2Fls70pbg==
X-Google-Smtp-Source: APXvYqzmIrTETx9SuLnFJbbk7eE7VgPvlT6tOo6LaT1WkjJJjIEn1SeLZrsHAr7qOO6dBn1fCt8qbg==
X-Received: by 2002:ac2:494f:: with SMTP id o15mr2908131lfi.22.1559240452479;
        Thu, 30 May 2019 11:20:52 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id v7sm388946lfe.11.2019.05.30.11.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:20:51 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 2/7] net: page_pool: add helper function to unmap dma addresses
Date:   Thu, 30 May 2019 21:20:34 +0300
Message-Id: <20190530182039.4945-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
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

