Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC124655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594177;
	bh=a5BOGuIgwL91Z/3VqfWS23cVy3qRdxItEWxIcY9skbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WD4q+mef4GQyLtOd3cmUoAfW6JMWZaoxr+MhB4UwZMpS/QWCtrPFngTDeLqgAVCPS
	 XmryLhFYP+9W4aBzGc2HeExtm4vwdH7FielcayGKU3EaWbfih8HinruZpg6XGQGbYV
	 hfXOKMvzEm2Ut8RmLmnuRhG3Qr/WK8amLFSvCWYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfLQOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbfLQOtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:49:33 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 046362465E;
        Tue, 17 Dec 2019 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594172;
        bh=a5BOGuIgwL91Z/3VqfWS23cVy3qRdxItEWxIcY9skbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=adOL0R4Pbqr+XNgohPIT1E1m7WpM81wuuxh2YZb6GggTwx7y+TLOFYeRWTqdftg6n
         nnn27Ur8TKrpqezSJj6HbsAM87fykUt5jTM2rns6yi8FqoUOtn5JS5NPynGYegzQy8
         0DVQDbadlcBuB5s8kpijcuYCyipGbxpQ3Mg3G14k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for kernel maps
Date:   Tue, 17 Dec 2019 11:48:28 -0300
Message-Id: <20191217144828.2460-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When kernel maps are created with map__new2() we allocate an extra area
to store a pointer to the 'struct maps' for the kernel maps, and this
ends up being used in places like __map__is_kernel() to figure out if a
map is the main kernel one.

We were setting this up only in __machine__create_kernel_maps() and
machine__create_extra_kernel_map(), but not when splitting kallsyms,
kcore address ranges in new kernel maps such as
"[kernel.vmlinux].init.text", leading to assertion failures in
__map__is_kernel().

So make map__new2() receive the kernel 'struct maps' pointer so that all
kernel maps point back to it in its 'struct kmap' area.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-z4qrek7y7s7sjnczremjdn1z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/maps.c       |  8 ++++----
 tools/perf/util/auxtrace.c    |  2 +-
 tools/perf/util/dso.c         |  4 ++--
 tools/perf/util/dso.h         |  4 +++-
 tools/perf/util/machine.c     | 10 ++++------
 tools/perf/util/map.c         | 15 ++++++++++++++-
 tools/perf/util/map.h         |  2 +-
 tools/perf/util/probe-event.c | 10 ++++++----
 tools/perf/util/symbol-elf.c  |  2 +-
 tools/perf/util/symbol.c      |  6 ++++--
 10 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index edcbc70ff9d6..7e32b4df8ff1 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -69,7 +69,7 @@ int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unus
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
 		struct map *map;
 
-		map = dso__new_map(bpf_progs[i].name);
+		map = dso__new_map(bpf_progs[i].name, &maps);
 		TEST_ASSERT_VAL("failed to create map", map);
 
 		map->start = bpf_progs[i].start;
@@ -78,13 +78,13 @@ int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unus
 		map__put(map);
 	}
 
-	map_kcore1 = dso__new_map("kcore1");
+	map_kcore1 = dso__new_map("kcore1", &maps);
 	TEST_ASSERT_VAL("failed to create map", map_kcore1);
 
-	map_kcore2 = dso__new_map("kcore2");
+	map_kcore2 = dso__new_map("kcore2", &maps);
 	TEST_ASSERT_VAL("failed to create map", map_kcore2);
 
-	map_kcore3 = dso__new_map("kcore3");
+	map_kcore3 = dso__new_map("kcore3", &maps);
 	TEST_ASSERT_VAL("failed to create map", map_kcore3);
 
 	/* kcore1 map overlaps over all bpf maps */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eb087e7df6f4..c5be6eeff069 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2250,7 +2250,7 @@ static struct dso *load_dso(const char *name)
 	struct map *map;
 	struct dso *dso;
 
-	map = dso__new_map(name);
+	map = dso__new_map(name, NULL);
 	if (!map)
 		return NULL;
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 91f21239608b..dd5c2e71d8d7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1118,13 +1118,13 @@ ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
 	return dso__data_write_cache_offs(dso, machine, offset, data, size);
 }
 
-struct map *dso__new_map(const char *name)
+struct map *dso__new_map(const char *name, struct maps *kmaps)
 {
 	struct map *map = NULL;
 	struct dso *dso = dso__new(name);
 
 	if (dso)
-		map = map__new2(0, dso);
+		map = map__new2(0, dso, kmaps);
 
 	return map;
 }
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2db64b79617a..3b4f690c67e0 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -353,7 +353,9 @@ ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
 				   struct machine *machine, u64 addr,
 				   const u8 *data, ssize_t size);
 
-struct map *dso__new_map(const char *name);
+struct maps;
+
+struct map *dso__new_map(const char *name, struct maps *kmaps);
 struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 				    const char *short_name, int dso_type);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..7ee14963edc9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -726,7 +726,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
+		map = dso__new_map(event->ksymbol.name, &machine->kmaps);
 		if (!map)
 			return -ENOMEM;
 
@@ -784,7 +784,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 	if (dso == NULL)
 		goto out;
 
-	map = map__new2(start, dso);
+	map = map__new2(start, dso, &machine->kmaps);
 	if (map == NULL)
 		goto out;
 
@@ -963,7 +963,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	struct kmap *kmap;
 	struct map *map;
 
-	map = map__new2(xm->start, kernel);
+	map = map__new2(xm->start, kernel, &machine->kmaps);
 	if (!map)
 		return -1;
 
@@ -972,7 +972,6 @@ int machine__create_extra_kernel_map(struct machine *machine,
 
 	kmap = map__kmap(map);
 
-	kmap->kmaps = &machine->kmaps;
 	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	maps__insert(&machine->kmaps, map);
@@ -1088,7 +1087,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
-	machine->vmlinux_map = map__new2(0, kernel);
+	machine->vmlinux_map = map__new2(0, kernel, &machine->kmaps);
 	if (machine->vmlinux_map == NULL)
 		return -1;
 
@@ -1098,7 +1097,6 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	if (!kmap)
 		return -1;
 
-	kmap->kmaps = &machine->kmaps;
 	maps__insert(&machine->kmaps, map);
 
 	return 0;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fdd5bddb3075..a2cdfe62df94 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -223,7 +223,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
  * they are loaded) and for vmlinux, where only after we load all the
  * symbols we'll know where it starts and ends.
  */
-struct map *map__new2(u64 start, struct dso *dso)
+struct map *map__new2(u64 start, struct dso *dso, struct maps *kmaps)
 {
 	struct map *map = calloc(1, (sizeof(*map) +
 				     (dso->kernel ? sizeof(struct kmap) : 0)));
@@ -232,6 +232,19 @@ struct map *map__new2(u64 start, struct dso *dso)
 		 * ->end will be filled after we load all the symbols
 		 */
 		map__init(map, start, 0, 0, dso);
+		if (dso->kernel) {
+			/*
+			 * __map__is_kernel() Needs this for in-kernel map ranges
+			 * such as:
+			 * (gdb) print map->dso->name
+			 * $8 = 0x1232d6c "[kernel.vmlinux].init.text"
+			 * (gdb) print map->dso->kernel
+			 * $9 = DSO_TYPE_KERNEL
+			 * (gdb)
+			 */
+			struct kmap *kmap = map__kmap(map);
+			kmap->kmaps = kmaps;
+		}
 	}
 
 	return map;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 067036e8970c..b4531876cd66 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -108,7 +108,7 @@ struct dso_id;
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
 		     char *filename, struct thread *thread);
-struct map *map__new2(u64 start, struct dso *dso);
+struct map *map__new2(u64 start, struct dso *dso, struct maps *kmaps);
 void map__delete(struct map *map);
 struct map *map__clone(struct map *map);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index eea132f512b0..b123a800d260 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -146,7 +146,7 @@ static struct map *kernel_get_module_map(const char *module)
 
 	/* A file path -- this is an offline module */
 	if (module && strchr(module, '/'))
-		return dso__new_map(module);
+		return dso__new_map(module, maps);
 
 	if (!module) {
 		pos = machine__kernel_map(host_machine);
@@ -170,7 +170,7 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
 	if (user) {
 		struct map *map;
 
-		map = dso__new_map(target);
+		map = dso__new_map(target, NULL);
 		if (map && map->dso)
 			map->dso->nsinfo = nsinfo__get(nsi);
 		return map;
@@ -651,12 +651,13 @@ static int
 post_process_offline_probe_trace_events(struct probe_trace_event *tevs,
 					int ntevs, const char *pathname)
 {
+	struct maps *maps = machine__kernel_maps(host_machine);
 	struct map *map;
 	unsigned long stext = 0;
 	int i, ret = 0;
 
 	/* Prepare a map for offline binary */
-	map = dso__new_map(pathname);
+	map = dso__new_map(pathname, maps);
 	if (!map || get_text_start_address(pathname, &stext, NULL) < 0) {
 		pr_warning("Failed to get ELF symbols for %s\n", pathname);
 		return -EINVAL;
@@ -2111,7 +2112,8 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
 	int ret = -ENOENT;
 
 	if (!is_kprobe) {
-		map = dso__new_map(tp->module);
+		struct maps *maps = machine__kernel_maps(host_machine);
+		map = dso__new_map(tp->module, maps);
 		if (!map)
 			goto out;
 		sym = map__find_symbol(map, addr);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6658fbf196e6..cc896ba85a99 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -915,7 +915,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		curr_dso->kernel = dso->kernel;
 		curr_dso->long_name = dso->long_name;
 		curr_dso->long_name_len = dso->long_name_len;
-		curr_map = map__new2(start, curr_dso);
+		curr_map = map__new2(start, curr_dso, kmaps);
 		dso__put(curr_dso);
 		if (curr_map == NULL)
 			return -1;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..d166f0fb258c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -856,7 +856,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 
 			ndso->kernel = dso->kernel;
 
-			curr_map = map__new2(pos->start, ndso);
+			curr_map = map__new2(pos->start, ndso, kmaps);
 			if (curr_map == NULL) {
 				dso__put(ndso);
 				return -1;
@@ -1144,6 +1144,7 @@ static int validate_kcore_addresses(const char *kallsyms_filename,
 
 struct kcore_mapfn_data {
 	struct dso *dso;
+	struct maps *kmaps;
 	struct list_head maps;
 };
 
@@ -1152,7 +1153,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	struct kcore_mapfn_data *md = data;
 	struct map *map;
 
-	map = map__new2(start, md->dso);
+	map = map__new2(start, md->dso, md->kmaps);
 	if (map == NULL)
 		return -ENOMEM;
 
@@ -1271,6 +1272,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		return -EINVAL;
 
 	md.dso = dso;
+	md.kmaps = kmaps;
 	INIT_LIST_HEAD(&md.maps);
 
 	fd = open(kcore_filename, O_RDONLY);
-- 
2.21.0

