Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002AC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CD62189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 04:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vSdua536"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGDEek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 00:34:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47029 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfGDEej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 00:34:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so816626plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 21:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vbppYg/PV/7L5iaCilqYrS88KLuUxXV/tcBcygZ/DM=;
        b=vSdua536NKvlq/muYod+Jq39qhq9nRhECF2mZYOuyu5lZpriRV/S6tJYaf/Pw9PHZ/
         lZfpE7zfIuF/+6bGXZkeMn8jkyGBSRQMOOuZUffJGlRZL7Gou+fT1Ojz7VI/nnFKiI7m
         F5/Cov48q5JztOsOlW9D0/vvuOiRNNPKCdDC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7vbppYg/PV/7L5iaCilqYrS88KLuUxXV/tcBcygZ/DM=;
        b=J4O0WW/N31aFKszGyHsawE6SH31TnNbuKQ3KvTr78kg63U5+LOs7zkg6MN9KtbgN0C
         uV9ebo+k0U12a/o18n72TIgEim7d1TKGBtAswLmVjb+JLofcRBNyHCnAnNdTAS3OpxXt
         gtyGc7lr7b/Q5ntAL1ArPGUrRMP92g8gQziFwF/aTRVfiYmBUqf0XgA0kqwtPuM1mJME
         N01k7/q6Ox2THjc0AMK75ROs+jJ8Lq3mPhxG5fnkVGZh24Et4SPuvJFRgYhyVv+FkLci
         OZf35YZ19g5TJgk9ZmFDf57sfTfOIdBha1SIYqYD2aQOriMgAIuenDB2XRqaJygb1HFI
         /lmw==
X-Gm-Message-State: APjAAAW8yzHispDvtb9ZpTWAtrBJT4D2+Zo0yvVqrdSt5rh/feMenjYd
        1VA5v8pC35c5NqVHWLdY6lZQvZxfFW0=
X-Google-Smtp-Source: APXvYqwVb4pSb+wRU1yNknNpnD1K4ghm+jlabCGwIkOi0NNnKD1g3x6RkZi6gHlb7LQd044e3blFGg==
X-Received: by 2002:a17:902:a504:: with SMTP id s4mr32822885plq.117.1562214878674;
        Wed, 03 Jul 2019 21:34:38 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b24sm3837621pfd.98.2019.07.03.21.34.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 21:34:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Subject: [PATCH] rcuperf: Make rcuperf kernel test more robust for !expedited mode
Date:   Thu,  4 Jul 2019 00:34:30 -0400
Message-Id: <20190704043431.208689-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that the rcuperf kernel test runs concurrently with init
starting up.  During this time, the system is running all grace periods
as expedited.  However, rcuperf can also be run for normal GP tests.
Right now, it depends on a holdoff time before starting the test to
ensure grace periods start later. This works fine with the default
holdoff time however it is not robust in situations where init takes
greater than the holdoff time to finish running. Or, as in my case:

I modified the rcuperf test locally to also run a thread that did
preempt disable/enable in a loop. This had the effect of slowing down
init. The end result was that the "batches:" counter in rcuperf was 0
causing a division by 0 error in the results. This counter was 0 because
only expedited GPs seem to happen, not normal ones which led to the
rcu_state.gp_seq counter remaining constant across grace periods which
unexpectedly happen to be expedited. The system was running expedited
RCU all the time because rcu_unexpedited_gp() would not have run yet
from init.  In other words, the test would concurrently with init
booting in expedited GP mode.

To fix this properly, let us check if system_state if SYSTEM_RUNNING
is set before starting the test. The system_state approximately aligns
with when rcu_unexpedited_gp() is called and works well in practice.

I also tried late_initcall however it is still too early to be
meaningful for this case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuperf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 4513807cd4c4..5a879d073c1c 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -375,6 +375,14 @@ rcu_perf_writer(void *arg)
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
 
+	/*
+	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
+	 * so that RCU is not always expedited for normal GP tests.
+	 * The system_state test is approximate, but works well in practice.
+	 */
+	while (!gp_exp && system_state != SYSTEM_RUNNING)
+		schedule_timeout_uninterruptible(1);
+
 	t = ktime_get_mono_fast_ns();
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
-- 
2.22.0.410.gd8fdbe21b5-goog

