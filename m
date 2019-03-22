Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D990721939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256053;
	bh=XR/8oQcwp6+Bx10xVjI37uDZax1W8ZQlk188pSjhs60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oC8kIIH0gFGfv0I0DKVC4tWG13E32jiGg15RORv00BeX4PYWt526QtlStZi0HVt22
	 vfOON5MtqXr6V87LpIihsQgOjFiqxAndqBAyt1mCBeMsdihGMP5ChGHA1Ya+23Pda4
	 jTaI71f9TvzdJP4QIJYiOUuvveXqPijgdmkEiYUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfCVMAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733120AbfCVMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828222192D;
        Fri, 22 Mar 2019 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256049;
        bh=XR/8oQcwp6+Bx10xVjI37uDZax1W8ZQlk188pSjhs60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlKDjVOcshNrVRuXCpZ+Zv2dKI1PqRfmSdQ/Iio8tojM/ZuBmXnW8WXKbDF+1vwlx
         BrgtDQ8+pHVEfMUO64liDRMzEWAf28QQ8vYhXEP5vWZdMcLc+G1sQ/Dq1dGacj2Sgd
         EO19TnziyuY9yCH4iNlDkNHtfectfNTbCuKQCvyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 4.19 093/280] mm: handle lru_add_drain_all for UP properly
Date:   Fri, 22 Mar 2019 12:14:06 +0100
Message-Id: <20190322111311.719819625@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6ea183d60c469560e7b08a83c9804299e84ec9eb ]

Since for_each_cpu(cpu, mask) added by commit 2d3854a37e8b767a
("cpumask: introduce new API, without changing anything") did not
evaluate the mask argument if NR_CPUS == 1 due to CONFIG_SMP=n,
lru_add_drain_all() is hitting WARN_ON() at __flush_work() added by
commit 4d43d395fed12463 ("workqueue: Try to catch flush_work() without
INIT_WORK().") by unconditionally calling flush_work() [1].

Workaround this issue by using CONFIG_SMP=n specific lru_add_drain_all
implementation.  There is no real need to defer the implementation to
the workqueue as the draining is going to happen on the local cpu.  So
alias lru_add_drain_all to lru_add_drain which does all the necessary
work.

[akpm@linux-foundation.org: fix various build warnings]
[1] https://lkml.kernel.org/r/18a30387-6aa5-6123-e67c-57579ecc3f38@roeck-us.net
Link: http://lkml.kernel.org/r/20190213124334.GH4525@dhcp22.suse.cz
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Debugged-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 26fc9b5f1b6c..a3fc028e338e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -321,11 +321,6 @@ static inline void activate_page_drain(int cpu)
 {
 }
 
-static bool need_activate_page_drain(int cpu)
-{
-	return false;
-}
-
 void activate_page(struct page *page)
 {
 	struct zone *zone = page_zone(page);
@@ -654,13 +649,15 @@ void lru_add_drain(void)
 	put_cpu();
 }
 
+#ifdef CONFIG_SMP
+
+static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
 	lru_add_drain();
 }
 
-static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
-
 /*
  * Doesn't need any cpu hotplug locking because we do rely on per-cpu
  * kworkers being shut down before our page_alloc_cpu_dead callback is
@@ -703,6 +700,12 @@ void lru_add_drain_all(void)
 
 	mutex_unlock(&lock);
 }
+#else
+void lru_add_drain_all(void)
+{
+	lru_add_drain();
+}
+#endif
 
 /**
  * release_pages - batched put_page()
-- 
2.19.1



