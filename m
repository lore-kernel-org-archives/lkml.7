Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B0C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7enxB+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0Jqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:46:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45244 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0Jqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:46:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so937226pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uMmVaqGs6Qzw1v02Xne45iZzGkIbUBWZpJMKSMkhWCo=;
        b=s7enxB+IExQARnhO0Qax0ABS2Hi6if5hn8MT8/E9KB4L+I8bWQEYmgRCgrbAoBA5PZ
         8/ENKEDKnCFRMDJPKphqSHG+Wfb1srI7LDWUfcv6SyGcIXuW8r2byhT6R6LW9/QW1XbK
         S0VmYxJGA0bCxTFxrItDMEye/uFBR95uyHbq+8RdjXlNQXxAchyFRzfFp/oE7VylKZ8c
         tFAk/jv0V6dgRI+BVy7G2ud84jqP71+C82mrfD2usIBsg18ed01xUNkA6hPsjB4vdynO
         kDiQAFpPoFdGLnJnIbB+Ggy8V7qb0Zemn76gL1DZ8OyLIGB4rJoFFGGqAQkga9fz1wuB
         WQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uMmVaqGs6Qzw1v02Xne45iZzGkIbUBWZpJMKSMkhWCo=;
        b=Vungjs4HMNdO6EITW6k1+tA3rF8AxMB9pbWAKHJs6sh5uGDMFTb+u/rKt0mo6YckBK
         XPGty1BSSr2335Tqfi93jTLYBNrwRY+gLP959tFZ10frwJo2I1cpihN9AxyshyXpU+2U
         CHr1LUEBWkiQY+JI/MtxHer3qmvxOt3CewlPIw+uDQ8j01QY8wfHcRc+UjK5/gtw80K5
         FJuAYGTXIOZL6Etez0mbP31H0dIf+OsKmMQo41/NDU3OWJ1vkyeNnUQk9TrrOc0Ldtv1
         LtT2/fNZWxKaUeM5pniQWER7Q/Lcjxfpp5m93mClcoZ3xyUkg8+QJLkKypfIxEmee+a4
         r8RA==
X-Gm-Message-State: APjAAAWDphXS3S2c+Icw7lupQuqNg4FsuEg+LTS3VptVQkhW4dsq+CiR
        92AObdWL5hbS+PN4v+jVR1I=
X-Google-Smtp-Source: APXvYqzV988AIws0jlsYMBuVHSS5AnNS0myfaZDDR3n7w9cPoWvRFgrEcd3t71Hz1fqgEMUY3UzZ0w==
X-Received: by 2002:a63:f746:: with SMTP id f6mr2945161pgk.56.1561628803496;
        Thu, 27 Jun 2019 02:46:43 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id 64sm4653324pfe.128.2019.06.27.02.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:46:42 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND v2] staging: erofs: return the error value if fill_inline_data() fails
Date:   Thu, 27 Jun 2019 17:46:15 +0800
Message-Id: <20190627094615.2224-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We should consider the error returned by fill_inline_data() when filling
last page in fill_inode(). If not getting inode will be successful even
though last page is bad. That is illogical. Also change -EAGAIN to 0 in
fill_inline_data() to stand for successful filling.

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
no change

 drivers/staging/erofs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index d6e1e16..1433f25 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -156,7 +156,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 		inode->i_link = lnk;
 		set_inode_fast_symlink(inode);
 	}
-	return -EAGAIN;
+	return 0;
 }
 
 static int fill_inode(struct inode *inode, int isdir)
@@ -223,7 +223,7 @@ static int fill_inode(struct inode *inode, int isdir)
 		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 		/* fill last page if inline data is available */
-		fill_inline_data(inode, data, ofs);
+		err = fill_inline_data(inode, data, ofs);
 	}
 
 out_unlock:
-- 
1.9.1

