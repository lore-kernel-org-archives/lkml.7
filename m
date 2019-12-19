Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A72C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A77524684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781788;
	bh=nUJQkdlrLbP8vid/uIYs8cG57aNUfqgBoXs6B9lMV8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ck4NImoHQKsTXxiBvQZ5CztG4t4RHjO9k4XB76szL1CX/c4XwRyopOgmeZB7jAOj6
	 tlyPyhwM9ZFbNn4CFkQ7f9Apo8gmE5BiIS+VNUUH2Uh9YB2+/eSoGt9OVG6zGXuJjc
	 EQpX2ikuMJj/h8RpHQQy5MFdiYcCFAtj09fubbRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfLSS41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbfLSS4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:56:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78830227BF;
        Thu, 19 Dec 2019 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781778;
        bh=nUJQkdlrLbP8vid/uIYs8cG57aNUfqgBoXs6B9lMV8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjXW3z8BWSTI+d/Pioz7F1ZuBgUobFjSlSG+aWgE1AES5UNgRVyw+sOrBoPO8KFfM
         6BACPrEcoERdytH07gOc6rG0L+zURUiu3mVps+VCF5LWBZU09LrFoEOT4/EdWj5Tyl
         NJHQ7mXN2/GRkp0JV36WSBjy/clGGymjzTr+Rc50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 38/80] cifs: Fix retrieval of DFS referrals in cifs_mount()
Date:   Thu, 19 Dec 2019 19:34:30 +0100
Message-Id: <20191219183107.931508671@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara (SUSE) <pc@cjr.nz>

commit 5bb30a4dd60e2a10a4de9932daff23e503f1dd2b upstream.

Make sure that DFS referrals are sent to newly resolved root targets
as in a multi tier DFS setup.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Link: https://lkml.kernel.org/r/05aa2995-e85e-0ff4-d003-5bb08bd17a22@canonical.com
Cc: stable@vger.kernel.org
Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/connect.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4709,6 +4709,17 @@ static int is_path_remote(struct cifs_sb
 }
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
+static inline void set_root_tcon(struct cifs_sb_info *cifs_sb,
+				 struct cifs_tcon *tcon,
+				 struct cifs_tcon **root)
+{
+	spin_lock(&cifs_tcp_ses_lock);
+	tcon->tc_count++;
+	tcon->remap = cifs_remap(cifs_sb);
+	spin_unlock(&cifs_tcp_ses_lock);
+	*root = tcon;
+}
+
 int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb_vol *vol)
 {
 	int rc = 0;
@@ -4810,18 +4821,10 @@ int cifs_mount(struct cifs_sb_info *cifs
 	/* Cache out resolved root server */
 	(void)dfs_cache_find(xid, ses, cifs_sb->local_nls, cifs_remap(cifs_sb),
 			     root_path + 1, NULL, NULL);
-	/*
-	 * Save root tcon for additional DFS requests to update or create a new
-	 * DFS cache entry, or even perform DFS failover.
-	 */
-	spin_lock(&cifs_tcp_ses_lock);
-	tcon->tc_count++;
-	tcon->dfs_path = root_path;
+	kfree(root_path);
 	root_path = NULL;
-	tcon->remap = cifs_remap(cifs_sb);
-	spin_unlock(&cifs_tcp_ses_lock);
 
-	root_tcon = tcon;
+	set_root_tcon(cifs_sb, tcon, &root_tcon);
 
 	for (count = 1; ;) {
 		if (!rc && tcon) {
@@ -4858,6 +4861,15 @@ int cifs_mount(struct cifs_sb_info *cifs
 			mount_put_conns(cifs_sb, xid, server, ses, tcon);
 			rc = mount_get_conns(vol, cifs_sb, &xid, &server, &ses,
 					     &tcon);
+			/*
+			 * Ensure that DFS referrals go through new root server.
+			 */
+			if (!rc && tcon &&
+			    (tcon->share_flags & (SHI1005_FLAGS_DFS |
+						  SHI1005_FLAGS_DFS_ROOT))) {
+				cifs_put_tcon(root_tcon);
+				set_root_tcon(cifs_sb, tcon, &root_tcon);
+			}
 		}
 		if (rc) {
 			if (rc == -EACCES || rc == -EOPNOTSUPP)


