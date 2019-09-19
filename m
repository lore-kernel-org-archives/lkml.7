Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3018AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023E721924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9vCHWpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbfISHd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:33:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35747 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387987AbfISHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:33:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so1949555wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uY1/ylDyFsviT6XapDzVuCTqMf2QKuzO/x6kAiRsGL4=;
        b=G9vCHWpQSry7IngYsbrlBYYhMrLzdYwOrIVMOGibLUEmXkFBiAzx4Zm0gdoHsqV8eN
         N3Iu9nsVRzs30bkWveu0KjmBtw8qx4i4c9wLW9fuX4LClrIh1B4Ot1vUFYXDCkNY9uK5
         eqEdijMXFzRFchB0lurZ1Pa1SjUUWy3pH9VPWFn/RBULbG9qnzfB3aZtdPe85ZRJZNRV
         ZmHP6fXKDbxu8D4Js3+WQ6zbE2J6hY+9CdSm3rGehVcyJXv+u3rzvbylFnG7Ctb5NNR8
         su1qpI3jA/o21wxps4Z9Pq5bfsH61Ao+W8iakIzqg0QWNLyDdvf6jAppgta54yIatVOB
         OjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uY1/ylDyFsviT6XapDzVuCTqMf2QKuzO/x6kAiRsGL4=;
        b=IIzZRasHBBRPjRYBWBftRVxd+1PQqgmb5LN34vnVCTCCH7kstYkhWURC3womcq740+
         xrPVJNZ1+Hdd/1VF2MhE8gwnk5GcTPVR2kKP4d+1xvq22O6qKXctqY7IScW3hPNOmmqd
         X5avLkcsz/FwFVNrHqm/r4Adi5kFmi8Ksk5u0CJZ5Hr1k79RI9SAAeP3yV92pGx4QBm9
         IW/jocouCmJdmsnM62t56thOGrWUjmdOKNC9GgM/C1+mFLK/VBvkycZ/3yBadX4upcvX
         cArDnLF7d9aYSNCO4OnpTa5pEW6xiK1fgDi6yFRRpZDd0aOyz9npfHQP/VtuO58Aloe/
         3mXw==
X-Gm-Message-State: APjAAAXcHb+YBu7sgwACVX3N4d6qpxg0E5kjug8TQwGOTga2OjeEKcXf
        /GU8oLX1uVQB7U5BJ5m0/WArI1qVCqQ=
X-Google-Smtp-Source: APXvYqy7SG1NmOz6g0e0FLFmmDpjIjgok6UfafSJbToHJ6yvuBlc3IzEymgZ/r+YTxececYprhzdyw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr6003594wrm.114.1568878436123;
        Thu, 19 Sep 2019 00:33:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:33:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/8] sched/fair: rework the CFS load balance
Date:   Thu, 19 Sep 2019 09:33:31 +0200
Message-Id: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
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

Some benchmarks results based on 8 iterations of each tests:
- small arm64 dual quad cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe      54981 +/-0.36%        55459 +/-0.31%   (+0.97%)

hackbench
1 groups       0.906 +/-2.34%        0.906 +/-2.88%   (+0.06%)

- large arm64 2 nodes / 224 cores system

           tip/sched/core        w/ this patchset    improvement
schedpipe     125323 +/-0.98%       125624 +/-0.71%   (+0.24%)

hackbench -l (256000/#grp) -g #grp
1 groups      15.360 +/-1.76%       14.206 +/-1.40%   (+8.69%)
4 groups       5.822 +/-1.02%        5.508 +/-6.45%   (+5.38%)
16 groups      3.103 +/-0.80%        3.244 +/-0.77%   (-4.52%)
32 groups      2.892 +/-1.23%        2.850 +/-1.81%   (+1.47%)
64 groups      2.825 +/-1.51%        2.725 +/-1.51%   (+3.54%)
128 groups     3.149 +/-8.46%        3.053 +/-13.15%  (+3.06%)
256 groups     3.511 +/-8.49%        3.019 +/-1.71%  (+14.03%)

dbench
1 groups     329.677 +/-0.46%      329.771 +/-0.11%   (+0.03%)
4 groups     931.499 +/-0.79%      947.118 +/-0.94%   (+1.68%)
16 groups   1924.210 +/-0.89%     1947.849 +/-0.76%   (+1.23%)
32 groups   2350.646 +/-5.75%     2351.549 +/-6.33%   (+0.04%)
64 groups   2201.524 +/-3.35%     2192.749 +/-5.84%   (-0.40%)
128 groups  2206.858 +/-2.50%     2376.265 +/-7.44%   (+7.68%)
256 groups  1263.520 +/-3.34%     1633.143 +/-13.02% (+29.25%)

tip/sched/core sha1:
  0413d7f33e60 ('sched/uclamp: Always use 'enum uclamp_id' for clamp_id values')

Changes since v2:
- fix typo and reorder code
- some minor code fixes
- optimize the find_idles_group()

Not covered in this patchset:
- update find_idlest_group() to be more aligned with load_balance(). I didn't
  want to delay this version because of this update which is not ready yet
- Better detection of overloaded and fully busy state, especially for cases
  when nr_running > nr CPUs.

Vincent Guittot (8):
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

 kernel/sched/fair.c | 805 +++++++++++++++++++++++++++-------------------------
 1 file changed, 417 insertions(+), 388 deletions(-)

-- 
2.7.4

