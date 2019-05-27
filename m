Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E095C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056192173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKJOah5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfE0JjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:39:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44055 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfE0Ji5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:38:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so2107156lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YcUVHwpttwwhej4P2HLvEtL1IO2oJH9O8jVbXiQY6lI=;
        b=oKJOah5xsOQejVe608LbU61tgbZZ2r49/ifr2Pg6M8Gev75S4nFQ0K3prprtB8Gqsp
         eQN25PWP6sKRyhOQ+K02sT4mfB0dYIWkeE7SCVDLAQ9VgkarDjs/wa/XrbA4AnWmWGNa
         4TOxGgaZ/cjy6wTD+FfUGOz7RAsr5sdGGjj9MBQ+nX6RSGU39wsC/mbLzXKheB5cwCYk
         BGgIjofaHT/mDTdJUky19xxG6JP51PmNkZqY0RGbFFHVuEkwzhWZ/HZH4IC7qoSYv5NY
         jN8Qwc/VgUyguwN5/1SagWlBDNKZZ9RZrbeNUI7Deskd8Qm/p6zP4x7pmy3/q+YOEiHL
         fOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YcUVHwpttwwhej4P2HLvEtL1IO2oJH9O8jVbXiQY6lI=;
        b=Flqp3Y89fNYa6Uz5FnogUo4QfV1Ija29KUG8dGNpXVGQIW1lheH8hMqUInV1oN8Als
         IZHsOhLJPuyroXMew2KuRtOW+rUK3MPXUsDQgztBbmRV5azSyVC9CXHhvF3anUBu1lG5
         0xaWMMmEjDSsymGL00Ms82AeRSOZhIBavE2r++GkQBMdd1kDr0ad13KBtCbMG96EwX+r
         JjbvCQpgQw9LHKeogKZjXEMwT7bIPfUSguhT9BEeYo4CYdgmeSQ5Vln5rg4x26D0sbo9
         dm0otTT4L51Y2e1losGIGhPA27mlpRQcgUgSICEWwxDCqysgecyuOf+DQVlqX4ZfOBci
         661w==
X-Gm-Message-State: APjAAAUFsvw0NVvhJLH616xSh3G3hHbOnlKgOisekDYKMg6YHuJVMSvS
        QgMQVRXOA7Wzp1TGSeNHdvw=
X-Google-Smtp-Source: APXvYqywizOFQsq0Kc/mdfHedIy36/aqlY/XqJ446kfsuuNBXVjWi5ZhB+MqLoq5qQE2xOF8S89VKQ==
X-Received: by 2002:a19:d612:: with SMTP id n18mr45866962lfg.162.1558949935111;
        Mon, 27 May 2019 02:38:55 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z26sm2176293lfg.31.2019.05.27.02.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 02:38:54 -0700 (PDT)
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
Subject: [PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when merge
Date:   Mon, 27 May 2019 11:38:41 +0200
Message-Id: <20190527093842.10701-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527093842.10701-1-urezki@gmail.com>
References: <20190527093842.10701-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to try to "unlink" the node that is
definitely not linked with a list nor tree. On the first
merge step VA just points to the previously disconnected
busy area.

On the second step, check if the node has been merged and do
"unlink" if so, because now it points to an object that must
be linked.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Hillf Danton <hdanton@sina.com>
---
 mm/vmalloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b553047aa05b..371aba9a4bf1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -718,9 +718,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
 
@@ -745,12 +742,11 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
+			if (merged)
+				unlink_va(va, root);
 
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
-
 			return;
 		}
 	}
-- 
2.11.0

