Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC15BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD0C222DC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="NlWa6PMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfKSWVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:21:01 -0500
Received: from mout02.posteo.de ([185.67.36.66]:44643 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfKSWU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:20:59 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 2D68D240101
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:20:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1574202056; bh=6gnMHWcz1HkD4X2H3XeYl1zHwzltviEq5WfWUQfGnzQ=;
        h=Subject:From:To:Cc:Date:From;
        b=NlWa6PMapOkExiBm29qZbcMrKdv3CoEaJ6AuO7MxuFKJQ/DvwmYqbKs0/0UExQ9zj
         HkDMUOHbZz12r4Nf/3HgwQqBRuG/1EpPNjsmsB6fI6nPV/6SqnNuPpfV5uWtlOY2ss
         Ex7X4TBvr3lYkEqYDcXMJw3Ia7NPAtwQxZN2US9mfDvK5WxRJMqfRpPRtJU47vSkq+
         nFllBSEHhUGQUZq6fplPKlcRT6BfnDl0JVOeq67jHaJClCJFpE7mctvB1mTJCXcS94
         MBXidWg/wrxP9XWk1Y1gcq79lLLw5r7w5Ov093LlAf983029d8sHE/EwA/VrpAGvU1
         xbJ1pvGfbve8Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47HgJP08t5z9rxK;
        Tue, 19 Nov 2019 23:20:52 +0100 (CET)
Message-ID: <1574202052.1931.17.camel@posteo.de>
Subject: SCHED_DEADLINE with CPU affinity
From:   Philipp Stanner <stanner@posteo.de>
To:     linux-kernel@vger.kernel.org
Cc:     Hagen Pfeifer <hagen@jauu.net>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Date:   Tue, 19 Nov 2019 23:20:52 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,
(please put me in CC when answering, I'm not subscribed)

I'm currently working student in the embedded industry. We have a device where
we need to be able to process network data within a certain deadline. At the
same time, safety is a primary requirement; that's why we construct everything
fully redundant. Meaning: We have two network interfaces, each IRQ then bound
to one CPU core and spawn a container (systemd-nspawn, cgroups based) which in
turn is bound to the corresponding CPU (CPU affinity masked).

        Container0       Container1
   -----------------  -----------------
   |               |  |               |
   |    Proc. A    |  |   Proc. A'    |
   |    Proc. B    |  |   Proc. B'    |
   |               |  |               |
   -----------------  -----------------
          ^                  ^
          |                  |
        CPU 0              CPU 1
          |                  |
       IRQ eth0           IRQ eth1


Within each container several processes are started. Ranging from systemd
(SCHED_OTHER) till two (soft) real-time critical processes: which we want to
execute via SCHED_DEADLINE.

Now, I've worked through the manpage describing scheduling policies, and it
seems that our scenario is forbidden my the kernel.  I've done some tests with
the syscalls sched_setattr and sched_setaffinity, trying to activate
SCHED_DEADLINE while also binding to a certain core.  It fails with EINVAL or
EINBUSY, depending on the order of the syscalls.

I've read that the kernel accomplishes plausibility checks when you ask for a
new deadline task to be scheduled, and I assume this check is what prevents us
from implementing our intended architecture.

Now, the questions we're having are:

   1. Why does the kernel do this, what is the problem with scheduling with
      SCHED_DEADLINE on a certain core? In contrast, how is it handled when
      you have single core systems etc.? Why this artificial limitation?
   2. How can we possibly implement this? We don't want to use SCHED_FIFO,
      because out-of-control tasks would freeze the entire container.

SCHED_RR / SCHED_FIFO will probably be a better policy compared to
SCHED_OTHER, but SCHED_DEADLINE is exactly what we are looking for.

Cheers,
Philipp
