Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF30C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7D7206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566757078;
	bh=sYQBPoRxnU9ckPlAOKwoeLOK9orVH4LLobdXOrmd8+E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=soWSIwQHBYNi13Fs3CVb3wvfRGm2nrhfAGJjBTH0vialo8VSI5+R6lYSRcI828cbq
	 IX8Xc2qTIXX9nSLpE2GRbIsKsCAExRN4GiuQkaG/5ghd69k+hebENJirs03Oi/BNBs
	 l6kB62w9lRgpZLH1wCYEkL7NZ4ghtBn+A0lWGGB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfHYSR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:17:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfHYSR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 054D6307D91E;
        Sun, 25 Aug 2019 18:17:56 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08E2D5D9C3;
        Sun, 25 Aug 2019 18:17:53 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 00/12] libperf: Add events to perf/event.h
Date:   Sun, 25 Aug 2019 20:17:40 +0200
Message-Id: <20190825181752.722-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 25 Aug 2019 18:17:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
as a preparation for sampling libperf interface, moving event
definitions into the library header. Moving just the kernel 
non-AUX events now.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Perf added 'u*' types mainly to ease up printing __u64 values
as stated in the linux/types.h comment:

  /*
   * We define u64 as uint64_t for every architecture
   * so that we can print it with "%"PRIx64 without getting warnings.
   *
   * typedef __u64 u64;
   * typedef __s64 s64;
   */

Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
that.  Using extra '_' to ease up the reading and differentiate
them from standard PRI*64 macros.

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (12):
      libperf: Add mmap_event to perf/event.h
      libperf: Add mmap2_event to perf/event.h
      libperf: Add comm_event to perf/event.h
      libperf: Add namespaces_event to perf/event.h
      libperf: Add fork_event to perf/event.h
      libperf: Add lost_event to perf/event.h
      libperf: Add lost_samples_event to perf/event.h
      libperf: Add read_event to perf/event.h
      libperf: Add throttle_event to perf/event.h
      libperf: Add ksymbol_event to perf/event.h
      libperf: Add bpf_event to perf/event.h
      libperf: Add sample_event to perf/event.h

 tools/perf/builtin-sched.c          |   2 +-
 tools/perf/lib/include/perf/event.h | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/event.c             |  12 ++++++------
 tools/perf/util/event.h             | 104 +++-----------------------------------------------------------------------------------------------------
 tools/perf/util/evlist.c            |   2 +-
 tools/perf/util/evsel.c             |   8 ++++----
 tools/perf/util/machine.c           |   4 ++--
 tools/perf/util/python.c            |  14 +++++++-------
 tools/perf/util/session.c           |   8 ++++----
 9 files changed, 140 insertions(+), 126 deletions(-)
 create mode 100644 tools/perf/lib/include/perf/event.h
