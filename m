Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0EBC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15201206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfIPI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:58:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:49388 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbfIPI6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:58:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 01:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="211088547"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2019 01:58:02 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] perf record: Put a copy of kcore into the perf.data directory
Date:   Mon, 16 Sep 2019 11:56:46 +0300
Message-Id: <20190916085646.6199-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916085646.6199-1-adrian.hunter@intel.com>
References: <20190916085646.6199-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new 'perf record' option '--kcore' which will put a copy of /proc/kcore,
kallsyms and modules into the perf.data directory.

Example:

$ sudo perf record --kcore uname

$ sudo tree perf.data
perf.data
├── kcore_dir
│   ├── kallsyms
│   ├── kcore
│   └── modules
└── perf.data

$ sudo perf script -v
build id event received for vmlinux: 1eaa285996affce2d74d8e66dcea09a80c9941de
build id event received for [vdso]: 8bbaf5dc62a9b644b4d4e4539737e104e4a84541
Samples for 'cycles' event do not have CPU attribute set. Skipping 'cpu' field.
Using CPUID GenuineIntel-6-8E-A
Using perf.data/kcore_dir/kcore for kernel data
Using perf.data/kcore_dir/kallsyms for symbols
            perf 19058 506778.423729:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
            perf 19058 506778.423733:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
            perf 19058 506778.423734:          7 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
            perf 19058 506778.423736:        117 cycles:  ffffffffa2caa54a native_write_msr+0xa (vmlinux)
            perf 19058 506778.423738:       2092 cycles:  ffffffffa2c9b7b0 native_apic_msr_write+0x0 (vmlinux)
            perf 19058 506778.423740:      37380 cycles:  ffffffffa2f121d0 perf_event_addr_filters_exec+0x0 (vmlinux)
           uname 19058 506778.423751:     582673 cycles:  ffffffffa303a407 propagate_protected_usage+0x147 (vmlinux)
           uname 19058 506778.423892:    2241841 cycles:  ffffffffa2cae0c9 unwind_next_frame.part.5+0x79 (vmlinux)
           uname 19058 506778.424430:    2457397 cycles:  ffffffffa3019232 check_memory_region+0x52 (vmlinux)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt |  3 ++
 tools/perf/builtin-record.c              | 52 ++++++++++++++++++++++++
 tools/perf/util/data.c                   | 33 +++++++++++++++
 tools/perf/util/data.h                   |  2 +
 tools/perf/util/record.h                 |  1 +
 tools/perf/util/session.c                |  4 ++
 tools/perf/util/util.c                   | 17 ++++++++
 7 files changed, 112 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c6f9f31b6039..1d85e24aa453 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -571,6 +571,9 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
 
 Implies --tail-synthesize.
 
+--kcore::
+Make a copy of /proc/kcore and place it into a directory with the perf.data file.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c356a046dd3..b665ec7254b9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,9 @@
 #include <signal.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
@@ -696,6 +699,37 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 
 #endif
 
+static bool record__kcore_readable(struct machine *machine)
+{
+	char kcore[PATH_MAX];
+	int fd;
+
+	scnprintf(kcore, sizeof(kcore), "%s/proc/kcore", machine->root_dir);
+
+	fd = open(kcore, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+
+	return true;
+}
+
+static int record__kcore_copy(struct machine *machine, struct perf_data *data)
+{
+	char from_dir[PATH_MAX];
+	char kcore_dir[PATH_MAX];
+	int ret;
+
+	snprintf(from_dir, sizeof(from_dir), "%s/proc", machine->root_dir);
+
+	ret = perf_data__make_kcore_dir(data, kcore_dir, sizeof(kcore_dir));
+	if (ret)
+		return ret;
+
+	return kcore_copy(from_dir, kcore_dir);
+}
+
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
@@ -1378,6 +1412,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	session->header.env.comp_type  = PERF_COMP_ZSTD;
 	session->header.env.comp_level = rec->opts.comp_level;
 
+	if (rec->opts.kcore &&
+	    !record__kcore_readable(&session->machines.host)) {
+		pr_err("ERROR: kcore is not readable.\n");
+		return -1;
+	}
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
@@ -1409,6 +1449,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 	session->header.env.comp_mmap_len = session->evlist->mmap_len;
 
+	if (rec->opts.kcore) {
+		err = record__kcore_copy(&session->machines.host, data);
+		if (err) {
+			pr_err("ERROR: Failed to copy kcore\n");
+			goto out_child;
+		}
+	}
+
 	err = bpf__apply_obj_config();
 	if (err) {
 		char errbuf[BUFSIZ];
@@ -2179,6 +2227,7 @@ static struct option __record_options[] = {
 		     parse_cgroups),
 	OPT_UINTEGER('D', "delay", &record.opts.initial_delay,
 		  "ms to wait before starting measurement after program start"),
+	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
 	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
 		   "user to profile"),
 
@@ -2317,6 +2366,9 @@ int cmd_record(int argc, const char **argv)
 
 	}
 
+	if (rec->opts.kcore)
+		rec->data.is_dir = true;
+
 	if (rec->opts.comp_level != 0) {
 		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
 		rec->no_buildid = true;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 2fd3114d1167..86b2d6cf5f11 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -434,3 +434,36 @@ unsigned long perf_data__size(struct perf_data *data)
 
 	return size;
 }
+
+int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz)
+{
+	int ret;
+
+	if (!data->is_dir)
+		return -1;
+
+	ret = snprintf(buf, buf_sz, "%s/kcore_dir", data->path);
+	if (ret < 0 || (size_t)ret >= buf_sz)
+		return -1;
+
+	return mkdir(buf, S_IRWXU);
+}
+
+char *perf_data__kallsyms_name(struct perf_data *data)
+{
+	char *kallsyms_name;
+	struct stat st;
+
+	if (!data->is_dir)
+		return NULL;
+
+	if (asprintf(&kallsyms_name, "%s/kcore_dir/kallsyms", data->path) < 0)
+		return NULL;
+
+	if (stat(kallsyms_name, &st)) {
+		free(kallsyms_name);
+		return NULL;
+	}
+
+	return kallsyms_name;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 0c5994d969c7..cb906b524897 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -83,4 +83,6 @@ int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
+int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
+char *perf_data__kallsyms_name(struct perf_data *data);
 #endif /* __PERF_DATA_H */
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 00275afc524d..948bbcf9aef3 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -44,6 +44,7 @@ struct record_opts {
 	bool	      strict_freq;
 	bool	      sample_id;
 	bool	      no_bpf_event;
+	bool	      kcore;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6dd04bd092d1..00d3e75ca1f4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -224,6 +224,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			/* Open the directory data. */
 			if (data->is_multi_file && perf_data__open_dir(data))
 				goto out_delete;
+
+			if (!symbol_conf.kallsyms_name &&
+			    !symbol_conf.vmlinux_name)
+				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5ca7490afdd1..44568ce5082f 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -184,6 +184,21 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 	return rmdir(path);
 }
 
+static int rm_rf_kcore_dir(const char *path)
+{
+	char kcore_dir_path[PATH_MAX];
+	const char *pat[] = {
+		"kcore",
+		"kallsyms",
+		"modules",
+		NULL,
+	};
+
+	snprintf(kcore_dir_path, sizeof(kcore_dir_path), "%s/kcore_dir", path);
+
+	return rm_rf_depth_pat(kcore_dir_path, 0, pat);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
@@ -193,6 +208,8 @@ int rm_rf_perf_data(const char *path)
 		NULL,
 	};
 
+	rm_rf_kcore_dir(path);
+
 	return rm_rf_depth_pat(path, 0, pat);
 }
 
-- 
2.17.1

