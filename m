Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A75207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520329;
	bh=Ltm3WPzjFODL+q4vxM3aPHEEioyW6r2iui2xqS0cdJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UefbaNwCiVOSI5x2/K3B5jTzeF9y8KSxataYr3WqboM3ELDT5zoVjrdfiXQZjTKv1
	 rE/jO4HKHrXK7E96ttPCBQ1YPYkMVa+nNrP+X4YVVtMxo7GnaGCbX/EwKDkDjq9g02
	 KNHE9I1yqOjflei8eXHo6k2TrhMKKhg+5fDFaHW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfLPSSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731836AbfLPSSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:18:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF573206EC;
        Mon, 16 Dec 2019 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520320;
        bh=Ltm3WPzjFODL+q4vxM3aPHEEioyW6r2iui2xqS0cdJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbXYgoSZYTqV7X5UJiRBu4dNAYZLmiciWNlovGQ/DDwzcPkKG8/VUVxSXNQ3+1vHG
         epwpbnX5M+EFg4EW6ahemALU4uNf8rs8FlVXPaWxs6uOG0CFFTCyTg86YqZYNUM8WH
         te0oZFjZz24o+n3l5OTLzK53bjGrfwqoPU+mvnFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 106/177] cpuidle: teo: Rename local variable in teo_select()
Date:   Mon, 16 Dec 2019 18:49:22 +0100
Message-Id: <20191216174841.562660829@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 4f690bb8ce4cc5d3fabe3a8e9c2401de1554cdc1 upstream.

Rename a local variable in teo_select() in preparation for subsequent
code modifications, no intentional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.1+ <stable@vger.kernel.org> # 5.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/governors/teo.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -233,7 +233,7 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
-	unsigned int duration_us, count;
+	unsigned int duration_us, early_hits;
 	int max_early_idx, constraint_idx, idx, i;
 	ktime_t delta_tick;
 
@@ -247,7 +247,7 @@ static int teo_select(struct cpuidle_dri
 	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
-	count = 0;
+	early_hits = 0;
 	max_early_idx = -1;
 	constraint_idx = drv->state_count;
 	idx = -1;
@@ -270,12 +270,12 @@ static int teo_select(struct cpuidle_dri
 			 * into account, because it would be a mistake to select
 			 * a deeper state with lower "early hits" metric.  The
 			 * index cannot be changed to point to it, however, so
-			 * just increase the max count alone and let the index
-			 * still point to a shallower idle state.
+			 * just increase the "early hits" count alone and let
+			 * the index still point to a shallower idle state.
 			 */
 			if (max_early_idx >= 0 &&
-			    count < cpu_data->states[i].early_hits)
-				count = cpu_data->states[i].early_hits;
+			    early_hits < cpu_data->states[i].early_hits)
+				early_hits = cpu_data->states[i].early_hits;
 
 			continue;
 		}
@@ -291,10 +291,10 @@ static int teo_select(struct cpuidle_dri
 
 		idx = i;
 
-		if (count < cpu_data->states[i].early_hits &&
+		if (early_hits < cpu_data->states[i].early_hits &&
 		    !(tick_nohz_tick_stopped() &&
 		      drv->states[i].target_residency < TICK_USEC)) {
-			count = cpu_data->states[i].early_hits;
+			early_hits = cpu_data->states[i].early_hits;
 			max_early_idx = i;
 		}
 	}
@@ -323,10 +323,9 @@ static int teo_select(struct cpuidle_dri
 	if (idx < 0) {
 		idx = 0; /* No states enabled. Must use 0. */
 	} else if (idx > 0) {
+		unsigned int count = 0;
 		u64 sum = 0;
 
-		count = 0;
-
 		/*
 		 * Count and sum the most recent idle duration values less than
 		 * the current expected idle duration value.


