Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC5C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA62183F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfF0DGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:06:51 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:34200 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfF0DGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:06:51 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 3EE8E2C9276DC129DA98;
        Thu, 27 Jun 2019 11:06:47 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x5R35oef016048;
        Thu, 27 Jun 2019 11:05:50 +0800 (GMT-8)
        (envelope-from yang.bin18@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019062711061544-1753646 ;
          Thu, 27 Jun 2019 11:06:15 +0800 
From:   Yang Bin <yang.bin18@zte.com.cn>
To:     rpeterso@redhat.com
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        " Yang Bin " <yang.bin18@zte.com.cn>
Subject: [PATCH] sub sd_rgrps When clear rgrp
Date:   Thu, 27 Jun 2019 11:04:30 +0800
Message-Id: <1561604670-11476-1-git-send-email-yang.bin18@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-06-27 11:06:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-06-27 11:05:54,
        Serialize complete at 2019-06-27 11:05:54
X-MAIL: mse-fl2.zte.com.cn x5R35oef016048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: " Yang Bin "<yang.bin18@zte.com.cn>

When clear rgrp,sub sd_rgrps after erased from rindex_tree

Signed-off-by: Yang Bin <yang.bin18@zte.com.cn>
---
 fs/gfs2/rgrp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 15d6e32..a4b2e83
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -730,6 +730,7 @@ void gfs2_clear_rgrpd(struct gfs2_sbd *sdp)
 		gl = rgd->rd_gl;
 
 		rb_erase(n, &sdp->sd_rindex_tree);
+		sdp->sd_rgrps--;
 
 		if (gl) {
 			glock_clear_object(gl, rgd);
-- 
1.8.3.1

