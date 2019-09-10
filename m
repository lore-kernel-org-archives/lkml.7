Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4F4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EAA21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTp1PUS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393129AbfIJL5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:57:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43739 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392956AbfIJL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so14905237wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9oggadqo//5FtNHKx2jdFdUWzoATro1ikb31coyYYI=;
        b=bTp1PUS3Z5bMMkdNcaOM8y5T4F95uMErsTVg+BHYorLfez9asaBj35Nw53EDM9sdT/
         zXW1RzFperDXJiDwvRRF4nStFyFc7fxonUqN8MDZNtgFzsGokPc7C318EssXZhVkv4pL
         EFTPPlfz0Q2d1J/WJs6mVW8E2jXTWOhd8wNyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9oggadqo//5FtNHKx2jdFdUWzoATro1ikb31coyYYI=;
        b=CQYl48D6XbFNYUv+ekXJFK92YKtLrHJTVQNMekqN2+5nO4eCarYoBaZLIj3SkQ/+P0
         1P+wGAU4CZLofOUeqC/SMjTJFY5bNff/+vjLv7v7qXkIqrMvb3qlo6fL66UT3QjoT8po
         yA1r+rLU/d5wbi5PntHq0LBqK+lAnOLzabJg/uacJ9q1mLLKmvEpu5B2D0JiEdjbp8ak
         w4uPZ5VFU9aMG/2KQ1tGAyUhd4pnbrR+BTfrRaZ5xDaRG+k0MDR3IwjmZbWR20HlSFPj
         ichvGavXhNnJlp6ljm3NcoSc0Vy6w/0O1Z4C+P3t3XN8vSTOXFB/Jn2Dwpw8yJUxwgox
         FJAw==
X-Gm-Message-State: APjAAAUYMKEjnk4OS81PcO9EeP5/sBp6vhW1uVsFtcG8F0FCWKJbhLoa
        j2Io/jn93BRJT5Rm1ITkugLCpnOu1KY=
X-Google-Smtp-Source: APXvYqxVfjrIddTA8bsV5am8Cb4uN3Xue2sI0Y2t94RDurY57DjHjCKpgbH0KcvKK5FQZimJkzyHsg==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr25354235wrn.299.1568116605922;
        Tue, 10 Sep 2019 04:56:45 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:45 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 13/14] krsi: Provide an example to read and log environment variables
Date:   Tue, 10 Sep 2019 13:55:26 +0200
Message-Id: <20190910115527.5235-14-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

	*  The program takes the name of an environment variable as an
	   argument.
	*  An eBPF program is loaded and attached to the
	   process_execution hook.
	*  The name of the environment variable passed is updated in a
	   eBPF per-cpu map.
	*  The eBPF program uses the krsi_get_env_var helper to get the
	   the value of this variable and logs the result to the perf
	   events buffer.
	*  The user-space program listens to the perf events and prints
	   the values.

Example execution:

	./krsi LD_PRELOAD

	[p_pid=123] LD_PRELOAD is not set
	[p_pid=456] LD_PRELOAD=/lib/bad.so
	[p_pid=789] WARNING! LD_PRELOAD is set 2 times
	[p_pid=789] LD_PRELOAD=/lib/decoy.so
	[p_pid=789] LD_PRELOAD=/lib/bad.so

In a separate session the following [1, 2, 3] exec system calls
are made where:

	[1, 2, 3] char *argv[] = {"/bin/ls", 0};

	[1] char *envp = {0};
	[2] char *envp = {"LD_PRELOAD=/lib/bad.so", 0};
	[3] char *envp = {"LD_PRELOAD=/lib/decoy.so, "LD_PRELOAD=/lib/bad.so", 0};

This example demonstrates that user-space is free to choose the format
in which the data is logged and can use very specific helpers like
krsi_get_env_var to populate only the data that is required.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS                |   3 +
 samples/bpf/.gitignore     |   1 +
 samples/bpf/Makefile       |   3 +
 samples/bpf/krsi_helpers.h |  31 ++++++
 samples/bpf/krsi_kern.c    |  52 ++++++++++
 samples/bpf/krsi_user.c    | 202 +++++++++++++++++++++++++++++++++++++
 6 files changed, 292 insertions(+)
 create mode 100644 samples/bpf/krsi_helpers.h
 create mode 100644 samples/bpf/krsi_kern.c
 create mode 100644 samples/bpf/krsi_user.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0364391d8b..ec378abb4c23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9005,6 +9005,9 @@ F:	kernel/kprobes.c
 KRSI SECURITY MODULE
 M:	KP Singh <kpsingh@chromium.org>
 S:	Supported
+F:	samples/bpf/krsi_helpers.h
+F:	samples/bpf/krsi_kern.c
+F:	samples/bpf/krsi_user.c
 F:	security/krsi/
 
 KS0108 LCD CONTROLLER DRIVER
diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 74d31fd3c99c..6bbf5a04877f 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -2,6 +2,7 @@ cpustat
 fds_example
 hbm
 ibumad
+krsi
 lathist
 lwt_len_hist
 map_perf_test
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1d9be26b4edd..33d3bef17549 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -8,6 +8,7 @@ hostprogs-y := test_lru_dist
 hostprogs-y += sock_example
 hostprogs-y += fds_example
 hostprogs-y += sockex1
+hostprogs-y += krsi
 hostprogs-y += sockex2
 hostprogs-y += sockex3
 hostprogs-y += tracex1
@@ -62,6 +63,7 @@ TRACE_HELPERS := ../../tools/testing/selftests/bpf/trace_helpers.o
 
 fds_example-objs := fds_example.o
 sockex1-objs := sockex1_user.o
+krsi-objs := krsi_user.o $(TRACE_HELPERS)
 sockex2-objs := sockex2_user.o
 sockex3-objs := bpf_load.o sockex3_user.o
 tracex1-objs := bpf_load.o tracex1_user.o
@@ -113,6 +115,7 @@ hbm-objs := bpf_load.o hbm.o $(CGROUP_HELPERS)
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 always += sockex1_kern.o
+always += krsi_kern.o
 always += sockex2_kern.o
 always += sockex3_kern.o
 always += tracex1_kern.o
diff --git a/samples/bpf/krsi_helpers.h b/samples/bpf/krsi_helpers.h
new file mode 100644
index 000000000000..3007bfd6212e
--- /dev/null
+++ b/samples/bpf/krsi_helpers.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KRSI_HELPERS_H
+#define _KRSI_HELPERS_H
+
+#define __bpf_percpu_val_align __aligned(8)
+
+#define ENV_VAR_NAME_MAX_LEN 48
+#define ENV_VAR_VAL_MAX_LEN 4096
+
+#define MAX_CPUS 128
+
+#define __LOWER(x) (x & 0xffffffff)
+#define __UPPER(x) (x >> 32)
+
+struct krsi_env_value {
+	// The name of the environment variable.
+	char name[ENV_VAR_NAME_MAX_LEN];
+	// The value of the environment variable (if set).
+	char value[ENV_VAR_VAL_MAX_LEN];
+	// Indicates if an overflow occurred while reading the value of the
+	// of the environment variable. This means that an -E2BIG was received
+	// from the krsi_get_env_var helper.
+	bool overflow;
+	// The number of times the environment variable was set.
+	__u32 times;
+	// The PID of the parent process.
+	__u32 p_pid;
+} __bpf_percpu_val_align;
+
+#endif // _KRSI_HELPERS_H
diff --git a/samples/bpf/krsi_kern.c b/samples/bpf/krsi_kern.c
new file mode 100644
index 000000000000..087a6f0cc81d
--- /dev/null
+++ b/samples/bpf/krsi_kern.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <uapi/linux/bpf.h>
+#include <uapi/linux/ip.h>
+#include "bpf_helpers.h"
+#include "krsi_helpers.h"
+
+#define MAX_CPUS 128
+
+struct bpf_map_def SEC("maps") env_map = {
+	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
+	.key_size = sizeof(u32),
+	.value_size = sizeof(struct krsi_env_value),
+	.max_entries = 1,
+};
+
+struct bpf_map_def SEC("maps") perf_map = {
+	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+	.key_size = sizeof(int),
+	.value_size = sizeof(u32),
+	.max_entries = MAX_CPUS,
+};
+
+SEC("krsi")
+int env_dumper(void *ctx)
+{
+	u64 times_ret;
+	s32 ret;
+	u32 map_id = 0;
+	char *map_value;
+	struct krsi_env_value *env;
+
+	env = bpf_map_lookup_elem(&env_map, &map_id);
+	if (!env)
+		return -ENOMEM;
+	times_ret = krsi_get_env_var(ctx, env->name, ENV_VAR_NAME_MAX_LEN,
+				     env->value, ENV_VAR_VAL_MAX_LEN);
+	ret = __LOWER(times_ret);
+	if (ret == -E2BIG)
+		env->overflow = true;
+	else if (ret < 0)
+		return ret;
+
+	env->times = __UPPER(times_ret);
+	env->p_pid = bpf_get_current_pid_tgid();
+	bpf_perf_event_output(ctx, &perf_map, BPF_F_CURRENT_CPU, env,
+			      sizeof(struct krsi_env_value));
+
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/krsi_user.c b/samples/bpf/krsi_user.c
new file mode 100644
index 000000000000..1fad29bf017a
--- /dev/null
+++ b/samples/bpf/krsi_user.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <err.h>
+#include <assert.h>
+#include <linux/limits.h>
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+#include "bpf/libbpf.h"
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysinfo.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <sys/resource.h>
+
+#include "perf-sys.h"
+#include "trace_helpers.h"
+#include "krsi_helpers.h"
+
+#define LSM_HOOK_PATH "/sys/kernel/security/krsi/process_execution"
+
+static int pmu_fds[MAX_CPUS];
+static struct perf_event_mmap_page *headers[MAX_CPUS];
+
+static int print_env(void *d, int size)
+{
+	struct krsi_env_value *env = d;
+	int times = env->times;
+	char *next = env->value;
+	size_t total = 0;
+
+	if (env->times > 1)
+		printf("[p_pid=%u] WARNING! %s is set %u times\n",
+			env->p_pid, env->name, env->times);
+
+	/*
+	 * krsi_get_env_var ensures that even overflows
+	 * are null terminated. Incase of an overflow,
+	 * this logic tries to print as much information
+	 * that was gathered.
+	 */
+	while (times && total < ENV_VAR_NAME_MAX_LEN) {
+		next += total;
+		if (env->overflow)
+			printf("[p_pid=%u] OVERFLOW! %s=%s\n",
+			       env->p_pid, env->name, next);
+		else
+			printf("[p_pid=%u] %s=%s\n",
+			       env->p_pid, env->name, next);
+		times--;
+		total += strlen(next) + 1;
+	}
+
+	if (!env->times)
+		printf("p_pid=%u] %s is not set\n",
+		       env->p_pid, env->name);
+
+	return LIBBPF_PERF_EVENT_CONT;
+}
+
+static int open_perf_events(int map_fd, int num)
+{
+	int i;
+	struct perf_event_attr attr = {
+		.sample_type = PERF_SAMPLE_RAW,
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_BPF_OUTPUT,
+		.wakeup_events = 1, /* get an fd notification for every event */
+	};
+
+	for (i = 0; i < num; i++) {
+		int key = i;
+		int ret;
+
+		ret = sys_perf_event_open(&attr, -1 /*pid*/, i/*cpu*/,
+					 -1/*group_fd*/, 0);
+		if (ret < 0)
+			return ret;
+		pmu_fds[i] = ret;
+		ret = bpf_map_update_elem(map_fd, &key, &pmu_fds[i], BPF_ANY);
+		if (ret < 0)
+			return ret;
+		ioctl(pmu_fds[i], PERF_EVENT_IOC_ENABLE, 0);
+	}
+	return 0;
+}
+
+static int update_env_map(struct bpf_object *prog_obj, const char *env_var_name,
+			  int numcpus)
+{
+	struct bpf_map *map;
+	struct krsi_env_value *env;
+	int map_fd;
+	int key = 0, ret = 0, i;
+
+	map = bpf_object__find_map_by_name(prog_obj, "env_map");
+	if (!map)
+		return -EINVAL;
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0)
+		return map_fd;
+
+	env = malloc(numcpus * sizeof(struct krsi_env_value));
+	if (!env) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < numcpus; i++)
+		strcpy(env[i].name, env_var_name);
+
+	ret = bpf_map_update_elem(map_fd, &key, env, BPF_ANY);
+	if (ret < 0)
+		goto out;
+
+out:
+	free(env);
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	struct bpf_object *prog_obj;
+	const char *env_var_name;
+	struct bpf_prog_load_attr attr;
+	int prog_fd, target_fd, map_fd;
+	int ret, i, numcpus;
+	struct bpf_map *map;
+	char filename[PATH_MAX];
+	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
+
+
+	if (argc != 2)
+		errx(EXIT_FAILURE, "Usage %s env_var_name\n", argv[0]);
+
+	env_var_name = argv[1];
+	if (strlen(env_var_name) > ENV_VAR_NAME_MAX_LEN - 1)
+		errx(EXIT_FAILURE,
+		     "<env_var_name> cannot be more than %d in length",
+		     ENV_VAR_NAME_MAX_LEN - 1);
+
+
+	setrlimit(RLIMIT_MEMLOCK, &r);
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+
+	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
+	attr.prog_type = BPF_PROG_TYPE_KRSI;
+	attr.expected_attach_type = BPF_KRSI;
+	attr.file = filename;
+
+	/* Attach the BPF program to the given hook */
+	target_fd = open(LSM_HOOK_PATH, O_RDWR);
+	if (target_fd < 0)
+		err(EXIT_FAILURE, "Failed to open target file");
+
+	if (bpf_prog_load_xattr(&attr, &prog_obj, &prog_fd))
+		err(EXIT_FAILURE, "Failed to load eBPF program");
+
+	numcpus = get_nprocs();
+	if (numcpus > MAX_CPUS)
+		numcpus = MAX_CPUS;
+
+	ret = update_env_map(prog_obj, env_var_name, numcpus);
+	if (ret < 0)
+		err(EXIT_FAILURE, "Failed to update env map");
+
+	map = bpf_object__find_map_by_name(prog_obj, "perf_map");
+	if (!map)
+		err(EXIT_FAILURE,
+		    "Finding the perf event map in obj file failed");
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0)
+		err(EXIT_FAILURE, "Failed to get fd for perf events map");
+
+	ret = bpf_prog_attach(prog_fd, target_fd, BPF_KRSI,
+			      BPF_F_ALLOW_OVERRIDE);
+	if (ret < 0)
+		err(EXIT_FAILURE, "Failed to attach prog to LSM hook");
+
+	ret = open_perf_events(map_fd, numcpus);
+	if (ret < 0)
+		err(EXIT_FAILURE, "Failed to open perf events handler");
+
+	for (i = 0; i < numcpus; i++) {
+		ret = perf_event_mmap_header(pmu_fds[i], &headers[i]);
+		if (ret < 0)
+			err(EXIT_FAILURE, "perf_event_mmap_header");
+	}
+
+	ret = perf_event_poller_multi(pmu_fds, headers, numcpus, print_env);
+	if (ret < 0)
+		err(EXIT_FAILURE, "Failed to poll perf events");
+
+	return EXIT_SUCCESS;
+}
-- 
2.20.1

