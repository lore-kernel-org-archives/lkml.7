Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33473C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14AE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjTo7E7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfEFVYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:24:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38985 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEFVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:24:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id z26so7430217pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mcgpr1EbDMecE7rZGD6vwsoGUZztxKYeNBa1TJHRsqc=;
        b=jjTo7E7PRELtaKbiax6Ts7rsh4/BvAeWg+3CSjtwVD9iBAJ5XvpgEH5NkCZCHMMaYq
         pUxfABpU2w9NWVo+vpDZ90SSjhA8Ppgno5KHHcECq5uBILhrrLmSd4t6K31u8KyB4fQm
         wzisp6v64m7vFxMV5Pmzu2pxyrjHMcvv3rIJwdqGtHPO4LxsLYZ140eoE630Pqh9pwsS
         Mk1sb6eoWLIKJaIs0RweXo+S2/d/dd+hylIvqAb/dTIAuHJ6FtiRlwoFaGVNPq+BsWQU
         h0Hg6yy49zhC34CeWCIpu1KhQ9yNil47dDHAAxA3bveeoqDit2AOh/rMHXZHivMz1xIy
         Yigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mcgpr1EbDMecE7rZGD6vwsoGUZztxKYeNBa1TJHRsqc=;
        b=MSVsjYfMHaJOZtSwMHMC9mdlnPBQkM7+vELGeggOfrxkdO1LO3s/GvGrv1E4e7ZHiO
         qxQngwXKSIUDQU0HONdGDBNeShp6uWsbkyjnQY5H24Rli/LA+/LTjm0oQJ0Mmr47M7dq
         sN5PSk5AEm8hk4Gvu+Fjodn0ssJ0PPt7eBKchR1huG+xFcW4vIuOoKGnlbiQkKDT+akX
         xTkFBQKZozaZ64URQaaj/JZM3QqSrKHO947F0CiBakJvp+/G5Ja7r6CD7mS5qd1rmcGI
         W9Le62eRfCMrA1rHcw84maIQaLCBoYzoN/B+3lYg/agjybqRzRXEL9Jw9i3/2p0EZaIy
         LlFA==
X-Gm-Message-State: APjAAAV3rwCLu1wOE+woDaF40y0xxkQy5Nel5fcd5wiWKNwUQk2c4KfA
        tiM7Qmly/OvhtdQXrSc1PO4=
X-Google-Smtp-Source: APXvYqyNXdy0gck+QiSXiwWgqIvLja5eUnY9VM/YdDEVYWyMtWhJNQcNz1nChR29KIyWIeWTWQeWlA==
X-Received: by 2002:a62:a513:: with SMTP id v19mr36199277pfm.212.1557177848733;
        Mon, 06 May 2019 14:24:08 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([61.1.213.72])
        by smtp.gmail.com with ESMTPSA id v14sm14378469pfm.95.2019.05.06.14.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:24:07 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vandana BN <bnvandana@gmail.com>
Subject: [PATCH] fs: ubifs: Resolve sparse warning for using plain integer as NULL pointer
Date:   Tue,  7 May 2019 02:53:27 +0530
Message-Id: <20190506212327.6480-1-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/ubifs/xattr.c:615:58: warning: Using plain integer as NULL pointer

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 fs/ubifs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index f5ad1ede7990..066a5666c50f 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -612,7 +612,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
 	int err;
 
 	err = security_inode_init_security(inode, dentry, qstr,
-					   &init_xattrs, 0);
+					   &init_xattrs, NULL);
 	if (err) {
 		struct ubifs_info *c = dentry->i_sb->s_fs_info;
 		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
-- 
2.17.1

