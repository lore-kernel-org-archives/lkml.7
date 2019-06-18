Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D689C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F264206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3c4XTWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfFRQ7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:59:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37970 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfFRQ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:59:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id f98so381739plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRMDk2BAfRDYDNECYYhM1BfKg5f7KkTU03mHf+QYRbE=;
        b=C3c4XTWoNgJakO71gg1YUplJAt4MELRvc4yd0sAONMl1zgwrGjZnEgmulHFTBQtsSN
         zJpp3FK/4A8RkSgj+I8H445n9VaHxYRfCmIH0gPhLGCtErpM0MWqlZVhcbpKHNrhl9zt
         fmWkivPYggTvuFKel8SMOuNoFNFsUGzN3VEbtVEoUmtNjm3B5JBQqNCBm5vmpDbMP2Zn
         k65KS0bDEcOIdWrjoFEutjHusI6DMoxLTgv+qS5kPiJ4uq8jgLtcPuk7sq8Mi/itZvnw
         LFPS68lD5kUz0Qt4XTTqy4Icn0kXywtcQNIGwebC1xKwlCACmrugcYPeTpdlLpWT7M6y
         THlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRMDk2BAfRDYDNECYYhM1BfKg5f7KkTU03mHf+QYRbE=;
        b=TZgHrjpjySR0bGMuSgGmG9cZCuZYJFyymL29vm85S+FvgA7WyCa5GdYJMB8cbyedSw
         F64BbIg6WD+siF8Gj3w5sjK9sJr3/ecKI2MXhw50GA6LZC+LEC45lBDk+P7XbIahvrf0
         rCRvffOibFKJ55NhvimNztjghnIPiq9poSaMi/ZbSzUSWKk5ac2xm/tzIvqhpmw+IzWD
         5CCRhEhGktLdIf32UtEs9S1BiTA7OJ+wk0M6Y9d5y0Ju3/X4hrOf58vxaeQ6qQkM5d7Q
         7uG3/qDkf4VKTAEhIFllHnR17B7MmhLxxM+R+U2Sz4dFVo4cHNc0necq45vTdcjHP3WS
         XmRg==
X-Gm-Message-State: APjAAAXVdL2TICWgir+3yzSl9PaTamrTlaRG2x9fEh5Nm/Sno4a62+QZ
        Er1jBwXlEMG+NDwhVRZ5i/o=
X-Google-Smtp-Source: APXvYqwpWBjfeXR2nSPVbLHaFfOhqkDLRBzVuZj6BkNDNTEsIJKP1MGFkea5KKD3TI5XDk+hlKqOBA==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr30537867plb.270.1560877179452;
        Tue, 18 Jun 2019 09:59:39 -0700 (PDT)
Received: from localhost.localdomain ([112.196.181.128])
        by smtp.googlemail.com with ESMTPSA id r6sm3307678pji.0.2019.06.18.09.59.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 09:59:38 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Sched: Change type of 'overrun' from int to u64
Date:   Tue, 18 Jun 2019 22:29:08 +0530
Message-Id: <20190618165908.15012-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of hrtimer_forward_now() should save the return value in u64.
function sched_cfs_period_timer() stores
it in variable 'overrun' of type int
change type of overrun from int to u64 to solve the issue.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..c6bcae7d4e49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4896,7 +4896,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
 	unsigned long flags;
-	int overrun;
+	u64 overrun;
 	int idle = 0;
 	int count = 0;
 
-- 
2.21.0

