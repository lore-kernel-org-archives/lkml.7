Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8830C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BFC20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYEw+SbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfIYVjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:39:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38234 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfIYVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:39:13 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so865598iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o3HD36ChA358R1g516TCEdPi0qQJP37RNyq0UULAKoE=;
        b=QYEw+SbHZ1Q9KQHDVL8wxYW7IxX4ybtdF8LH+N2Hf5uctzZH5OV04sT3j25fMZY0zl
         TkZ+05YYBG9WB9bGpgUB//eDXtqeWpeXh0VzR5DusiO2OrboaX2RffltQPewDx6aJGYk
         sbXx2whaNeE+prUhBmxJR9c9HVS9DbOz1bXj26W2UcIZnIRXUBSNowXlZVFXxQIhZupz
         wJCu+vxgj9fbuABOc07scMy1MYOUIsaKbMGOyoo6leMdRektNUZT6zlhkfpBN0k3a4Wl
         smM+ASdTnN/2UCe4Xb9LJ1LfXmG3XWES2NuqUGB2Z0erZ8zPSw2k2Ah+7iA7fUqbhqAy
         0LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o3HD36ChA358R1g516TCEdPi0qQJP37RNyq0UULAKoE=;
        b=LvcUbqpWsIzlqJGbtCLobnt+5IOfe+EqPkXh2r9auNQKupSCxFXYWKU6pSCLcey0oq
         2ESCpJQzIPQ7+3QZ9sR9dIC3bj1WttSPUpfNjNOvuRmnhMePHYTEO0o4Ae5MvgzFihDB
         O1tRToyc4c42ShSn51rV9XCyt16F6cimpaq7fH8TkIIq6sWcnXN5RKKxlAXVulo6B1FL
         V6j/z4ZcVsM3mhBoZJF0SRLeoOAeOYe+toMP9fdqPv4g7JE3sknMcgIR4QKrlYFnzzCB
         kLEw0QRAKHK7GTa0zdPZwtb6JWZilQDh9+rCVpuSmRU9vak1kMOLNV7vm2nOmhoHthpK
         qq7w==
X-Gm-Message-State: APjAAAXeK4FNMUH+5dbCKfKm1ap6OrzdsW2+QChtGOnaqWsCao7BWC7A
        f6gXedZGp9lR7dl8hpIGsbU=
X-Google-Smtp-Source: APXvYqyd5xfldJC7URqaq9MRA3HvLuFOQ5gWKYubAdtAe3l2ZINQBnN59h8HMHR8LNUcFKUHoIKQJw==
X-Received: by 2002:a6b:fa07:: with SMTP id p7mr115825ioh.164.1569447552596;
        Wed, 25 Sep 2019 14:39:12 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id s201sm896898ios.83.2019.09.25.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:39:12 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] udf: prevent memory leak in udf_new_inode
Date:   Wed, 25 Sep 2019 16:39:03 -0500
Message-Id: <20190925213904.12128-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In udf_new_inode if either udf_new_block or insert_inode_locked fials
the allocated memory for iinfo->i_ext.i_data should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/udf/ialloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 0adb40718a5d..b8ab3acab6b6 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -86,6 +86,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 			      dinfo->i_location.partitionReferenceNum,
 			      start, &err);
 	if (err) {
+		kfree(iinfo->i_ext.i_data);
 		iput(inode);
 		return ERR_PTR(err);
 	}
@@ -130,6 +131,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	iinfo->i_crtime = inode->i_mtime;
 	if (unlikely(insert_inode_locked(inode) < 0)) {
+		kfree(iinfo->i_ext.i_data);
 		make_bad_inode(inode);
 		iput(inode);
 		return ERR_PTR(-EIO);
-- 
2.17.1

