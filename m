Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B898C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FD920651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011884;
	bh=gLhcLb24+hu8Id2jLHg2jY0IJZHzomjJkTqE7MI4mjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pTieRFOAnyJ6LpuX7d9+85bALwtGHcKJzhaPcS1nCjusm4tlpTv9uxuFhLCdw2opR
	 v4lxgj5ZEkENs2Ha/kx8mfcCOGCb4p52kTu7n/xUyM3LGuvYcYnVObqndKbOLnSMQu
	 234DBrr9hRkGif4hyqPJha82Juzf3iOp3VZAudLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfHENbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729755AbfHENbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:31:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEAF1ACB4;
        Mon,  5 Aug 2019 13:31:20 +0000 (UTC)
Date:   Mon, 5 Aug 2019 15:31:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190805133119.GO7597@dhcp22.suse.cz>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-08-19 14:13:16, Vlastimil Babka wrote:
> On 8/4/19 11:23 AM, Artem S. Tashkinov wrote:
> > Hello,
> > 
> > There's this bug which has been bugging many people for many years
> > already and which is reproducible in less than a few minutes under the
> > latest and greatest kernel, 5.2.6. All the kernel parameters are set to
> > defaults.
> > 
> > Steps to reproduce:
> > 
> > 1) Boot with mem=4G
> > 2) Disable swap to make everything faster (sudo swapoff -a)
> > 3) Launch a web browser, e.g. Chrome/Chromium or/and Firefox
> > 4) Start opening tabs in either of them and watch your free RAM decrease
> > 
> > Once you hit a situation when opening a new tab requires more RAM than
> > is currently available, the system will stall hard. You will barely  be
> > able to move the mouse pointer. Your disk LED will be flashing
> > incessantly (I'm not entirely sure why). You will not be able to run new
> > applications or close currently running ones.
> 
> > This little crisis may continue for minutes or even longer. I think
> > that's not how the system should behave in this situation. I believe
> > something must be done about that to avoid this stall.
> 
> Yeah that's a known problem, made worse SSD's in fact, as they are able
> to keep refaulting the last remaining file pages fast enough, so there
> is still apparent progress in reclaim and OOM doesn't kick in.
> 
> At this point, the likely solution will be probably based on pressure
> stall monitoring (PSI). I don't know how far we are from a built-in
> monitor with reasonable defaults for a desktop workload, so CCing
> relevant folks.

Another potential approach would be to consider the refault information
we have already for file backed pages. Once we start reclaiming only
workingset pages then we should be trashing, right? It cannot be as
precise as the cost model which can be defined around PSI but it might
give us at least a fallback measure.

This is a really just an idea for a primitive detection. Most likely
incorrect one but it shows an idea at least. It is completely untested
and might be completely broken so unless somebody is really brave and
doesn't run anything that would be missed then I do not recommend to run
it.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 70394cabaf4e..7f30c78b4fbc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -300,6 +300,7 @@ struct lruvec {
 	atomic_long_t			inactive_age;
 	/* Refaults at the time of last reclaim cycle */
 	unsigned long			refaults;
+	atomic_t			workingset_refaults;
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4bfb5c4ac108..4401753c3912 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -311,6 +311,15 @@ void *workingset_eviction(struct page *page);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
 
+bool lruvec_trashing(struct lruvec *lruvec)
+{
+	/*
+	 * One quarter of the inactive list is constantly refaulting.
+	 * This suggests that we are trashing.
+	 */
+	return 4 * atomic_read(&lruvec->workingset_refaults) > lruvec_lru_size(lruvec, LRU_INACTIVE_FILE, MAX_NR_ZONES);
+}
+
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
 #define mapping_set_update(xas, mapping) do {				\
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7889f583ced9..d198594af0cd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2381,6 +2381,11 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 						  denominator);
 			break;
 		case SCAN_FILE:
+			if (lruvec_trashing(lruvec)) {
+				size = 0;
+				scan = 0;
+				break;
+			}
 		case SCAN_ANON:
 			/* Scan one type exclusively */
 			if ((scan_balance == SCAN_FILE) != file) {
diff --git a/mm/workingset.c b/mm/workingset.c
index e0b4edcb88c8..ee4c45b27e34 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -309,17 +309,25 @@ void workingset_refault(struct page *page, void *shadow)
 	 * don't act on pages that couldn't stay resident even if all
 	 * the memory was available to the page cache.
 	 */
-	if (refault_distance > active_file)
+	if (refault_distance > active_file) {
+		atomic_set(&lruvec->workingset_refaults, 0);
 		goto out;
+	}
 
 	SetPageActive(page);
 	atomic_long_inc(&lruvec->inactive_age);
 	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
+	atomic_inc(&lruvec->workingset_refaults);
 
 	/* Page was active prior to eviction */
 	if (workingset) {
 		SetPageWorkingset(page);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
+		/*
+		 * Double the trashing numbers for the actual working set.
+		 * refaults
+		 */
+		atomic_inc(&lruvec->workingset_refaults);
 	}
 out:
 	rcu_read_unlock();
-- 
Michal Hocko
SUSE Labs
