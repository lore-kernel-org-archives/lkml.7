Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C03C282E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06BA206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW8EQGCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfEZVWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 17:22:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41795 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEZVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 17:22:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id q16so4565716ljj.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nMiFTZq9m8Tud2oYGi2GiJ1Z+X/2sbQtc11N2qZi8ps=;
        b=kW8EQGCX9RPA7Y1Hbh9+m37Rg3nnmFcAhCEEN+Wn4d6HHxofUWi5NJZicvFduiIiWH
         Z4tWfptAT8kbByu96/Af1k9A65xG9kG1xwVMP+zdYzfi5mBI3MfRi++wLymSduYdjNPS
         el25ZYIltNE8kQrBHpSMo9w+RS1fCViSv708fFUtKfLosmGswxo1c4tg/wZs9epUFFel
         ipOv7KktBtXHfm5LZmxBImQl05kSuQGLu5g/C2/JEqvzEanQeYq1WFYBsfHbm4lXQFMl
         0gdsAkkrqKf4WYwHkn8KFBNHuGoBxYk55CqocVHv6l8pqAYsNa0wErxcHIB5sV+ZYsyz
         bOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nMiFTZq9m8Tud2oYGi2GiJ1Z+X/2sbQtc11N2qZi8ps=;
        b=O4H4g36kwkUcITafgPI51whKaqtqRJc2T6fEUgjr7GovLNOdmxyWQLIYwPOoxRvU7X
         Jd+8aQDY2vB+YKg8LZXWHucDOiwrPC1mZneX5ujyh8iZmfWX0C1OibUtBS4PPGSaBYWj
         MSEGl9eKYHufpqqMrusgW2rbu6mfXgsal03hwyoyJYaKI7GQzHM4spTqrJ+hymecpfnW
         ul9SB9+Vl+5iDn/Yy2PJyqDrYpwi0LZNEtIArjYbJlqfVM4RGVOeVeqnawVOV/8ZYgOB
         mGtPONVD1nZOK2wsn0vdrLoAfe3xqj//x6xRE+l2KBDHOYsgxW+Tksxov9+c52qR0G49
         Dtyg==
X-Gm-Message-State: APjAAAWTNbjWzqYCCdTfUCPPLXnScM/raEI//mp+xvUmDRcWBtgd5tlW
        7YGhAs+iMoekZBHPHbvNUKc=
X-Google-Smtp-Source: APXvYqwLtfKo3g1XsLcA3UgctcSE5rh7e9LElVzrf5Zs8QIa2LJrFz7rsW567IrrpGxEhHMpbftXEw==
X-Received: by 2002:a2e:8985:: with SMTP id c5mr14828724lji.84.1558905747025;
        Sun, 26 May 2019 14:22:27 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y4sm1885105lje.24.2019.05.26.14.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 14:22:26 -0700 (PDT)
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
Subject: [PATCH v2 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Date:   Sun, 26 May 2019 23:22:13 +0200
Message-Id: <20190526212213.5944-5-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190526212213.5944-1-urezki@gmail.com>
References: <20190526212213.5944-1-urezki@gmail.com>
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
index 6f91136f2cc8..0cd2a152826e 100644
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
@@ -1188,8 +1184,6 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
 
 static void __free_vmap_area(struct vmap_area *va)
 {
-	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
-
 	/*
 	 * Remove from the busy tree/list.
 	 */
-- 
2.11.0

