Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40205C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1890720880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/N2p4ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfGPAF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:05:26 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:54407 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfGPAF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:05:26 -0400
Received: by mail-vk1-f202.google.com with SMTP id w137so9105840vkd.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bM16Cxlynj/iYFnBhEVrgD674cLfvqLU43B4Z5mZd8I=;
        b=r/N2p4ZHJhSkKWCbefj7oLG94wDUQjVPvpVsO2bZgKuDB6odzuwkhgqvbFRar5HUSM
         F0Uee5JIrhmDjcjHNCYqP0u8lHTYYSn3P5mPCGUqXgaEfFm0vlsGVxLj41XRkh4JassI
         T55j3gjAdlSg1uZ8LLEGxKrPlRyotdJfmag6H/o9kkWnFeHryKqaCuOkKEDMzD7SCS18
         64inrAv4F0E2JBmU86ETFJNPwo7XAlMBkS+jTgXic46jJcC/gfZFvRu2rZuCrPBU/+DD
         UWyMrmLLTGyjqm4yYyaofcm9Nw3LgJzqsQ+8xMf57fKGz/XDrayl8zrfMiG8bQejHqWU
         TV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bM16Cxlynj/iYFnBhEVrgD674cLfvqLU43B4Z5mZd8I=;
        b=q8VJ3IiCXd1OyspFgsscK+k1hP4ZtCI9n3eAKbzxhDr0fDxsximaZ9ODCoiH7E3A5T
         8C23Tvlhbzg7uwAcIBQWNOMW1PD308nYOLg8df3hUGutrus3uq9KexUlMiYjGmh5yL0s
         Mv8tqYphUxLYqOBROPVq4dJbtJ3L8HUBZC5M00u3i8czF7sqMrZL2HFsko8pULf1q4jb
         CWZ9Z11x/jGBgRGmhBYJijfDHT/mcDiqiIr467AAQgRHQ2I7f8dRaHT2RPwmErfGXL1u
         Gyj4Eae3y7duxZI4iFECwNc1tcZ0P8FPwFPDveJiuGcIiIHsoBu/Jz/GmO9iw6x+BuXc
         Ab7w==
X-Gm-Message-State: APjAAAXrEVqxql4P9OhdvtgsDoShbo4gRjSTxr0OiPBuuM/420KQL6Ig
        tI22z3iKNWLBi8OFHvZgwMCOZHMQy0Cjr/kP
X-Google-Smtp-Source: APXvYqyKghXqh+hUwmcq39WhjGsA7PEfDV7IUtnSHADGYoM5Fvn2cKgA8Y0Zc4zvh5r1tKWM+7vjLynajC+dIAJ5
X-Received: by 2002:a1f:dec7:: with SMTP id v190mr11423849vkg.39.1563235525244;
 Mon, 15 Jul 2019 17:05:25 -0700 (PDT)
Date:   Mon, 15 Jul 2019 17:05:20 -0700
Message-Id: <20190716000520.230595-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v2] mm/z3fold.c: Reinitialize zhdr structs after migration
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Vul <vitaly.vul@sony.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

z3fold_page_migration() calls memcpy(new_zhdr, zhdr, PAGE_SIZE).
However, zhdr contains fields that can't be directly coppied over (ex:
list_head, a circular linked list). We only need to initialize the
linked lists in new_zhdr, as z3fold_isolate_page() already ensures
that these lists are empty

Additionally it is possible that zhdr->work has been placed in a
workqueue. In this case we shouldn't migrate the page, as zhdr->work
references zhdr as opposed to new_zhdr.

Fixes: bba4c5f96ce4 ("mm/z3fold.c: support page migration")
Signed-off-by: Henry Burns <henryburns@google.com>
---
 Changelog since v1:
 - Made comments explicityly refer to new_zhdr->buddy.

 mm/z3fold.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 42ef9955117c..f4b2283b19a3 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1352,12 +1352,22 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 		z3fold_page_unlock(zhdr);
 		return -EBUSY;
 	}
+	if (work_pending(&zhdr->work)) {
+		z3fold_page_unlock(zhdr);
+		return -EAGAIN;
+	}
 	new_zhdr = page_address(newpage);
 	memcpy(new_zhdr, zhdr, PAGE_SIZE);
 	newpage->private = page->private;
 	page->private = 0;
 	z3fold_page_unlock(zhdr);
 	spin_lock_init(&new_zhdr->page_lock);
+	INIT_WORK(&new_zhdr->work, compact_page_work);
+	/*
+	 * z3fold_page_isolate() ensures that new_zhdr->buddy is empty,
+	 * so we only have to reinitialize it.
+	 */
+	INIT_LIST_HEAD(&new_zhdr->buddy);
 	new_mapping = page_mapping(page);
 	__ClearPageMovable(page);
 	ClearPagePrivate(page);
-- 
2.22.0.510.g264f2c817a-goog

