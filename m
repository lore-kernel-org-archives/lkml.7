Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7C720861
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeBZBrSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfGOQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:47:42 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56149 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfGOQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:47:42 -0400
Received: by mail-qk1-f202.google.com with SMTP id m198so14146656qke.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uefiGP790QPlHmhELnOTMDg4Gfv1ldPwSxnEHTELlh4=;
        b=YeBZBrSXtK9i0HJSVVv2OwHsZlDPNrQA38z/OP0Renlqzd0x8ogg6n9oOCOxRZ/qJX
         2AFyJyFpg1T1qww+sFCfX4m+DLyS53IgMyeu1hTMwdzvac1reuMswpgPAbjchx8I44XD
         fTWAXvuAXFBDzH4LdWpWN5jKmuC0JAYcMKLII//xrW7oz2dgVjc34ys4nbJDLcGFLFg6
         hbJD7DHbO3okpeMb0YQw1fsqgya5/i7c5TpasVmFLqZuZZFs9wUa/O7K2vxk3tAXzORg
         +TBEy4PIZSjdM5zWz8MjB1WoK2H5ny25+wl5R6aKGS+eF9K8N/Y14yXFkgTIXR1hGUPR
         THYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uefiGP790QPlHmhELnOTMDg4Gfv1ldPwSxnEHTELlh4=;
        b=TEyW3XY7xXyllMbruBcwMbzvt8KAE0VgRuigyD9NnemFnVvNBQWQaSSCUJHaEj0QrS
         wQtznCHrIUGa5fjdnTMukJAetAhnbV1iQulG02CrdDxW/f5noED6ISZJo+/NLoLKieCf
         p/2S3AxSWO0/2a9x470xxFOlcJcohAuL1FPoYobkPZDsgsdeHyX6P/j3dPdWkhP10ZJk
         z3aSrWr4Pm3wKSuZ5HN3w/deIeEzODjTnkKPOoHDpyG2MJR5hBwWNSjWRuBBlYNdRGGt
         3rxh8kTsVG7qXYmH6m8JypTgXrV+0KlK7cE7PNdNc3JEr9DhzpR2rMmrxQos+eokA8Cp
         dsAA==
X-Gm-Message-State: APjAAAXMVck8Kgd/7bayKQ+Vl/NLzQIUdsro0DcV1JUivQIYG5j6xdAp
        4pxaVe6Swnl7aURTK0S8ff8wVuQU7yEEjmS2
X-Google-Smtp-Source: APXvYqxhV21lnl98vfMuXVfbZYtgXl89P2Xqlu5YAtnRRfAoENjqyw61PjICMmXKSWQSqVMA9ImLdH2rX49JwDhR
X-Received: by 2002:a37:a343:: with SMTP id m64mr17595893qke.75.1563209261293;
 Mon, 15 Jul 2019 09:47:41 -0700 (PDT)
Date:   Mon, 15 Jul 2019 09:47:05 -0700
Message-Id: <20190715164705.220693-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH] mm/z3fold.c: Reinitialize zhdr structs after migration
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
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
that these lists are empty.

Additionally it is possible that zhdr->work has been placed in a
workqueue. In this case we shouldn't migrate the page, as zhdr->work
references zhdr as opposed to new_zhdr.

Fixes: bba4c5f96ce4 ("mm/z3fold.c: support page migration")
Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/z3fold.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 42ef9955117c..9da471bcab93 100644
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
+	 * z3fold_page_isolate() ensures that this list is empty, so we only
+	 * have to reinitialize it.
+	 */
+	INIT_LIST_HEAD(&new_zhdr->buddy);
 	new_mapping = page_mapping(page);
 	__ClearPageMovable(page);
 	ClearPagePrivate(page);
-- 
2.22.0.510.g264f2c817a-goog

