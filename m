Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184BFC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89F22054F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS4OCsP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHKSqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:46:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45634 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfHKSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:46:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id t3so7903989ljj.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sHzzzA2xQ402RWvU0Hu0IKz3pQGvFb+F2/QvqTcdhf8=;
        b=OS4OCsP8BenhY51p8Ak6rLYx4nCshsn6TVflf7rjLCbw1BgGGoFNcGyLh2d1XIwIv3
         CqpNm2hBHMWtealt8suXi5VqYKlCHgoBK3yIWBcTQ6d1Bxx9+U/B8WITXCMCVwauWKgv
         M1jUOKF46HqhGVZuPcW+n5HesWClcxctftF/m4cU+uusN1I5uyeOPgH/l2Bvea0mbZmb
         xZwTCqBcTbL5PwVPiSZksFX56bxzIg02REWywzbZWohvsfAs1N2/yAYi0HbTEjVtH2Zu
         IU/cJK3SEA2GPlbZa0WPk3svaJ+z6tVRWVjuktLxxIeB5fOaBkj+Np+rll68+9+uxmyn
         xKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sHzzzA2xQ402RWvU0Hu0IKz3pQGvFb+F2/QvqTcdhf8=;
        b=AGkLtlYZzVOon9Jd5a1v/OVPN5gR1+JoCwpzX3N5QguQlkgTB3LT0OlHfMpkKiaBjR
         Ba5FYvme6JnNjEw1/RwAEwJoek0/8yqjaqP3l0UUmowhb68gtJzrk9KdQB3xEOJVKSbg
         YMOul2eMDKZqBhp++6QrSytEzU2sw4vSVj0+SKpY7YGxA0Tr4voG8wAq1jmnFYZC2aVg
         OWy00npY4wzCNHtM9YI9izUKgajeWUq00HojgmMQbKFFDMLumv+ojOjrbgO/iVkeCL0N
         rUCbtWJN5AjdqhG2FQjunRbQ5FSQsmH8TGOz5G2ErkxzDPZWt8nK5YGR+mDNRkeImcuq
         vvRQ==
X-Gm-Message-State: APjAAAVTREQWolCidQPfpkMOmfAqFL1MlF5/fEKlmlD5KSyonYe4Ud2g
        FXjzpCo677TdFSevPKDfiOM=
X-Google-Smtp-Source: APXvYqxOFPiSBzpEvwA4o0KKqFwesdC+LHIdPwuhVDpto0/o8yY2Owf8hxw72k10f1rYMVkEyjEzwA==
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr16554929ljj.147.1565549188182;
        Sun, 11 Aug 2019 11:46:28 -0700 (PDT)
Received: from localhost.localdomain ([37.212.199.11])
        by smtp.gmail.com with ESMTPSA id t66sm1536425lje.66.2019.08.11.11.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:46:27 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] mm/vmalloc: use generated callback to populate subtree_max_size
Date:   Sun, 11 Aug 2019 20:46:13 +0200
Message-Id: <20190811184613.20463-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190811184613.20463-1-urezki@gmail.com>
References: <20190811184613.20463-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RB_DECLARE_CALLBACKS_MAX defines its own callback to update the
augmented subtree information after a node is modified. It makes
sense to use it instead of our own propagate implementation.

Apart of that, in case of using generated callback we can eliminate
compute_subtree_max_size() function and get rid of duplication.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b8101030f79e..e03444598ae1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -385,17 +385,6 @@ get_subtree_max_size(struct rb_node *node)
 	return va ? va->subtree_max_size : 0;
 }
 
-/*
- * Gets called when remove the node and rotate.
- */
-static __always_inline unsigned long
-compute_subtree_max_size(struct vmap_area *va)
-{
-	return max3(va_size(va),
-		get_subtree_max_size(va->rb_node.rb_left),
-		get_subtree_max_size(va->rb_node.rb_right));
-}
-
 RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
 	struct vmap_area, rb_node, unsigned long, subtree_max_size, va_size)
 
@@ -623,25 +612,7 @@ augment_tree_propagate_check(struct rb_node *n)
 static __always_inline void
 augment_tree_propagate_from(struct vmap_area *va)
 {
-	struct rb_node *node = &va->rb_node;
-	unsigned long new_va_sub_max_size;
-
-	while (node) {
-		va = rb_entry(node, struct vmap_area, rb_node);
-		new_va_sub_max_size = compute_subtree_max_size(va);
-
-		/*
-		 * If the newly calculated maximum available size of the
-		 * subtree is equal to the current one, then it means that
-		 * the tree is propagated correctly. So we have to stop at
-		 * this point to save cycles.
-		 */
-		if (va->subtree_max_size == new_va_sub_max_size)
-			break;
-
-		va->subtree_max_size = new_va_sub_max_size;
-		node = rb_parent(&va->rb_node);
-	}
+	free_vmap_area_rb_augment_cb_propagate(&va->rb_node, NULL);
 
 #if DEBUG_AUGMENT_PROPAGATE_CHECK
 	augment_tree_propagate_check(free_vmap_area_root.rb_node);
-- 
2.11.0

