Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE49C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0362321771
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887194;
	bh=so95XS4O66+8Z/UvJxGLDcKObNsXURYi5iN/ZapenmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7mZ8WaSJQOqOc437vbDgoYowsjkFhtBg6MthZKcHTxsXtq6K8YWIhk6R1XT+QwmJ
	 yXArj00Kdc4oJWBvEPbSrr+2VdFqKtqk5nVANyUiJhDIZv/jd9tT3cOWyJqJsjZEgO
	 EPN3dxnA1c9pZuqnHyJPywPQFsQqkptZUXR5hIPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfK0Ujw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbfK0Ujs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:39:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0463120863;
        Wed, 27 Nov 2019 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887188;
        bh=so95XS4O66+8Z/UvJxGLDcKObNsXURYi5iN/ZapenmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkK9QJWbBr0rnVuUDMIQ4oaWRyCYpIJ246++/X0lXkV09fMsOhMprtIiFd6UTbDJN
         Nj/8T17C0xX49tOGEwPt7/IrkASaUKf6Ia0zpz+hJN3VABg2/pn5hcy1+07tblBKJX
         Rs+yrFGJUu6vzKQ8Pso4HfC1Dy5iiSBwEH3EP2vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 015/151] gfs2: Fix marking bitmaps non-full
Date:   Wed, 27 Nov 2019 21:29:58 +0100
Message-Id: <20191127203009.496625779@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit ec23df2b0cf3e1620f5db77972b7fb735f267eff ]

Reservations in gfs can span multiple gfs2_bitmaps (but they won't span
multiple resource groups).  When removing a reservation, we want to
clear the GBF_FULL flags of all involved gfs2_bitmaps, not just that of
the first bitmap.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/rgrp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index f77a38755aea6..0a80f66365492 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -630,7 +630,10 @@ static void __rs_deltree(struct gfs2_blkreserv *rs)
 	RB_CLEAR_NODE(&rs->rs_node);
 
 	if (rs->rs_free) {
-		struct gfs2_bitmap *bi = rbm_bi(&rs->rs_rbm);
+		u64 last_block = gfs2_rbm_to_block(&rs->rs_rbm) +
+				 rs->rs_free - 1;
+		struct gfs2_rbm last_rbm = { .rgd = rs->rs_rbm.rgd, };
+		struct gfs2_bitmap *start, *last;
 
 		/* return reserved blocks to the rgrp */
 		BUG_ON(rs->rs_rbm.rgd->rd_reserved < rs->rs_free);
@@ -641,7 +644,13 @@ static void __rs_deltree(struct gfs2_blkreserv *rs)
 		   it will force the number to be recalculated later. */
 		rgd->rd_extfail_pt += rs->rs_free;
 		rs->rs_free = 0;
-		clear_bit(GBF_FULL, &bi->bi_flags);
+		if (gfs2_rbm_from_block(&last_rbm, last_block))
+			return;
+		start = rbm_bi(&rs->rs_rbm);
+		last = rbm_bi(&last_rbm);
+		do
+			clear_bit(GBF_FULL, &start->bi_flags);
+		while (start++ != last);
 	}
 }
 
-- 
2.20.1



