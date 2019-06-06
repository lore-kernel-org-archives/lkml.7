Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CBC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7912089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQT4WuDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfFFMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:04:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36265 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbfFFMEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:04:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so1349582lfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XWWrktLRhmH5onjl7ijfGHY6CQGMEsILV3xHR3Mmnn8=;
        b=bQT4WuDlx82yqPLzBi5aH828d7S/PWpupBCEa50SzGE4GRNiWoaeUegTs9DH/63Db+
         3Aaceh4MKlRNKmnSBRcbq4N5pjyoQjI0cNRy1dlxpn0LT5QTI5rBrfNOYURNJY9SqBct
         C5fdXevDbg8BmUSSzYcbWvuqKqxSCMXcAjmfm7gAoDLiOogur2nPbI0mhUaI8A/PyAJE
         e8g1GhnyMYhcDPjxxzFXahQssbL/mtsQWUtHFzUr3xm01uFdPsjuxXi2PS81JPyeL1ez
         5Ux8SmXB2+DrXu2KWm5NNzyiDOu2tMnVCZgIaZL6GHhIex3BFzixO59045Go+8FTuI0m
         wB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XWWrktLRhmH5onjl7ijfGHY6CQGMEsILV3xHR3Mmnn8=;
        b=I4l8to7KC62TkMxrUWhzKuW54f1rxM3rCmWisR0m1iHk6MmxiwefVjlZyhIs5F0b+W
         wOBsQM6prG5K9OVeWi+95gFeAr6hnIt99aTkmXsHAvhdW+3ibXT/+hcHAJ1yLKmn/03z
         E8dA0iaGflMvOKS0U+uwHHZPNsdYsacJ41LQjg2iwVKiP7xW8oilDxq7vZYRo/dpZxsn
         siAJZHn5sXLbeOytrksnz92WDZTanDhOnaxbP1f3xKliAk6Owdi4jTeuALuMagLIQYl+
         y49QDiHX309IP15/Rn5Kmljrls5PUsNxjx3oFnzII4z2mK02nzll80xTFvMneBSe6Yfa
         ja9g==
X-Gm-Message-State: APjAAAXVEzyW3QjXMbdxpio3zWebGA5yq21oeWOBa0Hqh0WS+55+yPDC
        RqjBexLg6ToJmScM/fT5Hvh9KPJSbmM=
X-Google-Smtp-Source: APXvYqwmXYlkVxNNMJGX5neeMTOxEpgrpeKu/vrN2TjjhK9CMP3mWnApcrZQjx9lDDGfsysi0/QCkg==
X-Received: by 2002:a19:9156:: with SMTP id y22mr9854544lfj.43.1559822668509;
        Thu, 06 Jun 2019 05:04:28 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm309036lja.94.2019.06.06.05.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:04:27 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5 4/4] mm/vmalloc.c: switch to WARN_ON() and move it under unlink_va()
Date:   Thu,  6 Jun 2019 14:04:11 +0200
Message-Id: <20190606120411.8298-5-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606120411.8298-1-urezki@gmail.com>
References: <20190606120411.8298-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger a warning if an object that is about to be freed is detached.
We used to have a BUG_ON(), but even though it is considered as faulty
behaviour that is not a good reason to break a system.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a4bdf5fc3512..899a250e4eb6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -534,20 +534,17 @@ link_va(struct vmap_area *va, struct rb_root *root,
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
+	if (WARN_ON(RB_EMPTY_NODE(&va->rb_node)))
+		return;
 
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
@@ -1162,8 +1159,6 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
 static void __free_vmap_area(struct vmap_area *va)
 {
-	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
-
 	/*
 	 * Remove from the busy tree/list.
 	 */
-- 
2.11.0

