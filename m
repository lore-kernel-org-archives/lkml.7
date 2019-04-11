Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAEC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA948204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVv0xkpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKBoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:44:01 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37376 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDKBoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:44:01 -0400
Received: by mail-pg1-f201.google.com with SMTP id z12so3330003pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 18:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=nMpKzlGnRjDmkTf14iU5Inuh5KPox7tkPv+EdiTrd5w=;
        b=sVv0xkpTwtzSlxpxf7Eh4uPvLQht8KTOHpymErP8ujjl0cROfAcy7azfsZtPXzWhWD
         cPgOu8rqPN+xOWDfdsbN52MxtcOc8fPxkqn1nTl62mmFD96RJ3eCnLvqiljGRTmR+iU2
         u/8Wm3cwbwW0mNn+qKGQvNbBO57ZzMpj+1ZVHMkfxMRgVg+wd1ZXlbaMZjQehFJeS3+D
         I5DtiYpbRf9zi0jJ5YUu0jLfd6NTxO8SXl1KmcijblbJDQNv52x7jwD2KAQNYPIZX5ED
         9ThgeOsWuFoiKZpvcFu2LQm8oDNYWq/0s+1e6KxU9h+JPK2hW29GfO5mc8EA+4hoT0b3
         AMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=nMpKzlGnRjDmkTf14iU5Inuh5KPox7tkPv+EdiTrd5w=;
        b=e8V8xfT3hpax9358baW2N29za59tX+dGFICFFAhBUndC7hz+4tNgMZArLFiHtbTUIc
         wMocymnufDFAuEbirBWMaqlVlMbELwEt0ji1r5iYuBw+I48M1U56+W3ZpBhEW5+w6rHh
         XYPn+TUVaE5Dbh31VhxJVHDYVc3ZWjcn4sBgnTCLig7K/PgqbXCkKu5f75GQxGaxQhrH
         tacA9BKr0bg9FiRcm/JAK86u0qWETnvqmsWRPv/WjfJPRC6sHvYhMrHeuKe8s5wnEbyP
         1p0f2d3pL+TDlV1MMo7yVu/FOIkdpCInK4defS9Tb/3uIOYRNFowD0N7fPmuUbzUrVlP
         6eXQ==
X-Gm-Message-State: APjAAAWwf6MHITWdHsatFsMQZePyhmfNFHPR8ushMgii9kcYT7+FQ1uG
        0782df5HLxUBBYs2zYwOeDghp8gev9E=
X-Google-Smtp-Source: APXvYqygCxVEH3ItByD6IxnaQ7ZdqZzlBm5rUdx0sPDioNv5BDwnqxGY49XVXyyMG+u6hN8qQpv1cl41iCU=
X-Received: by 2002:a63:b74b:: with SMTP id w11mr915185pgt.87.1554947039847;
 Wed, 10 Apr 2019 18:43:59 -0700 (PDT)
Date:   Wed, 10 Apr 2019 18:43:51 -0700
Message-Id: <20190411014353.113252-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC 0/2] opportunistic memory reclaim of a killed process
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        ebiederm@xmission.com, shakeelb@google.com, christian@brauner.io,
        minchan@kernel.org, timmurray@google.com, dancol@google.com,
        joel@joelfernandes.org, jannh@google.com, surenb@google.com,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time to kill a process and free its memory can be critical when the
killing was done to prevent memory shortages affecting system
responsiveness.

In the case of Android, where processes can be restarted easily, killing a
less important background process is preferred to delaying or throttling
an interactive foreground process. At the same time unnecessary kills
should be avoided as they cause delays when the killed process is needed
again. This requires a balanced decision from the system software about
how long a kill can be postponed in the hope that memory usage will
decrease without such drastic measures.

As killing a process and reclaiming its memory is not an instant operation,
a margin of free memory has to be maintained to prevent system performance
deterioration while memory of the killed process is being reclaimed. The
size of this margin depends on the minimum reclaim rate to cover the
worst-case scenario and this minimum rate should be deterministic.

Note that on asymmetric architectures like ARM big.LITTLE the reclaim rate
can vary dramatically depending on which core it=E2=80=99s performed at (se=
e test
results). It=E2=80=99s a usual scenario that a non-essential victim process=
 is
being restricted to a less performant or throttled CPU for power saving
purposes. This makes the worst-case reclaim rate scenario very probable.

The cases when victim=E2=80=99s memory reclaim can be delayed further due t=
o
process being blocked in an uninterruptible sleep or when it performs a
time-consuming operation makes the reclaim time even more unpredictable.

Increasing memory reclaim rate and making it more deterministic would
allow for a smaller free memory margin and would lead to more opportunities
to avoid killing a process.

Note that while other strategies like throttling memory allocations are
viable and can be employed for other non-essential processes they would
affect user experience if applied towards an interactive process.

Proposed solution uses existing oom-reaper thread to increase memory
reclaim rate of a killed process and to make this rate more deterministic.
By no means the proposed solution is considered the best and was chosen
because it was simple to implement and allowed for test data collection.
The downside of this solution is that it requires additional =E2=80=9Cexped=
ite=E2=80=9D
hint for something which has to be fast in all cases. Would be great to
find a way that does not require additional hints.

Other possible approaches include:
- Implementing a dedicated syscall to perform opportunistic reclaim in the
context of the process waiting for the victim=E2=80=99s death. A natural bo=
ost
bonus occurs if the waiting process has high or RT priority and is not
limited by cpuset cgroup in its CPU choices.
- Implement a mechanism that would perform opportunistic reclaim if it=E2=
=80=99s
possible unconditionally (similar to checks in task_will_free_mem()).
- Implement opportunistic reclaim that uses shrinker interface, PSI or
other memory pressure indications as a hint to engage.

Test details:
Tests are performed on a Qualcomm=C2=AE Snapdragon=E2=84=A2 845 8-core ARM =
big.LITTLE
system with 4 little cores (0.3-1.6GHz) and 4 big cores (0.8-2.5GHz)
running Android.
Memory reclaim speed was measured using signal/signal_generate,
kmem/rss_stat and sched/sched_process_exit traces.

Test results:
powersave governor, min freq
                        normal kills      expedited kills
        little          856 MB/sec        3236 MB/sec
        big             5084 MB/sec       6144 MB/sec

performance governor, max freq
                        normal kills      expedited kills
        little          5602 MB/sec       8144 MB/sec
        big             14656 MB/sec      12398 MB/sec

schedutil governor (default)
                        normal kills      expedited kills
        little          2386 MB/sec       3908 MB/sec
        big             7282 MB/sec       6820-16386 MB/sec
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min reclaim speed:      856 MB/sec        3236 MB/sec

The patches are based on 5.1-rc1

Suren Baghdasaryan (2):
  mm: oom: expose expedite_reclaim to use oom_reaper outside of
    oom_kill.c
  signal: extend pidfd_send_signal() to allow expedited process killing

 include/linux/oom.h          |  1 +
 include/linux/sched/signal.h |  3 ++-
 include/linux/signal.h       | 11 ++++++++++-
 ipc/mqueue.c                 |  2 +-
 kernel/signal.c              | 37 ++++++++++++++++++++++++++++--------
 kernel/time/itimer.c         |  2 +-
 mm/oom_kill.c                | 15 +++++++++++++++
 7 files changed, 59 insertions(+), 12 deletions(-)

--=20
2.21.0.392.gf8f6787159e-goog

