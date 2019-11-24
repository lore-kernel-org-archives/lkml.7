Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB85EC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 04:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4E12077B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 04:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574571335;
	bh=0CuBaOkD0kZlfygG7//3oYVtOE04F+HFqdcsIYasqxA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Xp0TOeD+dqNvF1/goJyRoms/Qhm0LbLNHNVqCQ5oUtme3wyU4pY2tuq3/7e5lBAgX
	 tAWY9jJ1k1GXecqr4wlIHeLonTQr8HHOI/UGbF8V6ha5E/rcQH/6xLoZErMpaYb+jh
	 UR71vq04UzJ45b8bkp0TWFecXmucuhOyEW06LQec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKXEze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 23:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfKXEze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 23:55:34 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D8B2073F;
        Sun, 24 Nov 2019 04:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574571333;
        bh=0CuBaOkD0kZlfygG7//3oYVtOE04F+HFqdcsIYasqxA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ug/ETyO8KGS+t3KruWh37nI+izedPQ/p2X1Ccx/A6yNCZJ47RVxV3+AczM3Fvh+iR
         NjC9jN7nZLt+KHlOrbpvRsX4PjIlgab24iCo47dT8mIocN6UhLUatffG9yoR0+NqvK
         BdFC/bi9EDIIo764kskUwK05ohU0bFrSIRJjgZMk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 0/3] selftests/ftrace: Fix ftracetest testcases for non-function tracer case
Date:   Sun, 24 Nov 2019 13:55:30 +0900
Message-Id: <157457133001.25666.5309062776021151107.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of patches to fix some issues which happens on
the kernel with CONFIG_FUNCTION_TRACER=n but CONFIG_TRACER=y.

Thank you,

---

Masami Hiramatsu (3):
      selftests/ftrace: Fix to check the existence of set_ftrace_filter
      selftests/ftrace: Fix ftrace test cases to check unsupported
      selftests/ftrace: Do not to use absolute debugfs path


 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
 tools/testing/selftests/ftrace/test.d/functions    |    4 +++-
 .../inter-event/trigger-action-hist-xfail.tc       |    4 ++--
 .../inter-event/trigger-onchange-action-hist.tc    |    2 +-
 .../inter-event/trigger-snapshot-action-hist.tc    |    4 ++--
 6 files changed, 15 insertions(+), 6 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
