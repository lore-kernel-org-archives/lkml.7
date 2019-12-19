Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F63C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEFA24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG2Rag9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:26:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36664 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:26:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so6460068ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYZf2PAZk6wJlce5o8wLQfqz+k895+yefprdeiTmKqI=;
        b=UG2Rag9zPQHoaQ48g84ISujxsEL3CqlKjU167VCafzjKPq2OPtDP05/RKbX+aRaJBK
         APiv1iiZcjwGZTm+NVk2vrUzQ4YLNxb5rMznUGV+krOQdXLjZ+xUj0LUN8C/AUaSkfJ3
         lKeKpUPFNJN/pzwh3MvnV8mzR6XmKkuniKawcKtmCnvylPrt2Yzs9S77wwzQ27mWXdb+
         yl0i6MMzFQhg4sNQRHJoK1h9nMrKUVF+TPIOPDbJ1r7M8eShQkbnae0/lES/OdBvjIFS
         08z2nH846N9EuofyWjdcAX1QLeqdAosv8iJQhcW6cE5fBFcLg1qw6mIPCZOV0WMK+wk/
         P2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYZf2PAZk6wJlce5o8wLQfqz+k895+yefprdeiTmKqI=;
        b=Hp91ATMbLqnfCe3oLYwEV9LXO/Ml7hUYQTxrPl7ViFxkvr89X+2WnW3hlNcSwPD++E
         VlelskupghyR5ig+kEI0JHxl+qzdXU/s9zLEIsuFvQL2qt0ks+J73brXKK3FFIZwesIQ
         L5oz4nL5jFm4pqGVsu4yNDr2ex/OcZz91e1bvza6NpIWEjmVEyzGUPe9cSulhDewL1aD
         CYkeiNf2m7rSMgtBI5SGg1DxzrPhNCVzWyLlUuZp8ckpS/h7IR7JpL3nsIHyd8YaSHe/
         BvRIGDa8TwplEbF26a/Zyz6/nAaanavjmOSG/eTRX5gq/ur/HJ6phjnEZZAH2TXwj4Aw
         VOgw==
X-Gm-Message-State: APjAAAWJ/YK8G+Z4HyVZkdF7Yc9iEPmXeOggLjgeZ5kwqun+JZUli1HA
        MNMMjufK9dA0NCgR6r8RX2U=
X-Google-Smtp-Source: APXvYqwoDSKjOq8wwxmkSZnXq/HfNtdJzzk7qU8k6Ew6E7DXu96p7VMBGYDJB60KDr7YWng8euHmIA==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr5690943ljg.126.1576765569240;
        Thu, 19 Dec 2019 06:26:09 -0800 (PST)
Received: from assa ([109.252.14.238])
        by smtp.gmail.com with ESMTPSA id y1sm611437ljm.12.2019.12.19.06.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:26:08 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:26:07 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: [PATCHv2 2/3] zsmalloc: add compaction and huge class callbacks
Message-Id: <20191219152607.03b458b910625d95f388f4d1@gmail.com>
In-Reply-To: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
References: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compaction callbacks for zpool compaction API extension.
Add huge_class_size callback too to be fully aligned.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 mm/zsmalloc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2b2b9aae8a3c..43f43272b998 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -437,11 +437,29 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
 	zs_unmap_object(pool, handle);
 }
 
+static unsigned long zs_zpool_compact(void *pool)
+{
+	return zs_compact(pool);
+}
+
+static unsigned long zs_zpool_get_compacted(void *pool)
+{
+	struct zs_pool_stats stats;
+
+	zs_pool_stats(pool, &stats);
+	return stats.pages_compacted;
+}
+
 static u64 zs_zpool_total_size(void *pool)
 {
 	return zs_get_total_pages(pool) << PAGE_SHIFT;
 }
 
+static size_t zs_zpool_huge_class_size(void *pool)
+{
+	return zs_huge_class_size(pool);
+}
+
 static struct zpool_driver zs_zpool_driver = {
 	.type =			  "zsmalloc",
 	.owner =		  THIS_MODULE,
@@ -453,6 +471,9 @@ static struct zpool_driver zs_zpool_driver = {
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
+	.compact =		  zs_zpool_compact,
+	.get_num_compacted =	  zs_zpool_get_compacted,
+	.huge_class_size =	  zs_zpool_huge_class_size,
 };
 
 MODULE_ALIAS("zpool-zsmalloc");
-- 
2.20.1
