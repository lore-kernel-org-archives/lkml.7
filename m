Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14551C4649E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A8F216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkkUt0Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfGEQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:30:41 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:57202 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGEQal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:30:41 -0400
Received: by mail-yb1-f201.google.com with SMTP id w6so4581065ybe.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HGTWQFDxYVMCMUJdNYUyNG/FKXXlxIV2zrqsyrgnOLI=;
        b=WkkUt0LyKQsbN0xk0dY4mHPc1O2nPXbz7w2egGziV95fDI3u52YGBpBbdpMZwBKO3W
         YS2xFk7//eojhE6wXj4v15i7Cj4aW7vrYtSE23eu+l4owgufAQL0XLoSCmgwTokx431L
         2RyF/pKgRn7U1+2mD+hmWu+voWoEXttPq2PkZJGvgGNk7mIt1wT3MUliG2orf2xiWfCH
         35TjLUvNDF4EzaIr7FgAleR1nZsR9+L6pB97hwmhJnsp47P2DPSS1jJoFKU2AlO8rRg2
         cftwue0TmYGDKiQ47L32Ip0RIjt8L6xhGWiklPkU4I7aHVucarWEQBBxMt4SZzU2BSE/
         ylQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HGTWQFDxYVMCMUJdNYUyNG/FKXXlxIV2zrqsyrgnOLI=;
        b=n7GqmqKzSgvzeVe4n7IlKUpru5g5PTjIl3zvRW1Q3BIN4nX/zDNnVrXinJStr/9+v1
         WhyEZrRCqR1gg6V6ghyxOmWFR96V92g9PRmeNZ3tR343WXdibKGE0SLiVfXfspZoMDE4
         HWuXFW9Mxt4hkx+WH5Vsqf2NhkEoAUzDxlG0OXSFgMV0vbuPhWwnI0reqmHfMjOTvSPy
         a0uVQJ14AfQzXRNblYGx+F12GHYjjfltcu4A/ob91jPLc5TYGYqTRvZAoMzG1jzaIqQb
         4rpMM1HZbAnRFOU7LuIy7lH2ATBI8egxYbnHQpD9T5gEQuLbNOB0B0UNSh+/Zgv5ToY5
         ZdfQ==
X-Gm-Message-State: APjAAAWsZON4Q1p2zHKaNw1D5IOaDcYyRjoGls0EPwwmAXWSliPtuccy
        aCrqzitZg8/RZQSdWxqvaZYoIUYU4fg=
X-Google-Smtp-Source: APXvYqwZ4OKhEzX5lujcHH6VcKquOZyDhPFBRHBTWl6GHZ0kfdO/wP1Swcx12SgftW+x+Rv7faRgM6uFwOc=
X-Received: by 2002:a81:f012:: with SMTP id p18mr2538485ywm.375.1562344240222;
 Fri, 05 Jul 2019 09:30:40 -0700 (PDT)
Date:   Fri,  5 Jul 2019 18:30:21 +0200
Message-Id: <20190705163021.142924-1-rburny@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] fs: Fix the default values of i_uid/i_gid on /proc/sys inodes.
From:   Radoslaw Burny <rburny@google.com>
To:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com, Radoslaw Burny <rburny@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also fixes a problem where, in a user namespace without root user
mapping, it is not possible to write to /proc/sys/kernel/shmmax.

The problem was introduced by the combination of the two commits:
* 81754357770ebd900801231e7bc8d151ddc00498: fs: Update
  i_[ug]id_(read|write) to translate relative to s_user_ns
    - this caused the kernel to write INVALID_[UG]ID to i_uid/i_gid
    members of /proc/sys inodes if a containing userns does not have
    entries for root in the uid/gid_map.
* 0bd23d09b874e53bd1a2fe2296030aa2720d7b08: vfs: Don't modify inodes
  with a uid or gid unknown to the vfs
    - changed the kernel to prevent opens for write if the i_uid/i_gid
    field in the inode is invalid

This commit fixes the issue by defaulting i_uid/i_gid to
GLOBAL_ROOT_UID/GID. Note that these values are not used for /proc/sys
access checks, so the change does not otherwise affect /proc semantics.

Tested: Used a repro program that creates a user namespace without any
mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
Before the change, it shows the overflow uid, with the change it's 0.

Signed-off-by: Radoslaw Burny <rburny@google.com>
---
Changelog since v1:
- Updated the commit title and description.

 fs/proc/proc_sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c74570736b24..36ad1b0d6259 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 
 	if (root->set_ownership)
 		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
+	else {
+		inode->i_uid = GLOBAL_ROOT_UID;
+		inode->i_gid = GLOBAL_ROOT_GID;
+	}
 
 	return inode;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

