Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0921882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne9mmSOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKGURU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46629 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKGURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so4498324wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/opqRnW7mjWd271JJZcuLRT2Lb4Wp0fV1/zJUBsf+Y=;
        b=ne9mmSOfGkk5Y32hWFtONWWsmIM6mTY5QO445acSLVvqUN6Zu/45H+2vjLokJMrQnJ
         CffvUybm7kU9O1IBsUoR14V1nkNOidakqp4r6dXlXloZv5VmaD0bOGFblQC4hpejoA45
         ClKCVPEmxlsGBuzSb4eyipp6TKpjYw/wMQ15udpflXFruBkMjppJC+cseXXN7b64rRBS
         7UOGuKbJu288ebTc8duWSW+61vLZ2mEnZI/exCueQWFTr86iGZnA0RBja4FdgAemBU+O
         lzqFaB8k6yNZA6ZoehgPYTFuG09Belb7Rl1KYo2cEBfdIdsZ9DNxavs3iLIUrphe92Vu
         1zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/opqRnW7mjWd271JJZcuLRT2Lb4Wp0fV1/zJUBsf+Y=;
        b=n9GPCuEuJNTYqDo1kMXCC50skZec0rUOhYNtymrrLcChqFqBq69MJOoJpp/Mld/Hb4
         HZdmWULao0iJRg6PIZZecMELcX+ORVqfetIUmCb2jnzOUikBpTifWab9/epFTOGGFxtV
         zdUf2N+RblQSb5eTUZq4xZ2kwZH5fecHaub/pcOcCmUo2oG4CSiRSr+ZPsEf0nRjehaE
         ONxXHusFGGyI6Eh0lk9oMwhpcGyfTw6+VpQXpCpBa0BzFj1e91eWg2eg3woT4A2zN8TQ
         qPjaW7dFMyi+vPzvqRUcaY7Sc/nbMox8yYnvNfACHc+TmNfLphYl2+0mjGdBbCKRtoCv
         QrnA==
X-Gm-Message-State: APjAAAVQJrsK7o0rcmnUVxUJ9EziLcSh5n7wm2qGq9Zz59sKOmLd6bX6
        4y/dvE0msTuyB2E2DCl9VXvAHg==
X-Google-Smtp-Source: APXvYqyyjcITWBzH0Dzq6p8czJPlGmkRNJ5gNj8J2RJV66DTzp4cH3p+YQPaSfdSy5SCVYQ8JJvrrg==
X-Received: by 2002:a05:6000:11c4:: with SMTP id i4mr4682337wrx.277.1573157832439;
        Thu, 07 Nov 2019 12:17:12 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/10] md: fix for divide error in status_resync
Date:   Thu,  7 Nov 2019 20:16:59 +0000
Message-Id: <20191107201702.27023-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>

[ Upstream commit 9642fa73d073527b0cbc337cc17a47d545d82cd2 ]

Stopping external metadata arrays during resync/recovery causes
retries, loop of interrupting and starting reconstruction, until it
hit at good moment to stop completely. While these retries
curr_mark_cnt can be small- especially on HDD drives, so subtraction
result can be smaller than 0. However it is casted to uint without
checking. As a result of it the status bar in /proc/mdstat while stopping
is strange (it jumps between 0% and 99%).

The real problem occurs here after commit 72deb455b5ec ("block: remove
CONFIG_LBDAF"). Sector_div() macro has been changed, now the
divisor is casted to uint32. For db = -8 the divisior(db/32-1) becomes 0.

Check if db value can be really counted and replace these macro by
div64_u64() inline.

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: If2744cff07135d0c1fa5f55bcec36ab2137b841e
---
 drivers/md/md.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ba201db6afce..9a84a74747f8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6701,9 +6701,9 @@ static void status_unused(struct seq_file *seq)
 static void status_resync(struct seq_file *seq, struct mddev *mddev)
 {
 	sector_t max_sectors, resync, res;
-	unsigned long dt, db;
-	sector_t rt;
-	int scale;
+	unsigned long dt, db = 0;
+	sector_t rt, curr_mark_cnt, resync_mark_cnt;
+	int scale, recovery_active;
 	unsigned int per_milli;
 
 	if (mddev->curr_resync <= 3)
@@ -6759,22 +6759,30 @@ static void status_resync(struct seq_file *seq, struct mddev *mddev)
 	 * db: blocks written from mark until now
 	 * rt: remaining time
 	 *
-	 * rt is a sector_t, so could be 32bit or 64bit.
-	 * So we divide before multiply in case it is 32bit and close
-	 * to the limit.
-	 * We scale the divisor (db) by 32 to avoid losing precision
-	 * near the end of resync when the number of remaining sectors
-	 * is close to 'db'.
-	 * We then divide rt by 32 after multiplying by db to compensate.
-	 * The '+1' avoids division by zero if db is very small.
+	 * rt is a sector_t, which is always 64bit now. We are keeping
+	 * the original algorithm, but it is not really necessary.
+	 *
+	 * Original algorithm:
+	 *   So we divide before multiply in case it is 32bit and close
+	 *   to the limit.
+	 *   We scale the divisor (db) by 32 to avoid losing precision
+	 *   near the end of resync when the number of remaining sectors
+	 *   is close to 'db'.
+	 *   We then divide rt by 32 after multiplying by db to compensate.
+	 *   The '+1' avoids division by zero if db is very small.
 	 */
 	dt = ((jiffies - mddev->resync_mark) / HZ);
 	if (!dt) dt++;
-	db = (mddev->curr_mark_cnt - atomic_read(&mddev->recovery_active))
-		- mddev->resync_mark_cnt;
+
+	curr_mark_cnt = mddev->curr_mark_cnt;
+	recovery_active = atomic_read(&mddev->recovery_active);
+	resync_mark_cnt = mddev->resync_mark_cnt;
+
+	if (curr_mark_cnt >= (recovery_active + resync_mark_cnt))
+		db = curr_mark_cnt - (recovery_active + resync_mark_cnt);
 
 	rt = max_sectors - resync;    /* number of remaining sectors */
-	sector_div(rt, db/32+1);
+	rt = div64_u64(rt, db/32+1);
 	rt *= dt;
 	rt >>= 5;
 
-- 
2.24.0

