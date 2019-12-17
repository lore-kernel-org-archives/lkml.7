Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE01D20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjOyv4WF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfLQNwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:52:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbfLQNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:52:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so146319pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Ab3Q/X4ZX5gMws9nUNXBeFR4zcomqzcsyRHhrq8jyw=;
        b=bjOyv4WFNA4Oiymym030hvCTlXDF88KMh8GhOROZW1CBvNWjeEu7md9vnE2vrZU2DH
         eijW5Zxcylr10kqvF7gxoPPnxI/oNVp3NDQ9QDAOT/hlaKFBKCwEqMnS/lAHvFfI9+Tf
         5uiFyBRmQI6dcgpafCAxYmxoK6OGOU5pD6m7aiirOkUDVXkNqHlEexV6RXhMa7IuMH29
         omWFCSFF6Sqnui+mmfa6bbchqDIVjg3vr86PyR9DHuNEvyPMtebB4EMHyUnd7ONy/ZmU
         sqL7MJzUEMUga2WjtTjUqIUEjklL510v4ADYm/+0jXnczO4vsOzQWDPwdQ1ZywAZ4RB0
         qZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Ab3Q/X4ZX5gMws9nUNXBeFR4zcomqzcsyRHhrq8jyw=;
        b=DZMnPub3pe2dh2uvatHG4thkUib9j+yLRJ3AQpBU2gBBGA/Jll/L5GCUdLDkpsScKA
         vKC/wIRxEG8ByIt5tj/epMlIEeEbh1uAsvV8uwp9+o55ljOKvwhvg5HrUoMMeYNaMEWV
         kV/Kz7P+eqKmrgpf3OTzyJIsL5uQ/yp/5lmuzb3GwEzv3C2N47xg2pTWXJuEFeBfTZYv
         /p5Ci06W3YkiICG+GtnLikSB9DmtV36Yv1es1xPC0+SmeIUouukQLWnFPbjakvEExxOy
         53WBYfFy4we7nKrJTbr3G6PG77NiQu8nNzZSUD7QS6iRqLXhU0rkzTH3XB5aq07AUwZT
         80PQ==
X-Gm-Message-State: APjAAAXz4Hxq1qtcngArECWRmXUkXC9htN7FdGYAP2L6w0khqZOqXATx
        14n7jGyXjzE0qwrtylfo/94=
X-Google-Smtp-Source: APXvYqwg7iJqE7pkEx8c34mv/h5j38/Pvrmvpcu6TQkHXieFxOzdarytJCM8d0HbKBYvVOBk6zJV2w==
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11mr2085843plb.282.1576590755583;
        Tue, 17 Dec 2019 05:52:35 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id k1sm18091229pgq.70.2019.12.17.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:52:35 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dwmw2@infradead.org, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: jffs2: fix possible sleep-in-atomic-context bugs
Date:   Tue, 17 Dec 2019 21:51:43 +0800
Message-Id: <20191217135143.12875-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filesystem may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

fs/jffs2/malloc.c, 188: 
	kmem_cache_alloc(GFP_KERNEL) in jffs2_alloc_refblock
fs/jffs2/malloc.c, 221: 
	jffs2_alloc_refblock in jffs2_prealloc_raw_node_refs
fs/jffs2/wbuf.c, 164: 
	jffs2_prealloc_raw_node_refs in jffs2_block_refile
fs/jffs2/wbuf.c, 291: 
	jffs2_block_refile in jffs2_wbuf_recover
fs/jffs2/wbuf.c, 287: 
	spin_lock in jffs2_wbuf_recover

fs/jffs2/malloc.c, 188: 
    kmem_cache_alloc(GFP_KERNEL) in jffs2_alloc_refblock
fs/jffs2/malloc.c, 221: 
    jffs2_alloc_refblock in jffs2_prealloc_raw_node_refs
fs/jffs2/wbuf.c, 164: 
    jffs2_prealloc_raw_node_refs in jffs2_block_refile
fs/jffs2/wbuf.c, 927: 
	jffs2_block_refile in jffs2_flash_writev
fs/jffs2/wbuf.c, 924: 
	spin_lock in jffs2_flash_writev

kmem_cache_alloc(GFP_KERNEL) can sleep at runtime.

To fix these possible bugs, GFP_KERNEL is replaced with GFP_ATOMIC for
kmem_cache_alloc().

These bugs are found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/jffs2/malloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
index ce1189793288..66496ef09716 100644
--- a/fs/jffs2/malloc.c
+++ b/fs/jffs2/malloc.c
@@ -185,7 +185,7 @@ static struct jffs2_raw_node_ref *jffs2_alloc_refblock(void)
 {
 	struct jffs2_raw_node_ref *ret;
 
-	ret = kmem_cache_alloc(raw_node_ref_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(raw_node_ref_slab, GFP_ATOMIC);
 	if (ret) {
 		int i = 0;
 		for (i=0; i < REFS_PER_BLOCK; i++) {
-- 
2.17.1

