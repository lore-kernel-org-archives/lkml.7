Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB37C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED99321848
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sp5TtVt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfE0PTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:19:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44197 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfE0PTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:19:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id e13so14961640ljl.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/69OPvwjOinzl+9ALg7GpdBlRB0Izx4CLNV/SO6CVY=;
        b=sp5TtVt0QWossyePsI0pwfUwbXk0kwuyZ3Q6WK9mDv5RwWtoQH2e93S6VPSdJf2Pd7
         ueQNA2nVax3EAVEuU8+zB9l+e6ZKexa0Sala5JZsZhaJkmkJcpYsiX2BtKsY6VLpRuaT
         vz5fnHdqqbVuD1f6oHE4OTdmhb8AF9lGaT6wYx1HAS2P8EG6G7W2XULg76DyX3veqI56
         aND2VwK69f/iqhtVR9U2YgL0Oui6eD75hK3Ld9JxCrOVIw5jKVlZDCRI5hdghprkXpe/
         QazwvMFfeiMeEiR6SiWw/C3Rz70yvm0JA1FsRynowlMMKSyJTiry5opRgWMYWqNAP/H6
         LYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/69OPvwjOinzl+9ALg7GpdBlRB0Izx4CLNV/SO6CVY=;
        b=savOqdfgc2K9zNyAHWxKmNxslHyYhI1xZUAlD1nQeL98Lql+Lk06SxZ21beB3pOUvT
         2fgSe8Pl87BQ8TKyKGcc9XHdCappq5NCfGR1+So6HcbEdxGwhxqaG6ko74yO/eHYDgBi
         jAXgma+mxIbv40GvPxAktEgstQLUBaudJPbMe2/ZeP8YH6CfYY5TYV8nWzvF5xW1A1Uj
         sRPeHEl2Mufo/bX0Dm5Ym/n1fn/+66IAPzDYaMj3g5MqdpWscObpdB22kT0Yo6IOFaQL
         a++nucrZ3H2QXPVF/eeyjgK/AerCRVjAC1rLpg7UOPHfe1K3qH/gSYZ6xuIth2W68Bv2
         AhbA==
X-Gm-Message-State: APjAAAWAqejK5avoGMFtCDcorAGxZ1Apj9BUCB6uI6/1TtvT/MnzxET5
        ryy0kgpR44T78qOrYE6dWCc=
X-Google-Smtp-Source: APXvYqwCoutspyS+zZrN5ZysSrHKllwv2mgh3TpyyOJ5FW6lX7OaWsa0f9YLi2ui4UlgnpRQBjECXg==
X-Received: by 2002:a2e:8796:: with SMTP id n22mr3489968lji.75.1558970340582;
        Mon, 27 May 2019 08:19:00 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h25sm2308701ljb.80.2019.05.27.08.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:18:59 -0700 (PDT)
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
Subject: [PATCH v4 4/4] mm/vmap: switch to WARN_ON() and move it under unlink_va()
Date:   Mon, 27 May 2019 17:18:43 +0200
Message-Id: <20190527151843.27416-5-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527151843.27416-1-urezki@gmail.com>
References: <20190527151843.27416-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger a warning if an object that is about to be freed is
detached. We used to have a BUG_ON(), but even though it is
considered as faulty behaviour that is not a good reason to
break a system.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 371aba9a4bf1..1dd459d0220a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -533,11 +533,7 @@ link_va(struct vmap_area *va, struct rb_root *root,
 static __always_inline void
 unlink_va(struct vmap_area *va, struct rb_root *root)
 {
-	/*
-	 * During merging a VA node can be empty, therefore
-	 * not linked with the tree nor list. Just check it.
-	 */
-	if (!RB_EMPTY_NODE(&va->rb_node)) {
+	if (!WARN_ON(RB_EMPTY_NODE(&va->rb_node))) {
 		if (root == &free_vmap_area_root)
 			rb_erase_augmented(&va->rb_node,
 				root, &free_vmap_area_rb_augment_cb);
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

