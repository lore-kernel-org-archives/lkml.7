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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA0C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B48B2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVkukViM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGZDhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:37:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34548 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZDhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:37:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so17831590pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BLVEPxcF5NdA8EzN2EB6V4xBkvtLOum18kgdswH1FhA=;
        b=XVkukViMyVlBnVbjuVPWB2cGHGKknmsr5nyQ4AzfINu7whJU6erqA3n632yISp4R3+
         2fbks/qnFTS1+3Nseq0z25QJQslcDp9ScbW/FWwM6+2hJonkJLvS+ttTv0QlhRrQ53YB
         ZnZ1p/MnpZ6lJCDvbAc4z6mr0jbPUgHCBtY4at4ZMc80/WkrLWHEB/0anjEBvHv+SEMe
         XlSWnBPg6xR93Z4/MUCjzbNOSmgGSdRK6qfCyPAOTZaSq2lLBMH6yZm3b0An4rRByOpE
         SoR2zbcvSSWUNhBbZ47ZpVlF472129glrFpAMmIVpq7cPXiS6Ohz77hC96f8sO1c86Xe
         lYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLVEPxcF5NdA8EzN2EB6V4xBkvtLOum18kgdswH1FhA=;
        b=aHRRKB0MCI2KXA5yvdOcXyDHX/7FcwGK8Pg3VTiwjAbhB2b7BY3P7fPQ12KAmuVY5x
         FVWHBY4NSM6GQLm9EWBUHbI99jFcIoZZuo/oRUvz90ChSscsUs6ATpQqlOgonhcdYf6n
         OE73H2BZqD7hR7VjX+KSHlhfjOxvOTMnDnpEfPHtRQ8zjRj+nFXI/zQdoPyqj24+OdB7
         EfoPHKw7AApeKUNgAAte/WXFM62NcnxR9DC3lfIRgbutLAPD1JyF4AaGPQVf1ca/lsaU
         /VVyyUEVo6Fh+7GWDQBo5KrVMWQclUAGiKo5Wu5htTv29kCWchWYMl+RdLp6FLjzphQ3
         7SSA==
X-Gm-Message-State: APjAAAX1TYGcv1P0yL+PWzYg8TuwQNDHjCxlO8xpa2qDZ1eLH/AA4WbT
        HSQ/jgJlclQ7EbBY+aYc8PI=
X-Google-Smtp-Source: APXvYqz/RkbThPKJonBVw5XqABgitYzjNkz3eN5I/Z1rnN+CUU9HNL6Kyp58gJBrJ/dNGeqRJSOTrA==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr19181503pfi.221.1564112221975;
        Thu, 25 Jul 2019 20:37:01 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id b3sm66716040pfp.65.2019.07.25.20.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 20:37:01 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3] fs: ocfs2: Fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()
Date:   Fri, 26 Jul 2019 11:36:55 +0800
Message-Id: <20190726033655.32253-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ocfs2_xa_prepare_entry(), there is an if statement on line 2136 to
check whether loc->xl_entry is NULL:
    if (loc->xl_entry)

When loc->xl_entry is NULL, it is used on line 2158:
    ocfs2_xa_add_entry(loc, name_hash);
        loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
        loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);
and line 2164:
	ocfs2_xa_add_namevalue(loc, xi);
        loc->xl_entry->xe_value_size = cpu_to_le64(xi->xi_value_len);
        loc->xl_entry->xe_name_len = xi->xi_name_len;

Thus, possible null-pointer dereferences may occur.

To fix these bugs, if loc-xl_entry is NULL, ocfs2_xa_prepare_entry() 
abnormally returns with -EINVAL.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/ocfs2/xattr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 385f3aaa2448..f690502daf3c 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2154,8 +2154,10 @@ static int ocfs2_xa_prepare_entry(struct ocfs2_xa_loc *loc,
 			}
 		}
 		ocfs2_xa_wipe_namevalue(loc);
-	} else
-		ocfs2_xa_add_entry(loc, name_hash);
+	} else {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	/*
 	 * If we get here, we have a blank entry.  Fill it.  We grow our
-- 
2.17.0

