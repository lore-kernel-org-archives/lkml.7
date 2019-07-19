Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97595C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A3020651
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odcTokX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfGSH64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:58:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42857 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:58:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so16273359wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=laCOxAe96faoh5UJLwde2Jaa33L2DxaeyBFYzqyRqeg=;
        b=odcTokX63HRghLkFl/JjS7AX7HznB+6KrBGnFtNIfVo2CXF4Zw5o18gGpYUJcRXJkc
         4R4p5EoDtQ4WfVyUNn/UAZHw1yUX/krnud50J2z2M+NSHzCOusBiGSbHBa1DdZ3BnBa9
         vQX0J83vn95s7HB63ttDax+VowAMVe6VK2+o4oHyPzYekzLZgAQItJrC4+/2Jc5gG4V/
         QSce3jIuEKnRG/cNfwe2UtT2v5n0YLYQpq/hpJepIsUNvYQJgC5c2ZXuvu7ElQ2Hu0EV
         lyesLWVDuQXO7VVss9pNTfmiwnSTJX0HBEXqlx0Kb0rBTo5Lb2HnO0iIZkwl15N7Eusp
         TGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=laCOxAe96faoh5UJLwde2Jaa33L2DxaeyBFYzqyRqeg=;
        b=T4Jp25YDg2p727CL1pMEA0O8SxKPs3QWIl1KZ8C1tORChf1aN0eZzS/RNco5o2vQfi
         9mYVIsP2DljnerJeBllu/bCzHS9aHV3+3681DiJnvkKE05w4JYz9gLU9vuf9i/qxE3Ao
         AfZaKDLyv6d4UwAQqSPt5MeStNjjFejpBe7l72PAkZfI94bPto4s7RdibLgos66D6FAW
         7O8wd/l9QL0PJI/0RxNyl+kuhPSJt3O37pw+/zPajMzlQ5s8iG54EWa7vg8+a+FyYfaL
         c9Ejrah0tK2djmIsNttHuY8iSaMpFsl/ke7iWil+wfzhyYiA5bBnPS5SsTlkmDd8OHKN
         Tfzg==
X-Gm-Message-State: APjAAAWFexmveuR65O+TJENQ/kQrCDxGEdDIi8HXpqyq1A/FFdVrHQeM
        GkeUnrGt1nCqF8EX1SuJP2ZRU0o3YmU=
X-Google-Smtp-Source: APXvYqwSk61Sf8whTY3mgJSLp71ju/dELTU1al0q5pe7D8yrbFBs9qtscjpP628sujsl6Wmw/2Lx7A==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr56125400wrk.229.1563523134311;
        Fri, 19 Jul 2019 00:58:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:484b:32fe:1cf4:f69b])
        by smtp.gmail.com with ESMTPSA id c1sm58673826wrh.1.2019.07.19.00.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 00:58:53 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5] sched/fair: rework the CFS load balance
Date:   Fri, 19 Jul 2019 09:58:20 +0200
Message-Id: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
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

Patch 1 has already been sent separatly and only consolidate policy in one
place and help the review of the changes in load_balance.

Patch 2 renames the sum of h_nr_running and also add the sum of nr_running

Patch 3 reworks load_balance algorithm and fixes some wrong task placement
but try to stay conservative.

Patch 4 replaces runnable_load but load now that it is only used when
overloaded.

Patch 5 improves the spread of tasks at the 1st scheduling level.

Some benchmarks results based on 8 iterations of each tests:
- small arm64 dual quad cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe  53326 +/-0.32%        54494 +/-0.33%       (+2.19%)

hackbench
1 groups       0.914 +/-1.82%        0.903 +/-2.10%   (+1.24%)

- large arm64 2 nodes / 224 cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe 123373.625 +/-0.88%   124277.125 +/-1.34%   (+0.73%)

hackbench -l (256000/#grp) -g #grp
1 groups      14.886 +/-2.31%       14.504 +/-2.54%   (+2.56%)
4 groups       5.725 +/-7.26%        5.332 +/-9.05%   (+6.85%)
16 groups      3.041 +/-0.99%        3.221 +/-0.45%   (-5.92%)
32 groups      2.859 +/-1.04%        2.812 +/-1.25%   (+1.64%)
64 groups      2.740 +/-1.33%        2.662 +/-1.55%   (+2.84%)
128 groups     3.090 +/-13.22%       2.808 +/-12.90%  (+9.11%)
256 groups     3.629 +/-21.20%       3.063 +/-12.86% (+15.60%)

dbench
1 groups     337.703 +/-0.13%      333.729 +/-0.40%   (-1.18%)
4 groups     944.095 +/-1.09%      967.050 +/-0.96%   (+2.43%)
16 groups   1923.760 +/-3.62%     1981.926 +/-0.48%   (+3.02%)
32 groups   2243.161 +/-8.40%     2453.247 +/-0.56%   (+9.37%)
64 groups   2351.472 +/-10.64%    2621.137 +/-1.97%  (+11.47%)
128 groups  2070.117 +/-4.87%     2310.451 +/-2.45%  (+11.61%)
256 groups  1277.402 +/-3.03%     1691.865 +/-6.34%  (+32.45%)

tip/sched/core sha1:
  af24bde8df20('sched/uclamp: Add uclamp support to energy_compute()')

Vincent Guittot (5):
  sched/fair: clean up asym packing
  sched/fair: rename sum_nr_running to sum_h_nr_running
  sched/fair: rework load_balance
  sched/fair: use load instead of runnable load
  sched/fair: evenly spread tasks when not overloaded

 kernel/sched/fair.c | 614 +++++++++++++++++++++++++++-------------------------
 1 file changed, 323 insertions(+), 291 deletions(-)

-- 
2.7.4

