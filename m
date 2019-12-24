Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B97C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355A820730
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="0tCVYb7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLXMMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:12:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41897 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLXMMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:12:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so7482991oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xpn/DE/lipmC0d0Dlyqq2KHPBekSRodJk/NFu5QKcOU=;
        b=0tCVYb7hGi34DF0fuomxgdBrpJPjm1fMmXQhi34VYy5TBsfgkAVWP8pWWinFNy5ME2
         eahwqVClafWJDv4lZz1288tyeJo4frQS01257fqfp9qR9XnLM9wKryIwlrYBt8sJzXOy
         chBJS5yRnpqsn4rJlEl1jiGih8sM2ZU1sAJR/zBdOkJNqq3aYfN4Lj7s2SQgC54HwaiQ
         ybyiDaxuoW9VcvnEAvECGOFd2ljkwdmn5pB9STY1Tdp8h/Xe88U/fjRqiZ4im688pwfi
         hUBklZo3KOFRrMUyRGeOFlQHUF4bFRMRrDO2F44PX26/6EHdfvBNqpKpET8Sswk7lyNH
         MtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xpn/DE/lipmC0d0Dlyqq2KHPBekSRodJk/NFu5QKcOU=;
        b=kjZlQ4O50aYggjBN23qEp0t8q8qXlcxqc99BAqAPv1pSQWAMK/dTpJSc7EXQXaJGs+
         +9BBrXuafZjKlgvToDjxvFvda+2M00KSQLnAPVlcfOJKODrFiEynLU3Vq/4nqoPER86I
         jnSlQqRbdL+PE0rQsH7mil8rqWHLBdi7i9REE8s0n7OY5+6UKOzShiDtT8Xwf3yMYn+5
         ouQYMxwkO02Ly9BDxJeF0BcmWyGTgiUqycoiTBP3I9/6KA4pzDoASZlK1CTZEuJFijzz
         1xhHpqTr9+iMtQr/mkNg7G06SN5uvBXqiDeHfR0chQy6OR/L2UGdQ3UKmjRQorw4r1m8
         Y88w==
X-Gm-Message-State: APjAAAXevmosNfoQGAAUMP9wM9DANqzqWi7sSwqw7qR7Zuz5Mr8+w7hb
        u/nVFmk4wVogEmPVdHO+FBd2saJKhO6ObA==
X-Google-Smtp-Source: APXvYqxyWOqWNNtjktAYSq1j79AEY89ON4n29CyynO0Jf9amMzmdwGo2ISDF+mB/X2599jAoe/rVdg==
X-Received: by 2002:aca:554d:: with SMTP id j74mr604250oib.92.1577189553199;
        Tue, 24 Dec 2019 04:12:33 -0800 (PST)
Received: from hev-sbc.hz.ali.com ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id m12sm3778206otq.15.2019.12.24.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:12:32 -0800 (PST)
From:   Heiher <r@hev.cc>
To:     linux-kernel@vger.kernel.org
Cc:     Heiher <r@hev.cc>, Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 3/3] tools/rbtree: fix null pointer dereference in erase
Date:   Tue, 24 Dec 2019 20:12:10 +0800
Message-Id: <20191224121210.29713-3-r@hev.cc>
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
 tools/lib/rbtree.c | 94 +++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/tools/lib/rbtree.c b/tools/lib/rbtree.c
index 2548ff8c4d9c..8eb88439af57 100644
--- a/tools/lib/rbtree.c
+++ b/tools/lib/rbtree.c
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

