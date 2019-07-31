Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7887BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985521773
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfGaKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:37:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33591 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfGaKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:37:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so69200325wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k8iV1zA5X3Fl6os5LyVIh5yLsEGaYfREzD+XcT87bP0=;
        b=HlX7JeTG3wxQGyIoLAfrdcJ/95IjAhtbeZWY7Lpv5ySkRNKfYbVzzHKm23RYkmw7G3
         gT93IRa8Ph83/4OhV+0R9XZgPfJQt6S9o7kDCvKorlCFS9F4WwTMLoViUJiH+D3m2Cop
         I5OSFEzdneelNPil+emcOLhg8/j1HYc16GoSTfa8JMlnn1veus/7J4xgBvn0/SNJX58j
         uKlYFmtEPvWogUaQrexb7HO/Wt2vQSoqtmF1KTEytN8r4QWvgw9O+GgoQ9wYR3B6E3Uf
         LV0ZMFVi915gIbLu+yyn4LcDm19BpJXLQOOWUoN9y+oejBhALiSRRQrAqavCA5VwlTA1
         fhFA==
X-Gm-Message-State: APjAAAWZ8APB59CRT+bBt65ew3CTk8mraPhqIKepl+wVFVV099McEYBk
        Hm+QPsLe2MOADA6C7akr3JuOow==
X-Google-Smtp-Source: APXvYqzD5GnZ2oX3ivmVwh9gHiLMdPlFIqAWZvrVxayj9sB0Cvqa9vaVFTrf5abCsI1zTL6R9RzbFw==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr5644912wrp.188.1564569458406;
        Wed, 31 Jul 2019 03:37:38 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id s2sm55015229wmj.33.2019.07.31.03.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 03:37:37 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RT PATCH] sched/deadline: Make inactive timer run in hardirq context
Date:   Wed, 31 Jul 2019 12:37:15 +0200
Message-Id: <20190731103715.4047-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCHED_DEADLINE inactive timer needs to run in hardirq context (as
dl_task_timer already does).

Make it HRTIMER_MODE_REL_HARD.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

Both v4.19-rt and v5.2-rt need this.

Mainline "sched: Mark hrtimers to expire in hard interrupt context"
series needs this as well (20190726185753.077004842@linutronix.de in
particular). Do I need to send out a separate patch for it?

Best,

Juri
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1794e152d888..0889674b8915 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1292,7 +1292,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	timer->function = inactive_task_timer;
 }
 
-- 
2.17.2

