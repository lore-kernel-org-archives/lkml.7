Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA5CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF19206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YT8us2NR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfCEAqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:46:31 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44222 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCEAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:46:31 -0500
Received: by mail-pg1-f201.google.com with SMTP id 23so6700227pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QfpMaV94+0wgT+OuqRPo5XEGlcPZK1e4dqOorDrF3ZY=;
        b=YT8us2NRgFHYgT4mRU4IW96mK04cQbPtnO1IAE/tauoXqLg0jDxK4WQR1RitCpDODe
         D8fuQMxT3db3pVPvpH+hbXAP15B4iRY7fA98xVdITwfiW/I20fHiFla/hYSfdIK32VO0
         zcEiGH9Fq96ZjWzZuyQkQRr4Ny3mAaZ1NN6t5c2yF+grVCZc7Tw1VBjOtTq6+5+ou1CL
         752/bsRVT2elbSZXium+72a6MWvq7DVgeGje5UZ60WISsyVGYyQCitw2gebWn5PkwIOg
         Nmp3zT1nkSvorDnmS8lIRGhFPu7SxJ/GZb5itspuceQJQHmG8aEYcjxDyAwl/Xrq3TTo
         p5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QfpMaV94+0wgT+OuqRPo5XEGlcPZK1e4dqOorDrF3ZY=;
        b=KvVcVLezDeYPQ5p8n001ZyfAE+hUg1XHNeoNEnSvnmyZHSMlmo9M6hZNNZpob60r8s
         SPipUjFZ9ivSCGLt2tPTHy5DBMh0wpJualIXkIJtEDmSSdOWX71ZT5Sq32llUlUcYVfZ
         JrT4V/lRQ0UXvzoKhzuYn8vo8xltY6PR+IcQIVqLB6HAgmmtoz150kEFH7FDruBxan7z
         4OAhJ7uv/waPFMdbkHsNurDTLzW6X7Jnk7bYgHYnaujqVMa+DpaHoECnn6+e7Nac5FmT
         KhqLjzdg6LTz19Lyp2BuVxf8Z5Dqa/C4dexk2lZSr1tJKvt7t0X0PzAAHak5M2GRjIKb
         Fi4w==
X-Gm-Message-State: APjAAAW5uHngKBHaCpP4abKy4L4Mewj2zHmT/cMKMnKYtnGCgBEr//sf
        NF9req0hut5aS3rvayZ5LCj8Kg1EtYaz
X-Google-Smtp-Source: APXvYqxlyZF9zMvOdEA5eS1pFBL7W2vAqV7/HcaChTdd6/KURqoPkhMPJPP5T4fyPGMYe7KVvr89whKIEkSj
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr1914198plb.105.1551746789992;
 Mon, 04 Mar 2019 16:46:29 -0800 (PST)
Date:   Mon,  4 Mar 2019 16:46:17 -0800
Message-Id: <20190305004617.142590-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] writeback: fix inode cgroup switching comment
From:   Greg Thelen <gthelen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb
transaction and use it for stat updates") refers to
inode_switch_wb_work_fn() which never got merged.  Switch the comments
to inode_switch_wbs_work_fn().

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 include/linux/backing-dev.h | 2 +-
 include/linux/fs.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index c28a47cbe355..f9b029180241 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -365,7 +365,7 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	rcu_read_lock();
 
 	/*
-	 * Paired with store_release in inode_switch_wb_work_fn() and
+	 * Paired with store_release in inode_switch_wbs_work_fn() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
 	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd423fec8d83..08f26046233e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2091,7 +2091,7 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
  * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
  *			synchronize competing switching instances and to tell
  *			wb stat updates to grab the i_pages lock.  See
- *			inode_switch_wb_work_fn() for details.
+ *			inode_switch_wbs_work_fn() for details.
  *
  * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
  *			and work dirs among overlayfs mounts.
-- 
2.21.0.352.gf09ad66450-goog

