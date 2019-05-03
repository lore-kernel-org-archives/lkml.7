Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF6CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8250E2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843168;
	bh=/rwYQE6bsNEuc2Oc2m59rZibSQ8ZvzlxfUL8ZevX5L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MqMurXAipO0oPgAjQzBJeKqxCq5x04hHJeuWZWp7GDQAjDimdPM4tLHjix1IAybZN
	 B6/xHwpt+9gaqe7V79Z5w+Ez2EHc5Dlp2JAyA30weFro86moCx0CxrHx+1Zh9POAOz
	 ll+zeIKyxv0XAYielxkAha1z5G61YbzKtW0cqtak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfECA0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfECA0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:26:04 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CB6216FD;
        Fri,  3 May 2019 00:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843163;
        bh=/rwYQE6bsNEuc2Oc2m59rZibSQ8ZvzlxfUL8ZevX5L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIBnOt6Hq8RDZY0qgqF0wdIQmVh1ZeB8nIwSs0h+pi1tE9dw4lHn3Xn9ntklWV/dm
         YT9Wd89BzmhIzfFXa12yRnkvIUlKeGPzME88VGZCGy+fYG79ldKeDRiAAoubioQY1T
         hx4kPPsdsRGO9bj1WDiG+v+g1FCVtnoubxpHBM+Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/11] perf report: Report OOM in status line in the GTK UI
Date:   Thu,  2 May 2019 20:25:28 -0400
Message-Id: <20190503002533.29359-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

An -ENOMEM error is not reported in the GTK GUI.  Instead this error
message pops up on the screen:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1

	Processing events... [974K/3M]
	Error:failed to process sample

	0xf4198 [0x8]: failed to process type: 68

However when I use the same perf.data file with --stdio it works:

[root@m35lp76 perf]# ./perf  report -i perf.data.error68-1 --stdio \
		| head -12

  # Total Lost Samples: 0
  #
  # Samples: 76K of event 'cycles'
  # Event count (approx.): 99056160000
  #
  # Overhead  Command          Shared Object      Symbol
  # ........  ...............  .................  .........
  #
     8.81%  find             [kernel.kallsyms]  [k] ftrace_likely_update
     8.74%  swapper          [kernel.kallsyms]  [k] ftrace_likely_update
     8.34%  sshd             [kernel.kallsyms]  [k] ftrace_likely_update
     2.19%  kworker/u512:1-  [kernel.kallsyms]  [k] ftrace_likely_update

The sample precentage is a bit low.....

The GUI always fails in the FINISHED_ROUND event (68) and does not
indicate the reason why.

When happened is the following. Perf report calls a lot of functions and
down deep when a FINISHED_ROUND event is processed, these functions are
called:

  perf_session__process_event()
  + perf_session__process_user_event()
    + process_finished_round()
      + ordered_events__flush()
        + __ordered_events__flush()
	  + do_flush()
	    + ordered_events__deliver_event()
	      + perf_session__deliver_event()
	        + machine__deliver_event()
	          + perf_evlist__deliver_event()
	            + process_sample_event()
	              + hist_entry_iter_add() --> only called in GUI case!!!
	                + hist_iter__report__callback()
	                  + symbol__inc_addr_sample()

	                    Now this functions runs out of memory and
			    returns -ENOMEM. This is reported all the way up
			    until function

perf_session__process_event() returns to its caller, where -ENOMEM is
changed to -EINVAL and processing stops:

 if ((skip = perf_session__process_event(session, event, head)) < 0) {
      pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
	     head, event->header.size, event->header.type);
      err = -EINVAL;
      goto out_err;
 }

This occurred in the FINISHED_ROUND event when it has to process some
10000 entries and ran out of memory.

This patch indicates the root cause and displays it in the status line
of ther perf report GUI.

Output before (on GUI status line):

  0xf4198 [0x8]: failed to process type: 68

Output after:

  0xf4198 [0x8]: failed to process type: 68 [not enough memory]

Committer notes:

the 'skip' variable needs to be initialized to -EINVAL, so that when the
size is less than sizeof(struct perf_event_attr) we avoid this valid
compiler warning:

  util/session.c: In function ‘perf_session__process_events’:
  util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     err = skip;
     ~~~~^~~~~~
  util/session.c:1874:6: note: ‘skip’ was declared here
    s64 skip;
        ^~~~
  cc1: all warnings being treated as errors

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190423105303.61683-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b17f1c9bc965..bad5f87ae001 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1928,12 +1928,14 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	size = event->header.size;
 
+	skip = -EINVAL;
+
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
 		       file_offset + head, event->header.size,
-		       event->header.type);
-		err = -EINVAL;
+		       event->header.type, strerror(-skip));
+		err = skip;
 		goto out;
 	}
 
-- 
2.20.1

