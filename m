Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F104BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA03320685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfwhPozU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfDYJhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:37:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45944 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfDYJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:37:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so6483026pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4GNjjOM4WJx7rmvuMNCY3RTw8Tm7bDS0tz59trmNv8=;
        b=sfwhPozUFwlvhfRzSk2gBZGNlxngNkNoU2Hi7rtQ2ZU+BP0zGbmaLgMjYm7KrG2+rL
         WeUcoGWHysCRgdnzg5ehAeFHL0j6ck8soVvlIo8eu/OSTTfHrIgcxlImewyBiYMUsKqk
         8CbeV52uXVyGxcXM921Rs8PK68aKopjIvqie8BWZSQ1m5bhyrLeKLD9jAnTggOqHdOsG
         QWqQl3GECTQlAXIUurUeFLA0kLFcPXtIOKbQpBLhXaN/jTx2OmEVqpd99UvJPFQufBTR
         B+2yitrb5P5myYIXVZbNMEL2ccc63vz3oXQ/cvqNJaCCOpn4Nn8twWexVcPG593NaXHu
         i8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L4GNjjOM4WJx7rmvuMNCY3RTw8Tm7bDS0tz59trmNv8=;
        b=hupFleDxu5HARsjDscn6xXbN0XOWwqyvdUKRnz/6RavsIEjd1OtHYw5+t48o9wTRGg
         Kdppqh43WScw43ofmmJxX3v6qncg/y3mHErN96PSikOZYSsXHcZppNjUWSAeXegfgskM
         kzdvJkgICBA4xWLvD0ikagUD2d8oMzsnhRTwyBIrS2K6+X0mwY67nFHj/9495UA/0MaA
         fPOKq5sZKkPQiXa6G/0KaX/yC1HK/N8cuEdZgUCEI4p5Ub+CKOwWAD9Cb+Mz2606O/mb
         6YzinKOmeKTvlTU+aJZoywtZJn5a/PL/TYIUYmOqH1amIanXwTT/nocFwXIyYvDAeNev
         rE6g==
X-Gm-Message-State: APjAAAXqH270BkFAlSLXsxOCXquZ3PVhesJ3Vfx1L+2p9SDlpm/6t4Gh
        J7DK3GDJDrkAYQs9P9wXJ/GQUjcZBqg=
X-Google-Smtp-Source: APXvYqxbcvc43nhiX5weITiznYRP4iJeGge2oEmmPBSusLyHg08soOpLaIe8a2MW6M4eln1iWqYBUw==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr37158913plt.149.1556185064948;
        Thu, 25 Apr 2019 02:37:44 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id h20sm57587289pfj.40.2019.04.25.02.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:37:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC V2 0/2] sched/fair: Fallback to sched-idle CPU for better performance
Date:   Thu, 25 Apr 2019 15:07:38 +0530
Message-Id: <cover.1556182964.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is another attempt to get some benefit out of the sched-idle
policy. The previous version [1] focused on getting better power numbers
and this version tries to get better performance or lower response time
for the tasks.

The first patch is unchanged from v1 and accumulates
information about sched-idle tasks per CPU.

The second patch changes the way the target CPU is selected in the fast
path. Currently, we target for an idle CPU in select_idle_sibling() to
run the next task, but in case we don't find idle CPUs it is better to
pick a CPU which will run the task the soonest, for performance reason.
A CPU which isn't idle but has only SCHED_IDLE activity queued on it
should be a good target based on this criteria as any normal fair task
will most likely preempt the currently running SCHED_IDLE task
immediately. In fact, choosing a SCHED_IDLE CPU shall give better
results as it should be able to run the task sooner than an idle CPU
(which requires to be woken up from an idle state).

Basic testing is done with the help of rt-app currently to make sure the
task is getting placed correctly.

--
viresh

Viresh Kumar (2):
  sched: Start tracking SCHED_IDLE tasks count in cfs_rq
  sched/fair: Fallback to sched-idle CPU if idle CPU isn't found

 kernel/sched/fair.c  | 42 +++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h |  2 ++
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

[1] https://lore.kernel.org/lkml/cover.1543229820.git.viresh.kumar@linaro.org/
