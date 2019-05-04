Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61C1C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897DF206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="PPjUpdKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfEDSjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 14:39:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39107 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbfEDSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id q10so7855578ljc.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBdLqqjxHYW1kPxTWduoEbxzX4ezRJnZs+qJaWu8u0g=;
        b=PPjUpdKacIp//54A2oxSBs5bIvajIMm64RqVN4Q4vAhHm/De9tBhlkLSakFvnd6uDv
         o3JXQ4lbofIh/KDTqwXp+ukg+2YQhgL32epNhZdE+hnMSXX5CEk3L0ULMxo+SOoUn1Ky
         37IJC4UXcC82lguF/1uGywsCAzVz7VAQhSnTHpQBqn1lkHmqWqVlWqdJFgySb0VTvMfq
         sHt8p6eIs3X74RdqgSSHquC1r4Sc1K1DmTgM2J7h6PEp2LeVU7W5jZTxKHPhF7Tm+RLJ
         hpSbfFnIvryod8qpl8n+n4K4bmTdw2Amaf5L7EX1mF4o8KYEIOcr20ClW5ddG25hbuzv
         VHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBdLqqjxHYW1kPxTWduoEbxzX4ezRJnZs+qJaWu8u0g=;
        b=o4FMD+ywi9GK0Q+NCuhGf+5V+jyt7yB/pPSSDk4zpd20aNKFT83IDR9TrTTmt0lz0x
         bku4IjMT5efkixrH7j/6iwGqMjvDGsjeuvrS54accDKYDnz+SNGRp8SqB2FK8yxz5NYa
         tVwvKG0Hu9HBizf1XW6mgwe/RnCw7X0m02fYj5BGNb5PF62WCUPPx4jomuK0P3ilSqYx
         EbXqZV2HkNhcM1fckjpY2rg9OrrBRy1WPIeuwn/QXVUei9QJxVIq3H/qmLTpI7sFdw0a
         qcIiwOsV4au5vd8o6zBdh5kterrRS8bzGPeASE3uSO4NKv70NkHjJGYSxHuhzHNbuIMq
         RYhA==
X-Gm-Message-State: APjAAAVZCoVspkzkAF271wmHMEozlk0eymzfrXcaczSetivG6LGtDGbG
        uvdwYvG+NtYqvyWkZZMkCn4cyZHdKpGq0Q==
X-Google-Smtp-Source: APXvYqzWu/9GP2ZfVfk3sRZgZtiBYoyyeB0U+biuKsIrGpFGGm1QOnjaxoYERtKJTFPlXTn3yc7qSw==
X-Received: by 2002:a2e:309:: with SMTP id 9mr9388943ljd.114.1556995122282;
        Sat, 04 May 2019 11:38:42 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:41 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 17/26] lightnvm: pblk: propagate errors when reading meta
Date:   Sat,  4 May 2019 20:38:02 +0200
Message-Id: <20190504183811.18725-18-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Read errors are not correctly propagated. Errors are cleared before
returning control to the io submitter. Change the behaviour such that
all read errors exept high ecc read warning status is returned
appropriately.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 9 +++++++--
 drivers/lightnvm/pblk-recovery.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 39280c1e9b5d..38e26fe23138 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -761,8 +761,10 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
 
 	atomic_dec(&pblk->inflight_io);
 
-	if (rqd.error)
+	if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
 		pblk_log_read_err(pblk, &rqd);
+		ret = -EIO;
+	}
 
 clear_rqd:
 	pblk_free_rqd_meta(pblk, &rqd);
@@ -916,8 +918,11 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
 
 	atomic_dec(&pblk->inflight_io);
 
-	if (rqd.error)
+	if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
 		pblk_log_read_err(pblk, &rqd);
+		ret = -EIO;
+		goto free_rqd_dma;
+	}
 
 	emeta_buf += rq_len;
 	left_ppas -= rq_ppas;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 357e52980f2f..124d8179b2ad 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -458,7 +458,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	atomic_dec(&pblk->inflight_io);
 
 	/* If a read fails, do a best effort by padding the line and retrying */
-	if (rqd->error) {
+	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
 		int pad_distance, ret;
 
 		if (padded) {
-- 
2.19.1

