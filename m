Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5696CC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2982173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb7K9MML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfE0Ji5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:38:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34344 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfE0Jiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:38:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so14125563ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=Tb7K9MMLxMfT8Ruf4WhPnYDIGjoQlIJuk2rE0mwfrdgOa/ztIWbsgQRI00S7Iejm44
         hO7Bn46pPdR249Rmcc1jZDG2trMR8cqjlK4Kv2xTAQqcJQQ82aP1b10pZZFz+CDc9qLj
         cfkr89AF+OJ6LHZd+GGhpFaEUIWiZVM4F3jXQlnztnDKPVcwLVyKw/7LYsO7FrOhnC1Y
         qYGeXOx6TkhbMI3bbxrw337HiydFA0nJ/+KrDcd6M7/w1gfyW0hw1SrPBC5bz5k9BJXx
         XRyhT06BSCeU8Jp0OAn+AU1ZNGNNX7c2oxxAz3E7mtf8G7P+cYWz44gNM+/OOh5Tw/u3
         Hf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=U9z9rMrrb5TkskxfVxQYs7RLe2U/vjvTCSA7swmrHX92d4oW3lnE3re75F521lUGvb
         Nzf8uJNh1puq59B5l3hpCvbqJmdbwAc9jLB63D3KA75udIw9aQZSHlh9NBNLPHcoaW+z
         2rdC+iECH/AfKq2pvO5kslXoieMXZ9wpyMLmxoCFJHkkFc1rjyndcC4xiWDi9HZ+knfr
         uLcqbubLNg2QowVDflRqT0Ifs7iHd+x1nje7WjAqtADbUSIIVN/5FlZWYtxzYTo2GZhf
         psjNCUOyR9A7SZPPn9hFQW906+XOknqjT2AkORXiKDAo5Qj3dHchwE600hlfy+cjQsEI
         NURQ==
X-Gm-Message-State: APjAAAXTBmnwIsmMc5NSb1yiNBqJkzz3MQT7aKs3nawCU4ORDXxZMyur
        +mtolLgZBXEkwEej7zKpPGc=
X-Google-Smtp-Source: APXvYqxqDucO+QSLHcUPvlIGziovBalve+hsDNrpg9l8JvuiiZP9nKTlMH0Z+oGIvB6vfIb/4Pv8Aw==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr16840496ljj.69.1558949932592;
        Mon, 27 May 2019 02:38:52 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z26sm2176293lfg.31.2019.05.27.02.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 02:38:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 1/4] mm/vmap: remove "node" argument
Date:   Mon, 27 May 2019 11:38:39 +0200
Message-Id: <20190527093842.10701-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527093842.10701-1-urezki@gmail.com>
References: <20190527093842.10701-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused argument from the __alloc_vmap_area() function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c42872ed82ac..ea1b65fac599 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -985,7 +985,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
  */
 static __always_inline unsigned long
 __alloc_vmap_area(unsigned long size, unsigned long align,
-	unsigned long vstart, unsigned long vend, int node)
+	unsigned long vstart, unsigned long vend)
 {
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
@@ -1062,7 +1062,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend, node);
+	addr = __alloc_vmap_area(size, align, vstart, vend);
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0

