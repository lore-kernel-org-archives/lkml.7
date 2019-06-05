Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DEAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52D120866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRYi4qcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfFENUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:20:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34201 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfFENUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:20:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so23136109ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AdSMTsu+LtgUCnPNRXGwSYsCPQyqbNfQqw5/RcvDJNQ=;
        b=mRYi4qcNVbZ//c6G57A5oDbp2t2NbASCzTsCDdchf6yJyjEu+CCRyMzKu+9CKFoid3
         ZwHgGIiAW5HvrqKBJ1X5jiXV8j+0CWCui9NP5egRT36VcapZyU/vhp6SCCBuya6WqE09
         EJI5NV/HOBQBQfIBMKnZYUXlDbPa5bHZf929T1qOP8lEPB6+5X4JX3FTK/mOgRyEjxPo
         NR9mpIYi6oFT+jPz7XZ9EZc54Uv5lBo2CILwvY4E+3997zzLyyuwJiHIM/f3AzUS5BuF
         Ott0Mezc+lVW/EK674CogiBpGozPsRXV/dA4sdWr0gp2tJ/mtnknDAgMwxIU0+VWMBe/
         l5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AdSMTsu+LtgUCnPNRXGwSYsCPQyqbNfQqw5/RcvDJNQ=;
        b=Wum1//M5Mz8iLby5nusqAVvot0E2UPsI8kAMETeVaz+PsRhXrpZ8r81Gh6q5lFb9GQ
         YQoqL2z/6hzY4SYTtqR751TiG0oJ2hj3c5gnJw4TmSIJDTpDLZtzr36s0KvW3xbYJGFi
         vBON2+cVHgfsMk+kZKmHN894V2iFL9oKOSGMM+7Zd+Fz6UVFFaAdPKK7hWaEpcnF7oRu
         DmmvrWgObMDbbAtFzvXxUA9Ay5KVdNvwGtMS8BIu2F9I/1FxkPJZEzaking7xjdKDrYj
         rXd6j1xY0mvb8TUICXf9rmVPYW3mY3J23Wu/c7pOqDSujDnPDukeG8ct4GGpaF/rap5R
         seew==
X-Gm-Message-State: APjAAAUnOPa7k2Thh0dyd0KA+RzPSLw6vyZSIs3ET3ESwuqvOefJzNIs
        H5XJp86LSbGnatvq67S8OMgWPA==
X-Google-Smtp-Source: APXvYqxvv58TgjJcuU4yrUeNFAHBwd42aANAPZB41bOxwg874J6YPY976CnnpFzfO0Rvt1BD4pVGQw==
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr6004919lji.209.1559740814483;
        Wed, 05 Jun 2019 06:20:14 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id t3sm1893259lfk.59.2019.06.05.06.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:20:13 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next 1/7] net: page_pool: add helper function to retrieve dma addresses
Date:   Wed,  5 Jun 2019 16:20:03 +0300
Message-Id: <20190605132009.10734-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
References: <20190605132009.10734-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

On a previous patch dma addr was stored in 'struct page'.
Use that to retrieve DMA addresses used by network drivers

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 include/net/page_pool.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 694d055e01ef..b885d86cb7a1 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -132,6 +132,11 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	__page_pool_put_page(pool, page, true);
 }
 
+static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
+{
+	return page->dma_addr;
+}
+
 static inline bool is_page_pool_compiled_in(void)
 {
 #ifdef CONFIG_PAGE_POOL
-- 
2.17.1

