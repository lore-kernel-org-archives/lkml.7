Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC78CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D45E2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UENcTL2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfECKtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:49:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfECKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:49:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x43AnJbC2712238
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 3 May 2019 03:49:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x43AnJbC2712238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556880559;
        bh=0cnvGg+UeSyvhKAhXJ2jh4wDLA866r9NS2e8y4/1NDY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UENcTL2r/iIMPysGiAChtdWM2vCG7Axy507dLK+5yPXzkF7VJRDwcIPFIHm7sNkNE
         ZRkEuUZFe+Wsj7lUus7NCE75rwqlVswud4wikTdpqZA6B1lSie9ILuutoRKlH+IJdb
         g6omLtLvyJO1A5qeuYt3yptAi1vg5g/1zqA8SnHWQNhMNUlrg/l1G5ttAxWBpOKgSu
         mWIcMFhfkM9tuOIRE49YEVRLY3tAO50Odj4YVRDTgUMjJinIWGuxiCytHOlL9yfWbJ
         kWvkTA2I5Sly5nRbOWYVsjfsm+4fibdD2aKbv8c/0RnYdGs9JeUk2xKuWyH312gfn8
         +E/MmLDPYll4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x43AnIjn2712235;
        Fri, 3 May 2019 03:49:18 -0700
Date:   Fri, 3 May 2019 03:49:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-26ae4f4406f88d82d79c85c11ac5fae18213cd38@git.kernel.org>
Cc:     eranian@google.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, vincent.weaver@maine.edu, ammy.yi@intel.com,
        a.p.zijlstra@chello.nl, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Reply-To: eranian@google.com, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, ammy.yi@intel.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
          torvalds@linux-foundation.org, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl
In-Reply-To: <20190503085536.24119-2-alexander.shishkin@linux.intel.com>
References: <20190503085536.24119-2-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ring_buffer: Fix AUX software double
 buffering
Git-Commit-ID: 26ae4f4406f88d82d79c85c11ac5fae18213cd38
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  26ae4f4406f88d82d79c85c11ac5fae18213cd38
Gitweb:     https://git.kernel.org/tip/26ae4f4406f88d82d79c85c11ac5fae18213cd38
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Fri, 3 May 2019 11:55:35 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 3 May 2019 12:46:10 +0200

perf/ring_buffer: Fix AUX software double buffering

This recent commit:

  5768402fd9c6e87 ("perf/ring_buffer: Use high order allocations for AUX buffers optimistically")

overlooked the fact that the previous one page granularity of the AUX buffer
provided an implicit double buffering capability to the PMU driver, which
went away when the entire buffer became one high-order page.

Always make the full-trace mode AUX allocation at least two-part to preserve
the previous behavior and allow the implicit double buffering to continue.

Reported-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: adrian.hunter@intel.com
Fixes: 5768402fd9c6e87 ("perf/ring_buffer: Use high order allocations for AUX buffers optimistically")
Link: http://lkml.kernel.org/r/20190503085536.24119-2-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5eedb49a65ea..674b35383491 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -610,8 +610,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	 * PMU requests more than one contiguous chunks of memory
 	 * for SW double buffering
 	 */
-	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_SW_DOUBLEBUF) &&
-	    !overwrite) {
+	if (!overwrite) {
 		if (!max_order)
 			return -EINVAL;
 
