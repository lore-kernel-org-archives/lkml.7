Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E2AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B28720835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWYe3Yj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfDQLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:52:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35462 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfDQLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:52:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so12004424pfh.2;
        Wed, 17 Apr 2019 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+Jy3DWbk9Qv0+8KvNBKbZ1gEm4HZaoLcJzKvfJBaD5E=;
        b=SWYe3Yj8ETbkBw2gpbitdQ6xGaO7BY7HmyqPT6TI5waSzG52Mfd2/z7yP5BjuvOimo
         o1obi4wwEbJwGgbrcbRkdnfTnAHtNnWr6r9DfaX5ff1Z0hmUjs5fKPqIi5uTAb2at/kF
         0nI9i87wZfVcYnsQjKPzfO4smxxS8R/86PdjvgGVMrMbyo7dlH/58L+w+0HtRHq5okH5
         pmQCPfOrh2vc7oHlT8OgxlrwVHbAHMJdT3r7COXZppIEm8n8YqeZa176q7sXakPrCh6g
         cS3SG5fu00wNPYCdloDp/qJ1jfP/Zp5+Uq5DKJydwKpW5L2NxcWp4NHxjZopOHWOEKgT
         CoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+Jy3DWbk9Qv0+8KvNBKbZ1gEm4HZaoLcJzKvfJBaD5E=;
        b=mNUdHD3YruB/o2C6L1kUgSfedrSnBadp4y2pB8HB/XGe52DLtjUWuCMSdWV1p0WyrY
         0J+mrgM6cYQD3HzBGj3qT4GYscL8lbobjzdFfEsfe6AFe41VEArE/WFmbtLcLF/zrrk5
         2FBAI3GfOsIjsrTMVDyvkBAAqU8M5QzeUSFImFgUdtSc+YswIYI12fAEbMpYeutCiUV9
         wlVT9J/3NguSVrHcmZ++DxBFS1eOzFkTWoVsFsEjEPygXWf75oN1r2iLXtAq8pOttEPw
         xCccJBN1hUUYPAg+9h67VUdKTanaVtenDciRK29rirJreHQpwGCvjUB2al5QyyqomsD/
         KAEg==
X-Gm-Message-State: APjAAAXxiexnAqT/b91Gdy/AIADdsDcDRMbIrK9euBpYA9zkAa+hcdRb
        B/PW5Y7/Y8ihIEB5tOtM0V9D2POQ
X-Google-Smtp-Source: APXvYqxayOK99yaJb6YdpXrgZj+Oo39SuCX11gOmJlk2pCOT9TxG1UrKmROABOuDrjM28JRRVJjMVg==
X-Received: by 2002:a63:6942:: with SMTP id e63mr83133514pgc.102.1555501927659;
        Wed, 17 Apr 2019 04:52:07 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id h65sm144720205pfd.108.2019.04.17.04.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 04:52:07 -0700 (PDT)
Date:   Wed, 17 Apr 2019 17:22:00 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     akpm@linux-foundation.org, jannh@google.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs: Force type conversion in xattr_hash
Message-ID: <20190417115200.GA10168@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sparse warning:

fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
expression (different base types)
fs/reiserfs//xattr.c:453:28:    expected unsigned int
fs/reiserfs//xattr.c:453:28:    got restricted __wsum
fs/reiserfs//xattr.c:453:28: warning: incorrect type in return
expression (different base types)
fs/reiserfs//xattr.c:453:28:    expected unsigned int
fs/reiserfs//xattr.c:453:28:    got restricted __wsum

csum_partial returns restricted integer __wsum whereas xattr_hash
expects a return type of __u32.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/reiserfs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 32d8986..60b29a0 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -450,7 +450,7 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
 
 static inline __u32 xattr_hash(const char *msg, int len)
 {
-	return csum_partial(msg, len, 0);
+	return (__force __u32)csum_partial(msg, len, 0);
 }
 
 int reiserfs_commit_write(struct file *f, struct page *page,
-- 
2.7.4

