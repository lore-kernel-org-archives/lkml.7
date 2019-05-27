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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDBDC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A33121848
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRPf3w6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfE0PTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:19:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36607 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfE0PTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:19:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so12355799lfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YcUVHwpttwwhej4P2HLvEtL1IO2oJH9O8jVbXiQY6lI=;
        b=GRPf3w6HyTwo7+Fo2X1EhAbWqLgX0C2WyNlMmi8HLlVHeG7Fooq65mhrW1jxaJZ4lo
         CBdc3l60xiGFTsJ6izeZPNITwmPXQEqzxNSIzebbpG8ln0HjSNuY0jWlTRsXtmWtQBL2
         9BoVM3lqnBtKv16LUVur1SdybeygmhtIdrfiVnvRJglXJy/1E+RazNMieDjGfr8fdInY
         556Xiy5gV+1Bf8g8nH5tBMAoBnPTpX+i9N6DTKJ+GK21dvPc/iS7Xc7hmdx9s2SEGc5f
         THY6CE1zNStf/A590wMKqWW+A5CU0nS2u/xxzlJQXvnO2JNqnBoBCpgyiel/OiN8eZnt
         V1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YcUVHwpttwwhej4P2HLvEtL1IO2oJH9O8jVbXiQY6lI=;
        b=ryWswgod9tZig7JJdSaB+8NH1289TfKZZyYOPEB1C6XtzN6mQM+YX6wZOA8o9dLY/p
         HDuNw7llHjefeoPj3ftkIkMYvd9ct20YwSEHMXZaOewo/2IrRiRy4TOhbXnumt4Dr7Nv
         v4yu5Y8atWnJkqwSPPKNWQaGFT8hobSGlI+QdWr6Q6r41UdXkimMR6DwdD2eyNkSUbUM
         rkE71RrDn1OaoDMj/kQtF1ybwoWxaA4LcAYsw1DtsmUAZPD4QJKhem1YWjNr8x0r8DVD
         SjY8DkZPeqA5E+nbk8VFDej1jLplc9v8k0M49ESTU380Zg33FteHjv2gLyxCtpwbN+V2
         fs0w==
X-Gm-Message-State: APjAAAUi0JGP5BTZ8ToAPRZcoN4GUAIT/NNM5nPPqM/IXUUvWRyz+GNp
        nWwLbOCtwTzre3NQc3kmtkpkxGm7D/E=
X-Google-Smtp-Source: APXvYqzQo8vRKuuRDWFg8/CKJYMSI+xoWSWF8WBR+DKBb8PShgEzqVzskrYUj2vWJf/7tX0bxA+aJg==
X-Received: by 2002:ac2:5449:: with SMTP id d9mr17568669lfn.126.1558970339188;
        Mon, 27 May 2019 08:18:59 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h25sm2308701ljb.80.2019.05.27.08.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:18:58 -0700 (PDT)
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
Subject: [PATCH v4 3/4] mm/vmap: get rid of one single unlink_va() when merge
Date:   Mon, 27 May 2019 17:18:42 +0200
Message-Id: <20190527151843.27416-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527151843.27416-1-urezki@gmail.com>
References: <20190527151843.27416-1-urezki@gmail.com>
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
Acked-by: Hillf Danton <hdanton@sina.com>
---
 mm/vmalloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b553047aa05b..371aba9a4bf1 100644
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
 
@@ -745,12 +742,11 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
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

