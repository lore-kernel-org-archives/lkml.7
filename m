Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F02C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EF620883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVWTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:19:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCVWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:19:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMJeqJ750100
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:19:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMJe1w750097;
        Fri, 22 Mar 2019 15:19:40 -0700
Date:   Fri, 22 Mar 2019 15:19:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-y5u2lik0ragt4vlktz6qc9ks@git.kernel.org>
Cc:     ak@linux.intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Allow to limit number of reported
 perf.data files
Git-Commit-ID: 03724b2e9c45d931eff0f304f2d3363ade65ca89
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

Commit-ID:  03724b2e9c45d931eff0f304f2d3363ade65ca89
Gitweb:     https://git.kernel.org/tip/03724b2e9c45d931eff0f304f2d3363ade65ca89
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:49:55 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 11:56:20 -0300

perf record: Allow to limit number of reported perf.data files

When doing long term recording and waiting for some event to snapshot
on, we often only care about the last minute or so.

The --switch-output command line option supports rotating the perf.data
file when the size exceeds a threshold. But the disk would still be
filled with unnecessary old files.

Add a new option to only keep a number of rotated files, so that the
disk space usage can be limited.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-3-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-y5u2lik0ragt4vlktz6qc9ks@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ++++
 tools/perf/builtin-record.c              | 30 +++++++++++++++++++++++++++++-
 tools/perf/util/data.c                   | 11 +++++------
 tools/perf/util/data.h                   |  2 +-
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8f0c2be34848..8fe4dffcadd0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -495,6 +495,10 @@ overhead. You can still switch them on with:
 
   --switch-output --no-no-buildid  --no-no-buildid-cache
 
+--switch-max-files=N::
+
+When rotating perf.data with --switch-output, only keep N files.
+
 --dry-run::
 Parse options then exit. --dry-run can be used to detect errors in cmdline
 options.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a468d882e74f..02d7c40b2d10 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -62,6 +62,9 @@ struct switch_output {
 	unsigned long	 time;
 	const char	*str;
 	bool		 set;
+	char		 **filenames;
+	int		 num_files;
+	int		 cur_file;
 };
 
 struct record {
@@ -892,6 +895,7 @@ record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
 	int fd, err;
+	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
@@ -912,7 +916,7 @@ record__switch_output(struct record *rec, bool at_exit)
 
 	fd = perf_data__switch(data, timestamp,
 				    rec->session->header.data_offset,
-				    at_exit);
+				    at_exit, &new_filename);
 	if (fd >= 0 && !at_exit) {
 		rec->bytes_written = 0;
 		rec->session->header.data_size = 0;
@@ -922,6 +926,21 @@ record__switch_output(struct record *rec, bool at_exit)
 		fprintf(stderr, "[ perf record: Dump %s.%s ]\n",
 			data->path, timestamp);
 
+	if (rec->switch_output.num_files) {
+		int n = rec->switch_output.cur_file + 1;
+
+		if (n >= rec->switch_output.num_files)
+			n = 0;
+		rec->switch_output.cur_file = n;
+		if (rec->switch_output.filenames[n]) {
+			remove(rec->switch_output.filenames[n]);
+			free(rec->switch_output.filenames[n]);
+		}
+		rec->switch_output.filenames[n] = new_filename;
+	} else {
+		free(new_filename);
+	}
+
 	/* Output tracking events */
 	if (!at_exit) {
 		record__synthesize(rec, false);
@@ -1973,6 +1992,8 @@ static struct option __record_options[] = {
 			  &record.switch_output.set, "signal,size,time",
 			  "Switch output when receive SIGUSR2 or cross size,time threshold",
 			  "signal"),
+	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
+		   "Limit number of switch output generated files"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
 #ifdef HAVE_AIO_SUPPORT
@@ -2059,6 +2080,13 @@ int cmd_record(int argc, const char **argv)
 		alarm(rec->switch_output.time);
 	}
 
+	if (rec->switch_output.num_files) {
+		rec->switch_output.filenames = calloc(sizeof(char *),
+						      rec->switch_output.num_files);
+		if (!rec->switch_output.filenames)
+			return -EINVAL;
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index c6b67efea11a..6a64f713710d 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -361,9 +361,9 @@ ssize_t perf_data__write(struct perf_data *data,
 
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
-			   size_t pos, bool at_exit)
+			   size_t pos, bool at_exit,
+			   char **new_filepath)
 {
-	char *new_filepath;
 	int ret;
 
 	if (check_pipe(data))
@@ -371,15 +371,15 @@ int perf_data__switch(struct perf_data *data,
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-	if (asprintf(&new_filepath, "%s.%s", data->path, postfix) < 0)
+	if (asprintf(new_filepath, "%s.%s", data->path, postfix) < 0)
 		return -ENOMEM;
 
 	/*
 	 * Only fire a warning, don't return error, continue fill
 	 * original file.
 	 */
-	if (rename(data->path, new_filepath))
-		pr_warning("Failed to rename %s to %s\n", data->path, new_filepath);
+	if (rename(data->path, *new_filepath))
+		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
 		close(data->file.fd);
@@ -396,7 +396,6 @@ int perf_data__switch(struct perf_data *data,
 	}
 	ret = data->file.fd;
 out:
-	free(new_filepath);
 	return ret;
 }
 
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 6aef8746469f..259868a39019 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -70,7 +70,7 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
  */
 int perf_data__switch(struct perf_data *data,
 			   const char *postfix,
-			   size_t pos, bool at_exit);
+			   size_t pos, bool at_exit, char **new_filepath);
 
 int perf_data__create_dir(struct perf_data *data, int nr);
 int perf_data__open_dir(struct perf_data *data);
