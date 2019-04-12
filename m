Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34612C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028F320818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555074498;
	bh=4m8aeJb30aNur13bk3swZYY8j0WaHF+WhIvR4qErEUw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uN9vMQaMxBdMwcA5vFkxEwJBxyHi21OOcmQv58VEi7SRRGWU4Lifjh+Vn6ZGTBxli
	 r0I5rfs++apP092QExFWg4dHRcGGks+em9IcJjFUYdKYq1bqjM/DHBBEZ0iUwbg8S6
	 lKxw4W5IJz5V5bHFPuZpkaifO8E2LVvoW1kf4iME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfDLNIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:08:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55194 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLNIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:08:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so11154052wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=spnCsUoHXxKdEfYrtSZbfXkIH0YsFifJdGTb2+PiewM=;
        b=kxBdwX+wdHuu7SK0aW6BNRIrYfjP8Y7RnpuKoZFSxal6y1LYPeVrvOu31PtWroiD0R
         zBd3jRoPBpA5yeLK6V5EeiqwGeWqDlq/Wm42gmqXnrQ21lH6WqdlttEvIWWR9boRJx1K
         dFeLvPyANVVGsnG+m1NJPz4u3r+++69n8MECagi2HYFcOpuaOzKZtGtVn547AqnOTdXl
         6uIU4AWpoHWQa/cMvg0kL85QQZIkCHWrpUOhhmUsCMYJuzn6iEzl+ZQRlqDiH3TT8T2h
         kMO1/aw7TlfI7xrNL/8DAYKp32LypQNTzUMvaCcO7eyJOtYkKfqNOso29rKrKgRPjEpO
         bPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=spnCsUoHXxKdEfYrtSZbfXkIH0YsFifJdGTb2+PiewM=;
        b=mgYLFschvltj+xx3SejP95O9U2FLxFXBs2VmeEFFez5L6fpaUBTbp5Jcv5bjzMDV6s
         X/EK9dN/f3MqFV3Ld9VknI9Ded90NG3oZ8t008y6PHiU1uIleAS6bOhrbCEUgpnOB3rK
         KGdHkrhX+5QF9JEGarKf8mIURBgEVcSsFooGGdkFaip3I/e+E+pU3DJusEkPs5QaG+U6
         4DtaQKP+elhmWFqXGRat3noE8jd4iz1w5owvZn+WUZdt63q+jk1pvT94Ms81s76SuwEU
         GIwg8i4rmSJrxgdTaWYKXY+c7zEDpFg2P9/cfuRi5QZKN6gwXq9ub4PXBH3htYJ/A6Bt
         iXLw==
X-Gm-Message-State: APjAAAU6kyT1UKuDi5M5wr4BMePwrHhRNsE/NhO2MtES0x/A2VOnd/vv
        dLEMZMvBIO7VCO2GFtCahNo=
X-Google-Smtp-Source: APXvYqzI5MFZkk+C8nSSAvZ6SvfuHvEXUxfORdKih0t+7Z/4ct/fb5UptnkGraMrVjnv2ggSkhp+iw==
X-Received: by 2002:a1c:df89:: with SMTP id w131mr10800762wmg.82.1555074494384;
        Fri, 12 Apr 2019 06:08:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i17sm42713836wrs.44.2019.04.12.06.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 06:08:13 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:08:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20190412130811.GA119417@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 0e9f02450da07fc7b1346c8c32c771555173e397 sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

Fix a NULL pointer dereference crash in certain environments.

 Thanks,

	Ingo

------------------>
Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load calculation


 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb6f351..40bd1e27b1b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7784,10 +7784,10 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	if (cfs_rq->last_h_load_update == now)
 		return;
 
-	cfs_rq->h_load_next = NULL;
+	WRITE_ONCE(cfs_rq->h_load_next, NULL);
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_load_next = se;
+		WRITE_ONCE(cfs_rq->h_load_next, se);
 		if (cfs_rq->last_h_load_update == now)
 			break;
 	}
@@ -7797,7 +7797,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 		cfs_rq->last_h_load_update = now;
 	}
 
-	while ((se = cfs_rq->h_load_next) != NULL) {
+	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);
