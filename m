Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A22CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89BE21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsvV260B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410282AbfJRN0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:26:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36372 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfJRN0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:26:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so6131691wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TAkstAn9NsxFhoflubgzwKM3D/DE0VbfgFDuIskogA8=;
        b=bsvV260BOxkwl9e0Mfzaynnfaop+K1KKSgUtL2bWpN6ZRbk6sCRQRX4OEoyC+UtVlH
         nQuE8h83eILJzAPmasT2C3DxVl57tgQ8U3jpyb83Z1pguC2piDxiwz3zQXhjOkiwBj0x
         D5M+Rk6N+onjA0SI+KXstlET28eIz5T5Ltq0DJi9O+iDsy4JkhkzuqT6Mq89ntRAfnuY
         uIPZfc1Lf+ts1z57DzfKTcWd2ZGmPhaupV9fqud2eLlv/g7Wl5TwfoIWSVSWfe3c2KGa
         B8+IYhtPU3AiWJjGO3XnsxGDG2hoH37bFC5LXkQT0URmxU0OwbOqtKiQ8sc8a/D7cDKf
         Fnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TAkstAn9NsxFhoflubgzwKM3D/DE0VbfgFDuIskogA8=;
        b=E6gXLUkkcT/FHpPohweqUEOk0GbZh47oP1R2C2059IASgL7Uj+mgrKY8Ok48hbE8oM
         oJ7Ez/ig9zh9rIzB++vepBmhUThKETKjlNIODocohnYLF9EPkuPXsGcNi3SQ0k24QJiD
         nyIkt+q04Pu8VxJ41W68sP8CVhduje7DUV0Jt8fm8pv5+4M2M794fkseS4uIhuhdfmg6
         di8vTVPifriTng/mMLJdOlWgWfs+3sTbJMlKlENXRHzZeavZUOx71qEjlAi6lT2pdNhI
         XiaDR6gDI9hDI4rhBJw+l8WDn7p3LZcmD9n4Nix7NwG52uyW7rCzSV9SQVLiOoWhZnxr
         k1fg==
X-Gm-Message-State: APjAAAWONi9Th1vZ1jZkvdEh3CCkSZqWvOqcNaS9/pBjzWq06f6N/u7r
        3hyYCR8UQjs3JceNuYWj/yTvS1nW2Qc=
X-Google-Smtp-Source: APXvYqxWuiSYsdhQu6RlgNWygQk1LmmJasj5x2i+SmVgEbO2xH+EhwMo53RYYcnBlbtR31ixkjQASw==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr7613244wmg.9.1571405202678;
        Fri, 18 Oct 2019 06:26:42 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:41 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Date:   Fri, 18 Oct 2019 15:26:27 +0200
Message-Id: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several wrong task placement have been raised with the current load
balance algorithm but their fixes are not always straight forward and
end up with using biased values to force migrations. A cleanup and rework
of the load balance will help to handle such UCs and enable to fine grain
the behavior of the scheduler for other cases.

Patch 1 has already been sent separately and only consolidate asym policy
in one place and help the review of the changes in load_balance.

Patch 2 renames the sum of h_nr_running in stats.

Patch 3 removes meaningless imbalance computation to make review of
patch 4 easier.

Patch 4 reworks load_balance algorithm and fixes some wrong task placement
but try to stay conservative.

Patch 5 add the sum of nr_running to monitor non cfs tasks and take that
into account when pulling tasks.

Patch 6 replaces runnable_load by load now that the signal is only used
when overloaded.

Patch 7 improves the spread of tasks at the 1st scheduling level.

Patch 8 uses utilization instead of load in all steps of misfit task
path.

Patch 9 replaces runnable_load_avg by load_avg in the wake up path.

Patch 10 optimizes find_idlest_group() that was using both runnable_load
and load. This has not been squashed with previous patch to ease the
review.

Patch 11 reworks find_idlest_group() to follow the same steps as
find_busiest_group()

Some benchmarks results based on 8 iterations of each tests:
- small arm64 dual quad cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe      53125 +/-0.18%        53443 +/-0.52%   (+0.60%)

hackbench -l (2560/#grp) -g #grp
 1 groups      1.579 +/-29.16%       1.410 +/-13.46% (+10.70%)
 4 groups      1.269 +/-9.69%        1.205 +/-3.27%   (+5.00%)
 8 groups      1.117 +/-1.51%        1.123 +/-1.27%   (+4.57%)
16 groups      1.176 +/-1.76%        1.164 +/-2.42%   (+1.07%)

Unixbench shell8
  1 test     1963.48 +/-0.36%       1902.88 +/-0.73%    (-3.09%)
224 tests    2427.60 +/-0.20%       2469.80 +/-0.42%  (1.74%)

- large arm64 2 nodes / 224 cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe     124084 +/-1.36%       124445 +/-0.67%   (+0.29%)

hackbench -l (256000/#grp) -g #grp
  1 groups    15.305 +/-1.50%       14.001 +/-1.99%   (+8.52%)
  4 groups     5.959 +/-0.70%        5.542 +/-3.76%   (+6.99%)
 16 groups     3.120 +/-1.72%        3.253 +/-0.61%   (-4.92%)
 32 groups     2.911 +/-0.88%        2.837 +/-1.16%   (+2.54%)
 64 groups     2.805 +/-1.90%        2.716 +/-1.18%   (+3.17%)
128 groups     3.166 +/-7.71%        3.891 +/-6.77%   (+5.82%)
256 groups     3.655 +/-10.09%       3.185 +/-6.65%  (+12.87%)

dbench
  1 groups   328.176 +/-0.29%      330.217 +/-0.32%   (+0.62%)
  4 groups   930.739 +/-0.50%      957.173 +/-0.66%   (+2.84%)
 16 groups  1928.292 +/-0.36%     1978.234 +/-0.88%   (+0.92%)
 32 groups  2369.348 +/-1.72%     2454.020 +/-0.90%   (+3.57%)
 64 groups  2583.880 +/-3.39%     2618.860 +/-0.84%   (+1.35%)
128 groups  2256.406 +/-10.67%    2392.498 +/-2.13%   (+6.03%)
256 groups  1257.546 +/-3.81%     1674.684 +/-4.97%  (+33.17%)

Unixbench shell8
  1 test     6944.16 +/-0.02     6605.82 +/-0.11      (-4.87%)
224 tests   13499.02 +/-0.14    13637.94 +/-0.47%     (+1.03%)
lkp reported a -10% regression on shell8 (1 test) for v3 that 
seems that is partially recovered on my platform with v4.

tip/sched/core sha1:
  commit 563c4f85f9f0 ("Merge branch 'sched/rt' into sched/core, to pick up -rt changes")
  
Changes since v3:
- small typo and variable ordering fixes
- add some acked/reviewed tag
- set 1 instead of load for migrate_misfit
- use nr_h_running instead of load for asym_packing
- update the optimization of find_idlest_group() and put back somes
 conditions when comparing load
- rework find_idlest_group() to match find_busiest_group() behavior

Changes since v2:
- fix typo and reorder code
- some minor code fixes
- optimize the find_idles_group()

Not covered in this patchset:
- Better detection of overloaded and fully busy state, especially for cases
  when nr_running > nr CPUs.

Vincent Guittot (11):
  sched/fair: clean up asym packing
  sched/fair: rename sum_nr_running to sum_h_nr_running
  sched/fair: remove meaningless imbalance calculation
  sched/fair: rework load_balance
  sched/fair: use rq->nr_running when balancing load
  sched/fair: use load instead of runnable load in load_balance
  sched/fair: evenly spread tasks when not overloaded
  sched/fair: use utilization to select misfit task
  sched/fair: use load instead of runnable load in wakeup path
  sched/fair: optimize find_idlest_group
  sched/fair: rework find_idlest_group

 kernel/sched/fair.c | 1181 +++++++++++++++++++++++++++++----------------------
 1 file changed, 682 insertions(+), 499 deletions(-)

-- 
2.7.4

