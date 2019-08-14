Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E9DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DD4217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808200;
	bh=Hsx3ZvmO1RN2rxGK+DyXHAUqDLwe7RWYaFLnTbWBuZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ykbObPjV8YW6qWV2qrieRtXxDoskhTMfI/x/TIGmC2XO33s2UX1hTnf+w54FfMjBV
	 sOfcr8MK3af6b9cDhJq7QOZqLV2XBd6dtvyeSVShPTch9TQdzrR2VSyTsn4kXuiWU3
	 f1O69JoESFf1oM9zf4MP/qCKtXXBbflRmjIV3zZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfHNSnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfHNSnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:43:19 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276F1216F4;
        Wed, 14 Aug 2019 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808198;
        bh=Hsx3ZvmO1RN2rxGK+DyXHAUqDLwe7RWYaFLnTbWBuZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14P0IsFVt7ofAVUQqh+BvG4WVZSiwNKuMFBT97B9V9VC0Ey+jDKNrBo5LGY4NKhqk
         59ejFGHgmxLoVP5ZrsSag8DgVfWsxIwhqaupGbJPDy9y9NCyZwz2/Wgz3k2SeY3ZZ0
         4WSI2c+FMTAVTVVT5JCM0BKtYBxs42/9QO4t5xcg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/28] perf top: Collapse and resort all evsels in a group
Date:   Wed, 14 Aug 2019 15:40:34 -0300
Message-Id: <20190814184051.3125-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And link them, i.e. find the hist entries in the non-leader events and
link them to the ones in the leader.

This should be the same thing already done for the 'perf report' case,
but now we do it periodically.

With this in place we get percentages in from the second overhead column
on, not just on the first (the leader).

Try it using:

  perf top --stdio -e '{cycles,instructions}'

You should see something like:

   PerfTop:   20776 irqs/sec  kernel:68.7%  exact:  0.0% lost: 0/0 drop: 0/0 [cycles],  (all, 8 CPUs)
  ---------------------------------------------------------------------------------------------------

     4.44%   0.44%  [kernel]                 [k] do_syscall_64
     2.27%   0.17%  [kernel]                 [k] entry_SYSCALL_64
     1.73%   0.27%  [kernel]                 [k] syscall_return_via_sysret
     1.60%   0.91%  [kernel]                 [k] _raw_spin_lock_irqsave
     1.45%   3.53%  libglib-2.0.so.0.6000.4  [.] g_string_insert_unichar
     1.39%   0.21%  [kernel]                 [k] copy_user_enhanced_fast_string
     1.26%   1.15%  [kernel]                 [k] psi_task_change
     1.16%   0.14%  libpixman-1.so.0.38.0    [.] 0x000000000006f403
     1.00%   0.32%  [kernel]                 [k] __sched_text_start
     0.97%   2.11%  [kernel]                 [k] n_tty_write
     0.96%   0.04%  [kernel]                 [k] queued_spin_lock_slowpath
     0.93%   0.88%  [kernel]                 [k] menu_select
     0.87%   0.14%  [kernel]                 [k] try_to_wake_up
     0.77%   0.10%  libpixman-1.so.0.38.0    [.] 0x000000000006f40b
     0.73%   0.09%  libpixman-1.so.0.38.0    [.] 0x000000000006f413
     0.69%   0.48%  libc-2.29.so             [.] __memmove_avx_unaligned_erms
     0.68%   0.29%  [kernel]                 [k] _raw_spin_lock_irq
     0.61%   0.04%  libpixman-1.so.0.38.0    [.] 0x000000000006f423
     0.60%   0.37%  [kernel]                 [k] native_sched_clock
     0.57%   0.23%  [kernel]                 [k] do_idle
     0.57%   0.23%  [kernel]                 [k] __fget
     0.56%   0.30%  [kernel]                 [k] __switch_to_asm
     0.56%   0.00%  libc-2.29.so             [.] __memset_avx2_erms
     0.52%   0.32%  [kernel]                 [k] _raw_spin_lock
     0.49%   0.24%  [kernel]                 [k] n_tty_poll
     0.49%   0.54%  libglib-2.0.so.0.6000.4  [.] g_mutex_lock
     0.48%   0.62%  [kernel]                 [k] _raw_spin_unlock_irqrestore
     0.47%   0.27%  [kernel]                 [k] __switch_to
     0.47%   0.25%  [kernel]                 [k] pick_next_task_fair
     0.45%   0.17%  [kernel]                 [k] filldir64
     0.40%   0.16%  [kernel]                 [k] update_rq_clock
     0.39%   0.19%  [kernel]                 [k] enqueue_task_fair
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uw8cjeifxvjpkjp6x2iil0ar@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 94e34853a238..78e7efc597a6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -264,6 +264,30 @@ static void perf_top__show_details(struct perf_top *top)
 	pthread_mutex_unlock(&notes->lock);
 }
 
+static void evlist__resort_hists(struct evlist *evlist)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		hists__collapse_resort(hists, NULL);
+
+		/* Non-group events are considered as leader */
+		if (symbol_conf.event_group &&
+		    !perf_evsel__is_group_leader(pos)) {
+			struct hists *leader_hists = evsel__hists(pos->leader);
+
+			hists__match(leader_hists, hists);
+			hists__link(leader_hists, hists);
+		}
+	}
+
+	evlist__for_each_entry(evlist, pos) {
+		perf_evsel__output_resort(pos, NULL);
+	}
+}
+
 static void perf_top__print_sym_table(struct perf_top *top)
 {
 	char bf[160];
@@ -304,8 +328,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 		}
 	}
 
-	hists__collapse_resort(hists, NULL);
-	perf_evsel__output_resort(evsel, NULL);
+	evlist__resort_hists(top->evlist);
 
 	hists__output_recalc_col_len(hists, top->print_entries - printed);
 	putchar('\n');
@@ -570,8 +593,7 @@ static void perf_top__sort_new_samples(void *arg)
 		}
 	}
 
-	hists__collapse_resort(hists, NULL);
-	perf_evsel__output_resort(evsel, NULL);
+	evlist__resort_hists(t->evlist);
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-- 
2.21.0

