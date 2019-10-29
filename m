Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612E0CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211C72067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaTawvnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJ2UAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:23 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39907 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2UAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:22 -0400
Received: by mail-il1-f193.google.com with SMTP id i12so14691ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1B/sVIU7g0H6+oVqEZGWuKo/CDrnMLWhEmc+JCWHQI=;
        b=RaTawvnmzMDsm0CX/EQ9P14Kb6O5HqVt8sXvtKm3E6Kss0RKF3rUwknfXh7C4qI5Nh
         UyMg7uVHidz2z+ehI/fLPeVyCCcadILRAnpvU01VxR8JbjoBndkMbKcJX0+bYktEumMt
         gRwfFlD+HAFpRPZcIg3Qo3RWMYv/7rAgo66XU2eir+hReULfrEn2v7z3Xzljnh/9qcSL
         ZkHb6J96P6wi5YICu0O+FbeE2aWASd8BYC2lPXM2Pe62Sh8C5v5LDQiMarb1OcKqx/NT
         ckGy4u1JApQ1BKdHx+iTQMvhhXaeNFbNtpOGYd53reko/BLGXYH/7m+v1zEBMH/4g+0M
         00sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1B/sVIU7g0H6+oVqEZGWuKo/CDrnMLWhEmc+JCWHQI=;
        b=QpsgpgaSowQL8Mol3J1nFsdgY81amlaWwisa725xJgWIlBbJ2ENIeMn2+QNirzSQuj
         h6siJCuB1rO6za/T58FIMl4lASc6OED0CgiaiUA3DVU1czDzAZS3BANDbvomKHaYfnW4
         eI6cVSrGDRc4eiz2T4zC1FlhkBbe1Pcp7BHuKN3NdPjPMc8Ark8JM313jZrt1YHnGiXp
         XjYmPT0F5xrzdVVp8YcWPq2VUM5h8Ne6FjciIVQuwff89+vNTWwD+Mma/F7Jc4lAqfW0
         xxdcE73487a40ef/2RXV52r1AYNvlMmyWR0i/eQxM2Cd8yyNKIdVpxpelbr4JDkOMiE3
         m3LA==
X-Gm-Message-State: APjAAAWsa2t7RbNbE1x1FuBW1Wga8KPW3xvO2EFDpgsVDVek82k7hdkf
        NDJnu8N/VxaTna29++cx7Ak=
X-Google-Smtp-Source: APXvYqzGJRKqwjOi67186Cw1/NVgdlJYMLvzxFSISCgQpUvyFM+c0Rj17oPCrXhm/kn2gEzvEL8pgQ==
X-Received: by 2002:a92:3b52:: with SMTP id i79mr30416067ila.19.1572379221625;
        Tue, 29 Oct 2019 13:00:21 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t11sm1883900ild.38.2019.10.29.13.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 02/16] dyndbg: drop overwrought comment on ddebug_proc_open
Date:   Tue, 29 Oct 2019 14:00:15 -0600
Message-Id: <20191029200015.9691-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4bad78c55002 ("lib/dynamic_debug.c: use seq_open_private() instead of seq_open()")'

The commit simplified ddebug_proc_open, replacing boilerplate with a
function call, and obsoleting the florid comment about that code. btw,
git blame shows me as comment author.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ba35199edd9c..8fb140a55ad3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -840,13 +840,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 	.stop = ddebug_proc_stop
 };
 
-/*
- * File_ops->open method for <debugfs>/dynamic_debug/control.  Does
- * the seq_file setup dance, and also creates an iterator to walk the
- * _ddebugs.  Note that we create a seq_file always, even for O_WRONLY
- * files where it's not needed, as doing so simplifies the ->release
- * method.
- */
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
 	vpr_info("called\n");
-- 
2.21.0

