Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2574CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC72217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTb1EOoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDKPfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:35:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:35:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so7913476wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eracmwt7PPl4AZZBoOATyO/9W4GSvbRyS4J/dbiNmIA=;
        b=ZTb1EOoyk2g0YosWNn4VcVrp37Q37OEm3YVArlwvPoQFaE1YLjccap5kzXUaRAtmIh
         iptk4qUXxUluaeBul5VtytYijzh5GrqUvh4aHjKLU4MbcHNab9IlXjLoRh84P/zFC8Q6
         QfkJJuVplNXhj6gFHj6tCAQLE1XiE6TI79mQaNPa5N4OsmBwId4hG2sG48LpcY7PgqDP
         7au/fLKxLOEJIwaiyvVYzqwEEhw4LQPRLrlVxZBA3uOqm/QXMaeFMdjO7BfsSGJ94Cox
         Fk9uKwaVDpqVdJStUt/WQBS/ZTDc2V60tVb9YN6NI6bMxrp8AzPcg6O0CJEAdaCIt8Cl
         5NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eracmwt7PPl4AZZBoOATyO/9W4GSvbRyS4J/dbiNmIA=;
        b=txCGhUHyNZtG4nj1kanUmLe56f5EHCcIMVjXZSlvJANmzx2UgJl0gCiY+ohvXYtaIr
         1VCCnOmc6VB2oBIlpQLI/4fRtD2/hS8BYKidkP0VWlWJkMYHzUMpafkNE97KFziR8PQ5
         ycU+FagUfGLtxdshcht131AKfIpO3syGt546dClJ0LkNejoFwiRiL5KiFFRCmp/KhpUM
         NkSto6qMYmROSiU5zg9Kf34xlM9bCXYR3DpGdy51jMwY8Xc5GYLoLnsNl5wpgcSB8RfT
         S+GzyArp3cc8P5BGFnXsV9jZlVW1YIM9jPN+hGzpY8yd+DoaTO86DsgahuTK8DFYAP8L
         CtuQ==
X-Gm-Message-State: APjAAAWYDvW0kd5pBYVdJpgN2jfYZM9DwSJwZB3kjMPXYL1KPTCQsTcJ
        LqIgi1yvyzeFwW1qymkntGs=
X-Google-Smtp-Source: APXvYqwdB4n0/82+wCQjWn8g2IEax8X5UaRW6x7ipGPP/Fo56zhXp7uZIX+UZNz9jOWSuzaFN8e2xg==
X-Received: by 2002:adf:db05:: with SMTP id s5mr33095860wri.247.1554996952020;
        Thu, 11 Apr 2019 08:35:52 -0700 (PDT)
Received: from ?IPv6:::1? (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 7sm130817888wrc.81.2019.04.11.08.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:35:51 -0700 (PDT)
Subject: [PATCH 2/4] z3fold: improve compression by extending search
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksiy.Avramchenko@sony.com, Dan Streetman <ddstreet@ieee.org>
References: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
Message-ID: <c1a85d7d-d372-6d8f-5bd1-8e124c335d6a@gmail.com>
Date:   Thu, 11 Apr 2019 17:35:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

