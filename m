Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B721FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726712085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eY4GMr/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfFQTeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:34:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfFQTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:34:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJWhAa3564885
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:32:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJWhAa3564885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799964;
        bh=4nLSxORKKfdtsedCu2qAk1aFuxmP7P25WZZBWJHuF5s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eY4GMr/ULqy51abLgAcJha9uht8lMl/J7pxJx5qwNPDvDZ9b8xZyXxFknmnydOLqp
         6bgPqrYLrwgf19bGxMQ08QKLbLHbSxLEFqF2KLFJO0vJRKWr7+up8UjZN6VLHcVDGH
         jn0HJd6abaGAT4dsyENZUd+clISFaYzNI3f8clQNb1beAgc9Ydg7kmJcYYG1dmS2z/
         7V6EzPIKmUOB27iEIt33bVqkc/mNsJL+kgnT8oUHRNeNJwSn85bYEnOT9YhO7yg2Ag
         UsyYTMcfkOE4zz+t7Duho3BEgwRlDsAhPoqLrmTmq0gKSI0AHvBekYtgpaZkCfgtSO
         yX4xouRH+buTg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJWhqs3564882;
        Mon, 17 Jun 2019 12:32:43 -0700
Date:   Mon, 17 Jun 2019 12:32:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-acae8b36cded0ee62038dedd0a44d54d5d673a96@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        kan.liang@linux.intel.com, ak@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          hpa@zytor.com, ak@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <1559688644-106558-2-git-send-email-kan.liang@linux.intel.com>
References: <1559688644-106558-2-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Add die information in CPU topology
Git-Commit-ID: acae8b36cded0ee62038dedd0a44d54d5d673a96
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

Commit-ID:  acae8b36cded0ee62038dedd0a44d54d5d673a96
Gitweb:     https://git.kernel.org/tip/acae8b36cded0ee62038dedd0a44d54d5d673a96
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 4 Jun 2019 15:50:41 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf header: Add die information in CPU topology

With the new CPUID.1F, a new level type of CPU topology, 'die', is
introduced. The 'die' information in CPU topology should be added in
perf header.

To be compatible with old perf.data, the patch checks the section size
before reading the die information. The new info is added at the end of
the cpu_topology section, the old perf tool ignores the extra data.  It
never reads data crossing the section boundary.

The new perf tool with the patch can be used on legacy kernel. Add a new
function has_die_topology() to check if die topology information is
supported by kernel. The function only check X86 and CPU 0. Assuming
other CPUs have same topology.

Use similar method for core and socket to support die id and sibling
dies string.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1559688644-106558-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt |  9 ++-
 tools/perf/util/cputopo.c                          | 76 +++++++++++++++--
 tools/perf/util/cputopo.h                          |  2 +
 tools/perf/util/env.c                              |  1 +
 tools/perf/util/env.h                              |  3 +
 tools/perf/util/header.c                           | 94 ++++++++++++++++++++--
 6 files changed, 172 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 6375e6fb8bac..0165e92e717e 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -153,7 +153,7 @@ struct {
 
 String lists defining the core and CPU threads topology.
 The string lists are followed by a variable length array
-which contains core_id and socket_id of each cpu.
+which contains core_id, die_id (for x86) and socket_id of each cpu.
 The number of entries can be determined by the size of the
 section minus the sizes of both string lists.
 
@@ -162,14 +162,19 @@ struct {
        struct perf_header_string_list threads; /* Variable length */
        struct {
 	      uint32_t core_id;
+	      uint32_t die_id;
 	      uint32_t socket_id;
        } cpus[nr]; /* Variable length records */
 };
 
 Example:
-	sibling cores   : 0-3
+	sibling cores   : 0-8
+	sibling dies	: 0-3
+	sibling dies	: 4-7
 	sibling threads : 0-1
 	sibling threads : 2-3
+	sibling threads : 4-5
+	sibling threads : 6-7
 
 	HEADER_NUMA_TOPOLOGY = 14,
 
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index ece0710249d4..85fa87fc30cf 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
+#include <sys/utsname.h>
 #include <inttypes.h>
 #include <api/fs/fs.h>
 
@@ -8,9 +9,10 @@
 #include "util.h"
 #include "env.h"
 
-
 #define CORE_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
+#define DIE_SIB_FMT \
+	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
 #define THRD_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 #define NODE_ONLINE_FMT \
@@ -34,12 +36,12 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
-		goto try_threads;
+		goto try_dies;
 
 	sret = getline(&buf, &len, fp);
 	fclose(fp);
 	if (sret <= 0)
-		goto try_threads;
+		goto try_dies;
 
 	p = strchr(buf, '\n');
 	if (p)
@@ -57,6 +59,37 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	}
 	ret = 0;
 
+try_dies:
+	if (!tp->die_siblings)
+		goto try_threads;
+
+	scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
+	fp = fopen(filename, "r");
+	if (!fp)
+		goto try_threads;
+
+	sret = getline(&buf, &len, fp);
+	fclose(fp);
+	if (sret <= 0)
+		goto try_threads;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	for (i = 0; i < tp->die_sib; i++) {
+		if (!strcmp(buf, tp->die_siblings[i]))
+			break;
+	}
+	if (i == tp->die_sib) {
+		tp->die_siblings[i] = buf;
+		tp->die_sib++;
+		buf = NULL;
+		len = 0;
+	}
+	ret = 0;
+
 try_threads:
 	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
 		  sysfs__mountpoint(), cpu);
@@ -98,21 +131,46 @@ void cpu_topology__delete(struct cpu_topology *tp)
 	for (i = 0 ; i < tp->core_sib; i++)
 		zfree(&tp->core_siblings[i]);
 
+	if (tp->die_sib) {
+		for (i = 0 ; i < tp->die_sib; i++)
+			zfree(&tp->die_siblings[i]);
+	}
+
 	for (i = 0 ; i < tp->thread_sib; i++)
 		zfree(&tp->thread_siblings[i]);
 
 	free(tp);
 }
 
+static bool has_die_topology(void)
+{
+	char filename[MAXPATHLEN];
+	struct utsname uts;
+
+	if (uname(&uts) < 0)
+		return false;
+
+	if (strncmp(uts.machine, "x86_64", 6))
+		return false;
+
+	scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
+		  sysfs__mountpoint(), 0);
+	if (access(filename, F_OK) == -1)
+		return false;
+
+	return true;
+}
+
 struct cpu_topology *cpu_topology__new(void)
 {
 	struct cpu_topology *tp = NULL;
 	void *addr;
-	u32 nr, i;
+	u32 nr, i, nr_addr;
 	size_t sz;
 	long ncpus;
 	int ret = -1;
 	struct cpu_map *map;
+	bool has_die = has_die_topology();
 
 	ncpus = cpu__max_present_cpu();
 
@@ -126,7 +184,11 @@ struct cpu_topology *cpu_topology__new(void)
 	nr = (u32)(ncpus & UINT_MAX);
 
 	sz = nr * sizeof(char *);
-	addr = calloc(1, sizeof(*tp) + 2 * sz);
+	if (has_die)
+		nr_addr = 3;
+	else
+		nr_addr = 2;
+	addr = calloc(1, sizeof(*tp) + nr_addr * sz);
 	if (!addr)
 		goto out_free;
 
@@ -134,6 +196,10 @@ struct cpu_topology *cpu_topology__new(void)
 	addr += sizeof(*tp);
 	tp->core_siblings = addr;
 	addr += sz;
+	if (has_die) {
+		tp->die_siblings = addr;
+		addr += sz;
+	}
 	tp->thread_siblings = addr;
 
 	for (i = 0; i < nr; i++) {
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 47a97e71acdf..bae2f1d41856 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -7,8 +7,10 @@
 
 struct cpu_topology {
 	u32	  core_sib;
+	u32	  die_sib;
 	u32	  thread_sib;
 	char	**core_siblings;
+	char	**die_siblings;
 	char	**thread_siblings;
 };
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6a3eaf7d9353..1cc7a1837822 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -246,6 +246,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	for (cpu = 0; cpu < nr_cpus; ++cpu) {
 		env->cpu[cpu].core_id	= cpu_map__get_core_id(cpu);
 		env->cpu[cpu].socket_id	= cpu_map__get_socket_id(cpu);
+		env->cpu[cpu].die_id	= cpu_map__get_die_id(cpu);
 	}
 
 	env->nr_cpus_avail = nr_cpus;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 271a90b326c4..d5d9865aa812 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -9,6 +9,7 @@
 
 struct cpu_topology_map {
 	int	socket_id;
+	int	die_id;
 	int	core_id;
 };
 
@@ -49,6 +50,7 @@ struct perf_env {
 
 	int			nr_cmdline;
 	int			nr_sibling_cores;
+	int			nr_sibling_dies;
 	int			nr_sibling_threads;
 	int			nr_numa_nodes;
 	int			nr_memory_nodes;
@@ -57,6 +59,7 @@ struct perf_env {
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
+	char			*sibling_dies;
 	char			*sibling_threads;
 	char			*pmu_mappings;
 	struct cpu_topology_map	*cpu;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 847ae51a524b..64976254431c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -599,6 +599,27 @@ static int write_cpu_topology(struct feat_fd *ff,
 		if (ret < 0)
 			return ret;
 	}
+
+	if (!tp->die_sib)
+		goto done;
+
+	ret = do_write(ff, &tp->die_sib, sizeof(tp->die_sib));
+	if (ret < 0)
+		goto done;
+
+	for (i = 0; i < tp->die_sib; i++) {
+		ret = do_write_string(ff, tp->die_siblings[i]);
+		if (ret < 0)
+			goto done;
+	}
+
+	for (j = 0; j < perf_env.nr_cpus_avail; j++) {
+		ret = do_write(ff, &perf_env.cpu[j].die_id,
+			       sizeof(perf_env.cpu[j].die_id));
+		if (ret < 0)
+			return ret;
+	}
+
 done:
 	cpu_topology__delete(tp);
 	return ret;
@@ -1443,6 +1464,16 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 		str += strlen(str) + 1;
 	}
 
+	if (ph->env.nr_sibling_dies) {
+		nr = ph->env.nr_sibling_dies;
+		str = ph->env.sibling_dies;
+
+		for (i = 0; i < nr; i++) {
+			fprintf(fp, "# sibling dies    : %s\n", str);
+			str += strlen(str) + 1;
+		}
+	}
+
 	nr = ph->env.nr_sibling_threads;
 	str = ph->env.sibling_threads;
 
@@ -1451,12 +1482,28 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 		str += strlen(str) + 1;
 	}
 
-	if (ph->env.cpu != NULL) {
-		for (i = 0; i < cpu_nr; i++)
-			fprintf(fp, "# CPU %d: Core ID %d, Socket ID %d\n", i,
-				ph->env.cpu[i].core_id, ph->env.cpu[i].socket_id);
-	} else
-		fprintf(fp, "# Core ID and Socket ID information is not available\n");
+	if (ph->env.nr_sibling_dies) {
+		if (ph->env.cpu != NULL) {
+			for (i = 0; i < cpu_nr; i++)
+				fprintf(fp, "# CPU %d: Core ID %d, "
+					    "Die ID %d, Socket ID %d\n",
+					    i, ph->env.cpu[i].core_id,
+					    ph->env.cpu[i].die_id,
+					    ph->env.cpu[i].socket_id);
+		} else
+			fprintf(fp, "# Core ID, Die ID and Socket ID "
+				    "information is not available\n");
+	} else {
+		if (ph->env.cpu != NULL) {
+			for (i = 0; i < cpu_nr; i++)
+				fprintf(fp, "# CPU %d: Core ID %d, "
+					    "Socket ID %d\n",
+					    i, ph->env.cpu[i].core_id,
+					    ph->env.cpu[i].socket_id);
+		} else
+			fprintf(fp, "# Core ID and Socket ID "
+				    "information is not available\n");
+	}
 }
 
 static void print_clockid(struct feat_fd *ff, FILE *fp)
@@ -2214,6 +2261,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto free_cpu;
 
 		ph->env.cpu[i].core_id = nr;
+		size += sizeof(u32);
 
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
@@ -2225,6 +2273,40 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		}
 
 		ph->env.cpu[i].socket_id = nr;
+		size += sizeof(u32);
+	}
+
+	/*
+	 * The header may be from old perf,
+	 * which doesn't include die information.
+	 */
+	if (ff->size <= size)
+		return 0;
+
+	if (do_read_u32(ff, &nr))
+		return -1;
+
+	ph->env.nr_sibling_dies = nr;
+	size += sizeof(u32);
+
+	for (i = 0; i < nr; i++) {
+		str = do_read_string(ff);
+		if (!str)
+			goto error;
+
+		/* include a NULL character at the end */
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+			goto error;
+		size += string_size(str);
+		free(str);
+	}
+	ph->env.sibling_dies = strbuf_detach(&sb, NULL);
+
+	for (i = 0; i < (u32)cpu_nr; i++) {
+		if (do_read_u32(ff, &nr))
+			goto free_cpu;
+
+		ph->env.cpu[i].die_id = nr;
 	}
 
 	return 0;
