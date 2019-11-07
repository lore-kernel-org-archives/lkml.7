Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F3C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D892084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153694;
	bh=GKA5r3QdsSXmNwNcoySiknXQGXR+yp7lsgBPHWUINbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DeL7P9MsJsO3H4tbb2U0rjn338NaEpeBfUZRrnHrQ0yKwwoi2hYs1qJA8uDzrXApc
	 Lrw7ytOTLwtg4a8Voai71uKmvIFxqTdmITVzwgXPQNNMNabqWz0EXN1d14hMCQKdxU
	 LDL9VbRB9GuX2Zs6cIEhYlvKb98AYmb1W++IdRXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfKGTIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfKGTIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:11 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549BF2085B;
        Thu,  7 Nov 2019 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153691;
        bh=GKA5r3QdsSXmNwNcoySiknXQGXR+yp7lsgBPHWUINbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCCxKQ5r4WWfW1teHigzPbOX0lP576h2/7xi0LZD7bzDTZwhUFGkTorgbcQtxaWEv
         UnU8JKGI3Ca+yscYpz6yw7mPFGZjW5sBxpWnHmr5DPV0EIbVG9NcnKVbiRjpq5eQdb
         UqhHsSorT3Ndffykd0JvLEx5keTfN1dSRuZnmDwM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 48/63] perf machine: Add kernel_dso() method
Date:   Thu,  7 Nov 2019 15:59:56 -0300
Message-Id: <20191107190011.23924-49-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce boilerplate in some places.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9s1bgoxxhlnu037e1nqx0tw3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 24d9e284daad..e768ef24633f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -42,6 +42,11 @@
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
 
+static struct dso *machine__kernel_dso(struct machine *machine)
+{
+	return machine->vmlinux_map->dso;
+}
+
 static void dsos__init(struct dsos *dsos)
 {
 	INIT_LIST_HEAD(&dsos->head);
@@ -861,7 +866,7 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 {
 	int i;
 	size_t printed = 0;
-	struct dso *kdso = machine__kernel_map(machine)->dso;
+	struct dso *kdso = machine__kernel_dso(machine);
 
 	if (kdso->has_build_id) {
 		char filename[PATH_MAX];
@@ -1543,8 +1548,7 @@ static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 static int machine__process_extra_kernel_map(struct machine *machine,
 					     union perf_event *event)
 {
-	struct map *kernel_map = machine__kernel_map(machine);
-	struct dso *kernel = kernel_map ? kernel_map->dso : NULL;
+	struct dso *kernel = machine__kernel_dso(machine);
 	struct extra_kernel_map xm = {
 		.start = event->mmap.start,
 		.end   = event->mmap.start + event->mmap.len,
-- 
2.21.0

