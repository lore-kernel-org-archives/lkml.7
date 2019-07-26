Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A3C41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD022C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/8noa7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfGZDhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:37:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38829 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZDhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:37:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so23785512pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MVFsNfeXzerLqMZOF/NXhnILFTns7YePBX6j9xJptms=;
        b=f/8noa7Cj2VQKBganab1JYvwrmyua4Cf/vzhDrYyIXd5XHyCwhZlCwqhtqih+QvxUU
         zgn+x9WKhWck1N72TP0W/qSYFawiiOcMkckjARINwR8GfMYg9ZxXOpy99LtcYWs9o+/U
         pkdUyvGvhxh+VpuEofdrLfS2YC8kQfF/ubUROkOV7Kypc+xSvCiFKbqCFqt2hMs7LiGi
         qhkxYMIol/sZg3s8tC8Bbpc4lbowo1tNE8fsCVB0GXcWtj7BRot5d4lHLzj1Y+UMFJOd
         L97vxAfIKce9S5vj+IbECZMhSPiln0J2zfffrnYfSec/ERRI8Z9XmfDBr0yyoRYITif9
         9Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MVFsNfeXzerLqMZOF/NXhnILFTns7YePBX6j9xJptms=;
        b=E4DXotCCltDMBygAJoskZ8sA0aSEHpgqwfPOQ7ULcDK60hETiNWBvRhow4cN/0OIQR
         0/WmM2v2ingK0glo+VoOuaWY9JyNeLwCyd4x+YLzfslVNVTGnmjVLn48/xBSIVACx+04
         Q06GKSPR4/0Zp0EWKkQNBXUdSehP0+ah+2z2aVGqSi2aJxnK00n/GVS/ub1frnfBVDcK
         5v+cOXmFqkUNfziCK7zMlzXXa31BkYHppHgmhRotiMYbTYJdy7+c3oavElM1NeirlZJd
         RYdZXUO6jwqDjDpET5WjwmA5Y3F7sb6JGF2nUQAJmlylrkLLjO9n4FeqB7Bi+nfiLjbY
         wpdA==
X-Gm-Message-State: APjAAAXxGC9D6u3SpK4jO/cy3fcoVd2bw59gQ/yL7xjFcPSCnPJUDMge
        0vFRSc5qMNhMmK2kWRHvA8M=
X-Google-Smtp-Source: APXvYqxQQRQYRv+F2M9U1lf7a/Ms/TkeOF4ZBQvd4vU0Jwb0/pQy2ipfwzw6SHhlDnP3RqsEJxm39g==
X-Received: by 2002:aa7:8651:: with SMTP id a17mr19749665pfo.138.1564112243397;
        Thu, 25 Jul 2019 20:37:23 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id v63sm53036295pfv.174.2019.07.25.20.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 20:37:22 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 3/3] fs: ocfs2: Fix a possible null-pointer dereference in ocfs2_info_scan_inode_alloc()
Date:   Fri, 26 Jul 2019 11:37:17 +0800
Message-Id: <20190726033717.32359-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ocfs2_info_scan_inode_alloc(), there is an if statement on line 283
to check whether inode_alloc is NULL:
    if (inode_alloc)

When inode_alloc is NULL, it is used on line 287:
    ocfs2_inode_lock(inode_alloc, &bh, 0);
        ocfs2_inode_lock_full_nested(inode, ...)
            struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);

Thus, a possible null-pointer dereference may occur.

To fix this bug, inode_alloc is checked on line 286.

This bug is found by a static analysis tool STCheck written by us.       

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/ocfs2/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index d6f7b299eb23..efeea208fdeb 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -283,7 +283,7 @@ static int ocfs2_info_scan_inode_alloc(struct ocfs2_super *osb,
 	if (inode_alloc)
 		inode_lock(inode_alloc);
 
-	if (o2info_coherent(&fi->ifi_req)) {
+	if (inode_alloc && o2info_coherent(&fi->ifi_req)) {
 		status = ocfs2_inode_lock(inode_alloc, &bh, 0);
 		if (status < 0) {
 			mlog_errno(status);
-- 
2.17.0

