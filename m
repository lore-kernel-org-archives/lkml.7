Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0861D2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405298AbfITQVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404596AbfITQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeU-00040s-Uf; Fri, 20 Sep 2019 18:20:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 07BF41C0E2E;
        Fri, 20 Sep 2019 18:20:58 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:57 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Move event synthesizing routines to
 separate .c file
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-s9zxxhk40s95pjng9panet16@git.kernel.org>
References: <tip-s9zxxhk40s95pjng9panet16@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899645796.24167.9429755872925427947.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     055c67ed39887c5563e9540470a4617c1b772aec
Gitweb:        https://git.kernel.org/tip/055c67ed39887c5563e9540470a4617c1b772aec
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 18 Sep 2019 16:08:52 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 10:28:21 -03:00

perf tools: Move event synthesizing routines to separate .c file

For better grouping, in time we may end up making most of these static,
i.e. generalizing the 'perf record' synthesizing code so that based on
the target it can do the right thing and call the needed synthesizers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s9zxxhk40s95pjng9panet16@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c        |    9 +-
 tools/perf/util/Build              |    1 +-
 tools/perf/util/cs-etm.c           |    1 +-
 tools/perf/util/event.c            | 1108 +----------------
 tools/perf/util/evsel.c            |  278 +----
 tools/perf/util/header.c           |  393 +------
 tools/perf/util/header.h           |   18 +-
 tools/perf/util/machine.c          |   25 +-
 tools/perf/util/namespaces.c       |   18 +-
 tools/perf/util/namespaces.h       |    2 +-
 tools/perf/util/session.c          |   71 +-
 tools/perf/util/stat.c             |   43 +-
 tools/perf/util/synthetic-events.c | 1884 +++++++++++++++++++++++++++-
 13 files changed, 1928 insertions(+), 1923 deletions(-)
 create mode 100644 tools/perf/util/synthetic-events.c

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 907d4d4..4bd11c9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1181,15 +1181,6 @@ static void workload_exec_failed_signal(int signo __maybe_unused,
 static void snapshot_sig_handler(int sig);
 static void alarm_sig_handler(int sig);
 
-int __weak
-perf_event__synth_time_conv(const struct perf_event_mmap_page *pc __maybe_unused,
-			    struct perf_tool *tool __maybe_unused,
-			    perf_event__handler_t process __maybe_unused,
-			    struct machine *machine __maybe_unused)
-{
-	return 0;
-}
-
 static const struct perf_event_mmap_page *
 perf_evlist__pick_pc(struct evlist *evlist)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0b4d8e0..fd89d6a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -86,6 +86,7 @@ perf-y += stat-display.o
 perf-y += record.o
 perf-y += srcline.o
 perf-y += srccode.o
+perf-y += synthetic-events.o
 perf-y += data.o
 perf-y += tsc.o
 perf-y += cloexec.o
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f87b9c1..6021974 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -35,6 +35,7 @@
 #include "thread.h"
 #include "thread-stack.h"
 #include <tools/libc_compat.h>
+#include "util/synthetic-events.h"
 
 #define MAX_TIMESTAMP (~0ULL)
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 043a08f..fc1e5a9 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,4 +1,3 @@
-#include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
@@ -9,7 +8,6 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
-#include <api/fs/fs.h>
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include "cpumap.h"
@@ -26,18 +24,16 @@
 #include "time-utils.h"
 #include <linux/ctype.h>
 #include "map.h"
+#include "util/namespaces.h"
 #include "symbol.h"
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
-#include "synthetic-events.h"
 #include "tool.h"
 #include "../perf.h"
 
-#define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
-
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
 	[PERF_RECORD_MMAP]			= "MMAP",
@@ -78,18 +74,6 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 };
 
-static const char *perf_ns__names[] = {
-	[NET_NS_INDEX]		= "net",
-	[UTS_NS_INDEX]		= "uts",
-	[IPC_NS_INDEX]		= "ipc",
-	[PID_NS_INDEX]		= "pid",
-	[USER_NS_INDEX]		= "user",
-	[MNT_NS_INDEX]		= "mnt",
-	[CGROUP_NS_INDEX]	= "cgroup",
-};
-
-unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
-
 const char *perf_event__name(unsigned int id)
 {
 	if (id >= ARRAY_SIZE(perf_event__names))
@@ -99,775 +83,6 @@ const char *perf_event__name(unsigned int id)
 	return perf_event__names[id];
 }
 
-static const char *perf_ns__name(unsigned int id)
-{
-	if (id >= ARRAY_SIZE(perf_ns__names))
-		return "UNKNOWN";
-	return perf_ns__names[id];
-}
-
-int perf_tool__process_synth_event(struct perf_tool *tool,
-				   union perf_event *event,
-				   struct machine *machine,
-				   perf_event__handler_t process)
-{
-	struct perf_sample synth_sample = {
-	.pid	   = -1,
-	.tid	   = -1,
-	.time	   = -1,
-	.stream_id = -1,
-	.cpu	   = -1,
-	.period	   = 1,
-	.cpumode   = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK,
-	};
-
-	return process(tool, event, &synth_sample, machine);
-};
-
-/*
- * Assumes that the first 4095 bytes of /proc/pid/stat contains
- * the comm, tgid and ppid.
- */
-static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
-				    pid_t *tgid, pid_t *ppid)
-{
-	char filename[PATH_MAX];
-	char bf[4096];
-	int fd;
-	size_t size = 0;
-	ssize_t n;
-	char *name, *tgids, *ppids;
-
-	*tgid = -1;
-	*ppid = -1;
-
-	snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
-
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		pr_debug("couldn't open %s\n", filename);
-		return -1;
-	}
-
-	n = read(fd, bf, sizeof(bf) - 1);
-	close(fd);
-	if (n <= 0) {
-		pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
-			   pid);
-		return -1;
-	}
-	bf[n] = '\0';
-
-	name = strstr(bf, "Name:");
-	tgids = strstr(bf, "Tgid:");
-	ppids = strstr(bf, "PPid:");
-
-	if (name) {
-		char *nl;
-
-		name = skip_spaces(name + 5);  /* strlen("Name:") */
-		nl = strchr(name, '\n');
-		if (nl)
-			*nl = '\0';
-
-		size = strlen(name);
-		if (size >= len)
-			size = len - 1;
-		memcpy(comm, name, size);
-		comm[size] = '\0';
-	} else {
-		pr_debug("Name: string not found for pid %d\n", pid);
-	}
-
-	if (tgids) {
-		tgids += 5;  /* strlen("Tgid:") */
-		*tgid = atoi(tgids);
-	} else {
-		pr_debug("Tgid: string not found for pid %d\n", pid);
-	}
-
-	if (ppids) {
-		ppids += 5;  /* strlen("PPid:") */
-		*ppid = atoi(ppids);
-	} else {
-		pr_debug("PPid: string not found for pid %d\n", pid);
-	}
-
-	return 0;
-}
-
-static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
-				    struct machine *machine,
-				    pid_t *tgid, pid_t *ppid)
-{
-	size_t size;
-
-	*ppid = -1;
-
-	memset(&event->comm, 0, sizeof(event->comm));
-
-	if (machine__is_host(machine)) {
-		if (perf_event__get_comm_ids(pid, event->comm.comm,
-					     sizeof(event->comm.comm),
-					     tgid, ppid) != 0) {
-			return -1;
-		}
-	} else {
-		*tgid = machine->pid;
-	}
-
-	if (*tgid < 0)
-		return -1;
-
-	event->comm.pid = *tgid;
-	event->comm.header.type = PERF_RECORD_COMM;
-
-	size = strlen(event->comm.comm) + 1;
-	size = PERF_ALIGN(size, sizeof(u64));
-	memset(event->comm.comm + size, 0, machine->id_hdr_size);
-	event->comm.header.size = (sizeof(event->comm) -
-				(sizeof(event->comm.comm) - size) +
-				machine->id_hdr_size);
-	event->comm.tid = pid;
-
-	return 0;
-}
-
-pid_t perf_event__synthesize_comm(struct perf_tool *tool,
-					 union perf_event *event, pid_t pid,
-					 perf_event__handler_t process,
-					 struct machine *machine)
-{
-	pid_t tgid, ppid;
-
-	if (perf_event__prepare_comm(event, pid, machine, &tgid, &ppid) != 0)
-		return -1;
-
-	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
-		return -1;
-
-	return tgid;
-}
-
-static void perf_event__get_ns_link_info(pid_t pid, const char *ns,
-					 struct perf_ns_link_info *ns_link_info)
-{
-	struct stat64 st;
-	char proc_ns[128];
-
-	sprintf(proc_ns, "/proc/%u/ns/%s", pid, ns);
-	if (stat64(proc_ns, &st) == 0) {
-		ns_link_info->dev = st.st_dev;
-		ns_link_info->ino = st.st_ino;
-	}
-}
-
-int perf_event__synthesize_namespaces(struct perf_tool *tool,
-				      union perf_event *event,
-				      pid_t pid, pid_t tgid,
-				      perf_event__handler_t process,
-				      struct machine *machine)
-{
-	u32 idx;
-	struct perf_ns_link_info *ns_link_info;
-
-	if (!tool || !tool->namespace_events)
-		return 0;
-
-	memset(&event->namespaces, 0, (sizeof(event->namespaces) +
-	       (NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
-	       machine->id_hdr_size));
-
-	event->namespaces.pid = tgid;
-	event->namespaces.tid = pid;
-
-	event->namespaces.nr_namespaces = NR_NAMESPACES;
-
-	ns_link_info = event->namespaces.link_info;
-
-	for (idx = 0; idx < event->namespaces.nr_namespaces; idx++)
-		perf_event__get_ns_link_info(pid, perf_ns__name(idx),
-					     &ns_link_info[idx]);
-
-	event->namespaces.header.type = PERF_RECORD_NAMESPACES;
-
-	event->namespaces.header.size = (sizeof(event->namespaces) +
-			(NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
-			machine->id_hdr_size);
-
-	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
-		return -1;
-
-	return 0;
-}
-
-static int perf_event__synthesize_fork(struct perf_tool *tool,
-				       union perf_event *event,
-				       pid_t pid, pid_t tgid, pid_t ppid,
-				       perf_event__handler_t process,
-				       struct machine *machine)
-{
-	memset(&event->fork, 0, sizeof(event->fork) + machine->id_hdr_size);
-
-	/*
-	 * for main thread set parent to ppid from status file. For other
-	 * threads set parent pid to main thread. ie., assume main thread
-	 * spawns all threads in a process
-	*/
-	if (tgid == pid) {
-		event->fork.ppid = ppid;
-		event->fork.ptid = ppid;
-	} else {
-		event->fork.ppid = tgid;
-		event->fork.ptid = tgid;
-	}
-	event->fork.pid  = tgid;
-	event->fork.tid  = pid;
-	event->fork.header.type = PERF_RECORD_FORK;
-	event->fork.header.misc = PERF_RECORD_MISC_FORK_EXEC;
-
-	event->fork.header.size = (sizeof(event->fork) + machine->id_hdr_size);
-
-	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
-		return -1;
-
-	return 0;
-}
-
-int perf_event__synthesize_mmap_events(struct perf_tool *tool,
-				       union perf_event *event,
-				       pid_t pid, pid_t tgid,
-				       perf_event__handler_t process,
-				       struct machine *machine,
-				       bool mmap_data)
-{
-	char filename[PATH_MAX];
-	FILE *fp;
-	unsigned long long t;
-	bool truncation = false;
-	unsigned long long timeout = proc_map_timeout * 1000000ULL;
-	int rc = 0;
-	const char *hugetlbfs_mnt = hugetlbfs__mountpoint();
-	int hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
-
-	if (machine__is_default_guest(machine))
-		return 0;
-
-	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
-		 machine->root_dir, pid, pid);
-
-	fp = fopen(filename, "r");
-	if (fp == NULL) {
-		/*
-		 * We raced with a task exiting - just return:
-		 */
-		pr_debug("couldn't open %s\n", filename);
-		return -1;
-	}
-
-	event->header.type = PERF_RECORD_MMAP2;
-	t = rdclock();
-
-	while (1) {
-		char bf[BUFSIZ];
-		char prot[5];
-		char execname[PATH_MAX];
-		char anonstr[] = "//anon";
-		unsigned int ino;
-		size_t size;
-		ssize_t n;
-
-		if (fgets(bf, sizeof(bf), fp) == NULL)
-			break;
-
-		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
-				   "You may want to increase "
-				   "the time limit by --proc-map-timeout\n",
-				   filename);
-			truncation = true;
-			goto out;
-		}
-
-		/* ensure null termination since stack will be reused. */
-		strcpy(execname, "");
-
-		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		n = sscanf(bf, "%"PRI_lx64"-%"PRI_lx64" %s %"PRI_lx64" %x:%x %u %[^\n]\n",
-		       &event->mmap2.start, &event->mmap2.len, prot,
-		       &event->mmap2.pgoff, &event->mmap2.maj,
-		       &event->mmap2.min,
-		       &ino, execname);
-
-		/*
- 		 * Anon maps don't have the execname.
- 		 */
-		if (n < 7)
-			continue;
-
-		event->mmap2.ino = (u64)ino;
-
-		/*
-		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
-		 */
-		if (machine__is_host(machine))
-			event->header.misc = PERF_RECORD_MISC_USER;
-		else
-			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
-
-		/* map protection and flags bits */
-		event->mmap2.prot = 0;
-		event->mmap2.flags = 0;
-		if (prot[0] == 'r')
-			event->mmap2.prot |= PROT_READ;
-		if (prot[1] == 'w')
-			event->mmap2.prot |= PROT_WRITE;
-		if (prot[2] == 'x')
-			event->mmap2.prot |= PROT_EXEC;
-
-		if (prot[3] == 's')
-			event->mmap2.flags |= MAP_SHARED;
-		else
-			event->mmap2.flags |= MAP_PRIVATE;
-
-		if (prot[2] != 'x') {
-			if (!mmap_data || prot[0] != 'r')
-				continue;
-
-			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
-		}
-
-out:
-		if (truncation)
-			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
-
-		if (!strcmp(execname, ""))
-			strcpy(execname, anonstr);
-
-		if (hugetlbfs_mnt_len &&
-		    !strncmp(execname, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
-			strcpy(execname, anonstr);
-			event->mmap2.flags |= MAP_HUGETLB;
-		}
-
-		size = strlen(execname) + 1;
-		memcpy(event->mmap2.filename, execname, size);
-		size = PERF_ALIGN(size, sizeof(u64));
-		event->mmap2.len -= event->mmap.start;
-		event->mmap2.header.size = (sizeof(event->mmap2) -
-					(sizeof(event->mmap2.filename) - size));
-		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
-		event->mmap2.header.size += machine->id_hdr_size;
-		event->mmap2.pid = tgid;
-		event->mmap2.tid = pid;
-
-		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
-			rc = -1;
-			break;
-		}
-
-		if (truncation)
-			break;
-	}
-
-	fclose(fp);
-	return rc;
-}
-
-int perf_event__synthesize_modules(struct perf_tool *tool,
-				   perf_event__handler_t process,
-				   struct machine *machine)
-{
-	int rc = 0;
-	struct map *pos;
-	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event = zalloc((sizeof(event->mmap) +
-					  machine->id_hdr_size));
-	if (event == NULL) {
-		pr_debug("Not enough memory synthesizing mmap event "
-			 "for kernel modules\n");
-		return -1;
-	}
-
-	event->header.type = PERF_RECORD_MMAP;
-
-	/*
-	 * kernel uses 0 for user space maps, see kernel/perf_event.c
-	 * __perf_event_mmap
-	 */
-	if (machine__is_host(machine))
-		event->header.misc = PERF_RECORD_MISC_KERNEL;
-	else
-		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
-
-	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
-		size_t size;
-
-		if (!__map__is_kmodule(pos))
-			continue;
-
-		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
-		event->mmap.header.type = PERF_RECORD_MMAP;
-		event->mmap.header.size = (sizeof(event->mmap) -
-				        (sizeof(event->mmap.filename) - size));
-		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-		event->mmap.header.size += machine->id_hdr_size;
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
-		event->mmap.pid   = machine->pid;
-
-		memcpy(event->mmap.filename, pos->dso->long_name,
-		       pos->dso->long_name_len + 1);
-		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
-			rc = -1;
-			break;
-		}
-	}
-
-	free(event);
-	return rc;
-}
-
-static int __event__synthesize_thread(union perf_event *comm_event,
-				      union perf_event *mmap_event,
-				      union perf_event *fork_event,
-				      union perf_event *namespaces_event,
-				      pid_t pid, int full,
-				      perf_event__handler_t process,
-				      struct perf_tool *tool,
-				      struct machine *machine,
-				      bool mmap_data)
-{
-	char filename[PATH_MAX];
-	DIR *tasks;
-	struct dirent *dirent;
-	pid_t tgid, ppid;
-	int rc = 0;
-
-	/* special case: only send one comm event using passed in pid */
-	if (!full) {
-		tgid = perf_event__synthesize_comm(tool, comm_event, pid,
-						   process, machine);
-
-		if (tgid == -1)
-			return -1;
-
-		if (perf_event__synthesize_namespaces(tool, namespaces_event, pid,
-						      tgid, process, machine) < 0)
-			return -1;
-
-		/*
-		 * send mmap only for thread group leader
-		 * see thread__init_map_groups
-		 */
-		if (pid == tgid &&
-		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-						       process, machine, mmap_data))
-			return -1;
-
-		return 0;
-	}
-
-	if (machine__is_default_guest(machine))
-		return 0;
-
-	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
-		 machine->root_dir, pid);
-
-	tasks = opendir(filename);
-	if (tasks == NULL) {
-		pr_debug("couldn't open %s\n", filename);
-		return 0;
-	}
-
-	while ((dirent = readdir(tasks)) != NULL) {
-		char *end;
-		pid_t _pid;
-
-		_pid = strtol(dirent->d_name, &end, 10);
-		if (*end)
-			continue;
-
-		rc = -1;
-		if (perf_event__prepare_comm(comm_event, _pid, machine,
-					     &tgid, &ppid) != 0)
-			break;
-
-		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
-						ppid, process, machine) < 0)
-			break;
-
-		if (perf_event__synthesize_namespaces(tool, namespaces_event, _pid,
-						      tgid, process, machine) < 0)
-			break;
-
-		/*
-		 * Send the prepared comm event
-		 */
-		if (perf_tool__process_synth_event(tool, comm_event, machine, process) != 0)
-			break;
-
-		rc = 0;
-		if (_pid == pid) {
-			/* process the parent's maps too */
-			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-						process, machine, mmap_data);
-			if (rc)
-				break;
-		}
-	}
-
-	closedir(tasks);
-	return rc;
-}
-
-int perf_event__synthesize_thread_map(struct perf_tool *tool,
-				      struct perf_thread_map *threads,
-				      perf_event__handler_t process,
-				      struct machine *machine,
-				      bool mmap_data)
-{
-	union perf_event *comm_event, *mmap_event, *fork_event;
-	union perf_event *namespaces_event;
-	int err = -1, thread, j;
-
-	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
-	if (comm_event == NULL)
-		goto out;
-
-	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
-	if (mmap_event == NULL)
-		goto out_free_comm;
-
-	fork_event = malloc(sizeof(fork_event->fork) + machine->id_hdr_size);
-	if (fork_event == NULL)
-		goto out_free_mmap;
-
-	namespaces_event = malloc(sizeof(namespaces_event->namespaces) +
-				  (NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
-				  machine->id_hdr_size);
-	if (namespaces_event == NULL)
-		goto out_free_fork;
-
-	err = 0;
-	for (thread = 0; thread < threads->nr; ++thread) {
-		if (__event__synthesize_thread(comm_event, mmap_event,
-					       fork_event, namespaces_event,
-					       perf_thread_map__pid(threads, thread), 0,
-					       process, tool, machine,
-					       mmap_data)) {
-			err = -1;
-			break;
-		}
-
-		/*
-		 * comm.pid is set to thread group id by
-		 * perf_event__synthesize_comm
-		 */
-		if ((int) comm_event->comm.pid != perf_thread_map__pid(threads, thread)) {
-			bool need_leader = true;
-
-			/* is thread group leader in thread_map? */
-			for (j = 0; j < threads->nr; ++j) {
-				if ((int) comm_event->comm.pid == perf_thread_map__pid(threads, j)) {
-					need_leader = false;
-					break;
-				}
-			}
-
-			/* if not, generate events for it */
-			if (need_leader &&
-			    __event__synthesize_thread(comm_event, mmap_event,
-						       fork_event, namespaces_event,
-						       comm_event->comm.pid, 0,
-						       process, tool, machine,
-						       mmap_data)) {
-				err = -1;
-				break;
-			}
-		}
-	}
-	free(namespaces_event);
-out_free_fork:
-	free(fork_event);
-out_free_mmap:
-	free(mmap_event);
-out_free_comm:
-	free(comm_event);
-out:
-	return err;
-}
-
-static int __perf_event__synthesize_threads(struct perf_tool *tool,
-					    perf_event__handler_t process,
-					    struct machine *machine,
-					    bool mmap_data,
-					    struct dirent **dirent,
-					    int start,
-					    int num)
-{
-	union perf_event *comm_event, *mmap_event, *fork_event;
-	union perf_event *namespaces_event;
-	int err = -1;
-	char *end;
-	pid_t pid;
-	int i;
-
-	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
-	if (comm_event == NULL)
-		goto out;
-
-	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
-	if (mmap_event == NULL)
-		goto out_free_comm;
-
-	fork_event = malloc(sizeof(fork_event->fork) + machine->id_hdr_size);
-	if (fork_event == NULL)
-		goto out_free_mmap;
-
-	namespaces_event = malloc(sizeof(namespaces_event->namespaces) +
-				  (NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
-				  machine->id_hdr_size);
-	if (namespaces_event == NULL)
-		goto out_free_fork;
-
-	for (i = start; i < start + num; i++) {
-		if (!isdigit(dirent[i]->d_name[0]))
-			continue;
-
-		pid = (pid_t)strtol(dirent[i]->d_name, &end, 10);
-		/* only interested in proper numerical dirents */
-		if (*end)
-			continue;
-		/*
-		 * We may race with exiting thread, so don't stop just because
-		 * one thread couldn't be synthesized.
-		 */
-		__event__synthesize_thread(comm_event, mmap_event, fork_event,
-					   namespaces_event, pid, 1, process,
-					   tool, machine, mmap_data);
-	}
-	err = 0;
-
-	free(namespaces_event);
-out_free_fork:
-	free(fork_event);
-out_free_mmap:
-	free(mmap_event);
-out_free_comm:
-	free(comm_event);
-out:
-	return err;
-}
-
-struct synthesize_threads_arg {
-	struct perf_tool *tool;
-	perf_event__handler_t process;
-	struct machine *machine;
-	bool mmap_data;
-	struct dirent **dirent;
-	int num;
-	int start;
-};
-
-static void *synthesize_threads_worker(void *arg)
-{
-	struct synthesize_threads_arg *args = arg;
-
-	__perf_event__synthesize_threads(args->tool, args->process,
-					 args->machine, args->mmap_data,
-					 args->dirent,
-					 args->start, args->num);
-	return NULL;
-}
-
-int perf_event__synthesize_threads(struct perf_tool *tool,
-				   perf_event__handler_t process,
-				   struct machine *machine,
-				   bool mmap_data,
-				   unsigned int nr_threads_synthesize)
-{
-	struct synthesize_threads_arg *args = NULL;
-	pthread_t *synthesize_threads = NULL;
-	char proc_path[PATH_MAX];
-	struct dirent **dirent;
-	int num_per_thread;
-	int m, n, i, j;
-	int thread_nr;
-	int base = 0;
-	int err = -1;
-
-
-	if (machine__is_default_guest(machine))
-		return 0;
-
-	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	n = scandir(proc_path, &dirent, 0, alphasort);
-	if (n < 0)
-		return err;
-
-	if (nr_threads_synthesize == UINT_MAX)
-		thread_nr = sysconf(_SC_NPROCESSORS_ONLN);
-	else
-		thread_nr = nr_threads_synthesize;
-
-	if (thread_nr <= 1) {
-		err = __perf_event__synthesize_threads(tool, process,
-						       machine, mmap_data,
-						       dirent, base, n);
-		goto free_dirent;
-	}
-	if (thread_nr > n)
-		thread_nr = n;
-
-	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
-	if (synthesize_threads == NULL)
-		goto free_dirent;
-
-	args = calloc(sizeof(*args), thread_nr);
-	if (args == NULL)
-		goto free_threads;
-
-	num_per_thread = n / thread_nr;
-	m = n % thread_nr;
-	for (i = 0; i < thread_nr; i++) {
-		args[i].tool = tool;
-		args[i].process = process;
-		args[i].machine = machine;
-		args[i].mmap_data = mmap_data;
-		args[i].dirent = dirent;
-	}
-	for (i = 0; i < m; i++) {
-		args[i].num = num_per_thread + 1;
-		args[i].start = i * args[i].num;
-	}
-	if (i != 0)
-		base = args[i-1].start + args[i-1].num;
-	for (j = i; j < thread_nr; j++) {
-		args[j].num = num_per_thread;
-		args[j].start = base + (j - i) * args[i].num;
-	}
-
-	for (i = 0; i < thread_nr; i++) {
-		if (pthread_create(&synthesize_threads[i], NULL,
-				   synthesize_threads_worker, &args[i]))
-			goto out_join;
-	}
-	err = 0;
-out_join:
-	for (i = 0; i < thread_nr; i++)
-		pthread_join(synthesize_threads[i], NULL);
-	free(args);
-free_threads:
-	free(synthesize_threads);
-free_dirent:
-	for (i = 0; i < n; i++)
-		zfree(&dirent[i]);
-	free(dirent);
-
-	return err;
-}
-
 struct process_symbol_args {
 	const char *name;
 	u64	   start;
@@ -902,327 +117,6 @@ int kallsyms__get_function_start(const char *kallsyms_filename,
 	return 0;
 }
 
-int __weak perf_event__synthesize_extra_kmaps(struct perf_tool *tool __maybe_unused,
-					      perf_event__handler_t process __maybe_unused,
-					      struct machine *machine __maybe_unused)
-{
-	return 0;
-}
-
-static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
-						perf_event__handler_t process,
-						struct machine *machine)
-{
-	size_t size;
-	struct map *map = machine__kernel_map(machine);
-	struct kmap *kmap;
-	int err;
-	union perf_event *event;
-
-	if (map == NULL)
-		return -1;
-
-	kmap = map__kmap(map);
-	if (!kmap->ref_reloc_sym)
-		return -1;
-
-	/*
-	 * We should get this from /sys/kernel/sections/.text, but till that is
-	 * available use this, and after it is use this as a fallback for older
-	 * kernels.
-	 */
-	event = zalloc((sizeof(event->mmap) + machine->id_hdr_size));
-	if (event == NULL) {
-		pr_debug("Not enough memory synthesizing mmap event "
-			 "for kernel modules\n");
-		return -1;
-	}
-
-	if (machine__is_host(machine)) {
-		/*
-		 * kernel uses PERF_RECORD_MISC_USER for user space maps,
-		 * see kernel/perf_event.c __perf_event_mmap
-		 */
-		event->header.misc = PERF_RECORD_MISC_KERNEL;
-	} else {
-		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
-	}
-
-	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
-			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
-	size = PERF_ALIGN(size, sizeof(u64));
-	event->mmap.header.type = PERF_RECORD_MMAP;
-	event->mmap.header.size = (sizeof(event->mmap) -
-			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
-	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
-	event->mmap.start = map->start;
-	event->mmap.len   = map->end - event->mmap.start;
-	event->mmap.pid   = machine->pid;
-
-	err = perf_tool__process_synth_event(tool, event, machine, process);
-	free(event);
-
-	return err;
-}
-
-int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
-				       perf_event__handler_t process,
-				       struct machine *machine)
-{
-	int err;
-
-	err = __perf_event__synthesize_kernel_mmap(tool, process, machine);
-	if (err < 0)
-		return err;
-
-	return perf_event__synthesize_extra_kmaps(tool, process, machine);
-}
-
-int perf_event__synthesize_thread_map2(struct perf_tool *tool,
-				      struct perf_thread_map *threads,
-				      perf_event__handler_t process,
-				      struct machine *machine)
-{
-	union perf_event *event;
-	int i, err, size;
-
-	size  = sizeof(event->thread_map);
-	size +=	threads->nr * sizeof(event->thread_map.entries[0]);
-
-	event = zalloc(size);
-	if (!event)
-		return -ENOMEM;
-
-	event->header.type = PERF_RECORD_THREAD_MAP;
-	event->header.size = size;
-	event->thread_map.nr = threads->nr;
-
-	for (i = 0; i < threads->nr; i++) {
-		struct perf_record_thread_map_entry *entry = &event->thread_map.entries[i];
-		char *comm = perf_thread_map__comm(threads, i);
-
-		if (!comm)
-			comm = (char *) "";
-
-		entry->pid = perf_thread_map__pid(threads, i);
-		strncpy((char *) &entry->comm, comm, sizeof(entry->comm));
-	}
-
-	err = process(tool, event, NULL, machine);
-
-	free(event);
-	return err;
-}
-
-static void synthesize_cpus(struct cpu_map_entries *cpus,
-			    struct perf_cpu_map *map)
-{
-	int i;
-
-	cpus->nr = map->nr;
-
-	for (i = 0; i < map->nr; i++)
-		cpus->cpu[i] = map->map[i];
-}
-
-static void synthesize_mask(struct perf_record_record_cpu_map *mask,
-			    struct perf_cpu_map *map, int max)
-{
-	int i;
-
-	mask->nr = BITS_TO_LONGS(max);
-	mask->long_size = sizeof(long);
-
-	for (i = 0; i < map->nr; i++)
-		set_bit(map->map[i], mask->mask);
-}
-
-static size_t cpus_size(struct perf_cpu_map *map)
-{
-	return sizeof(struct cpu_map_entries) + map->nr * sizeof(u16);
-}
-
-static size_t mask_size(struct perf_cpu_map *map, int *max)
-{
-	int i;
-
-	*max = 0;
-
-	for (i = 0; i < map->nr; i++) {
-		/* bit possition of the cpu is + 1 */
-		int bit = map->map[i] + 1;
-
-		if (bit > *max)
-			*max = bit;
-	}
-
-	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
-}
-
-void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max)
-{
-	size_t size_cpus, size_mask;
-	bool is_dummy = perf_cpu_map__empty(map);
-
-	/*
-	 * Both array and mask data have variable size based
-	 * on the number of cpus and their actual values.
-	 * The size of the 'struct perf_record_cpu_map_data' is:
-	 *
-	 *   array = size of 'struct cpu_map_entries' +
-	 *           number of cpus * sizeof(u64)
-	 *
-	 *   mask  = size of 'struct perf_record_record_cpu_map' +
-	 *           maximum cpu bit converted to size of longs
-	 *
-	 * and finaly + the size of 'struct perf_record_cpu_map_data'.
-	 */
-	size_cpus = cpus_size(map);
-	size_mask = mask_size(map, max);
-
-	if (is_dummy || (size_cpus < size_mask)) {
-		*size += size_cpus;
-		*type  = PERF_CPU_MAP__CPUS;
-	} else {
-		*size += size_mask;
-		*type  = PERF_CPU_MAP__MASK;
-	}
-
-	*size += sizeof(struct perf_record_cpu_map_data);
-	*size = PERF_ALIGN(*size, sizeof(u64));
-	return zalloc(*size);
-}
-
-void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf_cpu_map *map,
-			      u16 type, int max)
-{
-	data->type = type;
-
-	switch (type) {
-	case PERF_CPU_MAP__CPUS:
-		synthesize_cpus((struct cpu_map_entries *) data->data, map);
-		break;
-	case PERF_CPU_MAP__MASK:
-		synthesize_mask((struct perf_record_record_cpu_map *)data->data, map, max);
-	default:
-		break;
-	};
-}
-
-static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
-{
-	size_t size = sizeof(struct perf_record_cpu_map);
-	struct perf_record_cpu_map *event;
-	int max;
-	u16 type;
-
-	event = cpu_map_data__alloc(map, &size, &type, &max);
-	if (!event)
-		return NULL;
-
-	event->header.type = PERF_RECORD_CPU_MAP;
-	event->header.size = size;
-	event->data.type   = type;
-
-	cpu_map_data__synthesize(&event->data, map, type, max);
-	return event;
-}
-
-int perf_event__synthesize_cpu_map(struct perf_tool *tool,
-				   struct perf_cpu_map *map,
-				   perf_event__handler_t process,
-				   struct machine *machine)
-{
-	struct perf_record_cpu_map *event;
-	int err;
-
-	event = cpu_map_event__new(map);
-	if (!event)
-		return -ENOMEM;
-
-	err = process(tool, (union perf_event *) event, NULL, machine);
-
-	free(event);
-	return err;
-}
-
-int perf_event__synthesize_stat_config(struct perf_tool *tool,
-				       struct perf_stat_config *config,
-				       perf_event__handler_t process,
-				       struct machine *machine)
-{
-	struct perf_record_stat_config *event;
-	int size, i = 0, err;
-
-	size  = sizeof(*event);
-	size += (PERF_STAT_CONFIG_TERM__MAX * sizeof(event->data[0]));
-
-	event = zalloc(size);
-	if (!event)
-		return -ENOMEM;
-
-	event->header.type = PERF_RECORD_STAT_CONFIG;
-	event->header.size = size;
-	event->nr          = PERF_STAT_CONFIG_TERM__MAX;
-
-#define ADD(__term, __val)					\
-	event->data[i].tag = PERF_STAT_CONFIG_TERM__##__term;	\
-	event->data[i].val = __val;				\
-	i++;
-
-	ADD(AGGR_MODE,	config->aggr_mode)
-	ADD(INTERVAL,	config->interval)
-	ADD(SCALE,	config->scale)
-
-	WARN_ONCE(i != PERF_STAT_CONFIG_TERM__MAX,
-		  "stat config terms unbalanced\n");
-#undef ADD
-
-	err = process(tool, (union perf_event *) event, NULL, machine);
-
-	free(event);
-	return err;
-}
-
-int perf_event__synthesize_stat(struct perf_tool *tool,
-				u32 cpu, u32 thread, u64 id,
-				struct perf_counts_values *count,
-				perf_event__handler_t process,
-				struct machine *machine)
-{
-	struct perf_record_stat event;
-
-	event.header.type = PERF_RECORD_STAT;
-	event.header.size = sizeof(event);
-	event.header.misc = 0;
-
-	event.id        = id;
-	event.cpu       = cpu;
-	event.thread    = thread;
-	event.val       = count->val;
-	event.ena       = count->ena;
-	event.run       = count->run;
-
-	return process(tool, (union perf_event *) &event, NULL, machine);
-}
-
-int perf_event__synthesize_stat_round(struct perf_tool *tool,
-				      u64 evtime, u64 type,
-				      perf_event__handler_t process,
-				      struct machine *machine)
-{
-	struct perf_record_stat_round event;
-
-	event.header.type = PERF_RECORD_STAT_ROUND;
-	event.header.size = sizeof(event);
-	event.header.misc = 0;
-
-	event.time = evtime;
-	event.type = type;
-
-	return process(tool, (union perf_event *) &event, NULL, machine);
-}
-
 void perf_event__read_stat_config(struct perf_stat_config *config,
 				  struct perf_record_stat_config *event)
 {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5af025c..8e335d1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -40,7 +40,6 @@
 #include "trace-event.h"
 #include "stat.h"
 #include "string2.h"
-#include "util/synthetic-events.h"
 #include "memswap.h"
 #include "util.h"
 #include "../perf-sys.h"
@@ -2421,283 +2420,6 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 	return 0;
 }
 
-size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
-				     u64 read_format)
-{
-	size_t sz, result = sizeof(struct perf_record_sample);
-
-	if (type & PERF_SAMPLE_IDENTIFIER)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_IP)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_TID)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_TIME)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_ADDR)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_ID)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_STREAM_ID)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_CPU)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_PERIOD)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_READ) {
-		result += sizeof(u64);
-		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-			result += sizeof(u64);
-		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-			result += sizeof(u64);
-		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
-		if (read_format & PERF_FORMAT_GROUP) {
-			sz = sample->read.group.nr *
-			     sizeof(struct sample_read_value);
-			result += sz;
-		} else {
-			result += sizeof(u64);
-		}
-	}
-
-	if (type & PERF_SAMPLE_CALLCHAIN) {
-		sz = (sample->callchain->nr + 1) * sizeof(u64);
-		result += sz;
-	}
-
-	if (type & PERF_SAMPLE_RAW) {
-		result += sizeof(u32);
-		result += sample->raw_size;
-	}
-
-	if (type & PERF_SAMPLE_BRANCH_STACK) {
-		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		sz += sizeof(u64);
-		result += sz;
-	}
-
-	if (type & PERF_SAMPLE_REGS_USER) {
-		if (sample->user_regs.abi) {
-			result += sizeof(u64);
-			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
-			result += sz;
-		} else {
-			result += sizeof(u64);
-		}
-	}
-
-	if (type & PERF_SAMPLE_STACK_USER) {
-		sz = sample->user_stack.size;
-		result += sizeof(u64);
-		if (sz) {
-			result += sz;
-			result += sizeof(u64);
-		}
-	}
-
-	if (type & PERF_SAMPLE_WEIGHT)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_DATA_SRC)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_TRANSACTION)
-		result += sizeof(u64);
-
-	if (type & PERF_SAMPLE_REGS_INTR) {
-		if (sample->intr_regs.abi) {
-			result += sizeof(u64);
-			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
-			result += sz;
-		} else {
-			result += sizeof(u64);
-		}
-	}
-
-	if (type & PERF_SAMPLE_PHYS_ADDR)
-		result += sizeof(u64);
-
-	return result;
-}
-
-int perf_event__synthesize_sample(union perf_event *event, u64 type,
-				  u64 read_format,
-				  const struct perf_sample *sample)
-{
-	__u64 *array;
-	size_t sz;
-	/*
-	 * used for cross-endian analysis. See git commit 65014ab3
-	 * for why this goofiness is needed.
-	 */
-	union u64_swap u;
-
-	array = event->sample.array;
-
-	if (type & PERF_SAMPLE_IDENTIFIER) {
-		*array = sample->id;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_IP) {
-		*array = sample->ip;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_TID) {
-		u.val32[0] = sample->pid;
-		u.val32[1] = sample->tid;
-		*array = u.val64;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_TIME) {
-		*array = sample->time;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_ADDR) {
-		*array = sample->addr;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_ID) {
-		*array = sample->id;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_STREAM_ID) {
-		*array = sample->stream_id;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_CPU) {
-		u.val32[0] = sample->cpu;
-		u.val32[1] = 0;
-		*array = u.val64;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_PERIOD) {
-		*array = sample->period;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_READ) {
-		if (read_format & PERF_FORMAT_GROUP)
-			*array = sample->read.group.nr;
-		else
-			*array = sample->read.one.value;
-		array++;
-
-		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
-			*array = sample->read.time_enabled;
-			array++;
-		}
-
-		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
-			*array = sample->read.time_running;
-			array++;
-		}
-
-		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
-		if (read_format & PERF_FORMAT_GROUP) {
-			sz = sample->read.group.nr *
-			     sizeof(struct sample_read_value);
-			memcpy(array, sample->read.group.values, sz);
-			array = (void *)array + sz;
-		} else {
-			*array = sample->read.one.id;
-			array++;
-		}
-	}
-
-	if (type & PERF_SAMPLE_CALLCHAIN) {
-		sz = (sample->callchain->nr + 1) * sizeof(u64);
-		memcpy(array, sample->callchain, sz);
-		array = (void *)array + sz;
-	}
-
-	if (type & PERF_SAMPLE_RAW) {
-		u.val32[0] = sample->raw_size;
-		*array = u.val64;
-		array = (void *)array + sizeof(u32);
-
-		memcpy(array, sample->raw_data, sample->raw_size);
-		array = (void *)array + sample->raw_size;
-	}
-
-	if (type & PERF_SAMPLE_BRANCH_STACK) {
-		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		sz += sizeof(u64);
-		memcpy(array, sample->branch_stack, sz);
-		array = (void *)array + sz;
-	}
-
-	if (type & PERF_SAMPLE_REGS_USER) {
-		if (sample->user_regs.abi) {
-			*array++ = sample->user_regs.abi;
-			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
-			memcpy(array, sample->user_regs.regs, sz);
-			array = (void *)array + sz;
-		} else {
-			*array++ = 0;
-		}
-	}
-
-	if (type & PERF_SAMPLE_STACK_USER) {
-		sz = sample->user_stack.size;
-		*array++ = sz;
-		if (sz) {
-			memcpy(array, sample->user_stack.data, sz);
-			array = (void *)array + sz;
-			*array++ = sz;
-		}
-	}
-
-	if (type & PERF_SAMPLE_WEIGHT) {
-		*array = sample->weight;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_DATA_SRC) {
-		*array = sample->data_src;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_TRANSACTION) {
-		*array = sample->transaction;
-		array++;
-	}
-
-	if (type & PERF_SAMPLE_REGS_INTR) {
-		if (sample->intr_regs.abi) {
-			*array++ = sample->intr_regs.abi;
-			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
-			memcpy(array, sample->intr_regs.regs, sz);
-			array = (void *)array + sz;
-		} else {
-			*array++ = 0;
-		}
-	}
-
-	if (type & PERF_SAMPLE_PHYS_ADDR) {
-		*array = sample->phys_addr;
-		array++;
-	}
-
-	return 0;
-}
-
 struct tep_format_field *perf_evsel__field(struct evsel *evsel, const char *name)
 {
 	return tep_find_field(evsel->tp_format, name);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a4a8342..5722ff7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -45,7 +45,6 @@
 #include "util.h" // page_size, perf_exe()
 #include "cputopo.h"
 #include "bpf-event.h"
-#include "util/synthetic-events.h"
 
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -72,15 +71,6 @@ struct perf_file_attr {
 	struct perf_file_section	ids;
 };
 
-struct feat_fd {
-	struct perf_header	*ph;
-	int			fd;
-	void			*buf;	/* Either buf != NULL or fd >= 0 */
-	ssize_t			offset;
-	size_t			size;
-	struct evsel	*events;
-};
-
 void perf_header__set_feat(struct perf_header *header, int feat)
 {
 	set_bit(feat, header->adds_features);
@@ -2825,15 +2815,6 @@ static int process_compressed(struct feat_fd *ff,
 	return 0;
 }
 
-struct feature_ops {
-	int (*write)(struct feat_fd *ff, struct evlist *evlist);
-	void (*print)(struct feat_fd *ff, FILE *fp);
-	int (*process)(struct feat_fd *ff, void *data);
-	const char *name;
-	bool full_only;
-	bool synthesize;
-};
-
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -2860,8 +2841,10 @@ struct feature_ops {
 #define process_branch_stack	NULL
 #define process_stat		NULL
 
+// Only used in util/synthetic-events.c
+const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE];
 
-static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
+const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(TRACING_DATA,	tracing_data,	false),
 	FEAT_OPN(BUILD_ID,	build_id,	false),
 	FEAT_OPR(HOSTNAME,	hostname,	false),
@@ -3658,105 +3641,6 @@ out_delete_evlist:
 	return -ENOMEM;
 }
 
-int perf_event__synthesize_attr(struct perf_tool *tool,
-				struct perf_event_attr *attr, u32 ids, u64 *id,
-				perf_event__handler_t process)
-{
-	union perf_event *ev;
-	size_t size;
-	int err;
-
-	size = sizeof(struct perf_event_attr);
-	size = PERF_ALIGN(size, sizeof(u64));
-	size += sizeof(struct perf_event_header);
-	size += ids * sizeof(u64);
-
-	ev = zalloc(size);
-
-	if (ev == NULL)
-		return -ENOMEM;
-
-	ev->attr.attr = *attr;
-	memcpy(ev->attr.id, id, ids * sizeof(u64));
-
-	ev->attr.header.type = PERF_RECORD_HEADER_ATTR;
-	ev->attr.header.size = (u16)size;
-
-	if (ev->attr.header.size == size)
-		err = process(tool, ev, NULL, NULL);
-	else
-		err = -E2BIG;
-
-	free(ev);
-
-	return err;
-}
-
-int perf_event__synthesize_features(struct perf_tool *tool,
-				    struct perf_session *session,
-				    struct evlist *evlist,
-				    perf_event__handler_t process)
-{
-	struct perf_header *header = &session->header;
-	struct feat_fd ff;
-	struct perf_record_header_feature *fe;
-	size_t sz, sz_hdr;
-	int feat, ret;
-
-	sz_hdr = sizeof(fe->header);
-	sz = sizeof(union perf_event);
-	/* get a nice alignment */
-	sz = PERF_ALIGN(sz, page_size);
-
-	memset(&ff, 0, sizeof(ff));
-
-	ff.buf = malloc(sz);
-	if (!ff.buf)
-		return -ENOMEM;
-
-	ff.size = sz - sz_hdr;
-	ff.ph = &session->header;
-
-	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
-		if (!feat_ops[feat].synthesize) {
-			pr_debug("No record header feature for header :%d\n", feat);
-			continue;
-		}
-
-		ff.offset = sizeof(*fe);
-
-		ret = feat_ops[feat].write(&ff, evlist);
-		if (ret || ff.offset <= (ssize_t)sizeof(*fe)) {
-			pr_debug("Error writing feature\n");
-			continue;
-		}
-		/* ff.buf may have changed due to realloc in do_write() */
-		fe = ff.buf;
-		memset(fe, 0, sizeof(*fe));
-
-		fe->feat_id = feat;
-		fe->header.type = PERF_RECORD_HEADER_FEATURE;
-		fe->header.size = ff.offset;
-
-		ret = process(tool, ff.buf, NULL, NULL);
-		if (ret) {
-			free(ff.buf);
-			return ret;
-		}
-	}
-
-	/* Send HEADER_LAST_FEATURE mark. */
-	fe = ff.buf;
-	fe->feat_id     = HEADER_LAST_FEATURE;
-	fe->header.type = PERF_RECORD_HEADER_FEATURE;
-	fe->header.size = sizeof(*fe);
-
-	ret = process(tool, ff.buf, NULL, NULL);
-
-	free(ff.buf);
-	return ret;
-}
-
 int perf_event__process_feature(struct perf_session *session,
 				union perf_event *event)
 {
@@ -3799,113 +3683,6 @@ int perf_event__process_feature(struct perf_session *session,
 	return 0;
 }
 
-static struct perf_record_event_update *
-event_update_event__new(size_t size, u64 type, u64 id)
-{
-	struct perf_record_event_update *ev;
-
-	size += sizeof(*ev);
-	size  = PERF_ALIGN(size, sizeof(u64));
-
-	ev = zalloc(size);
-	if (ev) {
-		ev->header.type = PERF_RECORD_EVENT_UPDATE;
-		ev->header.size = (u16)size;
-		ev->type = type;
-		ev->id = id;
-	}
-	return ev;
-}
-
-int
-perf_event__synthesize_event_update_unit(struct perf_tool *tool,
-					 struct evsel *evsel,
-					 perf_event__handler_t process)
-{
-	struct perf_record_event_update *ev;
-	size_t size = strlen(evsel->unit);
-	int err;
-
-	ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
-	if (ev == NULL)
-		return -ENOMEM;
-
-	strlcpy(ev->data, evsel->unit, size + 1);
-	err = process(tool, (union perf_event *)ev, NULL, NULL);
-	free(ev);
-	return err;
-}
-
-int
-perf_event__synthesize_event_update_scale(struct perf_tool *tool,
-					  struct evsel *evsel,
-					  perf_event__handler_t process)
-{
-	struct perf_record_event_update *ev;
-	struct perf_record_event_update_scale *ev_data;
-	int err;
-
-	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->id[0]);
-	if (ev == NULL)
-		return -ENOMEM;
-
-	ev_data = (struct perf_record_event_update_scale *)ev->data;
-	ev_data->scale = evsel->scale;
-	err = process(tool, (union perf_event*) ev, NULL, NULL);
-	free(ev);
-	return err;
-}
-
-int
-perf_event__synthesize_event_update_name(struct perf_tool *tool,
-					 struct evsel *evsel,
-					 perf_event__handler_t process)
-{
-	struct perf_record_event_update *ev;
-	size_t len = strlen(evsel->name);
-	int err;
-
-	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->id[0]);
-	if (ev == NULL)
-		return -ENOMEM;
-
-	strlcpy(ev->data, evsel->name, len + 1);
-	err = process(tool, (union perf_event*) ev, NULL, NULL);
-	free(ev);
-	return err;
-}
-
-int
-perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
-					struct evsel *evsel,
-					perf_event__handler_t process)
-{
-	size_t size = sizeof(struct perf_record_event_update);
-	struct perf_record_event_update *ev;
-	int max, err;
-	u16 type;
-
-	if (!evsel->core.own_cpus)
-		return 0;
-
-	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
-	if (!ev)
-		return -ENOMEM;
-
-	ev->header.type = PERF_RECORD_EVENT_UPDATE;
-	ev->header.size = (u16)size;
-	ev->type = PERF_EVENT_UPDATE__CPUS;
-	ev->id   = evsel->id[0];
-
-	cpu_map_data__synthesize((struct perf_record_cpu_map_data *)ev->data,
-				 evsel->core.own_cpus,
-				 type, max);
-
-	err = process(tool, (union perf_event*) ev, NULL, NULL);
-	free(ev);
-	return err;
-}
-
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 {
 	struct perf_record_event_update *ev = &event->event_update;
@@ -3945,93 +3722,6 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 	return ret;
 }
 
-int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct evlist *evlist,
-				 perf_event__handler_t process)
-{
-	struct evsel *evsel;
-	int err = 0;
-
-	evlist__for_each_entry(evlist, evsel) {
-		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
-						  evsel->id, process);
-		if (err) {
-			pr_debug("failed to create perf header attribute\n");
-			return err;
-		}
-	}
-
-	return err;
-}
-
-static bool has_unit(struct evsel *counter)
-{
-	return counter->unit && *counter->unit;
-}
-
-static bool has_scale(struct evsel *counter)
-{
-	return counter->scale != 1;
-}
-
-int perf_event__synthesize_extra_attr(struct perf_tool *tool,
-				      struct evlist *evsel_list,
-				      perf_event__handler_t process,
-				      bool is_pipe)
-{
-	struct evsel *counter;
-	int err;
-
-	/*
-	 * Synthesize other events stuff not carried within
-	 * attr event - unit, scale, name
-	 */
-	evlist__for_each_entry(evsel_list, counter) {
-		if (!counter->supported)
-			continue;
-
-		/*
-		 * Synthesize unit and scale only if it's defined.
-		 */
-		if (has_unit(counter)) {
-			err = perf_event__synthesize_event_update_unit(tool, counter, process);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel unit.\n");
-				return err;
-			}
-		}
-
-		if (has_scale(counter)) {
-			err = perf_event__synthesize_event_update_scale(tool, counter, process);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel counter.\n");
-				return err;
-			}
-		}
-
-		if (counter->core.own_cpus) {
-			err = perf_event__synthesize_event_update_cpus(tool, counter, process);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel cpus.\n");
-				return err;
-			}
-		}
-
-		/*
-		 * Name is needed only for pipe output,
-		 * perf.data carries event names.
-		 */
-		if (is_pipe) {
-			err = perf_event__synthesize_event_update_name(tool, counter, process);
-			if (err < 0) {
-				pr_err("Couldn't synthesize evsel name.\n");
-				return err;
-			}
-		}
-	}
-	return 0;
-}
-
 int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
@@ -4116,55 +3806,6 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
-					struct evlist *evlist,
-					perf_event__handler_t process)
-{
-	union perf_event ev;
-	struct tracing_data *tdata;
-	ssize_t size = 0, aligned_size = 0, padding;
-	struct feat_fd ff;
-	int err __maybe_unused = 0;
-
-	/*
-	 * We are going to store the size of the data followed
-	 * by the data contents. Since the fd descriptor is a pipe,
-	 * we cannot seek back to store the size of the data once
-	 * we know it. Instead we:
-	 *
-	 * - write the tracing data to the temp file
-	 * - get/write the data size to pipe
-	 * - write the tracing data from the temp file
-	 *   to the pipe
-	 */
-	tdata = tracing_data_get(&evlist->core.entries, fd, true);
-	if (!tdata)
-		return -1;
-
-	memset(&ev, 0, sizeof(ev));
-
-	ev.tracing_data.header.type = PERF_RECORD_HEADER_TRACING_DATA;
-	size = tdata->size;
-	aligned_size = PERF_ALIGN(size, sizeof(u64));
-	padding = aligned_size - size;
-	ev.tracing_data.header.size = sizeof(ev.tracing_data);
-	ev.tracing_data.size = aligned_size;
-
-	process(tool, &ev, NULL, NULL);
-
-	/*
-	 * The put function will copy all the tracing data
-	 * stored in temp file to the pipe.
-	 */
-	tracing_data_put(tdata);
-
-	ff = (struct feat_fd){ .fd = fd };
-	if (write_padded(&ff, NULL, 0, padding))
-		return -1;
-
-	return aligned_size;
-}
-
 int perf_event__process_tracing_data(struct perf_session *session,
 				     union perf_event *event)
 {
@@ -4204,34 +3845,6 @@ int perf_event__process_tracing_data(struct perf_session *session,
 	return size_read + padding;
 }
 
-int perf_event__synthesize_build_id(struct perf_tool *tool,
-				    struct dso *pos, u16 misc,
-				    perf_event__handler_t process,
-				    struct machine *machine)
-{
-	union perf_event ev;
-	size_t len;
-	int err = 0;
-
-	if (!pos->hit)
-		return err;
-
-	memset(&ev, 0, sizeof(ev));
-
-	len = pos->long_name_len + 1;
-	len = PERF_ALIGN(len, NAME_ALIGN);
-	memcpy(&ev.build_id.build_id, pos->build_id, sizeof(pos->build_id));
-	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
-	ev.build_id.header.misc = misc;
-	ev.build_id.pid = machine->pid;
-	ev.build_id.header.size = sizeof(ev.build_id) + len;
-	memcpy(&ev.build_id.filename, pos->long_name, pos->long_name_len);
-
-	err = process(tool, &ev, NULL, machine);
-
-	return err;
-}
-
 int perf_event__process_build_id(struct perf_session *session,
 				 union perf_event *event)
 {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 999dac4..ca53a92 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -92,6 +92,24 @@ struct perf_header {
 	struct perf_env 	env;
 };
 
+struct feat_fd {
+	struct perf_header *ph;
+	int		   fd;
+	void		   *buf;	/* Either buf != NULL or fd >= 0 */
+	ssize_t		   offset;
+	size_t		   size;
+	struct evsel	   *events;
+};
+
+struct perf_header_feature_ops {
+	int	   (*write)(struct feat_fd *ff, struct evlist *evlist);
+	void	   (*print)(struct feat_fd *ff, FILE *fp);
+	int	   (*process)(struct feat_fd *ff, void *data);
+	const char *name;
+	bool	   full_only;
+	bool	   synthesize;
+};
+
 struct evlist;
 struct perf_session;
 struct perf_tool;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 132de5c..0535338 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -20,7 +20,6 @@
 #include "symbol.h"
 #include "sort.h"
 #include "strlist.h"
-#include "util/synthetic-events.h"
 #include "target.h"
 #include "thread.h"
 #include "util.h"
@@ -2610,30 +2609,6 @@ int machines__for_each_thread(struct machines *machines,
 	return rc;
 }
 
-int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
-				  struct target *target, struct perf_thread_map *threads,
-				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int nr_threads_synthesize)
-{
-	if (target__has_task(target))
-		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap);
-	else if (target__has_cpu(target))
-		return perf_event__synthesize_threads(tool, process,
-						      machine, data_mmap,
-						      nr_threads_synthesize);
-	/* command specified */
-	return 0;
-}
-
-int machine__synthesize_threads(struct machine *machine, struct target *target,
-				struct perf_thread_map *threads, bool data_mmap,
-				unsigned int nr_threads_synthesize)
-{
-	return __machine__synthesize_threads(machine, NULL, target, threads,
-					     perf_event__process, data_mmap,
-					     nr_threads_synthesize);
-}
-
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
 	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 99be15d..285d6f3 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -17,8 +17,26 @@
 #include <string.h>
 #include <unistd.h>
 #include <asm/bug.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 
+static const char *perf_ns__names[] = {
+	[NET_NS_INDEX]		= "net",
+	[UTS_NS_INDEX]		= "uts",
+	[IPC_NS_INDEX]		= "ipc",
+	[PID_NS_INDEX]		= "pid",
+	[USER_NS_INDEX]		= "user",
+	[MNT_NS_INDEX]		= "mnt",
+	[CGROUP_NS_INDEX]	= "cgroup",
+};
+
+const char *perf_ns__name(unsigned int id)
+{
+	if (id >= ARRAY_SIZE(perf_ns__names))
+		return "UNKNOWN";
+	return perf_ns__names[id];
+}
+
 struct namespaces *namespaces__new(struct perf_record_namespaces *event)
 {
 	struct namespaces *namespaces;
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 40edef5..4b33f68 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -66,4 +66,6 @@ static inline void __nsinfo__zput(struct nsinfo **nsip)
 
 #define nsinfo__zput(nsi) __nsinfo__zput(&nsi)
 
+const char *perf_ns__name(unsigned int id);
+
 #endif  /* __PERF_NAMESPACES_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6267613..58b5bc3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,7 +29,6 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
-#include "util/synthetic-events.h"
 #include "util.h"
 #include "ui/progress.h"
 #include "../perf.h"
@@ -2413,73 +2412,3 @@ int perf_event__process_id_index(struct perf_session *session,
 	}
 	return 0;
 }
-
-int perf_event__synthesize_id_index(struct perf_tool *tool,
-				    perf_event__handler_t process,
-				    struct evlist *evlist,
-				    struct machine *machine)
-{
-	union perf_event *ev;
-	struct evsel *evsel;
-	size_t nr = 0, i = 0, sz, max_nr, n;
-	int err;
-
-	pr_debug2("Synthesizing id index\n");
-
-	max_nr = (UINT16_MAX - sizeof(struct perf_record_id_index)) /
-		 sizeof(struct id_index_entry);
-
-	evlist__for_each_entry(evlist, evsel)
-		nr += evsel->ids;
-
-	n = nr > max_nr ? max_nr : nr;
-	sz = sizeof(struct perf_record_id_index) + n * sizeof(struct id_index_entry);
-	ev = zalloc(sz);
-	if (!ev)
-		return -ENOMEM;
-
-	ev->id_index.header.type = PERF_RECORD_ID_INDEX;
-	ev->id_index.header.size = sz;
-	ev->id_index.nr = n;
-
-	evlist__for_each_entry(evlist, evsel) {
-		u32 j;
-
-		for (j = 0; j < evsel->ids; j++) {
-			struct id_index_entry *e;
-			struct perf_sample_id *sid;
-
-			if (i >= n) {
-				err = process(tool, ev, NULL, machine);
-				if (err)
-					goto out_err;
-				nr -= n;
-				i = 0;
-			}
-
-			e = &ev->id_index.entries[i++];
-
-			e->id = evsel->id[j];
-
-			sid = perf_evlist__id2sid(evlist, e->id);
-			if (!sid) {
-				free(ev);
-				return -ENOENT;
-			}
-
-			e->idx = sid->idx;
-			e->cpu = sid->cpu;
-			e->tid = sid->tid;
-		}
-	}
-
-	sz = sizeof(struct perf_record_id_index) + nr * sizeof(struct id_index_entry);
-	ev->id_index.header.size = sz;
-	ev->id_index.nr = nr;
-
-	err = process(tool, ev, NULL, machine);
-out_err:
-	free(ev);
-
-	return err;
-}
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 46c8a50..0657120 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -12,7 +12,6 @@
 #include "target.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "util/synthetic-events.h"
 #include "thread_map.h"
 #include <linux/zalloc.h>
 
@@ -495,45 +494,3 @@ int create_perf_stat_counter(struct evsel *evsel,
 
 	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
-
-int perf_event__synthesize_stat_events(struct perf_stat_config *config,
-				       struct perf_tool *tool,
-				       struct evlist *evlist,
-				       perf_event__handler_t process,
-				       bool attrs)
-{
-	int err;
-
-	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evlist, process);
-		if (err < 0) {
-			pr_err("Couldn't synthesize attrs.\n");
-			return err;
-		}
-	}
-
-	err = perf_event__synthesize_extra_attr(tool, evlist, process,
-						attrs);
-
-	err = perf_event__synthesize_thread_map2(tool, evlist->core.threads,
-						 process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize thread map.\n");
-		return err;
-	}
-
-	err = perf_event__synthesize_cpu_map(tool, evlist->core.cpus,
-					     process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize thread map.\n");
-		return err;
-	}
-
-	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize config.\n");
-		return err;
-	}
-
-	return 0;
-}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
new file mode 100644
index 0000000..8322028
--- /dev/null
+++ b/tools/perf/util/synthetic-events.c
@@ -0,0 +1,1884 @@
+// SPDX-License-Identifier: GPL-2.0-only 
+
+#include "util/debug.h"
+#include "util/dso.h"
+#include "util/event.h"
+#include "util/evlist.h"
+#include "util/machine.h"
+#include "util/map.h"
+#include "util/map_symbol.h"
+#include "util/branch.h"
+#include "util/memswap.h"
+#include "util/namespaces.h"
+#include "util/session.h"
+#include "util/stat.h"
+#include "util/symbol.h"
+#include "util/synthetic-events.h"
+#include "util/target.h"
+#include "util/time-utils.h"
+#include "util/util.h"
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <linux/perf_event.h>
+#include <asm/bug.h>
+#include <perf/evsel.h>
+#include <internal/cpumap.h>
+#include <perf/cpumap.h>
+#include <internal/threadmap.h>
+#include <perf/threadmap.h>
+#include <symbol/kallsyms.h>
+#include <dirent.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <string.h>
+#include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
+#include <api/fs/fs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
+
+unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
+
+int perf_tool__process_synth_event(struct perf_tool *tool,
+				   union perf_event *event,
+				   struct machine *machine,
+				   perf_event__handler_t process)
+{
+	struct perf_sample synth_sample = {
+		.pid	   = -1,
+		.tid	   = -1,
+		.time	   = -1,
+		.stream_id = -1,
+		.cpu	   = -1,
+		.period	   = 1,
+		.cpumode   = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK,
+	};
+
+	return process(tool, event, &synth_sample, machine);
+};
+
+/*
+ * Assumes that the first 4095 bytes of /proc/pid/stat contains
+ * the comm, tgid and ppid.
+ */
+static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
+				    pid_t *tgid, pid_t *ppid)
+{
+	char filename[PATH_MAX];
+	char bf[4096];
+	int fd;
+	size_t size = 0;
+	ssize_t n;
+	char *name, *tgids, *ppids;
+
+	*tgid = -1;
+	*ppid = -1;
+
+	snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		pr_debug("couldn't open %s\n", filename);
+		return -1;
+	}
+
+	n = read(fd, bf, sizeof(bf) - 1);
+	close(fd);
+	if (n <= 0) {
+		pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
+			   pid);
+		return -1;
+	}
+	bf[n] = '\0';
+
+	name = strstr(bf, "Name:");
+	tgids = strstr(bf, "Tgid:");
+	ppids = strstr(bf, "PPid:");
+
+	if (name) {
+		char *nl;
+
+		name = skip_spaces(name + 5);  /* strlen("Name:") */
+		nl = strchr(name, '\n');
+		if (nl)
+			*nl = '\0';
+
+		size = strlen(name);
+		if (size >= len)
+			size = len - 1;
+		memcpy(comm, name, size);
+		comm[size] = '\0';
+	} else {
+		pr_debug("Name: string not found for pid %d\n", pid);
+	}
+
+	if (tgids) {
+		tgids += 5;  /* strlen("Tgid:") */
+		*tgid = atoi(tgids);
+	} else {
+		pr_debug("Tgid: string not found for pid %d\n", pid);
+	}
+
+	if (ppids) {
+		ppids += 5;  /* strlen("PPid:") */
+		*ppid = atoi(ppids);
+	} else {
+		pr_debug("PPid: string not found for pid %d\n", pid);
+	}
+
+	return 0;
+}
+
+static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
+				    struct machine *machine,
+				    pid_t *tgid, pid_t *ppid)
+{
+	size_t size;
+
+	*ppid = -1;
+
+	memset(&event->comm, 0, sizeof(event->comm));
+
+	if (machine__is_host(machine)) {
+		if (perf_event__get_comm_ids(pid, event->comm.comm,
+					     sizeof(event->comm.comm),
+					     tgid, ppid) != 0) {
+			return -1;
+		}
+	} else {
+		*tgid = machine->pid;
+	}
+
+	if (*tgid < 0)
+		return -1;
+
+	event->comm.pid = *tgid;
+	event->comm.header.type = PERF_RECORD_COMM;
+
+	size = strlen(event->comm.comm) + 1;
+	size = PERF_ALIGN(size, sizeof(u64));
+	memset(event->comm.comm + size, 0, machine->id_hdr_size);
+	event->comm.header.size = (sizeof(event->comm) -
+				(sizeof(event->comm.comm) - size) +
+				machine->id_hdr_size);
+	event->comm.tid = pid;
+
+	return 0;
+}
+
+pid_t perf_event__synthesize_comm(struct perf_tool *tool,
+					 union perf_event *event, pid_t pid,
+					 perf_event__handler_t process,
+					 struct machine *machine)
+{
+	pid_t tgid, ppid;
+
+	if (perf_event__prepare_comm(event, pid, machine, &tgid, &ppid) != 0)
+		return -1;
+
+	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
+		return -1;
+
+	return tgid;
+}
+
+static void perf_event__get_ns_link_info(pid_t pid, const char *ns,
+					 struct perf_ns_link_info *ns_link_info)
+{
+	struct stat64 st;
+	char proc_ns[128];
+
+	sprintf(proc_ns, "/proc/%u/ns/%s", pid, ns);
+	if (stat64(proc_ns, &st) == 0) {
+		ns_link_info->dev = st.st_dev;
+		ns_link_info->ino = st.st_ino;
+	}
+}
+
+int perf_event__synthesize_namespaces(struct perf_tool *tool,
+				      union perf_event *event,
+				      pid_t pid, pid_t tgid,
+				      perf_event__handler_t process,
+				      struct machine *machine)
+{
+	u32 idx;
+	struct perf_ns_link_info *ns_link_info;
+
+	if (!tool || !tool->namespace_events)
+		return 0;
+
+	memset(&event->namespaces, 0, (sizeof(event->namespaces) +
+	       (NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
+	       machine->id_hdr_size));
+
+	event->namespaces.pid = tgid;
+	event->namespaces.tid = pid;
+
+	event->namespaces.nr_namespaces = NR_NAMESPACES;
+
+	ns_link_info = event->namespaces.link_info;
+
+	for (idx = 0; idx < event->namespaces.nr_namespaces; idx++)
+		perf_event__get_ns_link_info(pid, perf_ns__name(idx),
+					     &ns_link_info[idx]);
+
+	event->namespaces.header.type = PERF_RECORD_NAMESPACES;
+
+	event->namespaces.header.size = (sizeof(event->namespaces) +
+			(NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
+			machine->id_hdr_size);
+
+	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
+		return -1;
+
+	return 0;
+}
+
+static int perf_event__synthesize_fork(struct perf_tool *tool,
+				       union perf_event *event,
+				       pid_t pid, pid_t tgid, pid_t ppid,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	memset(&event->fork, 0, sizeof(event->fork) + machine->id_hdr_size);
+
+	/*
+	 * for main thread set parent to ppid from status file. For other
+	 * threads set parent pid to main thread. ie., assume main thread
+	 * spawns all threads in a process
+	*/
+	if (tgid == pid) {
+		event->fork.ppid = ppid;
+		event->fork.ptid = ppid;
+	} else {
+		event->fork.ppid = tgid;
+		event->fork.ptid = tgid;
+	}
+	event->fork.pid  = tgid;
+	event->fork.tid  = pid;
+	event->fork.header.type = PERF_RECORD_FORK;
+	event->fork.header.misc = PERF_RECORD_MISC_FORK_EXEC;
+
+	event->fork.header.size = (sizeof(event->fork) + machine->id_hdr_size);
+
+	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
+		return -1;
+
+	return 0;
+}
+
+int perf_event__synthesize_mmap_events(struct perf_tool *tool,
+				       union perf_event *event,
+				       pid_t pid, pid_t tgid,
+				       perf_event__handler_t process,
+				       struct machine *machine,
+				       bool mmap_data)
+{
+	char filename[PATH_MAX];
+	FILE *fp;
+	unsigned long long t;
+	bool truncation = false;
+	unsigned long long timeout = proc_map_timeout * 1000000ULL;
+	int rc = 0;
+	const char *hugetlbfs_mnt = hugetlbfs__mountpoint();
+	int hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
+
+	if (machine__is_default_guest(machine))
+		return 0;
+
+	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
+		 machine->root_dir, pid, pid);
+
+	fp = fopen(filename, "r");
+	if (fp == NULL) {
+		/*
+		 * We raced with a task exiting - just return:
+		 */
+		pr_debug("couldn't open %s\n", filename);
+		return -1;
+	}
+
+	event->header.type = PERF_RECORD_MMAP2;
+	t = rdclock();
+
+	while (1) {
+		char bf[BUFSIZ];
+		char prot[5];
+		char execname[PATH_MAX];
+		char anonstr[] = "//anon";
+		unsigned int ino;
+		size_t size;
+		ssize_t n;
+
+		if (fgets(bf, sizeof(bf), fp) == NULL)
+			break;
+
+		if ((rdclock() - t) > timeout) {
+			pr_warning("Reading %s time out. "
+				   "You may want to increase "
+				   "the time limit by --proc-map-timeout\n",
+				   filename);
+			truncation = true;
+			goto out;
+		}
+
+		/* ensure null termination since stack will be reused. */
+		strcpy(execname, "");
+
+		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
+		n = sscanf(bf, "%"PRI_lx64"-%"PRI_lx64" %s %"PRI_lx64" %x:%x %u %[^\n]\n",
+		       &event->mmap2.start, &event->mmap2.len, prot,
+		       &event->mmap2.pgoff, &event->mmap2.maj,
+		       &event->mmap2.min,
+		       &ino, execname);
+
+		/*
+ 		 * Anon maps don't have the execname.
+ 		 */
+		if (n < 7)
+			continue;
+
+		event->mmap2.ino = (u64)ino;
+
+		/*
+		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
+		 */
+		if (machine__is_host(machine))
+			event->header.misc = PERF_RECORD_MISC_USER;
+		else
+			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
+
+		/* map protection and flags bits */
+		event->mmap2.prot = 0;
+		event->mmap2.flags = 0;
+		if (prot[0] == 'r')
+			event->mmap2.prot |= PROT_READ;
+		if (prot[1] == 'w')
+			event->mmap2.prot |= PROT_WRITE;
+		if (prot[2] == 'x')
+			event->mmap2.prot |= PROT_EXEC;
+
+		if (prot[3] == 's')
+			event->mmap2.flags |= MAP_SHARED;
+		else
+			event->mmap2.flags |= MAP_PRIVATE;
+
+		if (prot[2] != 'x') {
+			if (!mmap_data || prot[0] != 'r')
+				continue;
+
+			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
+		}
+
+out:
+		if (truncation)
+			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
+
+		if (!strcmp(execname, ""))
+			strcpy(execname, anonstr);
+
+		if (hugetlbfs_mnt_len &&
+		    !strncmp(execname, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
+			strcpy(execname, anonstr);
+			event->mmap2.flags |= MAP_HUGETLB;
+		}
+
+		size = strlen(execname) + 1;
+		memcpy(event->mmap2.filename, execname, size);
+		size = PERF_ALIGN(size, sizeof(u64));
+		event->mmap2.len -= event->mmap.start;
+		event->mmap2.header.size = (sizeof(event->mmap2) -
+					(sizeof(event->mmap2.filename) - size));
+		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
+		event->mmap2.header.size += machine->id_hdr_size;
+		event->mmap2.pid = tgid;
+		event->mmap2.tid = pid;
+
+		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
+			rc = -1;
+			break;
+		}
+
+		if (truncation)
+			break;
+	}
+
+	fclose(fp);
+	return rc;
+}
+
+int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
+				   struct machine *machine)
+{
+	int rc = 0;
+	struct map *pos;
+	struct maps *maps = machine__kernel_maps(machine);
+	union perf_event *event = zalloc((sizeof(event->mmap) +
+					  machine->id_hdr_size));
+	if (event == NULL) {
+		pr_debug("Not enough memory synthesizing mmap event "
+			 "for kernel modules\n");
+		return -1;
+	}
+
+	event->header.type = PERF_RECORD_MMAP;
+
+	/*
+	 * kernel uses 0 for user space maps, see kernel/perf_event.c
+	 * __perf_event_mmap
+	 */
+	if (machine__is_host(machine))
+		event->header.misc = PERF_RECORD_MISC_KERNEL;
+	else
+		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+
+	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
+		size_t size;
+
+		if (!__map__is_kmodule(pos))
+			continue;
+
+		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+		event->mmap.header.type = PERF_RECORD_MMAP;
+		event->mmap.header.size = (sizeof(event->mmap) -
+				        (sizeof(event->mmap.filename) - size));
+		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
+		event->mmap.header.size += machine->id_hdr_size;
+		event->mmap.start = pos->start;
+		event->mmap.len   = pos->end - pos->start;
+		event->mmap.pid   = machine->pid;
+
+		memcpy(event->mmap.filename, pos->dso->long_name,
+		       pos->dso->long_name_len + 1);
+		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
+			rc = -1;
+			break;
+		}
+	}
+
+	free(event);
+	return rc;
+}
+
+static int __event__synthesize_thread(union perf_event *comm_event,
+				      union perf_event *mmap_event,
+				      union perf_event *fork_event,
+				      union perf_event *namespaces_event,
+				      pid_t pid, int full, perf_event__handler_t process,
+				      struct perf_tool *tool, struct machine *machine, bool mmap_data)
+{
+	char filename[PATH_MAX];
+	DIR *tasks;
+	struct dirent *dirent;
+	pid_t tgid, ppid;
+	int rc = 0;
+
+	/* special case: only send one comm event using passed in pid */
+	if (!full) {
+		tgid = perf_event__synthesize_comm(tool, comm_event, pid,
+						   process, machine);
+
+		if (tgid == -1)
+			return -1;
+
+		if (perf_event__synthesize_namespaces(tool, namespaces_event, pid,
+						      tgid, process, machine) < 0)
+			return -1;
+
+		/*
+		 * send mmap only for thread group leader
+		 * see thread__init_map_groups
+		 */
+		if (pid == tgid &&
+		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
+						       process, machine, mmap_data))
+			return -1;
+
+		return 0;
+	}
+
+	if (machine__is_default_guest(machine))
+		return 0;
+
+	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
+		 machine->root_dir, pid);
+
+	tasks = opendir(filename);
+	if (tasks == NULL) {
+		pr_debug("couldn't open %s\n", filename);
+		return 0;
+	}
+
+	while ((dirent = readdir(tasks)) != NULL) {
+		char *end;
+		pid_t _pid;
+
+		_pid = strtol(dirent->d_name, &end, 10);
+		if (*end)
+			continue;
+
+		rc = -1;
+		if (perf_event__prepare_comm(comm_event, _pid, machine,
+					     &tgid, &ppid) != 0)
+			break;
+
+		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
+						ppid, process, machine) < 0)
+			break;
+
+		if (perf_event__synthesize_namespaces(tool, namespaces_event, _pid,
+						      tgid, process, machine) < 0)
+			break;
+
+		/*
+		 * Send the prepared comm event
+		 */
+		if (perf_tool__process_synth_event(tool, comm_event, machine, process) != 0)
+			break;
+
+		rc = 0;
+		if (_pid == pid) {
+			/* process the parent's maps too */
+			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
+						process, machine, mmap_data);
+			if (rc)
+				break;
+		}
+	}
+
+	closedir(tasks);
+	return rc;
+}
+
+int perf_event__synthesize_thread_map(struct perf_tool *tool,
+				      struct perf_thread_map *threads,
+				      perf_event__handler_t process,
+				      struct machine *machine,
+				      bool mmap_data)
+{
+	union perf_event *comm_event, *mmap_event, *fork_event;
+	union perf_event *namespaces_event;
+	int err = -1, thread, j;
+
+	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
+	if (comm_event == NULL)
+		goto out;
+
+	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
+	if (mmap_event == NULL)
+		goto out_free_comm;
+
+	fork_event = malloc(sizeof(fork_event->fork) + machine->id_hdr_size);
+	if (fork_event == NULL)
+		goto out_free_mmap;
+
+	namespaces_event = malloc(sizeof(namespaces_event->namespaces) +
+				  (NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
+				  machine->id_hdr_size);
+	if (namespaces_event == NULL)
+		goto out_free_fork;
+
+	err = 0;
+	for (thread = 0; thread < threads->nr; ++thread) {
+		if (__event__synthesize_thread(comm_event, mmap_event,
+					       fork_event, namespaces_event,
+					       perf_thread_map__pid(threads, thread), 0,
+					       process, tool, machine,
+					       mmap_data)) {
+			err = -1;
+			break;
+		}
+
+		/*
+		 * comm.pid is set to thread group id by
+		 * perf_event__synthesize_comm
+		 */
+		if ((int) comm_event->comm.pid != perf_thread_map__pid(threads, thread)) {
+			bool need_leader = true;
+
+			/* is thread group leader in thread_map? */
+			for (j = 0; j < threads->nr; ++j) {
+				if ((int) comm_event->comm.pid == perf_thread_map__pid(threads, j)) {
+					need_leader = false;
+					break;
+				}
+			}
+
+			/* if not, generate events for it */
+			if (need_leader &&
+			    __event__synthesize_thread(comm_event, mmap_event,
+						       fork_event, namespaces_event,
+						       comm_event->comm.pid, 0,
+						       process, tool, machine,
+						       mmap_data)) {
+				err = -1;
+				break;
+			}
+		}
+	}
+	free(namespaces_event);
+out_free_fork:
+	free(fork_event);
+out_free_mmap:
+	free(mmap_event);
+out_free_comm:
+	free(comm_event);
+out:
+	return err;
+}
+
+static int __perf_event__synthesize_threads(struct perf_tool *tool,
+					    perf_event__handler_t process,
+					    struct machine *machine,
+					    bool mmap_data,
+					    struct dirent **dirent,
+					    int start,
+					    int num)
+{
+	union perf_event *comm_event, *mmap_event, *fork_event;
+	union perf_event *namespaces_event;
+	int err = -1;
+	char *end;
+	pid_t pid;
+	int i;
+
+	comm_event = malloc(sizeof(comm_event->comm) + machine->id_hdr_size);
+	if (comm_event == NULL)
+		goto out;
+
+	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
+	if (mmap_event == NULL)
+		goto out_free_comm;
+
+	fork_event = malloc(sizeof(fork_event->fork) + machine->id_hdr_size);
+	if (fork_event == NULL)
+		goto out_free_mmap;
+
+	namespaces_event = malloc(sizeof(namespaces_event->namespaces) +
+				  (NR_NAMESPACES * sizeof(struct perf_ns_link_info)) +
+				  machine->id_hdr_size);
+	if (namespaces_event == NULL)
+		goto out_free_fork;
+
+	for (i = start; i < start + num; i++) {
+		if (!isdigit(dirent[i]->d_name[0]))
+			continue;
+
+		pid = (pid_t)strtol(dirent[i]->d_name, &end, 10);
+		/* only interested in proper numerical dirents */
+		if (*end)
+			continue;
+		/*
+		 * We may race with exiting thread, so don't stop just because
+		 * one thread couldn't be synthesized.
+		 */
+		__event__synthesize_thread(comm_event, mmap_event, fork_event,
+					   namespaces_event, pid, 1, process,
+					   tool, machine, mmap_data);
+	}
+	err = 0;
+
+	free(namespaces_event);
+out_free_fork:
+	free(fork_event);
+out_free_mmap:
+	free(mmap_event);
+out_free_comm:
+	free(comm_event);
+out:
+	return err;
+}
+
+struct synthesize_threads_arg {
+	struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+	bool mmap_data;
+	struct dirent **dirent;
+	int num;
+	int start;
+};
+
+static void *synthesize_threads_worker(void *arg)
+{
+	struct synthesize_threads_arg *args = arg;
+
+	__perf_event__synthesize_threads(args->tool, args->process,
+					 args->machine, args->mmap_data,
+					 args->dirent,
+					 args->start, args->num);
+	return NULL;
+}
+
+int perf_event__synthesize_threads(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine,
+				   bool mmap_data,
+				   unsigned int nr_threads_synthesize)
+{
+	struct synthesize_threads_arg *args = NULL;
+	pthread_t *synthesize_threads = NULL;
+	char proc_path[PATH_MAX];
+	struct dirent **dirent;
+	int num_per_thread;
+	int m, n, i, j;
+	int thread_nr;
+	int base = 0;
+	int err = -1;
+
+
+	if (machine__is_default_guest(machine))
+		return 0;
+
+	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
+	n = scandir(proc_path, &dirent, 0, alphasort);
+	if (n < 0)
+		return err;
+
+	if (nr_threads_synthesize == UINT_MAX)
+		thread_nr = sysconf(_SC_NPROCESSORS_ONLN);
+	else
+		thread_nr = nr_threads_synthesize;
+
+	if (thread_nr <= 1) {
+		err = __perf_event__synthesize_threads(tool, process,
+						       machine, mmap_data,
+						       dirent, base, n);
+		goto free_dirent;
+	}
+	if (thread_nr > n)
+		thread_nr = n;
+
+	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
+	if (synthesize_threads == NULL)
+		goto free_dirent;
+
+	args = calloc(sizeof(*args), thread_nr);
+	if (args == NULL)
+		goto free_threads;
+
+	num_per_thread = n / thread_nr;
+	m = n % thread_nr;
+	for (i = 0; i < thread_nr; i++) {
+		args[i].tool = tool;
+		args[i].process = process;
+		args[i].machine = machine;
+		args[i].mmap_data = mmap_data;
+		args[i].dirent = dirent;
+	}
+	for (i = 0; i < m; i++) {
+		args[i].num = num_per_thread + 1;
+		args[i].start = i * args[i].num;
+	}
+	if (i != 0)
+		base = args[i-1].start + args[i-1].num;
+	for (j = i; j < thread_nr; j++) {
+		args[j].num = num_per_thread;
+		args[j].start = base + (j - i) * args[i].num;
+	}
+
+	for (i = 0; i < thread_nr; i++) {
+		if (pthread_create(&synthesize_threads[i], NULL,
+				   synthesize_threads_worker, &args[i]))
+			goto out_join;
+	}
+	err = 0;
+out_join:
+	for (i = 0; i < thread_nr; i++)
+		pthread_join(synthesize_threads[i], NULL);
+	free(args);
+free_threads:
+	free(synthesize_threads);
+free_dirent:
+	for (i = 0; i < n; i++)
+		zfree(&dirent[i]);
+	free(dirent);
+
+	return err;
+}
+
+int __weak perf_event__synthesize_extra_kmaps(struct perf_tool *tool __maybe_unused,
+					      perf_event__handler_t process __maybe_unused,
+					      struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
+static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
+						perf_event__handler_t process,
+						struct machine *machine)
+{
+	size_t size;
+	struct map *map = machine__kernel_map(machine);
+	struct kmap *kmap;
+	int err;
+	union perf_event *event;
+
+	if (map == NULL)
+		return -1;
+
+	kmap = map__kmap(map);
+	if (!kmap->ref_reloc_sym)
+		return -1;
+
+	/*
+	 * We should get this from /sys/kernel/sections/.text, but till that is
+	 * available use this, and after it is use this as a fallback for older
+	 * kernels.
+	 */
+	event = zalloc((sizeof(event->mmap) + machine->id_hdr_size));
+	if (event == NULL) {
+		pr_debug("Not enough memory synthesizing mmap event "
+			 "for kernel modules\n");
+		return -1;
+	}
+
+	if (machine__is_host(machine)) {
+		/*
+		 * kernel uses PERF_RECORD_MISC_USER for user space maps,
+		 * see kernel/perf_event.c __perf_event_mmap
+		 */
+		event->header.misc = PERF_RECORD_MISC_KERNEL;
+	} else {
+		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+	}
+
+	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
+			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
+	size = PERF_ALIGN(size, sizeof(u64));
+	event->mmap.header.type = PERF_RECORD_MMAP;
+	event->mmap.header.size = (sizeof(event->mmap) -
+			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
+	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
+	event->mmap.start = map->start;
+	event->mmap.len   = map->end - event->mmap.start;
+	event->mmap.pid   = machine->pid;
+
+	err = perf_tool__process_synth_event(tool, event, machine, process);
+	free(event);
+
+	return err;
+}
+
+int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	int err;
+
+	err = __perf_event__synthesize_kernel_mmap(tool, process, machine);
+	if (err < 0)
+		return err;
+
+	return perf_event__synthesize_extra_kmaps(tool, process, machine);
+}
+
+int perf_event__synthesize_thread_map2(struct perf_tool *tool,
+				      struct perf_thread_map *threads,
+				      perf_event__handler_t process,
+				      struct machine *machine)
+{
+	union perf_event *event;
+	int i, err, size;
+
+	size  = sizeof(event->thread_map);
+	size +=	threads->nr * sizeof(event->thread_map.entries[0]);
+
+	event = zalloc(size);
+	if (!event)
+		return -ENOMEM;
+
+	event->header.type = PERF_RECORD_THREAD_MAP;
+	event->header.size = size;
+	event->thread_map.nr = threads->nr;
+
+	for (i = 0; i < threads->nr; i++) {
+		struct perf_record_thread_map_entry *entry = &event->thread_map.entries[i];
+		char *comm = perf_thread_map__comm(threads, i);
+
+		if (!comm)
+			comm = (char *) "";
+
+		entry->pid = perf_thread_map__pid(threads, i);
+		strncpy((char *) &entry->comm, comm, sizeof(entry->comm));
+	}
+
+	err = process(tool, event, NULL, machine);
+
+	free(event);
+	return err;
+}
+
+static void synthesize_cpus(struct cpu_map_entries *cpus,
+			    struct perf_cpu_map *map)
+{
+	int i;
+
+	cpus->nr = map->nr;
+
+	for (i = 0; i < map->nr; i++)
+		cpus->cpu[i] = map->map[i];
+}
+
+static void synthesize_mask(struct perf_record_record_cpu_map *mask,
+			    struct perf_cpu_map *map, int max)
+{
+	int i;
+
+	mask->nr = BITS_TO_LONGS(max);
+	mask->long_size = sizeof(long);
+
+	for (i = 0; i < map->nr; i++)
+		set_bit(map->map[i], mask->mask);
+}
+
+static size_t cpus_size(struct perf_cpu_map *map)
+{
+	return sizeof(struct cpu_map_entries) + map->nr * sizeof(u16);
+}
+
+static size_t mask_size(struct perf_cpu_map *map, int *max)
+{
+	int i;
+
+	*max = 0;
+
+	for (i = 0; i < map->nr; i++) {
+		/* bit possition of the cpu is + 1 */
+		int bit = map->map[i] + 1;
+
+		if (bit > *max)
+			*max = bit;
+	}
+
+	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
+}
+
+void *cpu_map_data__alloc(struct perf_cpu_map *map, size_t *size, u16 *type, int *max)
+{
+	size_t size_cpus, size_mask;
+	bool is_dummy = perf_cpu_map__empty(map);
+
+	/*
+	 * Both array and mask data have variable size based
+	 * on the number of cpus and their actual values.
+	 * The size of the 'struct perf_record_cpu_map_data' is:
+	 *
+	 *   array = size of 'struct cpu_map_entries' +
+	 *           number of cpus * sizeof(u64)
+	 *
+	 *   mask  = size of 'struct perf_record_record_cpu_map' +
+	 *           maximum cpu bit converted to size of longs
+	 *
+	 * and finaly + the size of 'struct perf_record_cpu_map_data'.
+	 */
+	size_cpus = cpus_size(map);
+	size_mask = mask_size(map, max);
+
+	if (is_dummy || (size_cpus < size_mask)) {
+		*size += size_cpus;
+		*type  = PERF_CPU_MAP__CPUS;
+	} else {
+		*size += size_mask;
+		*type  = PERF_CPU_MAP__MASK;
+	}
+
+	*size += sizeof(struct perf_record_cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
+	return zalloc(*size);
+}
+
+void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf_cpu_map *map,
+			      u16 type, int max)
+{
+	data->type = type;
+
+	switch (type) {
+	case PERF_CPU_MAP__CPUS:
+		synthesize_cpus((struct cpu_map_entries *) data->data, map);
+		break;
+	case PERF_CPU_MAP__MASK:
+		synthesize_mask((struct perf_record_record_cpu_map *)data->data, map, max);
+	default:
+		break;
+	};
+}
+
+static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
+{
+	size_t size = sizeof(struct perf_record_cpu_map);
+	struct perf_record_cpu_map *event;
+	int max;
+	u16 type;
+
+	event = cpu_map_data__alloc(map, &size, &type, &max);
+	if (!event)
+		return NULL;
+
+	event->header.type = PERF_RECORD_CPU_MAP;
+	event->header.size = size;
+	event->data.type   = type;
+
+	cpu_map_data__synthesize(&event->data, map, type, max);
+	return event;
+}
+
+int perf_event__synthesize_cpu_map(struct perf_tool *tool,
+				   struct perf_cpu_map *map,
+				   perf_event__handler_t process,
+				   struct machine *machine)
+{
+	struct perf_record_cpu_map *event;
+	int err;
+
+	event = cpu_map_event__new(map);
+	if (!event)
+		return -ENOMEM;
+
+	err = process(tool, (union perf_event *) event, NULL, machine);
+
+	free(event);
+	return err;
+}
+
+int perf_event__synthesize_stat_config(struct perf_tool *tool,
+				       struct perf_stat_config *config,
+				       perf_event__handler_t process,
+				       struct machine *machine)
+{
+	struct perf_record_stat_config *event;
+	int size, i = 0, err;
+
+	size  = sizeof(*event);
+	size += (PERF_STAT_CONFIG_TERM__MAX * sizeof(event->data[0]));
+
+	event = zalloc(size);
+	if (!event)
+		return -ENOMEM;
+
+	event->header.type = PERF_RECORD_STAT_CONFIG;
+	event->header.size = size;
+	event->nr          = PERF_STAT_CONFIG_TERM__MAX;
+
+#define ADD(__term, __val)					\
+	event->data[i].tag = PERF_STAT_CONFIG_TERM__##__term;	\
+	event->data[i].val = __val;				\
+	i++;
+
+	ADD(AGGR_MODE,	config->aggr_mode)
+	ADD(INTERVAL,	config->interval)
+	ADD(SCALE,	config->scale)
+
+	WARN_ONCE(i != PERF_STAT_CONFIG_TERM__MAX,
+		  "stat config terms unbalanced\n");
+#undef ADD
+
+	err = process(tool, (union perf_event *) event, NULL, machine);
+
+	free(event);
+	return err;
+}
+
+int perf_event__synthesize_stat(struct perf_tool *tool,
+				u32 cpu, u32 thread, u64 id,
+				struct perf_counts_values *count,
+				perf_event__handler_t process,
+				struct machine *machine)
+{
+	struct perf_record_stat event;
+
+	event.header.type = PERF_RECORD_STAT;
+	event.header.size = sizeof(event);
+	event.header.misc = 0;
+
+	event.id        = id;
+	event.cpu       = cpu;
+	event.thread    = thread;
+	event.val       = count->val;
+	event.ena       = count->ena;
+	event.run       = count->run;
+
+	return process(tool, (union perf_event *) &event, NULL, machine);
+}
+
+int perf_event__synthesize_stat_round(struct perf_tool *tool,
+				      u64 evtime, u64 type,
+				      perf_event__handler_t process,
+				      struct machine *machine)
+{
+	struct perf_record_stat_round event;
+
+	event.header.type = PERF_RECORD_STAT_ROUND;
+	event.header.size = sizeof(event);
+	event.header.misc = 0;
+
+	event.time = evtime;
+	event.type = type;
+
+	return process(tool, (union perf_event *) &event, NULL, machine);
+}
+
+size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format)
+{
+	size_t sz, result = sizeof(struct perf_record_sample);
+
+	if (type & PERF_SAMPLE_IDENTIFIER)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_IP)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_TID)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_TIME)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_ADDR)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_ID)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_STREAM_ID)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_CPU)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_PERIOD)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_READ) {
+		result += sizeof(u64);
+		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+			result += sizeof(u64);
+		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+			result += sizeof(u64);
+		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+		if (read_format & PERF_FORMAT_GROUP) {
+			sz = sample->read.group.nr *
+			     sizeof(struct sample_read_value);
+			result += sz;
+		} else {
+			result += sizeof(u64);
+		}
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN) {
+		sz = (sample->callchain->nr + 1) * sizeof(u64);
+		result += sz;
+	}
+
+	if (type & PERF_SAMPLE_RAW) {
+		result += sizeof(u32);
+		result += sample->raw_size;
+	}
+
+	if (type & PERF_SAMPLE_BRANCH_STACK) {
+		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
+		sz += sizeof(u64);
+		result += sz;
+	}
+
+	if (type & PERF_SAMPLE_REGS_USER) {
+		if (sample->user_regs.abi) {
+			result += sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
+			result += sz;
+		} else {
+			result += sizeof(u64);
+		}
+	}
+
+	if (type & PERF_SAMPLE_STACK_USER) {
+		sz = sample->user_stack.size;
+		result += sizeof(u64);
+		if (sz) {
+			result += sz;
+			result += sizeof(u64);
+		}
+	}
+
+	if (type & PERF_SAMPLE_WEIGHT)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_DATA_SRC)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_TRANSACTION)
+		result += sizeof(u64);
+
+	if (type & PERF_SAMPLE_REGS_INTR) {
+		if (sample->intr_regs.abi) {
+			result += sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
+			result += sz;
+		} else {
+			result += sizeof(u64);
+		}
+	}
+
+	if (type & PERF_SAMPLE_PHYS_ADDR)
+		result += sizeof(u64);
+
+	return result;
+}
+
+int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
+				  const struct perf_sample *sample)
+{
+	__u64 *array;
+	size_t sz;
+	/*
+	 * used for cross-endian analysis. See git commit 65014ab3
+	 * for why this goofiness is needed.
+	 */
+	union u64_swap u;
+
+	array = event->sample.array;
+
+	if (type & PERF_SAMPLE_IDENTIFIER) {
+		*array = sample->id;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_IP) {
+		*array = sample->ip;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_TID) {
+		u.val32[0] = sample->pid;
+		u.val32[1] = sample->tid;
+		*array = u.val64;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_TIME) {
+		*array = sample->time;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_ADDR) {
+		*array = sample->addr;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_ID) {
+		*array = sample->id;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_STREAM_ID) {
+		*array = sample->stream_id;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_CPU) {
+		u.val32[0] = sample->cpu;
+		u.val32[1] = 0;
+		*array = u.val64;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_PERIOD) {
+		*array = sample->period;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_READ) {
+		if (read_format & PERF_FORMAT_GROUP)
+			*array = sample->read.group.nr;
+		else
+			*array = sample->read.one.value;
+		array++;
+
+		if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
+			*array = sample->read.time_enabled;
+			array++;
+		}
+
+		if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
+			*array = sample->read.time_running;
+			array++;
+		}
+
+		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
+		if (read_format & PERF_FORMAT_GROUP) {
+			sz = sample->read.group.nr *
+			     sizeof(struct sample_read_value);
+			memcpy(array, sample->read.group.values, sz);
+			array = (void *)array + sz;
+		} else {
+			*array = sample->read.one.id;
+			array++;
+		}
+	}
+
+	if (type & PERF_SAMPLE_CALLCHAIN) {
+		sz = (sample->callchain->nr + 1) * sizeof(u64);
+		memcpy(array, sample->callchain, sz);
+		array = (void *)array + sz;
+	}
+
+	if (type & PERF_SAMPLE_RAW) {
+		u.val32[0] = sample->raw_size;
+		*array = u.val64;
+		array = (void *)array + sizeof(u32);
+
+		memcpy(array, sample->raw_data, sample->raw_size);
+		array = (void *)array + sample->raw_size;
+	}
+
+	if (type & PERF_SAMPLE_BRANCH_STACK) {
+		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
+		sz += sizeof(u64);
+		memcpy(array, sample->branch_stack, sz);
+		array = (void *)array + sz;
+	}
+
+	if (type & PERF_SAMPLE_REGS_USER) {
+		if (sample->user_regs.abi) {
+			*array++ = sample->user_regs.abi;
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
+			memcpy(array, sample->user_regs.regs, sz);
+			array = (void *)array + sz;
+		} else {
+			*array++ = 0;
+		}
+	}
+
+	if (type & PERF_SAMPLE_STACK_USER) {
+		sz = sample->user_stack.size;
+		*array++ = sz;
+		if (sz) {
+			memcpy(array, sample->user_stack.data, sz);
+			array = (void *)array + sz;
+			*array++ = sz;
+		}
+	}
+
+	if (type & PERF_SAMPLE_WEIGHT) {
+		*array = sample->weight;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_DATA_SRC) {
+		*array = sample->data_src;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_TRANSACTION) {
+		*array = sample->transaction;
+		array++;
+	}
+
+	if (type & PERF_SAMPLE_REGS_INTR) {
+		if (sample->intr_regs.abi) {
+			*array++ = sample->intr_regs.abi;
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
+			memcpy(array, sample->intr_regs.regs, sz);
+			array = (void *)array + sz;
+		} else {
+			*array++ = 0;
+		}
+	}
+
+	if (type & PERF_SAMPLE_PHYS_ADDR) {
+		*array = sample->phys_addr;
+		array++;
+	}
+
+	return 0;
+}
+
+int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_t process,
+				    struct evlist *evlist, struct machine *machine)
+{
+	union perf_event *ev;
+	struct evsel *evsel;
+	size_t nr = 0, i = 0, sz, max_nr, n;
+	int err;
+
+	pr_debug2("Synthesizing id index\n");
+
+	max_nr = (UINT16_MAX - sizeof(struct perf_record_id_index)) /
+		 sizeof(struct id_index_entry);
+
+	evlist__for_each_entry(evlist, evsel)
+		nr += evsel->ids;
+
+	n = nr > max_nr ? max_nr : nr;
+	sz = sizeof(struct perf_record_id_index) + n * sizeof(struct id_index_entry);
+	ev = zalloc(sz);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->id_index.header.type = PERF_RECORD_ID_INDEX;
+	ev->id_index.header.size = sz;
+	ev->id_index.nr = n;
+
+	evlist__for_each_entry(evlist, evsel) {
+		u32 j;
+
+		for (j = 0; j < evsel->ids; j++) {
+			struct id_index_entry *e;
+			struct perf_sample_id *sid;
+
+			if (i >= n) {
+				err = process(tool, ev, NULL, machine);
+				if (err)
+					goto out_err;
+				nr -= n;
+				i = 0;
+			}
+
+			e = &ev->id_index.entries[i++];
+
+			e->id = evsel->id[j];
+
+			sid = perf_evlist__id2sid(evlist, e->id);
+			if (!sid) {
+				free(ev);
+				return -ENOENT;
+			}
+
+			e->idx = sid->idx;
+			e->cpu = sid->cpu;
+			e->tid = sid->tid;
+		}
+	}
+
+	sz = sizeof(struct perf_record_id_index) + nr * sizeof(struct id_index_entry);
+	ev->id_index.header.size = sz;
+	ev->id_index.nr = nr;
+
+	err = process(tool, ev, NULL, machine);
+out_err:
+	free(ev);
+
+	return err;
+}
+
+int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
+				  struct target *target, struct perf_thread_map *threads,
+				  perf_event__handler_t process, bool data_mmap,
+				  unsigned int nr_threads_synthesize)
+{
+	if (target__has_task(target))
+		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap);
+	else if (target__has_cpu(target))
+		return perf_event__synthesize_threads(tool, process,
+						      machine, data_mmap,
+						      nr_threads_synthesize);
+	/* command specified */
+	return 0;
+}
+
+int machine__synthesize_threads(struct machine *machine, struct target *target,
+				struct perf_thread_map *threads, bool data_mmap,
+				unsigned int nr_threads_synthesize)
+{
+	return __machine__synthesize_threads(machine, NULL, target, threads,
+					     perf_event__process, data_mmap,
+					     nr_threads_synthesize);
+}
+
+static struct perf_record_event_update *event_update_event__new(size_t size, u64 type, u64 id)
+{
+	struct perf_record_event_update *ev;
+
+	size += sizeof(*ev);
+	size  = PERF_ALIGN(size, sizeof(u64));
+
+	ev = zalloc(size);
+	if (ev) {
+		ev->header.type = PERF_RECORD_EVENT_UPDATE;
+		ev->header.size = (u16)size;
+		ev->type	= type;
+		ev->id		= id;
+	}
+	return ev;
+}
+
+int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evsel *evsel,
+					     perf_event__handler_t process)
+{
+	size_t size = strlen(evsel->unit);
+	struct perf_record_event_update *ev;
+	int err;
+
+	ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
+	if (ev == NULL)
+		return -ENOMEM;
+
+	strlcpy(ev->data, evsel->unit, size + 1);
+	err = process(tool, (union perf_event *)ev, NULL, NULL);
+	free(ev);
+	return err;
+}
+
+int perf_event__synthesize_event_update_scale(struct perf_tool *tool, struct evsel *evsel,
+					      perf_event__handler_t process)
+{
+	struct perf_record_event_update *ev;
+	struct perf_record_event_update_scale *ev_data;
+	int err;
+
+	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->id[0]);
+	if (ev == NULL)
+		return -ENOMEM;
+
+	ev_data = (struct perf_record_event_update_scale *)ev->data;
+	ev_data->scale = evsel->scale;
+	err = process(tool, (union perf_event *)ev, NULL, NULL);
+	free(ev);
+	return err;
+}
+
+int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evsel *evsel,
+					     perf_event__handler_t process)
+{
+	struct perf_record_event_update *ev;
+	size_t len = strlen(evsel->name);
+	int err;
+
+	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->id[0]);
+	if (ev == NULL)
+		return -ENOMEM;
+
+	strlcpy(ev->data, evsel->name, len + 1);
+	err = process(tool, (union perf_event *)ev, NULL, NULL);
+	free(ev);
+	return err;
+}
+
+int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
+					     perf_event__handler_t process)
+{
+	size_t size = sizeof(struct perf_record_event_update);
+	struct perf_record_event_update *ev;
+	int max, err;
+	u16 type;
+
+	if (!evsel->core.own_cpus)
+		return 0;
+
+	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->header.type = PERF_RECORD_EVENT_UPDATE;
+	ev->header.size = (u16)size;
+	ev->type	= PERF_EVENT_UPDATE__CPUS;
+	ev->id		= evsel->id[0];
+
+	cpu_map_data__synthesize((struct perf_record_cpu_map_data *)ev->data,
+				 evsel->core.own_cpus, type, max);
+
+	err = process(tool, (union perf_event *)ev, NULL, NULL);
+	free(ev);
+	return err;
+}
+
+int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist,
+				 perf_event__handler_t process)
+{
+	struct evsel *evsel;
+	int err = 0;
+
+	evlist__for_each_entry(evlist, evsel) {
+		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
+						  evsel->id, process);
+		if (err) {
+			pr_debug("failed to create perf header attribute\n");
+			return err;
+		}
+	}
+
+	return err;
+}
+
+static bool has_unit(struct evsel *evsel)
+{
+	return evsel->unit && *evsel->unit;
+}
+
+static bool has_scale(struct evsel *evsel)
+{
+	return evsel->scale != 1;
+}
+
+int perf_event__synthesize_extra_attr(struct perf_tool *tool, struct evlist *evsel_list,
+				      perf_event__handler_t process, bool is_pipe)
+{
+	struct evsel *evsel;
+	int err;
+
+	/*
+	 * Synthesize other events stuff not carried within
+	 * attr event - unit, scale, name
+	 */
+	evlist__for_each_entry(evsel_list, evsel) {
+		if (!evsel->supported)
+			continue;
+
+		/*
+		 * Synthesize unit and scale only if it's defined.
+		 */
+		if (has_unit(evsel)) {
+			err = perf_event__synthesize_event_update_unit(tool, evsel, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel unit.\n");
+				return err;
+			}
+		}
+
+		if (has_scale(evsel)) {
+			err = perf_event__synthesize_event_update_scale(tool, evsel, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel evsel.\n");
+				return err;
+			}
+		}
+
+		if (evsel->core.own_cpus) {
+			err = perf_event__synthesize_event_update_cpus(tool, evsel, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel cpus.\n");
+				return err;
+			}
+		}
+
+		/*
+		 * Name is needed only for pipe output,
+		 * perf.data carries event names.
+		 */
+		if (is_pipe) {
+			err = perf_event__synthesize_event_update_name(tool, evsel, process);
+			if (err < 0) {
+				pr_err("Couldn't synthesize evsel name.\n");
+				return err;
+			}
+		}
+	}
+	return 0;
+}
+
+int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *attr,
+				u32 ids, u64 *id, perf_event__handler_t process)
+{
+	union perf_event *ev;
+	size_t size;
+	int err;
+
+	size = sizeof(struct perf_event_attr);
+	size = PERF_ALIGN(size, sizeof(u64));
+	size += sizeof(struct perf_event_header);
+	size += ids * sizeof(u64);
+
+	ev = zalloc(size);
+
+	if (ev == NULL)
+		return -ENOMEM;
+
+	ev->attr.attr = *attr;
+	memcpy(ev->attr.id, id, ids * sizeof(u64));
+
+	ev->attr.header.type = PERF_RECORD_HEADER_ATTR;
+	ev->attr.header.size = (u16)size;
+
+	if (ev->attr.header.size == size)
+		err = process(tool, ev, NULL, NULL);
+	else
+		err = -E2BIG;
+
+	free(ev);
+
+	return err;
+}
+
+int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd, struct evlist *evlist,
+					perf_event__handler_t process)
+{
+	union perf_event ev;
+	struct tracing_data *tdata;
+	ssize_t size = 0, aligned_size = 0, padding;
+	struct feat_fd ff;
+
+	/*
+	 * We are going to store the size of the data followed
+	 * by the data contents. Since the fd descriptor is a pipe,
+	 * we cannot seek back to store the size of the data once
+	 * we know it. Instead we:
+	 *
+	 * - write the tracing data to the temp file
+	 * - get/write the data size to pipe
+	 * - write the tracing data from the temp file
+	 *   to the pipe
+	 */
+	tdata = tracing_data_get(&evlist->core.entries, fd, true);
+	if (!tdata)
+		return -1;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.tracing_data.header.type = PERF_RECORD_HEADER_TRACING_DATA;
+	size = tdata->size;
+	aligned_size = PERF_ALIGN(size, sizeof(u64));
+	padding = aligned_size - size;
+	ev.tracing_data.header.size = sizeof(ev.tracing_data);
+	ev.tracing_data.size = aligned_size;
+
+	process(tool, &ev, NULL, NULL);
+
+	/*
+	 * The put function will copy all the tracing data
+	 * stored in temp file to the pipe.
+	 */
+	tracing_data_put(tdata);
+
+	ff = (struct feat_fd){ .fd = fd };
+	if (write_padded(&ff, NULL, 0, padding))
+		return -1;
+
+	return aligned_size;
+}
+
+int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc,
+				    perf_event__handler_t process, struct machine *machine)
+{
+	union perf_event ev;
+	size_t len;
+
+	if (!pos->hit)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+
+	len = pos->long_name_len + 1;
+	len = PERF_ALIGN(len, NAME_ALIGN);
+	memcpy(&ev.build_id.build_id, pos->build_id, sizeof(pos->build_id));
+	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
+	ev.build_id.header.misc = misc;
+	ev.build_id.pid = machine->pid;
+	ev.build_id.header.size = sizeof(ev.build_id) + len;
+	memcpy(&ev.build_id.filename, pos->long_name, pos->long_name_len);
+
+	return process(tool, &ev, NULL, machine);
+}
+
+int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool,
+				       struct evlist *evlist, perf_event__handler_t process, bool attrs)
+{
+	int err;
+
+	if (attrs) {
+		err = perf_event__synthesize_attrs(tool, evlist, process);
+		if (err < 0) {
+			pr_err("Couldn't synthesize attrs.\n");
+			return err;
+		}
+	}
+
+	err = perf_event__synthesize_extra_attr(tool, evlist, process, attrs);
+	err = perf_event__synthesize_thread_map2(tool, evlist->core.threads, process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_cpu_map(tool, evlist->core.cpus, process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize config.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+int __weak perf_event__synth_time_conv(const struct perf_event_mmap_page *pc __maybe_unused,
+				       struct perf_tool *tool __maybe_unused,
+				       perf_event__handler_t process __maybe_unused,
+				       struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
+extern const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE];
+
+int perf_event__synthesize_features(struct perf_tool *tool, struct perf_session *session,
+				    struct evlist *evlist, perf_event__handler_t process)
+{
+	struct perf_header *header = &session->header;
+	struct perf_record_header_feature *fe;
+	struct feat_fd ff;
+	size_t sz, sz_hdr;
+	int feat, ret;
+
+	sz_hdr = sizeof(fe->header);
+	sz = sizeof(union perf_event);
+	/* get a nice alignment */
+	sz = PERF_ALIGN(sz, page_size);
+
+	memset(&ff, 0, sizeof(ff));
+
+	ff.buf = malloc(sz);
+	if (!ff.buf)
+		return -ENOMEM;
+
+	ff.size = sz - sz_hdr;
+	ff.ph = &session->header;
+
+	for_each_set_bit(feat, header->adds_features, HEADER_FEAT_BITS) {
+		if (!feat_ops[feat].synthesize) {
+			pr_debug("No record header feature for header :%d\n", feat);
+			continue;
+		}
+
+		ff.offset = sizeof(*fe);
+
+		ret = feat_ops[feat].write(&ff, evlist);
+		if (ret || ff.offset <= (ssize_t)sizeof(*fe)) {
+			pr_debug("Error writing feature\n");
+			continue;
+		}
+		/* ff.buf may have changed due to realloc in do_write() */
+		fe = ff.buf;
+		memset(fe, 0, sizeof(*fe));
+
+		fe->feat_id = feat;
+		fe->header.type = PERF_RECORD_HEADER_FEATURE;
+		fe->header.size = ff.offset;
+
+		ret = process(tool, ff.buf, NULL, NULL);
+		if (ret) {
+			free(ff.buf);
+			return ret;
+		}
+	}
+
+	/* Send HEADER_LAST_FEATURE mark. */
+	fe = ff.buf;
+	fe->feat_id     = HEADER_LAST_FEATURE;
+	fe->header.type = PERF_RECORD_HEADER_FEATURE;
+	fe->header.size = sizeof(*fe);
+
+	ret = process(tool, ff.buf, NULL, NULL);
+
+	free(ff.buf);
+	return ret;
+}
