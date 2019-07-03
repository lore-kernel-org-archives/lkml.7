Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E43218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGCTxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfGCTxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:53:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2848521882;
        Wed,  3 Jul 2019 19:53:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hilJM-0006Vf-3r; Wed, 03 Jul 2019 15:53:00 -0400
Message-Id: <20190703194959.596805445@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 15:49:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] ftrace/selftest: Fix ftracetest for non existant config and files
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Masami,

I worked a bit more on the one issue that Po-Hsu found, and made it use
tracefs a bit more aggressively. To test this I ran the test on a 3.5
kernel and found another issue, where it failed because set_event_pid
and set_ftrace_pid did not exist.

Can you review these patches. I can take them in my tree, or if Shuah
would like, she can take it in hers (after you give a review).

Thanks!

-- Steve


Steven Rostedt (VMware) (2):
      ftrace/selftests: Return the skip code when tracing directory not configured in kernel
      ftrace/selftest: Test if set_event/ftrace_pid exists before writing

----
 tools/testing/selftests/ftrace/ftracetest       | 38 +++++++++++++++++++++----
 tools/testing/selftests/ftrace/test.d/functions |  4 +--
 2 files changed, 34 insertions(+), 8 deletions(-)
