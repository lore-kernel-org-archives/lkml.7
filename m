Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BBB206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="cUifgq/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXMMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:12:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33787 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLXMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:12:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so4380467otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BNmPl4A7u77U4XYbjAnNEvFngSX3WTvrmL/4/NFf/0=;
        b=cUifgq/8r1suKoE/IUSYwY46YctGdVYUWTP+57RaD4Xmp/OGArfQd/7WoviYw4X9M9
         nSCbR5Zp1KsDJ14/45VuLhGTjqkmUHPtiMcueXWHjNgInTlk0B8Lz0cK9z6lkQHN6YT0
         IkZCCDtt5MEEzOZEcdk5V7Ee5EXWIkE+uJKFolRjKDQeR1WipfaSywCoYIjzgD7G6r+s
         8rdfoHxWv7UIeDF9/IBoHtyDbrKm+xvX1Ox2Z5btaSrrJMh69SGryMGM/Q9vhySytWXo
         JiHy4odvEn3zska7Htc2nzW3pNMb7kGTO8DrLJizg0tT0cKIwuI1R2aCf3Ax2noY5q/0
         x8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BNmPl4A7u77U4XYbjAnNEvFngSX3WTvrmL/4/NFf/0=;
        b=Nly/ZpLYI8ampSfESbuAR7JdEv9F1V3mR7/8pwKlMxh+hmWgoY1AKmBpnD7kXXisYP
         eIFWlHGxsccj03bWHPqmpQDPUOXXbOtAlQpwXyoha+lDtW95R1rIeKStgMb5bJ3Fksrl
         Il67XykjKFu0bcc52PtZmiUvFF6ACZoZDjCxz0HNYUvAdAq2cW2XCnlNQr0Kim0hNSON
         sotnW1IeF1t9JEC+OvvbmGgBZLjdVFY3mkZZuP0SoBkTeyhQ5Zjhqw85KOYAC6VuSA5u
         BaaJvEJFwbkfxYs+d5iaF5mOpIQOXw0gMb7BsA7LAYTY2xDd4Y6UBoFNICMcRVrt7V8X
         x8nA==
X-Gm-Message-State: APjAAAVzjw24wby4RwBnlIyLoixcpR8wzbbU8NZ2yCrgNgjVPeNnyvlW
        nqHbPj3Q34JagKoupU5Vr+k8mWPJydU=
X-Google-Smtp-Source: APXvYqwb0ZtnuLJdbkpODmLRmILFwVYKNGvImP2Q65k6khZatugV88Gg+CJk1ezJsLu0fni5MJkDkQ==
X-Received: by 2002:a9d:7d81:: with SMTP id j1mr33379310otn.267.1577189548643;
        Tue, 24 Dec 2019 04:12:28 -0800 (PST)
Received: from hev-sbc.hz.ali.com ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id m12sm3778206otq.15.2019.12.24.04.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:12:28 -0800 (PST)
From:   Heiher <r@hev.cc>
To:     linux-kernel@vger.kernel.org
Cc:     Heiher <r@hev.cc>, Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 2/3] lib/rbtree: fix null pointer dereference in erase
Date:   Tue, 24 Dec 2019 20:12:09 +0800
Message-Id: <20191224121210.29713-2-r@hev.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191224121210.29713-1-r@hev.cc>
References: <20191224121210.29713-1-r@hev.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a null pointer dereference in erasing the root node of below tree.

Tree structure:
		   (1)[2]
		  /   \
	       (2)[1]  (3)[4]
		      /
		   (4)[3]

(n): Insert order
[n]: Key value or key order

Signed-off-by: hev <r@hev.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michel Lespinasse <walken@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 lib/rbtree.c | 94 +++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/lib/rbtree.c b/lib/rbtree.c
index abc86c6a3177..a710c21f7be6 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -351,56 +351,58 @@ ____rb_erase_color(struct rb_node *parent, struct rb_root *root,
 			break;
 		} else {
 			sibling = parent->rb_left;
-			if (rb_is_red(sibling)) {
-				/* Case 1 - right rotate at parent */
-				tmp1 = sibling->rb_right;
-				WRITE_ONCE(parent->rb_left, tmp1);
-				WRITE_ONCE(sibling->rb_right, parent);
-				rb_set_parent_color(tmp1, parent, RB_BLACK);
-				__rb_rotate_set_parents(parent, sibling, root,
-							RB_RED);
-				augment_rotate(parent, sibling);
-				sibling = tmp1;
-			}
-			tmp1 = sibling->rb_left;
-			if (!tmp1 || rb_is_black(tmp1)) {
-				tmp2 = sibling->rb_right;
-				if (!tmp2 || rb_is_black(tmp2)) {
-					/* Case 2 - sibling color flip */
-					rb_set_parent_color(sibling, parent,
-							    RB_RED);
-					if (rb_is_red(parent))
-						rb_set_black(parent);
-					else {
-						node = parent;
-						parent = rb_parent(node);
-						if (parent)
-							continue;
+			if (sibling) {
+				if (rb_is_red(sibling)) {
+					/* Case 1 - right rotate at parent */
+					tmp1 = sibling->rb_right;
+					WRITE_ONCE(parent->rb_left, tmp1);
+					WRITE_ONCE(sibling->rb_right, parent);
+					rb_set_parent_color(tmp1, parent, RB_BLACK);
+					__rb_rotate_set_parents(parent, sibling, root,
+								RB_RED);
+					augment_rotate(parent, sibling);
+					sibling = tmp1;
+				}
+				tmp1 = sibling->rb_left;
+				if (!tmp1 || rb_is_black(tmp1)) {
+					tmp2 = sibling->rb_right;
+					if (!tmp2 || rb_is_black(tmp2)) {
+						/* Case 2 - sibling color flip */
+						rb_set_parent_color(sibling, parent,
+									RB_RED);
+						if (rb_is_red(parent))
+							rb_set_black(parent);
+						else {
+							node = parent;
+							parent = rb_parent(node);
+							if (parent)
+								continue;
+						}
+						break;
 					}
-					break;
+					/* Case 3 - left rotate at sibling */
+					tmp1 = tmp2->rb_left;
+					WRITE_ONCE(sibling->rb_right, tmp1);
+					WRITE_ONCE(tmp2->rb_left, sibling);
+					WRITE_ONCE(parent->rb_left, tmp2);
+					if (tmp1)
+						rb_set_parent_color(tmp1, sibling,
+									RB_BLACK);
+					augment_rotate(sibling, tmp2);
+					tmp1 = sibling;
+					sibling = tmp2;
 				}
-				/* Case 3 - left rotate at sibling */
-				tmp1 = tmp2->rb_left;
-				WRITE_ONCE(sibling->rb_right, tmp1);
-				WRITE_ONCE(tmp2->rb_left, sibling);
+				/* Case 4 - right rotate at parent + color flips */
+				tmp2 = sibling->rb_right;
 				WRITE_ONCE(parent->rb_left, tmp2);
-				if (tmp1)
-					rb_set_parent_color(tmp1, sibling,
-							    RB_BLACK);
-				augment_rotate(sibling, tmp2);
-				tmp1 = sibling;
-				sibling = tmp2;
+				WRITE_ONCE(sibling->rb_right, parent);
+				rb_set_parent_color(tmp1, sibling, RB_BLACK);
+				if (tmp2)
+					rb_set_parent(tmp2, parent);
+				__rb_rotate_set_parents(parent, sibling, root,
+							RB_BLACK);
+				augment_rotate(parent, sibling);
 			}
-			/* Case 4 - right rotate at parent + color flips */
-			tmp2 = sibling->rb_right;
-			WRITE_ONCE(parent->rb_left, tmp2);
-			WRITE_ONCE(sibling->rb_right, parent);
-			rb_set_parent_color(tmp1, sibling, RB_BLACK);
-			if (tmp2)
-				rb_set_parent(tmp2, parent);
-			__rb_rotate_set_parents(parent, sibling, root,
-						RB_BLACK);
-			augment_rotate(parent, sibling);
 			break;
 		}
 	}
-- 
2.24.1

