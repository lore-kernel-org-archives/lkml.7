Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4CC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551D5217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXGc0NZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfDQIhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:37:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34569 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfDQIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:37:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id h5so15295581lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eracmwt7PPl4AZZBoOATyO/9W4GSvbRyS4J/dbiNmIA=;
        b=tXGc0NZhjaZsco2x643feyLYfETk7tP69DmsmI1ukNlFcsqVxOZPgNTDgtFTsGpGei
         zDp0VmDlpdSIaiqE58MDXrAFrLOcsd2ZgUb40kf8v9PBhD3bI8ob/4WqnZcnPTB8Wjts
         D7UFfdJOdF4zoWWmRJgX3/VMH+om5tlrkb9WVaRuRnzgsLKBZ0zjusQF991pOWXNXSdV
         sUz8cyhwdpR8nh6Ub/i3hfNLgjfq3zCYmsmTmXt2YZ7it6U5BtPhVIOCvnYGYbn5Ga+c
         271dvA3vLMLYL7XdQfGgABhH7twTe7Z7PNeLa/lsXSITTNjU0Bnh7AWc/ZTyEmfCoxDY
         AysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eracmwt7PPl4AZZBoOATyO/9W4GSvbRyS4J/dbiNmIA=;
        b=apbLmVpZxUTEqVULXq7VZ2jlLi2gMi4v5E5BNsTYlSGstSHFnJBVqnM97D2w7T/ecA
         ZFDF4RDwH76HHvWNBPHeN+8xKqQYHUkl1fJewelshZH/dCQFjeGQzeTsXxeQt0Mw4h3Z
         O6MoamH4Ol+ghniygqIA6RFrm9/ltASOnZfwBN+TmxaH61kfBPzIl6Ty0f4XP3tzYS9K
         VSN7xA7MAfZtF0NLLJAIHAPDfiimMzTzQU9dLU6ZbR47s8DEzh1lKVmE73o8awjveg/f
         Cu8hiWxNKog8rJ2iS7eWsRNQ+rO4wY26UFZcl3kr+0fUu/dWsXl1TmJWNYCkxKSbErd7
         ffwQ==
X-Gm-Message-State: APjAAAWo/nIeA8wZtf88ds6cF6+OoZOtmdBxyvqNQHLoi/fHDsRwk7CW
        b+aXuaxF3Puv0M3OkBNYwiFkRF10Js0KmxfO
X-Google-Smtp-Source: APXvYqx4ExKeIMbFg9T9tX6SZdDS0Cbp3kgvlbWCD26SsYSpLy2UMegfsoPIlI9gnvs8kofXCRRpow==
X-Received: by 2002:ac2:43d8:: with SMTP id u24mr23190693lfl.94.1555490255103;
        Wed, 17 Apr 2019 01:37:35 -0700 (PDT)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id d192sm1649933lfg.79.2019.04.17.01.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 01:37:34 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:37:33 +0200
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCHv2 2/4] z3fold: improve compression by extending search
Message-Id: <20190417103733.72ae81abe1552397c95a008e@gmail.com>
In-Reply-To: <20190417103510.36b055f3314e0e32b916b30a@gmail.com>
References: <20190417103510.36b055f3314e0e32b916b30a@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current z3fold implementation only searches this CPU's page
lists for a fitting page to put a new object into. This patch adds
quick search for very well fitting pages (i. e. those having
exactly the required number of free space) on other CPUs too,
before allocating a new page for that object.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7a59875d880c..29a4f1249bef 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -522,6 +522,42 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 	}
 	put_cpu_ptr(pool->unbuddied);
 
+	if (!zhdr) {
+		int cpu;
+
+		/* look for _exact_ match on other cpus' lists */
+		for_each_online_cpu(cpu) {
+			struct list_head *l;
+
+			unbuddied = per_cpu_ptr(pool->unbuddied, cpu);
+			spin_lock(&pool->lock);
+			l = &unbuddied[chunks];
+
+			zhdr = list_first_entry_or_null(READ_ONCE(l),
+						struct z3fold_header, buddy);
+
+			if (!zhdr || !z3fold_page_trylock(zhdr)) {
+				spin_unlock(&pool->lock);
+				zhdr = NULL;
+				continue;
+			}
+			list_del_init(&zhdr->buddy);
+			zhdr->cpu = -1;
+			spin_unlock(&pool->lock);
+
+			page = virt_to_page(zhdr);
+			if (test_bit(NEEDS_COMPACTING, &page->private)) {
+				z3fold_page_unlock(zhdr);
+				zhdr = NULL;
+				if (can_sleep)
+					cond_resched();
+				continue;
+			}
+			kref_get(&zhdr->refcount);
+			break;
+		}
+	}
+
 	return zhdr;
 }
 
-- 
2.17.1
