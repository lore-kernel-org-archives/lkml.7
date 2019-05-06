Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF07AC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910502082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557134705;
	bh=G1QTq4yq//3cr3E8BiFb6UEyx1mn+bf38UTPahhH6cg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nOogr8M1b+Lm4JjXltTKNUt2doK8CCL0K4GhEmrKUk0GXsqWpOZ3SNnAaczsqF+Ir
	 Yi/FMrGOfAGzhkDF+C5D/0MRY3ZxyiKC6X309W3LXAZrVebGebSTNMkKE91uOzZq11
	 56UJthydnPfbctxy6Xiq2weX7fhkdD01v/V+AezA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEFJZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:25:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41122 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:25:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so16306334wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HLAMhXGhSJwHeuCcd3ooWYMkDx7GKQisfF8bv4omEjs=;
        b=XMxeRkLpDqcYAUbVUt35Zhs3ORhgoiI70RIktzCQ1pGiyQ7WoomSySx2P2ZS7ABDWR
         emhArp+BkYoRo93XcB6N09TTTBbHm9NXSmO9IgscADM44M5HKogK2PbiZK51q2vlP9GQ
         DrSc8kNDTbWzYcURueNHfuuZvvN1qByN9VCZpoFy75tN4kxMc2Sc9Z35atislvYhH7uB
         1eFE6g32b1F6VD8aLUW/I6lfguIIMYRLAyyr8Q2bEszY0dtBvw7C22siqIo/xNM+cbjf
         ZrWVSL3TSifOBLr1kFIWewEnwaGeoZ1ysVmqqWnKSg80iGGnnuQOk4MexxNFOYaPdsl2
         sN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=HLAMhXGhSJwHeuCcd3ooWYMkDx7GKQisfF8bv4omEjs=;
        b=oGoccAbhTdY3d0SJjf1976DSQGoCEiJtwDoCrUOVaBoX6/oXew1jbFW1AssGL0s8Fp
         WIPbkHXTktdAw5hY9BFeBQgll33fVyjE2nJCFO2airo/vfG/GHc9eOOOtM9HzdWVnkNR
         fx8/esMWB3Uvswjq9D7gSzhfFwkT8uq0C8m9rN69cZqGG7N4QtgPf9HS7uj9kTaNlLh1
         4FKI8Qb/gQMmvW7YC4aKuZ63aDdaecV1Zg0GcfOLN51ph3xanXkUH6dkMyWDPy3hYYcd
         2lntQrPV8lpZVWqJK4FhdimQr1uZoYJ7K5NPqLzKAB2y2lLDDJIIbGr/S77BwrXGecgQ
         KgiQ==
X-Gm-Message-State: APjAAAVmCy2Ez8stJ/JITUIjGjTzVBA4m5z4kr46fQyiG5Tw0kcugC88
        fM5w+MYCZiQXRZqZMzvP+So=
X-Google-Smtp-Source: APXvYqxGK5RMOWsSbPE7IzKAVPwj5pUgFy8cD9cb6myEJYZbE/ZNYb/QML0quYsxrdNVFczSJsNm5Q==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr16765314wrp.96.1557134702515;
        Mon, 06 May 2019 02:25:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o8sm12956264wra.4.2019.05.06.02.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:25:01 -0700 (PDT)
Date:   Mon, 6 May 2019 11:24:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer updates for v5.2
Message-ID: <20190506092459.GA86912@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

   # HEAD: 13e792a19d4e3a1c64e94197ba357685fd584ded tick: Fix typos in comments

This cycle had the following changes:

 - Timer tracing improvements (Anna-Maria Gleixner)

 - Continued tasklet reduction work: remove the hrtimer_tasklet
   (Thomas Gleixner)

 - Fix CPU hotplug remove race in the tick-broadcast mask handling code 
   (Thomas Gleixner)

 - Force upper bound for setting CLOCK_REALTIME, to fix ABI 
   inconsistencies with handling values that are close to the maximum 
   supported and the vagueness of when uptime related wraparound might 
   occur. Make the consistent maximum the year 2232 across all relevant 
   ABIs and APIs. (Thomas Gleixner)

 - various cleanups and smaller fixes.

 Thanks,

	Ingo

------------------>
Anna-Maria Gleixner (4):
      tick/sched: Update tick_sched struct documentation
      timer: Move trace point to get proper index
      timer/trace: Replace deprecated vsprintf pointer extension %pf by %ps
      timer/trace: Improve timer tracing

Borislav Petkov (1):
      tick/broadcast: Fix warning about undefined tick_broadcast_oneshot_offline()

Laurent Gauthier (1):
      tick: Fix typos in comments

Rasmus Villemoes (1):
      timekeeping: Consistently use unsigned int for seqcount snapshot

Thomas Gleixner (5):
      mac80211_hwsim: Replace hrtimer tasklet with softirq hrtimer
      xfrm: Replace hrtimer tasklet with softirq hrtimer
      softirq: Remove tasklet_hrtimer
      tick: Remove outgoing CPU from broadcast masks
      timekeeping: Force upper bound for setting CLOCK_REALTIME


 drivers/net/wireless/mac80211_hwsim.c | 46 +++++++++++++++----------------
 include/linux/interrupt.h             | 25 -----------------
 include/linux/tick.h                  |  6 +++++
 include/linux/time64.h                | 21 +++++++++++++++
 include/net/xfrm.h                    |  2 +-
 include/trace/events/timer.h          | 17 +++++++-----
 kernel/cpu.c                          |  2 ++
 kernel/softirq.c                      | 51 -----------------------------------
 kernel/time/clockevents.c             | 18 +++++++++++--
 kernel/time/jiffies.c                 |  2 +-
 kernel/time/sched_clock.c             |  4 +--
 kernel/time/tick-broadcast.c          | 48 +++++++++++++++++----------------
 kernel/time/tick-common.c             |  2 +-
 kernel/time/tick-internal.h           | 10 ++++---
 kernel/time/tick-sched.c              |  3 ++-
 kernel/time/tick-sched.h              | 13 ++++++---
 kernel/time/time.c                    |  2 +-
 kernel/time/timekeeping.c             | 24 ++++++++---------
 kernel/time/timer.c                   | 30 ++++++++++++---------
 net/xfrm/xfrm_state.c                 | 30 ++++++++++++---------
 20 files changed, 173 insertions(+), 183 deletions(-)
