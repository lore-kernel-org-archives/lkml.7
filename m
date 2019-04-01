Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553EEC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D861208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfDAQns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfDAQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14A6208E4;
        Mon,  1 Apr 2019 16:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02A-0004pn-PR; Mon, 01 Apr 2019 12:43:42 -0400
Message-Id: <20190401164305.359125441@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 00/15] tools/lib/traceevent: Continuing on the path to a stand alone library
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo,

These contain more patches to make libtraceevent a stand alone library.
It also brings in some changes that are in the trace-cmd library.

There's a few name changes to the API function names to be more
descriptive as well as closer to what they actually do.

The "pevent" has been renamed to "tep" as we no longer use "pevent"
to represent the handle to the libtraceevent library descriptor.
"tep" now stands for "Trace Event Parser".

The reason for the "(Red Hat)" in one of my patches is that the code
was written when I was working for Red Hat, but added when working
for VMware (which is in the Signed-off-by).

Steven Rostedt (Red Hat) (1):
      tools/lib/traceevent: Add more debugging to see various internal ring buffer entries

Steven Rostedt (VMware) (3):
      tools lib traceevent: Handle trace_printk() "%px"
      tools/lib/traceevent: Add mono clocks to be parsed in seconds
      tools/lib/traceevent: Removed unneeded !! and return parenthesis

Tzvetomir Stoyanov (11):
      tools lib traceevent: Implement a new API, tep_list_events_copy()
      tools/lib/traceevent: Change description of few APIs
      tools/lib/traceevent: Coding style fixes
      tools/lib/traceevent: Implement new traceevent APIs for accessing struct tep_handler fields
      tools/lib/traceevent: Remove tep filter trivial APIs
      tools/lib/traceevent: Remove call to exit() from tep_filter_add_filter_str()
      tools/perf,tools/lib/traceevent: Make traceevent APIs more consistent
      tools/lib/traceevent: Rename input arguments of libtraceevent APIs from pevent to tep
      tools/perf,tools/lib/traceevent: Rename "pevent" member of struct tep_event to "tep"
      tools/perf,tools/lib/traceevent: Rename "pevent" member of struct tep_event_filter to "tep"
      tools/lib/traceevent: Rename input arguments and local variables of libtraceevent from pevent to tep

----
 tools/lib/traceevent/event-parse-api.c             | 278 +++++--
 tools/lib/traceevent/event-parse-local.h           |   6 +-
 tools/lib/traceevent/event-parse.c                 | 909 +++++++++++----------
 tools/lib/traceevent/event-parse.h                 | 154 ++--
 tools/lib/traceevent/event-plugin.c                |  32 +-
 tools/lib/traceevent/kbuffer-parse.c               |  49 ++
 tools/lib/traceevent/kbuffer.h                     |  13 +
 tools/lib/traceevent/parse-filter.c                | 216 +----
 tools/lib/traceevent/plugin_cfg80211.c             |   8 +-
 tools/lib/traceevent/plugin_function.c             |  14 +-
 tools/lib/traceevent/plugin_hrtimer.c              |  12 +-
 tools/lib/traceevent/plugin_jbd2.c                 |  12 +-
 tools/lib/traceevent/plugin_kmem.c                 |  32 +-
 tools/lib/traceevent/plugin_kvm.c                  |  48 +-
 tools/lib/traceevent/plugin_mac80211.c             |   8 +-
 tools/lib/traceevent/plugin_sched_switch.c         |  18 +-
 tools/lib/traceevent/plugin_scsi.c                 |   8 +-
 tools/lib/traceevent/plugin_xen.c                  |   8 +-
 tools/perf/builtin-kmem.c                          |   2 +-
 tools/perf/util/data-convert-bt.c                  |   4 +-
 tools/perf/util/python.c                           |   2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   2 +-
 .../util/scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/trace-event-parse.c                |   2 +-
 tools/perf/util/trace-event-read.c                 |   2 +-
 tools/perf/util/trace-event.c                      |   4 +-
 26 files changed, 946 insertions(+), 899 deletions(-)
