Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843FC21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfB1HqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:46:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1HqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:46:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7jv9Q2950138
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:45:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7jsfc2950135;
        Wed, 27 Feb 2019 23:45:54 -0800
Date:   Wed, 27 Feb 2019 23:45:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6ef362fd3cf3af5d8143a07b4ea20499bf2a9eec@git.kernel.org>
Cc:     mingo@kernel.org, ak@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com, namhyung@kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, hpa@zytor.com,
          acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
          ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190220122800.864-4-jolsa@kernel.org>
References: <20190220122800.864-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Allow +- operator for type specific
 fields option
Git-Commit-ID: 6ef362fd3cf3af5d8143a07b4ea20499bf2a9eec
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

Commit-ID:  6ef362fd3cf3af5d8143a07b4ea20499bf2a9eec
Gitweb:     https://git.kernel.org/tip/6ef362fd3cf3af5d8143a07b4ea20499bf2a9eec
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 20 Feb 2019 13:27:57 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Feb 2019 16:15:35 -0300

perf script: Allow +- operator for type specific fields option

Add support to add/remove fields for specific event types in -F option.
It's now possible to use '+-' after event type, like:

  # cat > test.c
  #include <stdio.h>

  int main(void)
  {
     printf("Hello world\n");
     while(1) {}
  }
  ^D
  # gcc -g -o test test.c
  # perf probe -x test 'test.c:5'
  # perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
  ...

  # perf script -Ftrace:+period,-cpu
            test  3859 396291.117343:      10275 cpu/cpu-cycles,period=10000/:      7f..
            test  3859 396291.118234:      11041 cpu/cpu-cycles,period=10000/:  ffffff..
            test  3859 396291.118234:          1              probe_test:main:
            test  3859 396291.118248:       8668 cpu/cpu-cycles,period=10000/:  ffffff..
            test  3859 396291.118263:      10139 cpu/cpu-cycles,period=10000/:  ffffff..

Committer testing:

Couldn't make the test above work, but tested it with:

  # perf probe -x hello main
  Added new event:
    probe_hello:main     (on main in /home/acme/c/hello)

  You can now use it in all perf tools, such as:

	  perf record -e probe_hello:main -aR sleep 1

  # perf record -e probe_hello:main ./hello
  hello, world
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.025 MB perf.data (1 samples) ]
  # perf script
           hello 21454 [002] 254116.874005: probe_hello:main: (401126)
  #
  # perf script -Ftrace:+period,-cpu
           hello 21454 254116.874005:          1 probe_hello:main: (401126)

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 6 ++++++
 tools/perf/builtin-script.c              | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9e4def08d569..2e19fd7ffe35 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -159,6 +159,12 @@ OPTIONS
 	the override, and the result of the above is that only S/W and H/W
 	events are displayed with the given fields.
 
+	It's possible tp add/remove fields only for specific event type:
+
+		-Fsw:-cpu,-period
+
+	removes cpu and period from software events.
+
 	For the 'wildcard' option if a user selected field is invalid for an
 	event type, a message is displayed to the user that the option is
 	ignored for that type. For example:
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8d5fe092525c..373ea151dc60 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2560,6 +2560,10 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 			pr_warning("Overriding previous field request for %s events.\n",
 				   event_type(type));
 
+		/* Don't override defaults for +- */
+		if (strchr(tok, '+') || strchr(tok, '-'))
+			goto parse;
+
 		output[type].fields = 0;
 		output[type].user_set = true;
 		output[type].wildcard_set = false;
@@ -2644,6 +2648,10 @@ parse:
 				rc = -EINVAL;
 				goto out;
 			}
+			if (change == REMOVE)
+				output[type].fields &= ~all_output_options[i].field;
+			else
+				output[type].fields |= all_output_options[i].field;
 			output[type].user_set = true;
 			output[type].wildcard_set = true;
 		}
