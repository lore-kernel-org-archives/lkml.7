Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D84C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 05:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BE520867
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 05:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIMR+UCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLAFno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 00:43:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36183 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfLAFnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 00:43:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so4182839pjc.3;
        Sat, 30 Nov 2019 21:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X7ley8JXHje4lCwDYJLUwhoPHGOKy00BtUbYE06y2mQ=;
        b=gIMR+UCf26AXrDilZVj8Sd791uneddCgmgS/oZ0WtLeRuEwZEGSUOehtQbae8D1b2n
         7QetijqvdqwjLS9FIaQM7O+1cQXy1EI2nrHIGHSC2lPPjc+DabrLPk+2rvT/Hx5VcoDy
         5+oR/6AsQ4kFZAWSfb8XxaDyLSCcMWXUsxQk720GpeQ71lLUt6MmhZrKnfVZAw6Zas55
         bNh0Hito61dAZb0maszQSyyqCZ2KjFwt+jYiPPzf9vdJbp1zS0HfMX/vw/lXvDwO83ok
         LFyy7IIBHf58jg0ENXolHosZHhNJYMbFN+028GVI0HsJ0P7HyHLb45I/Fh7kZkxU1A9W
         0gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X7ley8JXHje4lCwDYJLUwhoPHGOKy00BtUbYE06y2mQ=;
        b=KvQBoenrTBLOljgdGGvBmNZTBp+1yfcpvMGvluOA1ay+fYCOrgbZ61SZ7mk4vI3iR2
         2QreIphRztSxsqhfe+3RsnSQICcpNfWiL6jIEc40REUHrH7+vrqlabWxQEkmHEdCKGRW
         KNoj+qe0mq00ICHv0D3X2MxNN+cpfNOkS9s5rR/rlPzjsrB9aTwzWoYLstTS8Rh3SHc0
         dap67BTVu/8+dAvGhDnbeXztsuz5zHIV9Sw9PGHEGB3kChrkU649F8MBuxopFbF5xpUU
         JOF89oSinU8vZYiKlJqahDl+4ybnFz0Kzb37fg7s1wXfrZ8RxoDkjAiE6HmOtCDVLu6I
         Xqjg==
X-Gm-Message-State: APjAAAWZ2uN+rnXBrU6QBLBDijpwbDqlEpb4U1zz4dHjOTP8jTRXq+Hk
        MHhd5tYQKsOkWXJBDdhs51g=
X-Google-Smtp-Source: APXvYqzChZcYdgldLt6cJOWuuRLOolGoelVm7oilHIxLRobVvFpZlI3HU50zBqiHHWrCv+3M+pAa9w==
X-Received: by 2002:a17:90a:353:: with SMTP id 19mr29595680pjf.128.1575179023309;
        Sat, 30 Nov 2019 21:43:43 -0800 (PST)
Received: from localhost.localdomain ([124.80.131.109])
        by smtp.googlemail.com with ESMTPSA id m71sm11730331pje.0.2019.11.30.21.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 21:43:42 -0800 (PST)
From:   Jieun Kim <jieun.kim4758@gmail.com>
X-Google-Original-From: Jieun Kim <Jieun.Kim4758@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jieun Kim <Jieun.Kim4758@gmail.com>
Subject: [PATCH 2/2] drivers: md: dm-log.c: Remove unused variable 'sz'
Date:   Sun,  1 Dec 2019 14:42:57 +0900
Message-Id: <20191201054257.13199-1-Jieun.Kim4758@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable 'sz' in disk_status function
detected by coccinelle scripts(returnvar.cocci)

Signed-off-by: Jieun Kim <Jieun.Kim4758@gmail.com>
---
 drivers/md/dm-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 8800ec1847b5..67e74362c6ac 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -800,7 +800,6 @@ static int core_status(struct dm_dirty_log *log, status_type_t status,
 static int disk_status(struct dm_dirty_log *log, status_type_t status,
 		       char *result, unsigned int maxlen)
 {
-	int sz = 0;
 	struct log_c *lc = log->context;
 
 	switch(status) {
@@ -818,7 +817,7 @@ static int disk_status(struct dm_dirty_log *log, status_type_t status,
 		DMEMIT_SYNC;
 	}
 
-	return sz;
+	return 0;
 }
 
 static struct dm_dirty_log_type _core_type = {
-- 
2.17.1

