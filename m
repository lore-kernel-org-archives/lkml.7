Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2999FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066DE25F5F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTEyy87m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfE3SUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:20:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36249 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfE3SUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:20:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id m22so6787279ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AdSMTsu+LtgUCnPNRXGwSYsCPQyqbNfQqw5/RcvDJNQ=;
        b=NTEyy87mbpZennf/zO3UY3SG/jU34eWt9oBeag4D8YjahXlGpvo7jFJ45TsemIdnir
         GDDTpbKLurGeDuALSvM6j7s2xNdezurfEaq3Do0FdVu1zSrcVUfBnzEjlX9CPvMPhzYJ
         syvG28Ahiha6P8q/z1kIyl0178d00DQHN+sX/j5wk8ko44/63zLEGfJyi7VPUdIJ0LKG
         TgaTpYJ6tpJG3xAZrI95TMKLk8q+WGk0L19nUTHjuhUVz5EeWBCSPoZe7eWVxtRSZtYW
         kYjH1/WFTyKdQ+VO2y6VV9nuGp1SruffgOv8KjxhvVfDhLZ+qlpEcUfBKzBd6xbaakTA
         2nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AdSMTsu+LtgUCnPNRXGwSYsCPQyqbNfQqw5/RcvDJNQ=;
        b=ZXKmn5oJ3RdxFXn7L45+qx3OR9LYg+lkNjAjsoI7YEbhClxvDQKdTo5qM+uaf6JtCX
         TnwXaFZ+kxTns3ZbJtqTomkOgYXbGoNJbJhvp7YFj6fOexA9Q6rmpdqM4StFZdc/IZY4
         /KzsUo6uwmd49Kjr245wb/SLi5vs4b+rCXIv10BITYM7q+1bvGU/YPj12x5IgWlJZpEH
         jdo1mhZq+Uf16sBrZcvKa3JlSkQlXQLC9vgIUUEYU70p12riYcZPVOnGEL0R3aQMgC9n
         esXMo87jmINpB5wioVd5101twCZsKPyeBohBZp1EHlKEHyD82Bsm8QHPVIXagnVe1Ydf
         0g4A==
X-Gm-Message-State: APjAAAWnkrI97YA/D4UxSxkR86ufAA/OO5e5YaVoWvx0mK3TRCYRbE5G
        dX/4+un9QEZkeINWt6PiN1wrve6Tq6U=
X-Google-Smtp-Source: APXvYqwcOOLVdQF2eRwE44U7qP1o+9tRsDYFuMaBYPD6l5MItx//FH0w80EsZyjHpAQDOz9EOA3SFQ==
X-Received: by 2002:a2e:9756:: with SMTP id f22mr3083605ljj.30.1559240451067;
        Thu, 30 May 2019 11:20:51 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id v7sm388946lfe.11.2019.05.30.11.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:20:50 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2 net-next 1/7] net: page_pool: add helper function to retrieve dma addresses
Date:   Thu, 30 May 2019 21:20:33 +0300
Message-Id: <20190530182039.4945-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
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

