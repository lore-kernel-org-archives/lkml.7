Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E4DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A51521848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWNLLt4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfJIQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:49:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40739 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfJIQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:49:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so3204302ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkGcyVg51H0E4AFHBmfSaZnSH8nue7geHmrbA1SXwgw=;
        b=uWNLLt4FV01tXR42m0BzyJwNl1r244JLyctfZn3BKgVSv8nrE2xMlQExCd8KFyjmoT
         tJoDvZUsuEvEO0Rvk/HUBFEgScUx4csk/VmA86Bc5NqNo6fPkq4jZqzLJt8iWhfGWGce
         aJZS8y2YAas3LDhAcmUNE26ifi+pxy8q6uMFEM+yzfkPhD6EnwTDFLALmpPCBQenMJl5
         YHYgJjgPku/rq/0eVi8SZ37AJBvyxjMZ8NrE+279ZX8itZqCjZCCzaePaY94FCu7QpmB
         Yxp2cxCQvJLKAv/vHf8g2j9RcaaWr4oTu8USsy6m4DBdniUQFhbvkVJTCDrN/XnYT2ki
         VYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SkGcyVg51H0E4AFHBmfSaZnSH8nue7geHmrbA1SXwgw=;
        b=gajKbmAegbugukBqBPtQ+uJ/yhUc9SNZhVTe3Fd4j8P7CB8meEZwc9459DBrV/OlZL
         ADgtbjgp6RKG4D5V7LYmZAHiEc8AGN97yiWz9fdM8g5parbJBHFMSVmWvg5npdr8yW5h
         YgcUdUYkXX4GUeG7Cpbprv8GmpThpqPPK+3P6HP7LEDGbx8zE3YsnTXSyyZJA1fNa4Jq
         AlwPiVOsLdlVytUl4NT611TXL4qGQhv4lUSegZBeNPG+pT0461wp7eHdaKzilGAPofmJ
         PxEh90PIrYIYNi240AhS2i/CNLVDENe9IWI7XOoMPjNve1iE5pG6EenmowP2gW9uZtIG
         JBFw==
X-Gm-Message-State: APjAAAV/X6oEoMtc2YLtKpAYkLL7zDZu3iWxTvEnGZUTQyxnTTt/t3sA
        HFOx+pOauuXlgIcWyQi66GA=
X-Google-Smtp-Source: APXvYqx8NBaZTGpzzgmaw4+w/0S+bRs+h195tjNsjKyxhK3dLzZj0MM8Vr8WJWzs4oe58eU6g9n1Ag==
X-Received: by 2002:a05:651c:105c:: with SMTP id x28mr3057983ljm.114.1570639785225;
        Wed, 09 Oct 2019 09:49:45 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h5sm623557ljf.83.2019.10.09.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 09:49:44 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do preloading
Date:   Wed,  9 Oct 2019 18:49:34 +0200
Message-Id: <20191009164934.10166-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of preempt_disable() and preempt_enable() when the
preload is done for splitting purpose. The reason is that
calling spin_lock() with disabled preemtion is forbidden in
CONFIG_PREEMPT_RT kernel.

Therefore, we do not guarantee that a CPU is preloaded, instead
we minimize the case when it is not with this change.

For example i run the special test case that follows the preload
pattern and path. 20 "unbind" threads run it and each does
1000000 allocations. Only 3.5 times among 1000000 a CPU was
not preloaded thus. So it can happen but the number is rather
negligible.

Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e92ff5f7dd8b..2ed6fef86950 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1078,9 +1078,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 retry:
 	/*
-	 * Preload this CPU with one extra vmap_area object to ensure
-	 * that we have it available when fit type of free area is
-	 * NE_FIT_TYPE.
+	 * Preload this CPU with one extra vmap_area object. It is used
+	 * when fit type of free area is NE_FIT_TYPE. Please note, it
+	 * does not guarantee that an allocation occurs on a CPU that
+	 * is preloaded, instead we minimize the case when it is not.
+	 * It can happen because of migration, because there is a race
+	 * until the below spinlock is taken.
 	 *
 	 * The preload is done in non-atomic context, thus it allows us
 	 * to use more permissive allocation masks to be more stable under
@@ -1089,20 +1092,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * Even if it fails we do not really care about that. Just proceed
 	 * as it is. "overflow" path will refill the cache we allocate from.
 	 */
-	preempt_disable();
-	if (!__this_cpu_read(ne_fit_preload_node)) {
-		preempt_enable();
+	if (!this_cpu_read(ne_fit_preload_node)) {
 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
-		preempt_disable();
 
-		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
+		if (this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
 			if (pva)
 				kmem_cache_free(vmap_area_cachep, pva);
 		}
 	}
 
 	spin_lock(&vmap_area_lock);
-	preempt_enable();
 
 	/*
 	 * If an allocation fails, the "vend" address is
-- 
2.20.1

