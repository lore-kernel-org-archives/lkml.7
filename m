Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE76FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1252084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YopBetrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfFQTyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:54:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFQTyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:54:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJraSi3570891
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:53:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJraSi3570891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560801217;
        bh=Rzo0baNNo6xSxGbeyFpsmtO3SJ2LPXYBvECxFKlMfCM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YopBetrACyMm/eQme48LXZMVu/oOLv2NyV76v5yf5nEM6r+x8SxLSR91VKPt/Na+l
         Maep9ZHyEy4nl/d+GCDNEmrVZkpK552QIctOZ8JBL4kX0IyBAaD6nkkAMUxudERSJs
         GQwvo0QS4pzUz7Dvy/MqcXDPiefVR3toZW5IMi3kurr25xjiWnwkVybvpQOatDNKos
         nyRplhr/oMQD0CH20HRQ4l5YbX2fcM589OJKA/feyiDE4Zj21ZezFNDPyJxoSl5ptN
         Baj1J3te3tFe9yuTg0TvpMQOrvRn9KACAvxWEomlq47cl9OUT3J/OrZkugtBA3cnZF
         vghdHQOqC2IHw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJra9u3570888;
        Mon, 17 Jun 2019 12:53:36 -0700
Date:   Mon, 17 Jun 2019 12:53:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-04c41bcb862bbec1fb225243ecf07a3219593f81@git.kernel.org>
Cc:     adrian.hunter@intel.com, namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, yhs@fb.com, acme@redhat.com,
        mingo@kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, kafai@fb.com,
        daniel@iogearbox.net, leo.yan@linaro.org, mike.leach@linaro.org,
        hpa@zytor.com, ast@kernel.org
Reply-To: kafai@fb.com, daniel@iogearbox.net, leo.yan@linaro.org,
          mike.leach@linaro.org, tglx@linutronix.de, ast@kernel.org,
          hpa@zytor.com, jolsa@redhat.com, adrian.hunter@intel.com,
          namhyung@kernel.org, suzuki.poulose@arm.com,
          songliubraving@fb.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org, yhs@fb.com,
          alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org
In-Reply-To: <20190610184754.GU21245@kernel.org>
References: <20190610184754.GU21245@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Skip unknown syscalls when expanding
 strace like syscall groups
Git-Commit-ID: 04c41bcb862bbec1fb225243ecf07a3219593f81
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

Commit-ID:  04c41bcb862bbec1fb225243ecf07a3219593f81
Gitweb:     https://git.kernel.org/tip/04c41bcb862bbec1fb225243ecf07a3219593f81
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 10 Jun 2019 15:37:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 17:50:04 -0300

perf trace: Skip unknown syscalls when expanding strace like syscall groups

We have $INSTALL_DIR/share/perf-core/strace/groups/string files with
syscalls that should be selected when 'string' is used, meaning, in this
case, syscalls that receive as one of its arguments a string, like a
pathname.

But those were first selected and tested on x86_64, and end up failing
in architectures where some of those syscalls are not available, like
the 'access' syscall on arm64, which makes using 'perf trace -e string'
in such archs to fail.

Since this the routine doing the validation is used only when reading
such files, do not fail when some syscall is not found in the
syscalltbl, instead just use pr_debug() to register that in case people
are suspicious of problems.

Now using 'perf trace -e string' should work on arm64, selecting only
the syscalls that have a string and are available on that architecture.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/20190610184754.GU21245@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1a2a605cf068..eb70a4b71755 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1529,6 +1529,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0, i;
+	bool printed_invalid_prefix = false;
 	size_t nr_allocated;
 	struct str_node *pos;
 
@@ -1555,14 +1556,15 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			if (id >= 0)
 				goto matches;
 
-			if (err == 0) {
-				fputs("Error:\tInvalid syscall ", trace->output);
-				err = -EINVAL;
+			if (!printed_invalid_prefix) {
+				pr_debug("Skipping unknown syscalls: ");
+				printed_invalid_prefix = true;
 			} else {
-				fputs(", ", trace->output);
+				pr_debug(", ");
 			}
 
-			fputs(sc, trace->output);
+			pr_debug("%s", sc);
+			continue;
 		}
 matches:
 		trace->ev_qualifier_ids.entries[i++] = id;
@@ -1591,15 +1593,14 @@ matches:
 		}
 	}
 
-	if (err < 0) {
-		fputs("\nHint:\ttry 'perf list syscalls:sys_enter_*'"
-		      "\nHint:\tand: 'man syscalls'\n", trace->output);
-out_free:
-		zfree(&trace->ev_qualifier_ids.entries);
-		trace->ev_qualifier_ids.nr = 0;
-	}
 out:
+	if (printed_invalid_prefix)
+		pr_debug("\n");
 	return err;
+out_free:
+	zfree(&trace->ev_qualifier_ids.entries);
+	trace->ev_qualifier_ids.nr = 0;
+	goto out;
 }
 
 /*
