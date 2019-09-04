Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034EAC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7A222CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619784;
	bh=L0sZQK6qaSRuKrv7nMZnF4nMuJ8kVVOlJ/PIJH9sBt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pz8/knTV80LbxfR5un+XWM3CwfX+s3Rh2JLwwY4lR6dPhmN1EDdp18uq+0uJ21rlx
	 A8fEvRzGIlSOqKpMdASTOHjfAxx0ZobyTQomVLxcHmoVvjvB4btwPkmjrdKwFZLkwp
	 jZotkVW+p7mo4/VAt6DLVeoE7hPN1QLpN/EGQSE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbfIDR4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbfIDR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:56:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D6C22CF5;
        Wed,  4 Sep 2019 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619780;
        bh=L0sZQK6qaSRuKrv7nMZnF4nMuJ8kVVOlJ/PIJH9sBt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGP6t6h7oopDdh/JPddCwIdtGoSTPltJ3JkGGMNqMbGuNGVNniYI4LVm3kXYJPXxS
         lcSiLyLgENggILX/y7bgX1eNJMHVuQ+/jfFWC9ySndv+q6HHwq5cxYM2fMGzUe1bqu
         IkPsoQRUsPlGkqw9EPz8CV9jCmESwKhvlP6a0+0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Tao <kontais@zoho.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.4 32/77] dm table: fix invalid memory accesses with too high sector number
Date:   Wed,  4 Sep 2019 19:53:19 +0200
Message-Id: <20190904175306.554010893@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 1cfd5d3399e87167b7f9157ef99daa0e959f395d upstream.

If the sector number is too high, dm_table_find_target() should return a
pointer to a zeroed dm_target structure (the caller should test it with
dm_target_is_valid).

However, for some table sizes, the code in dm_table_find_target() that
performs btree lookup will access out of bound memory structures.

Fix this bug by testing the sector number at the beginning of
dm_table_find_target(). Also, add an "inline" keyword to the function
dm_table_get_size() because this is a hot path.

Fixes: 512875bd9661 ("dm: table detect io beyond device")
Cc: stable@vger.kernel.org
Reported-by: Zhang Tao <kontais@zoho.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-table.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1167,7 +1167,7 @@ void dm_table_event(struct dm_table *t)
 }
 EXPORT_SYMBOL(dm_table_event);
 
-sector_t dm_table_get_size(struct dm_table *t)
+inline sector_t dm_table_get_size(struct dm_table *t)
 {
 	return t->num_targets ? (t->highs[t->num_targets - 1] + 1) : 0;
 }
@@ -1192,6 +1192,9 @@ struct dm_target *dm_table_find_target(s
 	unsigned int l, n = 0, k = 0;
 	sector_t *node;
 
+	if (unlikely(sector >= dm_table_get_size(t)))
+		return &t->targets[t->num_targets];
+
 	for (l = 0; l < t->depth; l++) {
 		n = get_child(n, k);
 		node = get_node(t, l, n);


