Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ECC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D520879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruSnW7Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfEVPKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:10:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32921 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfEVPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:09:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so2467962ljw.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFExWlr1uO9x+HQMZPCc0rJnteE0HEqVX28pJUGOwfI=;
        b=ruSnW7UoKugOt8Wk1U1vu2eypYhGi77d8sGeCoBp0oSFU+eDgdC9MwQtjOXVfQNXuV
         6KJdjb33wUXIuVd6jL6/hrMIkIwfRg6u25wtb98ZvjDdRkC8gQ5YNKjlKIERjDCtgBpF
         YTMccV5Ssgz03q4pn1PtYWTiu9ac7xUwgjKnVrljLksEI+e5xpoedgjRRhXPKAg0jQd7
         bphzSaFhRjZD4d1D9guADzeRVcCpyJyuiNn/S7k2cEay/j2r19+H6JHZF1iVQFe7KZYI
         wIiDn56+llj1MsRwEDWcT2FNWLpU0Kj75jessgu3OTtCThc/G7QGX3XDY0oUaBgCEhVl
         VxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFExWlr1uO9x+HQMZPCc0rJnteE0HEqVX28pJUGOwfI=;
        b=df9MeLznKzYnF6tkfzFvvW4OarszpdzcDBp4hsUJdpDOOCGkxGYzXy0Eh8kShhLTHL
         4ovysGdHqEUv1e2JCnVJeObJZ8IT7TH2m3FaSXlXCQIYjOkrkBbgwMLFnulMJldynqaE
         cg+bp3l3yLDG38VmgKpLbcJoiZ0vrDQ5Jty0NH4dfkpm2K6YPrANbVYU9C1aGe0ykMaZ
         PpSIcrUa7g69Pkyz0S4htEUhbiz0Yvzk3dyi+Nk8uCVxTqITxpMOs4Xs/lwxyj6LgpSQ
         DjgY0j5lbxSp3nEOPqshAjs80ftLAT77wIJKP9jJJ0rPovwUYHGGyt0dwOu3+Z7Yh3al
         bDJA==
X-Gm-Message-State: APjAAAUh0tFIwhKa/REebn469q5uUM0dpi7BLYibJpFib48GXG3TNl1K
        a1r+1L7zmU5rAXJj9cnnvEU=
X-Google-Smtp-Source: APXvYqxhdEDHSoE2NHR+WwYFSvC801p+AYV2zVp/M5sMm0EjyGz/P8bAl+KcSdmxXbpFBa/oszd+gQ==
X-Received: by 2002:a2e:9d09:: with SMTP id t9mr12001686lji.151.1558537794729;
        Wed, 22 May 2019 08:09:54 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t22sm5303615lje.58.2019.05.22.08.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:09:53 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Date:   Wed, 22 May 2019 17:09:39 +0200
Message-Id: <20190522150939.24605-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190522150939.24605-1-urezki@gmail.com>
References: <20190522150939.24605-1-urezki@gmail.com>
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
index 89b8f44e8837..47f7e7e83e23 100644
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
@@ -1190,8 +1186,6 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
 static void __free_vmap_area(struct vmap_area *va)
 {
-	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
-
 	/*
 	 * Remove from the busy tree/list.
 	 */
-- 
2.11.0

