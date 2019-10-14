Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F05ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055F320663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbfJNQoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:44:18 -0400
Received: from foss.arm.com ([217.140.110.172]:48774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfJNQoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:44:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF0C28;
        Mon, 14 Oct 2019 09:44:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (unknown [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD35B3F718;
        Mon, 14 Oct 2019 09:44:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, Dietmar.Eggemann@arm.com,
        morten.rasmussen@arm.com, seto.hidetoshi@jp.fujitsu.com,
        qperret@google.com
Subject: [PATCH] sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax
Date:   Mon, 14 Oct 2019 17:44:08 +0100
Message-Id: <20191014164408.32596-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out in commit

  182a85f8a119 ("sched: Disable wakeup balancing")

SD_BALANCE_WAKE is a tad too aggressive, and is usually left unset.

However, it turns out cpuset domain relaxation will unconditionally set it
on domains below the relaxation level. This made sense back when
SD_BALANCE_WAKE was set unconditionally, but it no longer is the case.

We can improve things slightly by noticing that set_domain_attribute() is
always called after sd_init(), so rather than setting flags we can rely on
whatever sd_init() is doing and only clear certain flags when above the
relaxation level.

While at it, slightly clean up the function and flip the relax level
check to be more human readable.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
I was tempted to put a

Fixes: 182a85f8a119 ("sched: Disable wakeup balancing")

but the SD setup code back then was a mess of SD_INIT() macros which I'm
not familiar with. It *looks* like the sequence was roughly the same as it
is now (i.e. set up domain flags, *then* call set_domain_attribute()) but
I'm not completely sure.
---
 kernel/sched/topology.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b5667a273bf6..3623ffe85d18 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1201,17 +1201,13 @@ static void set_domain_attribute(struct sched_domain *sd,
 	if (!attr || attr->relax_domain_level < 0) {
 		if (default_relax_domain_level < 0)
 			return;
-		else
-			request = default_relax_domain_level;
+		request = default_relax_domain_level;
 	} else
 		request = attr->relax_domain_level;
-	if (request < sd->level) {
+
+	if (sd->level > request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
-	} else {
-		/* Turn on idle balance on this domain: */
-		sd->flags |= (SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
 }
 
--
2.22.0

