Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00285C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54C5208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfEMT7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12675 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfEMT7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:59:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D592309B144;
        Mon, 13 May 2019 19:59:13 +0000 (UTC)
Received: from max.com (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5558F5C1B4;
        Mon, 13 May 2019 19:59:07 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Fix error path kobject memory leak
Date:   Mon, 13 May 2019 21:59:04 +0200
Message-Id: <20190513195904.15726-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 13 May 2019 19:59:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>

If a call to kobject_init_and_add() fails we must call kobject_put()
otherwise we leak memory.

Function gfs2_sys_fs_add always calls kobject_init_and_add() which
always calls kobject_init().

It is safe to leave object destruction up to the kobject release
function and never free it manually.

Remove call to kfree() and always call kobject_put() in the error path.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/sys.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 1787d295834e..08e4996adc23 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -650,7 +650,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 	char ro[20];
 	char spectator[20];
 	char *envp[] = { ro, spectator, NULL };
-	int sysfs_frees_sdp = 0;
 
 	sprintf(ro, "RDONLY=%d", sb_rdonly(sb));
 	sprintf(spectator, "SPECTATOR=%d", sdp->sd_args.ar_spectator ? 1 : 0);
@@ -661,8 +660,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 	if (error)
 		goto fail_reg;
 
-	sysfs_frees_sdp = 1; /* Freeing sdp is now done by sysfs calling
-				function gfs2_sbd_release. */
 	error = sysfs_create_group(&sdp->sd_kobj, &tune_group);
 	if (error)
 		goto fail_reg;
@@ -687,10 +684,7 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
 fail_reg:
 	free_percpu(sdp->sd_lkstats);
 	fs_err(sdp, "error %d adding sysfs files\n", error);
-	if (sysfs_frees_sdp)
-		kobject_put(&sdp->sd_kobj);
-	else
-		kfree(sdp);
+	kobject_put(&sdp->sd_kobj);
 	sb->s_fs_info = NULL;
 	return error;
 }
-- 
2.20.1

