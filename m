Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E8EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D1E21873
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dACcdR7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfHOJYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:24:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfHOJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:24:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9NsGB2271489
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:23:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9NsGB2271489
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861035;
        bh=BynCa3z1+v/j//96nM7bV8u8d5IsTxtgLkQ+UAbH9Hw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=dACcdR7oKiMW0i9oUn33yGzbokttS7g/ysoaYv6L9GtGq623ImKS6twNX35R2HBF4
         QEDm3rPghGIqC5t5/VibGNNLTtKlllo4uTftOV4r9N/x8kIrDQUwTBw8qvXD7RvDVr
         Zw8PJLN7II1ubdqZzsbkzU3/gB7C+LgdFZB1aJh30Nnt1kgYghjjPzWmIzxrX2EhAM
         cXfdbujbv19OG9PK8ETIJk+W9eo8u3ZWJR8Inb5o5PpI6MbUDpM5Ajovow/EbpLoiP
         D/Pf1pBDvP7hsZgdSD7HimSnLgatEl8sPw8s1rzO4GCGZmsV1KcatxqvI0FAo/mnZP
         KS4X3eUAhJjkw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9NrOs2271486;
        Thu, 15 Aug 2019 02:23:53 -0700
Date:   Thu, 15 Aug 2019 02:23:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uw8cjeifxvjpkjp6x2iil0ar@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Collapse and resort all evsels in a group
Git-Commit-ID: 40d81772dac45643cecc7add0e95356072265754
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  40d81772dac45643cecc7add0e95356072265754
Gitweb:     https://git.kernel.org/tip/40d81772dac45643cecc7add0e95356072265754
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 9 Aug 2019 16:44:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf top: Collapse and resort all evsels in a group

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
@@ -264,6 +264,30 @@ out_unlock:
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
