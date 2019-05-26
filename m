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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451EC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC60620815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao5CkBZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEZVWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 17:22:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33600 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfEZVW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 17:22:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so2747448lfe.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcDlkJTeHrjHVEgzRPAEZQALvFAG5US4eI5mM5YgZuY=;
        b=Ao5CkBZMIKG8lMZLADM2cFJSxDg0Ojot0t///bzeuKFY03bvOBAnzd/IYRNsnx1egd
         3cx0VIwpT7ShMf+DETVPyhQbGBL4J7Dq99mDqyJg9c16+rDrd31BAiUqhE+YSuLBA84g
         xyPOC78X5H2fEytgSnUVAtMS0oN4D55Qh4L+biWyJ0niL4cwDMbctSZPD0sko/8Wt+NL
         LwcBZwe5kMfaF35crXxjCxAx0oMGBleEaBvzu7biLO379bYGhX9Rla8wNqgEaWl9NWDQ
         Nu5wVqUKH58QonUtZTVWyTbAR65RhJDpanmma1bnW5KnExBlTs7P+ZcleNLu4AQoOqJP
         Y4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zcDlkJTeHrjHVEgzRPAEZQALvFAG5US4eI5mM5YgZuY=;
        b=tysgDkni1vjopg7MWwXcAg36H0Q+vmgL/LlQ9sjMJx6mT/22LM1f5qATNxccKSfbHg
         bnt0WJQAzTYW/G67Y+hcET1bz3kQiz4A7H8nlYfeGgU0Zd0t9pZ1qzARsbMfuJMvcfVH
         yhFO/P+//ZyY6tXOVcvlFDIxelpWOdfsdgOJW1B+XaGPXSJMAg2tPRzKrtxpnZ6lnsFI
         0LX0wGb88Qeh1sPe0b/n6LX32tGYGA0Vz7uROHygJ3rxHxWSEFGOEzThQjdsRjuGLl2L
         nnsPJZlbyetAbRcwLfj28D080ZCKdRTgHMqknUWzyHc301pvzcqRXFyiE2W8brmWc0cS
         Ct0g==
X-Gm-Message-State: APjAAAVqdQlJLJOsGxrZgyo6wFWjBo4mUSAUEoBZ5RTZe004859Dio4P
        mQQkCNgC6/5rzQKDCEcm0oc=
X-Google-Smtp-Source: APXvYqxcGZ6X45TO6AjIW2X5VxteP29qd3Xp+Mlo5MYszszCZhtL1+swSlNelKa8z6Y5OwrNMEa4KA==
X-Received: by 2002:ac2:5922:: with SMTP id v2mr164163lfi.180.1558905745839;
        Sun, 26 May 2019 14:22:25 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y4sm1885105lje.24.2019.05.26.14.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 14:22:25 -0700 (PDT)
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
Subject: [PATCH v2 3/4] mm/vmap: get rid of one single unlink_va() when merge
Date:   Sun, 26 May 2019 23:22:12 +0200
Message-Id: <20190526212213.5944-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190526212213.5944-1-urezki@gmail.com>
References: <20190526212213.5944-1-urezki@gmail.com>
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
---
 mm/vmalloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b553047aa05b..6f91136f2cc8 100644
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
 
@@ -745,12 +742,12 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
+			/* Remove this VA, if it has been merged. */
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

