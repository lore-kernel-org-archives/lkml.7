Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A995CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDAC21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633946AbfJRMsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:48:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633907AbfJRMsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLRfu-00075v-U5; Fri, 18 Oct 2019 14:48:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 804081C009C;
        Fri, 18 Oct 2019 14:48:10 +0200 (CEST)
Date:   Fri, 18 Oct 2019 12:48:10 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Don't set SD_BALANCE_WAKE on cpuset
 domain relax
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        seto.hidetoshi@jp.fujitsu.com, qperret@google.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191014164408.32596-1-valentin.schneider@arm.com>
References: <20191014164408.32596-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157140289031.29376.17217031888705940708.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9ae7ab20b4835dbea0e5fc6a5c70171dc354a72e
Gitweb:        https://git.kernel.org/tip/9ae7ab20b4835dbea0e5fc6a5c70171dc354a72e
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 14 Oct 2019 17:44:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Oct 2019 21:31:54 +02:00

sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: mingo@kernel.org
Cc: vincent.guittot@linaro.org
Cc: juri.lelli@redhat.com
Cc: seto.hidetoshi@jp.fujitsu.com
Cc: qperret@google.com
Cc: Dietmar.Eggemann@arm.com
Cc: morten.rasmussen@arm.com
Link: https://lkml.kernel.org/r/20191014164408.32596-1-valentin.schneider@arm.com
---
 kernel/sched/topology.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b5667a2..3623ffe 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1201,16 +1201,13 @@ static void set_domain_attribute(struct sched_domain *sd,
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
 
