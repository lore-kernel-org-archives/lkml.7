Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D87C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4252245C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 05:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npi54+lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfK3FbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 00:31:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41627 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3FbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id t8so13707372plr.8;
        Fri, 29 Nov 2019 21:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lm28kIqQgsof6QYEq9ODpPVkMAPFDe+UtXuv02kmoQo=;
        b=Npi54+lkuw0+YJz8HvLwnAKKaYNdKi562Aa7lPg4NSA5ybdMahLh/p5fJ4oGCwot7/
         jakmjx9aPiwG3uFE70HJW3OMyKuTPUyPJLsno9kx14SpVR4/Zg/wNrf0qZz7BCEfyK4z
         RB09pa/SRRW6eYXgSxQGo86ukHCyB8Lm7/jWNF4x79in9MWzN9sMGWYJPPxCxS6jFvzB
         W7mDZ1kmrJn+IMYlz9eJGFwF6kh/1QMJOwaMtXxyIlzNDfdr3x3xJBPSNNJCLTGNKmdY
         6OrCF6YGaolZKFrcxZT31A+F8LfB+EORE1PoOstQwPOWeftRa5ltQSCaqL9BoHu6MMSp
         fV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lm28kIqQgsof6QYEq9ODpPVkMAPFDe+UtXuv02kmoQo=;
        b=gjdeAvGhr+MQAY3QP/8iIZN/BXEjT+RZMzTbvBhD3h6pRATbiyITd5+8x7i69QSWDv
         PSsiHGKQKEVp2TqYbPh7/mN48/q/UYwnt7+YRS15D9Cam21X6qpjwbgdkKrsqCypiIQW
         7VzTplAigvMqP4t2PGGbItoToNQuOEzREWYgKhTzAGYM66ae1vTigEmNA11sWgDm/8Cu
         w+3sZ27w8WNhxRetngK3A8r74MFBCy1g1vyr4n9vZXgIgdgVPD7mMZxbz7ANMN0UJTmy
         LKLChvjdmDYA0PPOi/G0mAlEzFH/1Kas0WNyenfgP7q2sowMEXdh/b7Q9wAm0ofXqPov
         /0Dg==
X-Gm-Message-State: APjAAAX6ulYXAtT5L0PkVYJkwpw5U+wNMB9yUXeZxhUQfzbe+yH2ykdy
        EY8wvsbRukhH8Lz8EJQ2uDY=
X-Google-Smtp-Source: APXvYqwcaA1IcT3cJpggyCqWfO4MBFi0kS8zhv48i031lPPDUZezZFwY9SmFNt4iI6HSg94LJzhiBA==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4mr17917267pll.0.1575091870541;
        Fri, 29 Nov 2019 21:31:10 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:10 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        hirofumi@mail.parknet.co.jp
Subject: [PATCH 1/7] fs: fat: Eliminate timespec64_trunc() usage
Date:   Fri, 29 Nov 2019 21:30:24 -0800
Message-Id: <20191130053030.7868-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timespec64_trunc() is being deleted.

timestamp_truncate() is the replacement api for
timespec64_trunc. timestamp_truncate() additionally clamps
timestamps to make sure the timestamps lie within the
permitted range for the filesystem.

But, fat always truncates the times locally after it obtains
the timestamps from current_time().
Implement a local version here along the lines of existing
truncate functions.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hirofumi@mail.parknet.co.jp
---
 fs/fat/misc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 1e08bd54c5fb..f1b2a1fc2a6a 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -271,6 +271,14 @@ static inline struct timespec64 fat_timespec64_trunc_2secs(struct timespec64 ts)
 {
 	return (struct timespec64){ ts.tv_sec & ~1ULL, 0 };
 }
+
+static inline struct timespec64 fat_timespec64_trunc_10ms(struct timespec64 ts)
+{
+	if (ts.tv_nsec)
+		ts.tv_nsec -= ts.tv_nsec % 10000000UL;
+	return ts;
+}
+
 /*
  * truncate the various times with appropriate granularity:
  *   root inode:
@@ -308,7 +316,7 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 	}
 	if (flags & S_CTIME) {
 		if (sbi->options.isvfat)
-			inode->i_ctime = timespec64_trunc(*now, 10000000);
+			inode->i_ctime = fat_timespec64_trunc_10ms(*now);
 		else
 			inode->i_ctime = fat_timespec64_trunc_2secs(*now);
 	}
-- 
2.17.1

