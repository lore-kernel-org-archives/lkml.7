Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3761DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9FF2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRoMKFsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEILTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:19:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36481 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEILTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:19:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so1691417edx.3;
        Thu, 09 May 2019 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Svie9yUR/Ki3ERUJrCqza9pq7RGH5A+LU5XetAHZSY=;
        b=lRoMKFszdaZJXqdKVeaIsXxiaARvYZ0Yf1JHwCDUwRDmQuL9eCEjpJelCnhhWZsvzY
         yxj38hYULI9qscPUamGzBPjFQradK7txRfFQcDw9mv9eHdzDPQk5WxFMvtyjIW4wAC8Y
         xbib3RucZ9PZpigU012rkrGjQgbDMZb9wNpDq3S2bWezcO2CREUMgDbhQTbj/LspgqkZ
         7h3pDrtuwsF38yZIBbBY5idgTCUI0jtkHdMfK8xp+RnmtMuDzZEAVhLI2T+y/JoJbhPk
         GEi4Hk8yqCWjXC68CeZS56kDye5pB/LPj5daU/WcP0pPYPcUisL0+vP3J17GXjLPi8pJ
         EoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Svie9yUR/Ki3ERUJrCqza9pq7RGH5A+LU5XetAHZSY=;
        b=sDjOdK89nYlsMj4o0c5pO/UjlXqPXukGSwRcF9ql8W2O6d4aZsSZ+qqRgaRr4/RZU1
         jW1yufBhJBCF+IgeJM+7rVIyYzG/G5OAkCVwCGM7+OQC/mjglUgUU5zrarPLcGKPPlpe
         79mom8wtct3dlCalgE/oyY2N0UkQle8+/JJPhWXJ71MMF0OkvxpFuZ+FAX0DDieWSp0L
         ZaPZYb6AxBfA1OYEhZjlk5HHPc7YtHSfoSZuqFFS9zJXO2DVhZ+r52wr2tgBwCVs109U
         pfDWN9gV0E71zWryxisZcLaoQ43bjoRcei2wUnDZwo7LqmnMZwYgXHZfXd4PtmbLynyy
         Uddg==
X-Gm-Message-State: APjAAAV5h7ZidImViu4LmP7qFCqKLGm/sQoZQraVPvpBkZUmRMGxMTNh
        fDwlXycrZNL578skmXR5QiE2JfmE
X-Google-Smtp-Source: APXvYqyrKGN7RnGuN/OiBPlVnzUaz82ehvNxbBnu8pq6PN5SG9ycY6kGXiNHW8M/Nxz2rnpxRS98FA==
X-Received: by 2002:a17:906:2447:: with SMTP id a7mr2693190ejb.235.1557400747703;
        Thu, 09 May 2019 04:19:07 -0700 (PDT)
Received: from geeko.suse.cz (189.114.218.127.dynamic.adsl.gvt.net.br. [189.114.218.127])
        by smtp.gmail.com with ESMTPSA id j3sm290382edh.82.2019.05.09.04.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:19:05 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     neilb@suse.com, Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH] drivers: md: Unify common definitions of raid1 and raid10
Date:   Thu,  9 May 2019 08:18:49 -0300
Message-Id: <20190509111849.22927-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These definitions are being moved to raid1-10.c.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/raid1-10.c | 25 +++++++++++++++++++++++++
 drivers/md/raid1.c    | 29 ++---------------------------
 drivers/md/raid10.c   | 27 +--------------------------
 3 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 400001b815db..7d968bf08e54 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -3,6 +3,31 @@
 #define RESYNC_BLOCK_SIZE (64*1024)
 #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
 
+/*
+ * Number of guaranteed raid bios in case of extreme VM load:
+ */
+#define	NR_RAID_BIOS 256
+
+/* when we get a read error on a read-only array, we redirect to another
+ * device without failing the first device, or trying to over-write to
+ * correct the read error.  To keep track of bad blocks on a per-bio
+ * level, we store IO_BLOCKED in the appropriate 'bios' pointer
+ */
+#define IO_BLOCKED ((struct bio *)1)
+/* When we successfully write to a known bad-block, we need to remove the
+ * bad-block marking which must be done from process context.  So we record
+ * the success by setting devs[n].bio to IO_MADE_GOOD
+ */
+#define IO_MADE_GOOD ((struct bio *)2)
+
+#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
+
+/* When there are this many requests queue to be written by
+ * the raid thread, we become 'congested' to provide back-pressure
+ * for writeback.
+ */
+static int max_queued_requests = 1024;
+
 /* for managing resync I/O pages */
 struct resync_pages {
 	void		*raid_bio;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0c8a098d220e..bb052c35bf29 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -50,31 +50,6 @@
 	 (1L << MD_HAS_PPL) |		\
 	 (1L << MD_HAS_MULTIPLE_PPLS))
 
-/*
- * Number of guaranteed r1bios in case of extreme VM load:
- */
-#define	NR_RAID1_BIOS 256
-
-/* when we get a read error on a read-only array, we redirect to another
- * device without failing the first device, or trying to over-write to
- * correct the read error.  To keep track of bad blocks on a per-bio
- * level, we store IO_BLOCKED in the appropriate 'bios' pointer
- */
-#define IO_BLOCKED ((struct bio *)1)
-/* When we successfully write to a known bad-block, we need to remove the
- * bad-block marking which must be done from process context.  So we record
- * the success by setting devs[n].bio to IO_MADE_GOOD
- */
-#define IO_MADE_GOOD ((struct bio *)2)
-
-#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
-
-/* When there are this many requests queue to be written by
- * the raid1 thread, we become 'congested' to provide back-pressure
- * for writeback.
- */
-static int max_queued_requests = 1024;
-
 static void allow_barrier(struct r1conf *conf, sector_t sector_nr);
 static void lower_barrier(struct r1conf *conf, sector_t sector_nr);
 
@@ -2955,7 +2930,7 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 	if (!conf->poolinfo)
 		goto abort;
 	conf->poolinfo->raid_disks = mddev->raid_disks * 2;
-	err = mempool_init(&conf->r1bio_pool, NR_RAID1_BIOS, r1bio_pool_alloc,
+	err = mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
 			   r1bio_pool_free, conf->poolinfo);
 	if (err)
 		goto abort;
@@ -3240,7 +3215,7 @@ static int raid1_reshape(struct mddev *mddev)
 	newpoolinfo->mddev = mddev;
 	newpoolinfo->raid_disks = raid_disks * 2;
 
-	ret = mempool_init(&newpool, NR_RAID1_BIOS, r1bio_pool_alloc,
+	ret = mempool_init(&newpool, NR_RAID_BIOS, r1bio_pool_alloc,
 			   r1bio_pool_free, newpoolinfo);
 	if (ret) {
 		kfree(newpoolinfo);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 3b6880dd648d..24cb116d950f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -73,31 +73,6 @@
  *    [B A] [D C]    [B A] [E C D]
  */
 
-/*
- * Number of guaranteed r10bios in case of extreme VM load:
- */
-#define	NR_RAID10_BIOS 256
-
-/* when we get a read error on a read-only array, we redirect to another
- * device without failing the first device, or trying to over-write to
- * correct the read error.  To keep track of bad blocks on a per-bio
- * level, we store IO_BLOCKED in the appropriate 'bios' pointer
- */
-#define IO_BLOCKED ((struct bio *)1)
-/* When we successfully write to a known bad-block, we need to remove the
- * bad-block marking which must be done from process context.  So we record
- * the success by setting devs[n].bio to IO_MADE_GOOD
- */
-#define IO_MADE_GOOD ((struct bio *)2)
-
-#define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
-
-/* When there are this many requests queued to be written by
- * the raid10 thread, we become 'congested' to provide back-pressure
- * for writeback.
- */
-static int max_queued_requests = 1024;
-
 static void allow_barrier(struct r10conf *conf);
 static void lower_barrier(struct r10conf *conf);
 static int _enough(struct r10conf *conf, int previous, int ignore);
@@ -3684,7 +3659,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 
 	conf->geo = geo;
 	conf->copies = copies;
-	err = mempool_init(&conf->r10bio_pool, NR_RAID10_BIOS, r10bio_pool_alloc,
+	err = mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc,
 			   r10bio_pool_free, conf);
 	if (err)
 		goto out;
-- 
2.21.0

