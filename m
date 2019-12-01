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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7422CC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 05:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1DA20867
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 05:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCwufBGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLAFnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 00:43:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33457 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfLAFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 00:43:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so14813007plb.0;
        Sat, 30 Nov 2019 21:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rT96Bmg/Qb2KB7vPy+GvW9l+EOJf0s1IFpO90eKCR1g=;
        b=LCwufBGaBuabLAJlscSTT/M2o3Bydo5NgVzrIa/Gr0cQIZbQzd1DBuSFjZ4fsgGO/m
         pnAAJwfmqnr4y67Zc24zMVsVEbR7C0x/uwOP8HBw4Jlr02njc5VhXg8hEuJqzyWUCN7J
         mYyXSP6+FFw3bAjtElfPSIxDP1Rh4nXxvbNDsL28pJj2ia/JBu3J/i/eNu1Y8MbIdPi5
         Qo/GEHiER1MvOqqos9nxDs5v8EEr1PKSvPClDQ9w9ixQ13zEsnhp8wqYti8V8RNWuCVu
         Jw3R77RFPdZ3qO+kO6/vnq/2VRgu4HLY5uo/OEXUCbCz7ioqCte4rht/oQjji01Umvsv
         SFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rT96Bmg/Qb2KB7vPy+GvW9l+EOJf0s1IFpO90eKCR1g=;
        b=Ob5Fpy9cQ7dxHnFM1HDimDpqtMHV/p9GDUVix9hm83Qpe5Xb5hxdyFH0B5/DuHZ8JE
         dzm0TPF7VPbN6+uYRPyYS1UciYaYauvjcSbxDtx2oW8sXohQgy0DRF22ErvaZXTDZwtF
         Xnu1gUwtEgaFmn8bfnEH6JiTvyucSTn5KLXWK6bij5/jqLjSfX5DJqkHvhYuYa3+2XxX
         PYH5qm1AVfd6pIupmQZ97e1cTOQLrf1ffcbevvAzDYt3CUzAKu7jjdQw7SHBZ2mvtusq
         teoghG617mLWgRSguPfumTpRqtHu2SPKugfGhgkWnpusAAox+mO0TnnunsftkpXo76dI
         ZWhg==
X-Gm-Message-State: APjAAAVP6dkQrrOnCCJ6ICZGdXjFJzOR50PBii1LJkD9seI5TkcP3Ekk
        EoeWNGIZUYDezXF6PhqMMXIe7czx5Jg=
X-Google-Smtp-Source: APXvYqy6Ck4VuBdaU/0GKhE7mzxxF1dp19x8LqnHC5bbhc8DmO/tK7Im1liWnBEZh+JlQF2vBaLK3A==
X-Received: by 2002:a17:90a:8d10:: with SMTP id c16mr15467569pjo.109.1575178983609;
        Sat, 30 Nov 2019 21:43:03 -0800 (PST)
Received: from localhost.localdomain ([124.80.131.109])
        by smtp.googlemail.com with ESMTPSA id m71sm11729146pje.0.2019.11.30.21.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 21:43:03 -0800 (PST)
From:   Jieun Kim <jieun.kim4758@gmail.com>
X-Google-Original-From: Jieun Kim <Jieun.Kim4758@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jieun Kim <Jieun.Kim4758@gmail.com>
Subject: [PATCH 1/2] drivers: md: dm-log.c: Remove unused variable 'sz'
Date:   Sun,  1 Dec 2019 14:42:19 +0900
Message-Id: <20191201054219.13146-1-Jieun.Kim4758@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable 'sz' in core_status function
detected by coccinelle scripts(returnvar.cocci)

Signed-off-by: Jieun Kim <Jieun.Kim4758@gmail.com>
---
 drivers/md/dm-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 33e71ea6cc14..8800ec1847b5 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -781,7 +781,6 @@ static region_t core_get_sync_count(struct dm_dirty_log *log)
 static int core_status(struct dm_dirty_log *log, status_type_t status,
 		       char *result, unsigned int maxlen)
 {
-	int sz = 0;
 	struct log_c *lc = log->context;
 
 	switch(status) {
@@ -795,7 +794,7 @@ static int core_status(struct dm_dirty_log *log, status_type_t status,
 		DMEMIT_SYNC;
 	}
 
-	return sz;
+	return 0;
 }
 
 static int disk_status(struct dm_dirty_log *log, status_type_t status,
-- 
2.17.1

