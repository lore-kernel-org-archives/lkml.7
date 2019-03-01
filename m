Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5FD20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im9L0Asl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfCAOPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:15:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40706 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfCAOPA (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:15:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so27850545qta.7
        for <Linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJZVPXjCDTapcmhGnlgthPahF7SbsDzfuFzLx5e2Gzs=;
        b=Im9L0AslFY9l4yxWab+Q17VCqu5Get6c6vkV6m7mkcd9OI3ofhUpmfzaMx1lqBMzpL
         QL4TI8NcNE+MhFVSIIo5XEbOygqsrjbs7dz9ZcTOrm6spZJ1QvhJLTcU/ginsYgitcaC
         iwrhvg+xe6lLFWz3br+LoI9PMwyD7kYXwF/9GXHKMhaKWQ6lOtbcRVh7SkrO51xrN7tl
         emal3OJ6DRgq1KsD3aYMxO/rMn8Fv599lNELFC7f9uLh/4D3Su2EPzTdgU+tjJrtd1RI
         0Nu8jmhUa3FC1hMH/omOpu7WLMbstSedwHhmYER6WS3ha5d/3cvn8lLytvEOsKDO2mmU
         FKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJZVPXjCDTapcmhGnlgthPahF7SbsDzfuFzLx5e2Gzs=;
        b=mHOywqq7iEwqVeT+1kk4GZFvd8mng4P28b00AK1/YboCdNSLkKcrr25iO2D1kdPalK
         KdRYV87IXEDMiPJQ6Db4hZDpPe3w07pEM2Q1RMB85wwqXC7sXnPcDlNteL8cSALkSXmh
         IezjFrtqH1CVzyVagolp/Ch3zLPa6jSoWYqAIN1GbXUuiGxxr5Z4JQAoWYNrsL22rHfe
         myd/+2ReLJYEJNl87JjDg1KZF4Ktgl3wQE/yWbKgOyVoM//vvjizj3+tPhnzbWkRZiyR
         8xWQOw2iUqAwEHLLj677ZFQE5NU1FBZ+RoWZwEUgnqlws3S06snNcLZyqYfOxl7LGGxI
         8pbQ==
X-Gm-Message-State: APjAAAWqLpsQiTkL7msyMULpCot4fCJgn/tb3VSlY+SGr/Q2zLcspcEc
        f/pTWvCMqN4PNZnUlb/1HORdLSIGAVHdqQ==
X-Google-Smtp-Source: APXvYqzC9ca71wAUlQ66vrxOXsmYGtuQMeCLi2LkoL5xTtNvfGLap/rZ2kdBbvg0FX73WPFdOn/cmA==
X-Received: by 2002:aed:23ae:: with SMTP id j43mr4020299qtc.318.1551449698056;
        Fri, 01 Mar 2019 06:14:58 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-125-241.3g.claro.net.br. [177.59.125.241])
        by smtp.gmail.com with ESMTPSA id x17sm9589747qka.94.2019.03.01.06.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 06:14:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0F124039C; Fri,  1 Mar 2019 11:14:52 -0300 (-03)
Date:   Fri, 1 Mar 2019 11:14:52 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf util: Refactor time range parsing code
Message-ID: <20190301141452.GH13100@kernel.org>
References: <1551435186-6008-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551435186-6008-1-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 06:13:06PM +0800, Jin Yao escreveu:
> Jiri points out that we don't need any time checking and time string
> parsing if the --time option is not set. That makes sense.
> 
> This patch refactors the time range parsing code, move the duplicated
> code from perf report and perf script to time_utils and check if --time
> option is set before parsing the time string. This patch is no logic
> change expected. So the usage of --time is same as before.
> 
> For example,
> 
> Select the first and second 10% time slices:
>   perf report --time 10%/1,10%/2
>   perf script --time 10%/1,10%/2
> 
> Select the slices from 0% to 10% and from 30% to 40%:
>   perf report --time 0%-10%,30%-40%
>   perf script --time 0%-10%,30%-40%
> 
> Select the time slices from timestamp 3971 to 3973
>   perf report --time 3971,3973
>   perf script --time 3971,3973
> 
>  v2:
>  ---
>  Add some examples in patch description.
>  No functional changes.

Thanks, so here is what I applied, with some committer testing notes:

commit 284c4e18f55e85155fbcbef5f88b6e62d2b1c29c
Author: Jin Yao <yao.jin@linux.intel.com>
Date:   Fri Mar 1 18:13:06 2019 +0800

    perf time-utils: Refactor time range parsing code
    
    Jiri points out that we don't need any time checking and time string
    parsing if the --time option is not set. That makes sense.
    
    This patch refactors the time range parsing code, move the duplicated
    code from perf report and perf script to time_utils and check if --time
    option is set before parsing the time string. This patch is no logic
    change expected. So the usage of --time is same as before.
    
    For example:
    
    Select the first and second 10% time slices:
      perf report --time 10%/1,10%/2
      perf script --time 10%/1,10%/2
    
    Select the slices from 0% to 10% and from 30% to 40%:
      perf report --time 0%-10%,30%-40%
      perf script --time 0%-10%,30%-40%
    
    Select the time slices from timestamp 3971 to 3973
      perf report --time 3971,3973
      perf script --time 3971,3973
    
    Committer testing:
    
    Using the above examples, check before and after to see if it remains
    the same:
    
      $ perf record -F 10000 -- find . -name "*.[ch]" -exec cat {} + > /dev/null
      [ perf record: Woken up 3 times to write data ]
      [ perf record: Captured and wrote 1.626 MB perf.data (42392 samples) ]
      $
      $ perf report --time 10%/1,10%/2 > /tmp/report.before.1
      $ perf script --time 10%/1,10%/2 > /tmp/script.before.1
      $ perf report --time 0%-10%,30%-40% > /tmp/report.before.2
      $ perf script --time 0%-10%,30%-40% > /tmp/script.before.2
      $ perf report --time 180457.375844,180457.377717 > /tmp/report.before.3
      $ perf script --time 180457.375844,180457.377717 > /tmp/script.before.3
    
    For example, the 3rd test produces this slice:
    
      $ cat /tmp/script.before.3
            cat  3147 180457.375844:   2143 cycles:uppp:      7f79362590d9 cfree@GLIBC_2.2.5+0x9 (/usr/lib64/libc-2.28.so)
            cat  3147 180457.375986:   2245 cycles:uppp:      558b70f3d86e [unknown] (/usr/bin/cat)
            cat  3147 180457.376012:   2164 cycles:uppp:      7f7936257430 _int_malloc+0x8c0 (/usr/lib64/libc-2.28.so)
            cat  3147 180457.376140:   2921 cycles:uppp:      558b70f3a554 [unknown] (/usr/bin/cat)
            cat  3147 180457.376296:   2844 cycles:uppp:      7f7936258abe malloc+0x4e (/usr/lib64/libc-2.28.so)
            cat  3147 180457.376431:   2717 cycles:uppp:      558b70f3b0ca [unknown] (/usr/bin/cat)
            cat  3147 180457.376667:   2630 cycles:uppp:      558b70f3d86e [unknown] (/usr/bin/cat)
            cat  3147 180457.376795:   2442 cycles:uppp:      7f79362bff55 read+0x15 (/usr/lib64/libc-2.28.so)
            cat  3147 180457.376927:   2376 cycles:uppp:  ffffffff9aa00163 [unknown] ([unknown])
            cat  3147 180457.376954:   2307 cycles:uppp:      7f7936257438 _int_malloc+0x8c8 (/usr/lib64/libc-2.28.so)
            cat  3147 180457.377116:   3091 cycles:uppp:      7f7936258a70 malloc+0x0 (/usr/lib64/libc-2.28.so)
            cat  3147 180457.377362:   2945 cycles:uppp:      558b70f3a3b0 [unknown] (/usr/bin/cat)
            cat  3147 180457.377517:   2727 cycles:uppp:      558b70f3a9aa [unknown] (/usr/bin/cat)
      $
    
    Install 'coreutils-debuginfo' to see cat's guts (symbols), but then, the
    above chunk translates into this 'perf report' output:
    
      $ cat /tmp/report.before.3
      # To display the perf.data header info, please use --header/--header-only options.
      #
      #
      # Total Lost Samples: 0
      #
      # Samples: 13  of event 'cycles:uppp' (time slices: 180457.375844,180457.377717)
      # Event count (approx.): 33552
      #
      # Overhead  Command  Shared Object     Symbol
      # ........  .......  ................  ......................
      #
          17.69%  cat      libc-2.28.so      [.] malloc
          14.53%  cat      cat               [.] 0x000000000000586e
          13.33%  cat      libc-2.28.so      [.] _int_malloc
           8.78%  cat      cat               [.] 0x00000000000023b0
           8.71%  cat      cat               [.] 0x0000000000002554
           8.13%  cat      cat               [.] 0x00000000000029aa
           8.10%  cat      cat               [.] 0x00000000000030ca
           7.28%  cat      libc-2.28.so      [.] read
           7.08%  cat      [unknown]         [k] 0xffffffff9aa00163
           6.39%  cat      libc-2.28.so      [.] cfree@GLIBC_2.2.5
    
      #
      # (Tip: Order by the overhead of source file name and line number: perf report -s srcline)
      #
      $
    
    Now lets see after applying this patch, nothing should change:
    
      $ perf report --time 10%/1,10%/2 > /tmp/report.after.1
      $ perf script --time 10%/1,10%/2 > /tmp/script.after.1
      $ perf report --time 0%-10%,30%-40% > /tmp/report.after.2
      $ perf script --time 0%-10%,30%-40% > /tmp/script.after.2
      $ perf report --time 180457.375844,180457.377717 > /tmp/report.after.3
      $ perf script --time 180457.375844,180457.377717 > /tmp/script.after.3
      $ diff -u /tmp/report.before.1 /tmp/report.after.1
      $ diff -u /tmp/script.before.1 /tmp/script.after.1
      $ diff -u /tmp/report.before.2 /tmp/report.after.2
      --- /tmp/report.before.2      2019-03-01 11:01:53.526094883 -0300
      +++ /tmp/report.after.2       2019-03-01 11:09:18.231770467 -0300
      @@ -352,5 +352,5 @@
    
       #
      -# (Tip: Generate a script for your data: perf script -g <lang>)
      +# (Tip: Treat branches as callchains: perf report --branch-history)
       #
      $ diff -u /tmp/script.before.2 /tmp/script.after.2
      $ diff -u /tmp/report.before.3 /tmp/report.after.3
      --- /tmp/report.before.3      2019-03-01 11:03:08.890045588 -0300
      +++ /tmp/report.after.3       2019-03-01 11:09:40.660224002 -0300
      @@ -22,5 +22,5 @@
    
       #
      -# (Tip: Order by the overhead of source file name and line number: perf report -s srcline)
      +# (Tip: List events using substring match: perf list <keyword>)
       #
      $ diff -u /tmp/script.before.3 /tmp/script.after.3
      $
    
    Cool, just the 'perf report' tips changed, QED.
    
    Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jin Yao <yao.jin@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/1551435186-6008-1-git-send-email-yao.jin@linux.intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1532ebde6c4b..ee93c18a6685 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1375,36 +1375,13 @@ int cmd_report(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto error;
 
-	report.ptime_range = perf_time__range_alloc(report.time_str,
-						    &report.range_size);
-	if (!report.ptime_range) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
-		if (session->evlist->first_sample_time == 0 &&
-		    session->evlist->last_sample_time == 0) {
-			pr_err("HINT: no first/last sample time found in perf data.\n"
-			       "Please use latest perf binary to execute 'perf record'\n"
-			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
-			goto error;
-		}
-
-		report.range_num = perf_time__percent_parse_str(
-					report.ptime_range, report.range_size,
-					report.time_str,
-					session->evlist->first_sample_time,
-					session->evlist->last_sample_time);
-
-		if (report.range_num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
+	if (report.time_str) {
+		ret = perf_time__parse_for_ranges(report.time_str, session,
+						  &report.ptime_range,
+						  &report.range_size,
+						  &report.range_num);
+		if (ret < 0)
 			goto error;
-		}
-	} else {
-		report.range_num = 1;
 	}
 
 	if (session->tevent.pevent &&
@@ -1426,7 +1403,8 @@ int cmd_report(int argc, const char **argv)
 		ret = 0;
 
 error:
-	zfree(&report.ptime_range);
+	if (report.ptime_range)
+		zfree(&report.ptime_range);
 
 	perf_session__delete(session);
 	return ret;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2d8cb1d1682c..53f78cf3113f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3699,37 +3699,13 @@ int cmd_script(int argc, const char **argv)
 	if (err < 0)
 		goto out_delete;
 
-	script.ptime_range = perf_time__range_alloc(script.time_str,
-						    &script.range_size);
-	if (!script.ptime_range) {
-		err = -ENOMEM;
-		goto out_delete;
-	}
-
-	/* needs to be parsed after looking up reference time */
-	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
-		if (session->evlist->first_sample_time == 0 &&
-		    session->evlist->last_sample_time == 0) {
-			pr_err("HINT: no first/last sample time found in perf data.\n"
-			       "Please use latest perf binary to execute 'perf record'\n"
-			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			err = -EINVAL;
-			goto out_delete;
-		}
-
-		script.range_num = perf_time__percent_parse_str(
-					script.ptime_range, script.range_size,
-					script.time_str,
-					session->evlist->first_sample_time,
-					session->evlist->last_sample_time);
-
-		if (script.range_num < 0) {
-			pr_err("Invalid time string\n");
-			err = -EINVAL;
+	if (script.time_str) {
+		err = perf_time__parse_for_ranges(script.time_str, session,
+						  &script.ptime_range,
+						  &script.range_size,
+						  &script.range_num);
+		if (err < 0)
 			goto out_delete;
-		}
-	} else {
-		script.range_num = 1;
 	}
 
 	err = __cmd_script(&script);
@@ -3737,7 +3713,8 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
-	zfree(&script.ptime_range);
+	if (script.ptime_range)
+		zfree(&script.ptime_range);
 
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46050a5..0f53baec660e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -11,6 +11,8 @@
 #include "perf.h"
 #include "debug.h"
 #include "time-utils.h"
+#include "session.h"
+#include "evlist.h"
 
 int parse_nsec_time(const char *str, u64 *ptime)
 {
@@ -374,7 +376,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	struct perf_time_interval *ptime;
 	int i;
 
-	if ((timestamp == 0) || (num == 0))
+	if ((!ptime_buf) || (timestamp == 0) || (num == 0))
 		return false;
 
 	if (num == 1)
@@ -396,6 +398,53 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 	return (i == num) ? true : false;
 }
 
+int perf_time__parse_for_ranges(const char *time_str,
+				struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num)
+{
+	struct perf_time_interval *ptime_range;
+	int size, num, ret;
+
+	ptime_range = perf_time__range_alloc(time_str, &size);
+	if (!ptime_range)
+		return -ENOMEM;
+
+	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+		if (session->evlist->first_sample_time == 0 &&
+		    session->evlist->last_sample_time == 0) {
+			pr_err("HINT: no first/last sample time found in perf data.\n"
+			       "Please use latest perf binary to execute 'perf record'\n"
+			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		num = perf_time__percent_parse_str(
+				ptime_range, size,
+				time_str,
+				session->evlist->first_sample_time,
+				session->evlist->last_sample_time);
+
+		if (num < 0) {
+			pr_err("Invalid time string\n");
+			ret = -EINVAL;
+			goto error;
+		}
+	} else {
+		num = 1;
+	}
+
+	*range_size = size;
+	*range_num = num;
+	*ranges = ptime_range;
+	return 0;
+
+error:
+	free(ptime_range);
+	return ret;
+}
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 {
 	u64  sec = timestamp / NSEC_PER_SEC;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 70b177d2b98c..b923de44e36f 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -23,6 +23,12 @@ bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
 bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 				   int num, u64 timestamp);
 
+struct perf_session;
+
+int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
+				struct perf_time_interval **ranges,
+				int *range_size, int *range_num);
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);


