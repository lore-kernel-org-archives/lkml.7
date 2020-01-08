Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7694FC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2852070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IWDofTtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgAHTrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:47:32 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:44810 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgAHTrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:47:22 -0500
Received: by mail-qk1-f169.google.com with SMTP id w127so3742252qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6IdzXEjAqc3SzjG3DOyHv5lZ8YNCLuWwDx3dJsNyC9M=;
        b=IWDofTtAey2FIP2gPmZnFH9ea+/3z0vav6bCVBLb1VWPaxLPBF8NlyBSIAKQzMwx9j
         +3kTzyGv3FHZJ/1pt1ZOXD1HP69wLPxebCb81Dks3hV84TCElepy2bzylXtMHW6WCcTw
         2tHRkekqI+fAyF/3aVGec2Qr9PYLbpI5931q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6IdzXEjAqc3SzjG3DOyHv5lZ8YNCLuWwDx3dJsNyC9M=;
        b=Ck445sOi5Y3DFp7xvs1SgKa+0oCWAgMuFzbmPkuoBr3bO8TdGmXU0fI15ZdhTMTh0S
         RTyeHElm6TLOCRCrMISLI8gjneBqPVxVWpqwKseUP5iPl2JFGBg6Fj0Ic9P/ZeUNvMsA
         ItF/Q45jmy2YM/z11Baufr1vxZROrWmjh4R8b0RamK28bIUFRhj1bd/Fnkha5obA4zYX
         l1ef3Bm9Zwx6Sy+5p1gGraZzcIvRbAqCOs3K04P35a6mw4wpqSv2wzWi8F9R7ERzpgvK
         6Y73Xh0J2T/vIe3vAvDEe7l7baGPUNgD6z6a60R8a5pSWeIL7bjKy88H29KJDsWlX67P
         xEpg==
X-Gm-Message-State: APjAAAVzYl5lvB6surrJgWvVfY8i3tFLs9dgdLiYCZY9EtLZETHwQyU5
        FyDLL7S98S4GB9JFx29cg+fNTcvts5Ud7FBvmbHAL7evsuh0bg==
X-Google-Smtp-Source: APXvYqwhh03BE0rg64u29BK8WcfTtXo3JPfaLKujwZynWURBxhgIMqo/9QtycipodBIL5ZoGIS5kNGp8ipaOf4LiDXg=
X-Received: by 2002:a05:620a:228:: with SMTP id u8mr6030326qkm.88.1578512841317;
 Wed, 08 Jan 2020 11:47:21 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 8 Jan 2020 11:47:10 -0800
Message-ID: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
Subject: Lower than expected CPU pressure in PSI
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added reporting for PSI in cgroups and results are somewhat surprising.

My test setup consists of 3 services:

* stress-cpu1-no-contention.service : taskset -c 1 stress --cpu 1
* stress-cpu2-first-half.service    : taskset -c 2 stress --cpu 1
* stress-cpu2-second-half.service   : taskset -c 2 stress --cpu 1

First service runs unconstrained, the other two compete for CPU.

As expected, I can see 500ms/s sched delay for the latter two and
aggregated 1000ms/s delay for /system.slice, no surprises here.

However, CPU pressure reported by PSI says that none of my services
have any pressure on them. I can see around 434ms/s pressure on
/unified/system.slice and 425ms/s pressure on /unified cgroup, which
is surprising for three reasons:

* Pressure is absent for my services (I expect it to match scheed delay)
* Pressure on /unified/system.slice is lower than both 500ms/s and 1000ms/s
* Pressure on root cgroup is lower than on system.slice

I'm running Linux 5.4.8 with hybrid cgroup hierarchy under systemd.

P.S.: ./scripts/get_maintainer.pl kernel/sched/psi.c does not say
Johannes Weiner is a maintainer
