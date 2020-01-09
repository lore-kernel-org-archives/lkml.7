Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0BC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2C020721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="lGqemvVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgAIQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:23:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36133 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgAIQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:23:33 -0500
Received: by mail-qt1-f195.google.com with SMTP id i13so1507089qtr.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ic0Na07q4rKOF9CHw3HtqPOvoy8xsU/UO9GgbNroDuA=;
        b=lGqemvVW4OOqPrDuZezl5BBtxwmAXizIMHe4UVwk+zlDPyw4FwahplSi/mvyDaJauz
         IPX2uHyaKd0Sf/zBOrLmtA8NPONopdSqjlTG+NOjOb96VLIXBB+yr2yVp2cEwRLoJRqp
         yiDV8+vMqRtMfB3GhV0QXLk1F5WC/zY2Ab510044lCMjzbjVKMZ8y/7O9EYtzYDbHilh
         Vc9uFe8Ra40ZulrNrBw2Y96/ituX/7AioYo7TBQT3+I3MTJtb7WN4U7yXOcn3+uE1g2E
         Ci+r8WAwVpaq0wpOA5DQ6XJKhopxt+nZ1AGmsEcq1Pf+z1ntw6CbPQ0HNfaSi3B0UfU3
         CaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ic0Na07q4rKOF9CHw3HtqPOvoy8xsU/UO9GgbNroDuA=;
        b=QEk/trj3MkBjSyRI1tUeh3dLqZzQqaCG36FCAFkebRa+VXmx3iqT95KCDHHIz23WkF
         HD7UJrGz7gfssFSBNCmjmeCjGHLTH4vT0tIHLSctfxzf6bWmX4/PSL7cJzQRSmQ92fQ0
         dGOWGH6PiQtIe56IzFCZmKH2YGLGD1h3F4q+4r8TE0bUZQbWqRt3uJxevBzW2Z2Nm0yF
         2puYaDj4855g/6riOvIVMYS7+qyBcp9gI42Nq8zJKzFkrSB4eYQcou7dzp6J3tzJ4CD6
         dbSt6HmeinemnU6fXsXyWHtz5+YgTGDOyCSwOdXqd8/GXeChllY/ILza0xula7N5x/kA
         b1Vw==
X-Gm-Message-State: APjAAAVY3Vt4bXs+Xv9prFT6EJesSwQeLDnrXjnGq1DKm+5rmQJoQlOm
        2GneENjAJnLusGDtjnUyQX3jbg==
X-Google-Smtp-Source: APXvYqzOqTCKt2pGJzg1CPSGxDNqhRAO8deRTrmE6H7D5Urfe2sYa6m6Thv3olb273mgLSPrIdGu+g==
X-Received: by 2002:ac8:65da:: with SMTP id t26mr8673037qto.5.1578587012176;
        Thu, 09 Jan 2020 08:23:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:d72d])
        by smtp.gmail.com with ESMTPSA id g62sm3197786qkd.25.2020.01.09.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:23:31 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:23:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: Lower than expected CPU pressure in PSI
Message-ID: <20200109162330.GC8547@cmpxchg.org>
References: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 11:47:10AM -0800, Ivan Babrou wrote:
> P.S.: ./scripts/get_maintainer.pl kernel/sched/psi.c does not say
> Johannes Weiner is a maintainer

Mostly because psi is so intertwined with the scheduler that it's been
maintained through the scheduler tree. But let's add an entry for it,
the sched/ directory matching will ensure it shows all pertinent CCs:

$ ./scripts/get_maintainer.pl kernel/sched/psi.c 
Johannes Weiner <hannes@cmpxchg.org> (maintainer:PRESSURE STALL INFORMATION (PSI))
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
Juri Lelli <juri.lelli@redhat.com> (maintainer:SCHEDULER)
Vincent Guittot <vincent.guittot@linaro.org> (maintainer:SCHEDULER)
Dietmar Eggemann <dietmar.eggemann@arm.com> (reviewer:SCHEDULER)
Steven Rostedt <rostedt@goodmis.org> (reviewer:SCHEDULER)
Ben Segall <bsegall@google.com> (reviewer:SCHEDULER)
Mel Gorman <mgorman@suse.de> (reviewer:SCHEDULER)
linux-kernel@vger.kernel.org (open list:SCHEDULER)

---
From b865e10129c97c81fb83c368456d2c24e54badab Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 9 Jan 2020 10:36:58 -0500
Subject: [PATCH] MAINTAINERS: add maintenance information for psi

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..228baf0e40a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13367,6 +13367,12 @@ F:	net/psample
 F:	include/net/psample.h
 F:	include/uapi/linux/psample.h
 
+PRESSURE STALL INFORMATION (PSI)
+M:	Johannes Weiner <hannes@cmpxchg.org>
+S:	Maintained
+F:	kernel/sched/psi.c
+F:	include/linux/psi*
+
 PSTORE FILESYSTEM
 M:	Kees Cook <keescook@chromium.org>
 M:	Anton Vorontsov <anton@enomsg.org>
-- 
2.24.1

