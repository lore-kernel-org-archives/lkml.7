Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9160AC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316C221E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="mDtU0ENR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFQH7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:59:31 -0400
Received: from mail.avm.de ([212.42.244.120]:58506 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfFQH7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:59:31 -0400
X-Greylist: delayed 864 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2019 03:59:30 EDT
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (8.15.2/8.15.2/Debian-3) with ESMTP id x5H7d19f012959;
        Mon, 17 Jun 2019 09:39:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1560757141; bh=r/FcQUb3N2qSBatg63oxiav4UmylcSo1Y1G1sfJoF/Y=;
        h=From:To:Cc:Subject:Date;
        b=mDtU0ENR4vOBU+YhcvRRKTauQrbQf5TTRUlQjfl9fQXQR803PIhrz3TjGJv1G7AiQ
         nws9UibPIhdoZPGDITS0wUj6sUBObH8j4cNBBO85LvAgvQQbpLf91Dv7dhgio+EAav
         Q+gdGd+NuiEAIYuKk0PRl5WBpbY0hAB7zYZRcw3o=
Received: from buildd.avm.de. ([172.16.0.225])
          by mail-notes.avm.de (IBM Domino Release 10.0.1FP2)
          with ESMTP id 2019061709390082-2087 ;
          Mon, 17 Jun 2019 09:39:00 +0200 
From:   "Nicolas Schier" <n.schier@avm.de>
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Nicolas Schier" <nicolas@fjasle.eu>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: fix typo in MODULE_PARM_DESC
Date:   Mon, 17 Jun 2019 09:39:00 +0200
Message-Id: <20190617073900.31948-1-n.schier@avm.de>
X-Mailer: git-send-email 2.11.0
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 10.0.1FP2|May 24, 2019) at
 17.06.2019 09:39:00,
        Serialize by Router on ANIS1/AVM(Release 10.0.1FP2|May 24, 2019) at
 17.06.2019 09:39:01,
        Serialize complete at 17.06.2019 09:39:01
X-TNEFEvaluated: 1
MIME-Version: 1.0
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 4938
X-purgate-ID: 149429::1560757141-00001AFB-070550C8/0/0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change first argument to MODULE_PARM_DESC() calls, that each of them
matched the actual module parameter name.  The matching results in
changing (the 'parm' section from) the output of `modinfo overlay` from:

    parm: ovl_check_copy_up:Obsolete; does nothing
    parm: redirect_max:ushort
    parm: ovl_redirect_max:Maximum length of absolute redirect xattr value
    parm: redirect_dir:bool
    parm: ovl_redirect_dir_def:Default to on or off for the redirect_dir feature
    parm: redirect_always_follow:bool
    parm: ovl_redirect_always_follow:Follow redirects even if redirect_dir feature is turned off
    parm: index:bool
    parm: ovl_index_def:Default to on or off for the inodes index feature
    parm: nfs_export:bool
    parm: ovl_nfs_export_def:Default to on or off for the NFS export feature
    parm: xino_auto:bool
    parm: ovl_xino_auto_def:Auto enable xino feature
    parm: metacopy:bool
    parm: ovl_metacopy_def:Default to on or off for the metadata only copy up feature

into:

    parm: check_copy_up:Obsolete; does nothing
    parm: redirect_max:Maximum length of absolute redirect xattr value (ushort)
    parm: redirect_dir:Default to on or off for the redirect_dir feature (bool)
    parm: redirect_always_follow:Follow redirects even if redirect_dir feature is turned off (bool)
    parm: index:Default to on or off for the inodes index feature (bool)
    parm: nfs_export:Default to on or off for the NFS export feature (bool)
    parm: xino_auto:Auto enable xino feature (bool)
    parm: metacopy:Default to on or off for the metadata only copy up feature (bool)

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/dir.c     |  2 +-
 fs/overlayfs/super.c   | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9e62dcf06fc4..e9cdc453f247 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -37,7 +37,7 @@ static int ovl_ccup_get(char *buf, const struct kernel_param *param)
 }
 
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
-MODULE_PARM_DESC(ovl_check_copy_up, "Obsolete; does nothing");
+MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
 
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 82c129bfe58d..dbcb3ff588aa 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -21,7 +21,7 @@
 
 static unsigned short ovl_redirect_max = 256;
 module_param_named(redirect_max, ovl_redirect_max, ushort, 0644);
-MODULE_PARM_DESC(ovl_redirect_max,
+MODULE_PARM_DESC(redirect_max,
 		 "Maximum length of absolute redirect xattr value");
 
 static int ovl_set_redirect(struct dentry *dentry, bool samedir);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0116735cc321..eb32e68f1a83 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -31,29 +31,29 @@ struct ovl_dir_cache;
 
 static bool ovl_redirect_dir_def = IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_DIR);
 module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
-MODULE_PARM_DESC(ovl_redirect_dir_def,
+MODULE_PARM_DESC(redirect_dir,
 		 "Default to on or off for the redirect_dir feature");
 
 static bool ovl_redirect_always_follow =
 	IS_ENABLED(CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW);
 module_param_named(redirect_always_follow, ovl_redirect_always_follow,
 		   bool, 0644);
-MODULE_PARM_DESC(ovl_redirect_always_follow,
+MODULE_PARM_DESC(redirect_always_follow,
 		 "Follow redirects even if redirect_dir feature is turned off");
 
 static bool ovl_index_def = IS_ENABLED(CONFIG_OVERLAY_FS_INDEX);
 module_param_named(index, ovl_index_def, bool, 0644);
-MODULE_PARM_DESC(ovl_index_def,
+MODULE_PARM_DESC(index,
 		 "Default to on or off for the inodes index feature");
 
 static bool ovl_nfs_export_def = IS_ENABLED(CONFIG_OVERLAY_FS_NFS_EXPORT);
 module_param_named(nfs_export, ovl_nfs_export_def, bool, 0644);
-MODULE_PARM_DESC(ovl_nfs_export_def,
+MODULE_PARM_DESC(nfs_export,
 		 "Default to on or off for the NFS export feature");
 
 static bool ovl_xino_auto_def = IS_ENABLED(CONFIG_OVERLAY_FS_XINO_AUTO);
 module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
-MODULE_PARM_DESC(ovl_xino_auto_def,
+MODULE_PARM_DESC(xino_auto,
 		 "Auto enable xino feature");
 
 static void ovl_entry_stack_free(struct ovl_entry *oe)
@@ -66,7 +66,7 @@ static void ovl_entry_stack_free(struct ovl_entry *oe)
 
 static bool ovl_metacopy_def = IS_ENABLED(CONFIG_OVERLAY_FS_METACOPY);
 module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
-MODULE_PARM_DESC(ovl_metacopy_def,
+MODULE_PARM_DESC(metacopy,
 		 "Default to on or off for the metadata only copy up feature");
 
 static void ovl_dentry_release(struct dentry *dentry)
-- 
2.20.1

