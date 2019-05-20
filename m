Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638F92173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYXSqMnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfETVos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:44:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39645 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfETVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:44:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so18132562qtk.6;
        Mon, 20 May 2019 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6wj9uCNAgZU3i37+Q6Xt259Bwsf4HXrCdW34hRDdek=;
        b=uYXSqMnw+Qu/bdyyJ7hU6ANulSnhgvdwH5cEiNeyroXWomxYyJAWJuQzsChssEQbOi
         76vi/9Wvou+9gs4KNlZUil7LRe6CeEYOHp7CljEQKDK/K5IBbdceWw2ZKIGrRjD5xcHY
         sxCJ7OCLh0DzGxZKxw8VRGXwf008AnXID6RGBS3FGir1lXpH1F37ALFr4EP2brXsjLc2
         O+wgikm/x2AjQeGCLNC4Ug30DX84tm30lmWiK8FyeK56911qbdFyiWbol5coCKJoPP9y
         fj34gspVlD2Z+MhiNbunmd1qJDKZjTfneafhT8TqeOUKyPBqk4VMhekBJkqXbe4i8R3M
         6BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6wj9uCNAgZU3i37+Q6Xt259Bwsf4HXrCdW34hRDdek=;
        b=j0Hlw9XexFcCNZoyg6cAwbmBoEXkElryfGa/+gDqONz1U1IeNUYdd+MX7aEj13seGl
         zF0Yq4TbDkrrv5nPzxFjUzzjlImdFUwwDn2ROI0gU0FKkJVIY4vLOJ0p4QEP+R79T7An
         IXXvzwr4DNDhVLbyHfvR88PTSm6BEGgxwZvB/KORptuMnE+fYZ08oQ4XFQBw0g2TBVVO
         jzxUxTjS/Rw0cuQh7DOKNhHPBlQx7M6PsxNluTNIAan+lh9yUWMTqUNzq/hueRyqqra4
         c/pjIZjJJz0iVEq9qPQFKiDBABhRDqZ182qB/wyCDsBuxWCpRNYYcFFmYt/NX9edPwXv
         bIfQ==
X-Gm-Message-State: APjAAAUdtGeuUDADj0zda0r/b88rxbmdrIlSazeHC4r3wiWpO6L4NOVS
        BNdBKAZObI60GwwjG7e3d41RhzU3
X-Google-Smtp-Source: APXvYqzlrTl03PRyQEgmjdhOt6FdTHh/QDge50r8lJ0Z9InwIRM60KjbcJiVHuDNjVhpzwmS+0oqiA==
X-Received: by 2002:ac8:1ad3:: with SMTP id h19mr53256900qtk.47.1558388685141;
        Mon, 20 May 2019 14:44:45 -0700 (PDT)
Received: from localhost.localdomain ([179.185.210.219])
        by smtp.gmail.com with ESMTPSA id t30sm11427530qtc.80.2019.05.20.14.44.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:44:44 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH 1/4] md: raid1-10: Unify r{1,10}bio_pool_free
Date:   Mon, 20 May 2019 18:44:24 -0300
Message-Id: <20190520214427.18729-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520214427.18729-1-marcos.souza.org@gmail.com>
References: <20190520214427.18729-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoiding duplicated code, since they just execute a kfree.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/raid1-10.c |  5 +++++
 drivers/md/raid1.c    | 13 ++++---------
 drivers/md/raid10.c   | 11 +++--------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 7d968bf08e54..54db34163968 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -34,6 +34,11 @@ struct resync_pages {
 	struct page	*pages[RESYNC_PAGES];
 };
 
+static void rbio_pool_free(void *rbio, void *data)
+{
+	kfree(rbio);
+}
+
 static inline int resync_alloc_pages(struct resync_pages *rp,
 				     gfp_t gfp_flags)
 {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bb052c35bf29..3787c7e45849 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -76,11 +76,6 @@ static void * r1bio_pool_alloc(gfp_t gfp_flags, void *data)
 	return kzalloc(size, gfp_flags);
 }
 
-static void r1bio_pool_free(void *r1_bio, void *data)
-{
-	kfree(r1_bio);
-}
-
 #define RESYNC_DEPTH 32
 #define RESYNC_SECTORS (RESYNC_BLOCK_SIZE >> 9)
 #define RESYNC_WINDOW (RESYNC_BLOCK_SIZE * RESYNC_DEPTH)
@@ -156,7 +151,7 @@ static void * r1buf_pool_alloc(gfp_t gfp_flags, void *data)
 	kfree(rps);
 
 out_free_r1bio:
-	r1bio_pool_free(r1_bio, data);
+	rbio_pool_free(r1_bio, data);
 	return NULL;
 }
 
@@ -176,7 +171,7 @@ static void r1buf_pool_free(void *__r1_bio, void *data)
 	/* resync pages array stored in the 1st bio's .bi_private */
 	kfree(rp);
 
-	r1bio_pool_free(r1bio, data);
+	rbio_pool_free(r1bio, data);
 }
 
 static void put_all_bios(struct r1conf *conf, struct r1bio *r1_bio)
@@ -2931,7 +2926,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 		goto abort;
 	conf->poolinfo->raid_disks = mddev->raid_disks * 2;
 	err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
-			   r1bio_pool_free, conf->poolinfo);
+			   rbio_pool_free, conf->poolinfo);
 	if (err)
 		goto abort;
 
@@ -3216,7 +3211,7 @@ static int raid1_reshape(struct mddev *mddev)
 	newpoolinfo->raid_disks = raid_disks * 2;
 
 	ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
-			   r1bio_pool_free, newpoolinfo);
+			   rbio_pool_free, newpoolinfo);
 	if (ret) {
 		kfree(newpoolinfo);
 		return ret;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 24cb116d950f..c0d9ee4311d4 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -107,11 +107,6 @@ static void * r10bio_pool_alloc(gfp_t gfp_flags, void *data)
 	return kzalloc(size, gfp_flags);
 }
 
-static void r10bio_pool_free(void *r10_bio, void *data)
-{
-	kfree(r10_bio);
-}
-
 #define RESYNC_SECTORS (RESYNC_BLOCK_SIZE >> 9)
 /* amount of memory to reserve for resync requests */
 #define RESYNC_WINDOW (1024*1024)
@@ -217,7 +212,7 @@ static void * r10buf_pool_alloc(gfp_t gfp_flags, void *data)
 	}
 	kfree(rps);
 out_free_r10bio:
-	r10bio_pool_free(r10_bio, conf);
+	rbio_pool_free(r10_bio, conf);
 	return NULL;
 }
 
@@ -245,7 +240,7 @@ static void r10buf_pool_free(void *__r10_bio, void *data)
 	/* resync pages array stored in the 1st bio's .bi_private */
 	kfree(rp);
 
-	r10bio_pool_free(r10bio, conf);
+	rbio_pool_free(r10bio, conf);
 }
 
 static void put_all_bios(struct r10conf *conf, struct r10bio *r10_bio)
@@ -3660,7 +3655,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	conf->geo = geo;
 	conf->copies = copies;
 	err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
-			   r10bio_pool_free, conf);
+			   rbio_pool_free, conf);
 	if (err)
 		goto out;
 
-- 
2.21.0

