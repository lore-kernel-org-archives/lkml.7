Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BBBC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D86D218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8Jq1h8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfGEI4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:56:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44113 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfGEI4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:56:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so1211303plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YPlHtNgTN1G0od1SzkjELx9HewbPSo2GNnCAZJ9hb8=;
        b=E8Jq1h8pS4+Brm0rvsAfnwUSvN0RwgYU8sdYmdtRuWP21u1i+lCGYQL6/Y/sgCHfF9
         ZSnMGKSzXCSC9vsZmGDagepg0vPFU4yl22jxdN2k/SvpggYdlvY9QtKjjrAIYCT8bw8M
         2js32oP+jFjHueasQ5HbcSehBIaC/3usnew40IPZdfMgEDnBPTVDMU5rX6a78sRWhXBI
         k+byDQQgmqTOYGyfjWeCSQt3TuoaWoWlRgG3LfMrkUmuAyS9M+dhni/VIG/4Q88dbhXD
         Jve23Z7G4W1qWAaFb/Ym9pXjXCx9Jkw7SzaX0Gn6x3EhKu+0pO4sKIJ2U595pTn1pZWE
         4/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YPlHtNgTN1G0od1SzkjELx9HewbPSo2GNnCAZJ9hb8=;
        b=Ka+W3v/NmZ2e+RJ5K3B/FFGi5uSZRu/sfQRROiWG55ZRfv4BRLoAOqpauGu6E4d97p
         lF1PEvBBBY6yPujC8+tJ+GmAK/TMXU8Kw8Xcj7/z9XIpV6s9zCMvyCuVJp27XM421rl4
         TAhXZFgZO+lt8J7uC/N2cHGeUMgnGVtRG4hfyoDdwu939iyk1lNUSdQAEKwfPVqCo14s
         Uv0ODkmLJzdduNnpH+YKIofmy/v2GMGnNL1gfpMw9JG+AdgP1aWr/BFp+j1Svv7mVe8P
         IO30S7DD4Yx4A/OGEGEY0zFpTshLulMcbRDM2WxLyGzLaTKsDwsxhT4fCp4m+WNU6Qa5
         ih5Q==
X-Gm-Message-State: APjAAAV1owZBa2PNAInFyjWT07E2/hDlKw7szdZFhwBcGoz1eB8Bo7S9
        utwdCi5xHokrDfWGbnMqM0k=
X-Google-Smtp-Source: APXvYqyQBTT8qRZzKlQCeZ9irJTIkExtAyXVL/ZyLHGLSKUB5FFfj2IeI8Xcnd5OPKdaIfN8BzG1RQ==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr4140472plp.194.1562316990530;
        Fri, 05 Jul 2019 01:56:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7148:c4d0:6a65:6774:f88c:ebeb])
        by smtp.googlemail.com with ESMTPSA id n89sm19478906pjc.0.2019.07.05.01.56.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 01:56:29 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list:SCHEDULER),
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Sched: Change type of 'overrun' from int to u64
Date:   Fri,  5 Jul 2019 14:26:09 +0530
Message-Id: <20190705085609.24453-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of hrtimer_forward_now() should save the return value in u64.
function sched_rt_period_timer() stores
it in variable 'overrun' of type int
change type of overrun from int to u64 to solve the issue.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1e6b909dca36..f5d3893914f5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -19,7 +19,7 @@ static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 	struct rt_bandwidth *rt_b =
 		container_of(timer, struct rt_bandwidth, rt_period_timer);
 	int idle = 0;
-	int overrun;
+	u64 overrun;
 
 	raw_spin_lock(&rt_b->rt_runtime_lock);
 	for (;;) {
-- 
2.21.0

