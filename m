Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE54C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F0C2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfCENxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbfCENws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CB4208E4;
        Tue,  5 Mar 2019 13:52:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUw-00031j-RO; Tue, 05 Mar 2019 08:52:46 -0500
Message-Id: <20190305135246.706150603@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 6/6] tracing: Use strncpy instead of memcpy for string keys in hist
 triggers
References: <20190305135223.360347148@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Because there may be random garbage beyond a string's null terminator,
it's not correct to copy the the complete character array for use as a
hist trigger key.  This results in multiple histogram entries for the
'same' string key.

So, in the case of a string key, use strncpy instead of memcpy to
avoid copying in the extra bytes.

Before, using the gdbus entries in the following hist trigger as an
example:

  # echo 'hist:key=comm' > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist

  ...

  { comm: ImgDecoder #4                      } hitcount:        203
  { comm: gmain                              } hitcount:        213
  { comm: gmain                              } hitcount:        216
  { comm: StreamTrans #73                    } hitcount:        221
  { comm: mozStorage #3                      } hitcount:        230
  { comm: gdbus                              } hitcount:        233
  { comm: StyleThread#5                      } hitcount:        253
  { comm: gdbus                              } hitcount:        256
  { comm: gdbus                              } hitcount:        260
  { comm: StyleThread#4                      } hitcount:        271

  ...

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  51

After:

  # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist | egrep gdbus | wc -l
  1

Link: http://lkml.kernel.org/r/50c35ae1267d64eee975b8125e151e600071d4dc.1549309756.git.tom.zanussi@linux.intel.com

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 79e577cbce4c4 ("tracing: Support string type key properly")
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5b03b9a869bb..c7774fa119a7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5157,9 +5157,10 @@ static inline void add_to_key(char *compound_key, void *key,
 		/* ensure NULL-termination */
 		if (size > key_field->size - 1)
 			size = key_field->size - 1;
-	}
 
-	memcpy(compound_key + key_field->offset, key, size);
+		strncpy(compound_key + key_field->offset, (char *)key, size);
+	} else
+		memcpy(compound_key + key_field->offset, key, size);
 }
 
 static void
-- 
2.20.1


