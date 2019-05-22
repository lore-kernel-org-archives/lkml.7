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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A8C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A48320879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLgVs9bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfEVPJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:09:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34364 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfEVPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:09:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so1989850lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XfLoVJNG3YH3XU12QY7rmjEpG+NwOFxkxi1NTXn+kzk=;
        b=iLgVs9bciGGSfNr7lnaGuHN02LQSefOJFB8jCzlazwdjUT9zwD+9AiHD7mJH+QgV98
         cgQi9kr2nQ2QSQGNirYGrvhwR5h1gGIjtJR3DfVwa61umhpH3Ef94m4SUmibVYaMECiz
         /F0K3Nj4OGjsuwFwPuGP0eMwTTre0PJrjW0GQB/NCao8IOA7XNg1vXoyyGLOmkBe+aKs
         F1M/zzYr0TP7k7R33Weoc4rYMBBm+pD3GczPbmGPhLn+g4mBM+UAfGeYRGKAyQg8nXG8
         gl25OHegvI+FFXUwNoQTVY9rlqo+XeEykTmOAu97rVBqmr76OxM1M8IzK2DDEn/ITVkC
         sQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XfLoVJNG3YH3XU12QY7rmjEpG+NwOFxkxi1NTXn+kzk=;
        b=dcuVs77Mw886WdUG+jtEAB1GdMASx/OJ1l0+GOQ0DJh4zBe7i/aN2b9QqfHjhg9sA1
         abByayQEEx3ubZ17v2dFpb76uGTMpSmRSYNVaKZwHapmMhHz4H05vtFagPqORlOppTKQ
         BOmKdT4Av8QLpSgr7DoHerihRwYoQXsdJoIvAbDNJVLKBSYFsYAINmx2Xx2rRIz12u1D
         T3Oj+eIqvmksYKY5530nIqitnGpVzjROvdGB7ZCo2GHNFUtrSqdJoPcO7oPZyjQrPa4S
         2J26QqUq/FQ6bNf1zpBx6vSoOdvpbp4yg/ILS6rABTHe27nYgw+YSR8jhBOPySuqdyXm
         Oqaw==
X-Gm-Message-State: APjAAAV7zdH7oJXtFpCuAVcTArmWSvn6dKwHS6Y8OxtdOC7yKbWb2qBk
        EPpokaEfHF54rgOj78Nm6Dc=
X-Google-Smtp-Source: APXvYqyBoI7CHTOcBFOL7JPrYQSLJpWeJrCJebZpJdPWf/kriTBhBeULhSVwcS66AnUqV8yAuvhRlQ==
X-Received: by 2002:ac2:4471:: with SMTP id y17mr17527691lfl.23.1558537793265;
        Wed, 22 May 2019 08:09:53 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t22sm5303615lje.58.2019.05.22.08.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:09:52 -0700 (PDT)
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
Subject: [PATCH 3/4] mm/vmap: get rid of one single unlink_va() when merge
Date:   Wed, 22 May 2019 17:09:38 +0200
Message-Id: <20190522150939.24605-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190522150939.24605-1-urezki@gmail.com>
References: <20190522150939.24605-1-urezki@gmail.com>
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
index 5302e1b79c7b..89b8f44e8837 100644
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

