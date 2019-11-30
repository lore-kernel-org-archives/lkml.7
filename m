Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE203C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F1120833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvdSmCcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK3Fbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 00:31:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36724 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfK3FbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so15669457pfd.3;
        Fri, 29 Nov 2019 21:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BHTDtxvEiYFTLiebbwUbRtrN28Hzzvb20uPHKGc+/WM=;
        b=nvdSmCcxewXb1BHkTf3gNGqhYckwmrhVf8sXKug1CmL/BhlLAWtirBwk07cfOKmNNK
         UvO4QkqaPKn9cAZNrimKfT/w+nAa5O+LExr3EaaeUNonvW6TPRMN8chEZPUdeS5pLiEG
         p/zTTvUd4/1xZBvVkJP96VUi3GaDy08lqQquNuJubzrdeK99b6LXoCMZyEZpLk9NqBzq
         4epOErCHZ+iBzz0BO6rtrR8wnsDYhW1uMHvXqQHZNxEUpsIYj4G48hoG/Ofl6QQtdtfP
         0OmJTU7MXP3Mbw6FPSqUQGjf8PEN+meZogOLuTvoIiuMHrUkrtgwVTCoL9oJFmKxuyQG
         BAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BHTDtxvEiYFTLiebbwUbRtrN28Hzzvb20uPHKGc+/WM=;
        b=q4H2s5oACaSb6TcjP59548VVS7HJRLGKXXt9l2y5JMkruqBCiZlQOMXOCm4AMBGFZU
         zxIsYRkV/80grAnDmePlmzOlAOIwgANOyh7nhV0Syr42d6Z07CCNyTHhE4p1dLYvK7Ir
         LfCcpIeGuQjDIJIpywrqkFfyp4TLIe9QKNB0wPXKObrdNLqvNg8CBz/98VAFPpdImfGK
         hOci8g4rR2Xvsmfo/rsPn5PlXr59dx3Ec36cw0TXH9Uj0Oj+Jv4YGg/SBmJbcikqJ6Yc
         2ovD2kRvMCGZkMGkEtcOFTLj0PSeXo8/Y5DgUR/ZPlti6CgJkvzPL8VOq8bFBKvpv/ML
         O8Kg==
X-Gm-Message-State: APjAAAVLXFqstjgtTMbm5e7awV5MvpY4wqyb4ZqfMhCc81zS3qG7CyJn
        0dd9jNM8KAsY2RpKFBlRhIoUEwGD
X-Google-Smtp-Source: APXvYqwHAbVakfZAzkoRLCz096tq6L6dpSEor/4JiHH6Fc3UMoPDj4kgzHx2H0Kfc+D0nljOe9z/qg==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr21005232pgx.286.1575091883825;
        Fri, 29 Nov 2019 21:31:23 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:23 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH 6/7] fs: Delete timespec64_trunc()
Date:   Fri, 29 Nov 2019 21:30:29 -0800
Message-Id: <20191130053030.7868-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more callers to the function remaining.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/inode.c         | 24 ------------------------
 include/linux/fs.h |  1 -
 2 files changed, 25 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..12c9e38529c9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2145,30 +2145,6 @@ void inode_nohighmem(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_nohighmem);
 
-/**
- * timespec64_trunc - Truncate timespec64 to a granularity
- * @t: Timespec64
- * @gran: Granularity in ns.
- *
- * Truncate a timespec64 to a granularity. Always rounds down. gran must
- * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
- */
-struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran)
-{
-	/* Avoid division in the common cases 1 ns and 1 s. */
-	if (gran == 1) {
-		/* nothing */
-	} else if (gran == NSEC_PER_SEC) {
-		t.tv_nsec = 0;
-	} else if (gran > 1 && gran < NSEC_PER_SEC) {
-		t.tv_nsec -= t.tv_nsec % gran;
-	} else {
-		WARN(1, "illegal file time granularity: %u", gran);
-	}
-	return t;
-}
-EXPORT_SYMBOL(timespec64_trunc);
-
 /**
  * timestamp_truncate - Truncate timespec to a granularity
  * @t: Timespec
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..46dd7e6f6d73 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1575,7 +1575,6 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
-extern struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran);
 extern struct timespec64 current_time(struct inode *inode);
 
 /*
-- 
2.17.1

