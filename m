Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C10C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DA7208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQy4PHbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZFGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:06:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40299 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfFZFGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:06:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so590006pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 22:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqwAtLoOSuCORoYRcEtlWtwpPJkWltEAv9xLrEBH82I=;
        b=QQy4PHbQ7GDkmK3tGKen4TS3Ch8f6D+p8ve3xYLSdsOCc70F4V8LzLwCBznbYmh2eC
         vb+fg1xTUz/oTD7ZCpSivGmZ94GgmP+6f5lbXRrw+0s3S6qmSM4kWP6MARQv/16daw/i
         8aTkp1MG1snfvQ02wMb6L8Z+ZRL6FDg5oVw7NOKg4ep6/qWDZyZ/Jtz6Oln1LZU9eHHg
         Ws+P82e4BwjRd0PGnZ2OybOT85aVJp7xR1d7Hzn8Azv6PiBWjrqybZkLQw+uiwFGj+kM
         w53/IVX9c9KPYFKGqKAT9H6whV1JjyKyR2Jglau4mK6m8LzevPxR0/SCYplWJp7763TD
         E4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqwAtLoOSuCORoYRcEtlWtwpPJkWltEAv9xLrEBH82I=;
        b=SavTLCZD7qAUkUKf33KHCyYqso+hRgb7TFJ1abUupQT+91XvWPKts70hspskAv4VAQ
         NUernYnXt0mX+DM+E2dGQutRVL0kDH0ozq2c4kYGhGxXHcswifXWR2qx3jiwrDlNd6To
         +wAOqSGEp628ZoyUiEabr16fybnhRNJFf7nLAiN8u8GtebOzcg347nzC9/+YBHqzVA/3
         KbDF33lC0H2szDIqiMTLjL6cm5HtA3Is2bjGRr5FCbXzD4N2F+krlafs3QvDYwWzCY/b
         75c5hKpeD8C5y9325eM3ftuRCoCRHMiiLWMALdoLEFO59Jo1ONlyN57J5CoXhF/IZkXL
         rHgQ==
X-Gm-Message-State: APjAAAVngLR6k/StcAnFOW8Yobv3YUwY/Eb08VRjatBcgMQvQQB9cF+w
        J+ozU7vUUeiq7hJYl1fIX4WzYg==
X-Google-Smtp-Source: APXvYqw09/JbW9b51yimdFront3zv7jq7o9xu3LVBHKXB5D5wZkd0r7OIdX0c96i6qcchNoQET7ebw==
X-Received: by 2002:a17:90a:214f:: with SMTP id a73mr2217403pje.21.1561525604737;
        Tue, 25 Jun 2019 22:06:44 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id a72sm31502722pge.2.2019.06.25.22.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 22:06:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Subject: [PATCH V3 0/2] sched/fair: Fallback to sched-idle CPU in absence of idle CPUs
Date:   Wed, 26 Jun 2019 10:36:28 +0530
Message-Id: <cover.1561523542.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We try to find an idle CPU to run the next task, but in case we don't
find an idle CPU it is better to pick a CPU which will run the task the
soonest, for performance reason.

A CPU which isn't idle but has only SCHED_IDLE activity queued on it
should be a good target based on this criteria as any normal fair task
will most likely preempt the currently running SCHED_IDLE task
immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
shall give better results as it should be able to run the task sooner
than an idle CPU (which requires to be woken up from an idle state).

This patchset updates both fast and slow paths with this optimization.

Testing is done with the help of rt-app currently and here are the
details:

- Tested on Octacore Hikey platform (all CPUs change frequency
  together).

- rt-app json [1] creates few tasks and we monitor the scheduling
  latency for them by looking at "wu_lat" field (usec).

- The histograms are created using
  https://github.com/adkein/textogram: textogram -a 0 -z 1000 -n 10

- the stats are accumulated using: https://github.com/nferraz/st

- NOTE: The % values shown don't add up, just look at total numbers
  instead


Test 1: Create 8 CFS tasks (no SCHED_IDLE tasks) without this patchset:

      0 - 100  : ##################################################   72% (3688)
    100 - 200  : ################                                     24% (1253)
    200 - 300  : ##                                                    2% (149)
    300 - 400  :                                                       0% (22)
    400 - 500  :                                                       0% (1)
    500 - 600  :                                                       0% (3)
    600 - 700  :                                                       0% (1)
    700 - 800  :                                                       0% (1)
    800 - 900  :
    900 - 1000 :                                                       0% (1)
         >1000 : 0% (17)

   N       min     max     sum     mean    stddev
   5136    0       2452    535985  104.358 104.585


Test 2: Create 8 CFS tasks and 5 SCHED_IDLE tasks:

        A. Without sched-idle patchset:

      0 - 100  : ##################################################   88% (3102)
    100 - 200  : ##                                                    4% (148)
    200 - 300  :                                                       1% (41)
    300 - 400  :                                                       0% (27)
    400 - 500  :                                                       0% (33)
    500 - 600  :                                                       0% (32)
    600 - 700  :                                                       1% (36)
    700 - 800  :                                                       0% (27)
    800 - 900  :                                                       0% (19)
    900 - 1000 :                                                       0% (26)
         >1000 : 34% (1218)

   N       min     max     sum             mean    stddev
   4710    0       67664   5.25956e+06     1116.68 2315.09


        B. With sched-idle patchset:

      0 - 100  : ##################################################   99% (5042)
    100 - 200  :                                                       0% (8)
    200 - 300  :
    300 - 400  :
    400 - 500  :                                                       0% (2)
    500 - 600  :                                                       0% (1)
    600 - 700  :
    700 - 800  :                                                       0% (1)
    800 - 900  :                                                       0% (1)
    900 - 1000 :
         >1000 : 0% (40)

   N       min     max     sum     mean    stddev
   5095    0       7773    523170  102.683 475.482


The mean latency dropped to 10% and the stddev to around 25% with this
patchset.

@Song: Can you please see if the slowpath changes bring any further
improvements in your test case ?

V2->V3:
- Removed a pointless branch from 1/2 (PeterZ).
- Removed the RFC tags as patches are getting in better shape now.
- Updated the slow path as well, earlier versions only supported fast
  paths.
- Rebased over latest tip/master, fixed rebase conflicts.
- Improved commit logs.

--
viresh

[1] https://pastebin.com/TMHGGBxD

Viresh Kumar (2):
  sched: Start tracking SCHED_IDLE tasks count in cfs_rq
  sched/fair: Fallback to sched-idle CPU if idle CPU isn't found

 kernel/sched/fair.c  | 57 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h |  2 ++
 2 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

