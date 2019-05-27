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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FEEC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623821744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdyDohT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfE0JjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:39:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfE0Ji6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:38:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so11588488lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5tFxW9hH4KTKWLbD5PL7NocPZCk93KxY6ol7ln5ws1s=;
        b=WdyDohT79RWv5sQw8j/CoiyAF1ieXhBzh55F/UbajT9jF/0uJ67nJC3KNnHTUPoI0T
         oUBP1DChU3kD4+oixvGJZjalRgEuupfxfw3tAciwmhJ8azlHnw/9zdY211g0HetUZqHo
         pcLoUQjOziPwn7lefVncMQD2ZdI0BPz9lVodeDp4CHJnFXoNRL5DLmsx9CbYtKPcw5No
         UCR/uvKE8YK6JKhvoExYF/ggb0izBa8VIDKiBvqNTs5o+yZ8G4Hrb4BkQtKx1Z4I6Pvb
         0wCCaGD8KZvWTFTFFm9Z0/PQLWWVEWN+7T6Eg+/RaX3QawT2c0YbBBzBtdNCU4JatZ7j
         wZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5tFxW9hH4KTKWLbD5PL7NocPZCk93KxY6ol7ln5ws1s=;
        b=FxOF8uRJY4Jo+XQarH46OWPfbIKCirISnWlBujp3NTUcsZBRNpSmsFBcGC8DzK2/sl
         9ewUY7HUT7MqevTsMroW1TPWLIa0bWZ3NQeFkp+4ugYgKpYQguustsLZ+6YRocuFrWNw
         8evxGwtSq+AJQNze/gnbZ8qTqorleUQ8+V3UU6ZUtpm4SAjpVbPYUrcrQgZAGkcfO7Sx
         RP9Jf7x1fEfl1FPmzTRmJt4sZtDur7aLDslWT7ZR/dbm0tUAqWPhgRaHSWHOa9Zu7l9R
         j4cbnha8+NK3EPHYOIIQjmkvstnBwt3CwKgGrJWPKW1bn3KiNu14G9xCOMyFd5OJI2N+
         meCg==
X-Gm-Message-State: APjAAAXMQh348CzYNFIyKfp5sWHeadW/I6MBbo+VhFBf+39XansGQeDO
        YzEDjFJsgHQ0Ys8v9eck34I=
X-Google-Smtp-Source: APXvYqywlNbALD5TT5l11okB4ZaZ9LJNYUAYl35+RlPAv4hvj0NbaW0wQ0+uLocyyjJWapoGw3TE1w==
X-Received: by 2002:ac2:5324:: with SMTP id f4mr5086344lfh.156.1558949936459;
        Mon, 27 May 2019 02:38:56 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z26sm2176293lfg.31.2019.05.27.02.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 02:38:55 -0700 (PDT)
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
Subject: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Date:   Mon, 27 May 2019 11:38:42 +0200
Message-Id: <20190527093842.10701-5-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527093842.10701-1-urezki@gmail.com>
References: <20190527093842.10701-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
function, it means if an empty node gets freed it is a BUG
thus is considered as faulty behaviour.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 371aba9a4bf1..340959b81228 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -533,20 +533,16 @@ link_va(struct vmap_area *va, struct rb_root *root,
 static __always_inline void
 unlink_va(struct vmap_area *va, struct rb_root *root)
 {
-	/*
-	 * During merging a VA node can be empty, therefore
-	 * not linked with the tree nor list. Just check it.
-	 */
-	if (!RB_EMPTY_NODE(&va->rb_node)) {
-		if (root == &free_vmap_area_root)
-			rb_erase_augmented(&va->rb_node,
-				root, &free_vmap_area_rb_augment_cb);
-		else
-			rb_erase(&va->rb_node, root);
+	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
 
-		list_del(&va->list);
-		RB_CLEAR_NODE(&va->rb_node);
-	}
+	if (root == &free_vmap_area_root)
+		rb_erase_augmented(&va->rb_node,
+			root, &free_vmap_area_rb_augment_cb);
+	else
+		rb_erase(&va->rb_node, root);
+
+	list_del(&va->list);
+	RB_CLEAR_NODE(&va->rb_node);
 }
 
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
@@ -1187,8 +1183,6 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
 static void __free_vmap_area(struct vmap_area *va)
 {
-	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
-
 	/*
 	 * Remove from the busy tree/list.
 	 */
-- 
2.11.0

