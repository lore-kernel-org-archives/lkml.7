Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0387A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="g3pC5T8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCRPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:42:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35114 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCRPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:42:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so18458710qte.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ooNmMn2fOuE+lecLRch8pkBk7lzuBghGo9NoZBqRTLI=;
        b=g3pC5T8MNy9cNdZu4u6GusZ6CHq22XglrW/V0414vQSRLbD7WAHSzj+zRbfo2yRAKW
         rxEACa61cpW4bfTsR4qebyCRZmgiii4lErBJD4w5bcFqx8BV0f32Na5lv5iKmXQ8QVfo
         H6nryKAPYlC2gAhvB3ZtwWYivKRghemsNSpzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ooNmMn2fOuE+lecLRch8pkBk7lzuBghGo9NoZBqRTLI=;
        b=kJZ56eiLIPn2nbYqeqO9ryAEvH9LSlLRiB5A9mKk+L75vrvRod9CaGVNDV75SfhlhX
         RJuFqNSa+f15MMRjqPpJuW9TSXlEBiqQv5Qw1JTLoxQx+JuTh/KfqFb7KOynYBSXStfo
         KRltp4n5hXs3y0L2BAfBqncXT04GN1G1XVfYe9s3/qkwn7/ga0zdVhVh0d9GSaJwZCJu
         WC+TSLnV08x2pO+Y4t04ghaurjlC0/WAL4b+Z/LOEjMbJlBpufe/PJwq3F1REj8UJfsX
         P/KOCeKkWYAYe014K9hV+N4SRsSvELnYFcIe3DF978ZwKKUSI9SdJ0FBXm++zCssRJ3q
         8avA==
X-Gm-Message-State: APjAAAVf/6a3yLrA6TMdAN4XE4512kBSOmiX+TujuhDawBvk+uI9slWo
        iHI7qxGKwyUs8fbCf2MSBNPoqA==
X-Google-Smtp-Source: APXvYqzwKDD2JmSetcF+kJVj93ZnJ3/IlRJ/TurCLKzXG+npmnmLfepNmeTQSzciBcAyZkwZIPHtLw==
X-Received: by 2002:a0c:9319:: with SMTP id d25mr724302qvd.99.1552923729078;
        Mon, 18 Mar 2019 08:42:09 -0700 (PDT)
Received: from [192.168.1.240] (modemcable077.38-81-70.mc.videotron.ca. [70.81.38.77])
        by smtp.gmail.com with ESMTPSA id p46sm3374740qtc.41.2019.03.18.08.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 08:42:08 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Date:   Mon, 18 Mar 2019 11:41:50 -0400
Message-Id: <1552923710-30933-1-git-send-email-jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190218173514.064516553@infradead.org>
References: <20190218173514.064516553@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The case where we try to acquire the lock on 2 runqueues belonging to 2
different cores requires the rq_lockp wrapper as well otherwise we
frequently deadlock in there.

This fixes the crash reported in
1552577311-8218-1-git-send-email-jdesfossez@digitalocean.com

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76fee56..71bb71f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2078,7 +2078,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 		raw_spin_lock(rq_lockp(rq1));
 		__acquire(rq2->lock);	/* Fake it out ;) */
 	} else {
-		if (rq1 < rq2) {
+		if (rq_lockp(rq1) < rq_lockp(rq2)) {
 			raw_spin_lock(rq_lockp(rq1));
 			raw_spin_lock_nested(rq_lockp(rq2), SINGLE_DEPTH_NESTING);
 		} else {
-- 
2.7.4

