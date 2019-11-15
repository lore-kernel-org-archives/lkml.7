Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D5820859
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKOHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfKOHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDI-0002WY-0m; Fri, 15 Nov 2019 08:40:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9322F1C18B4;
        Fri, 15 Nov 2019 08:40:15 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:15 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf symbols: Use kmaps(map)->machine when we know
 its a kernel map
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-lgrrzdxo2p9liq2keivcg887@git.kernel.org>
References: <tip-lgrrzdxo2p9liq2keivcg887@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361519.29467.5470618161759183163.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     93fcce96c71931f65c9bb1a0f2303008e6862c97
Gitweb:        https://git.kernel.org/tip/93fcce96c71931f65c9bb1a0f2303008e6862c97
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 16:25:11 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf symbols: Use kmaps(map)->machine when we know its a kernel map

And then stop using map->groups to achieve that.

To test that that branch is being taken, probe the function that is only
called from there and then run something like 'perf top' in another
xterm:

  # perf probe -x ~/bin/perf machine__map_x86_64_entry_trampolines
  Added new event:
    probe_perf:machine__map_x86_64_entry_trampolines (on machine__map_x86_64_entry_trampolines in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:machine__map_x86_64_entry_trampolines -aR sleep 1

  # perf trace -e probe_perf:*
       0.000 bash/10614 probe_perf:machine__map_x86_64_entry_trampolines(__probe_ip: 5224944)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lgrrzdxo2p9liq2keivcg887@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2764863..88f4cfb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1588,7 +1588,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char *name;
 	int ret = -1;
 	u_int i;
-	struct machine *machine;
+	struct machine *machine = NULL;
 	char *root_dir = (char *) "";
 	int ss_pos = 0;
 	struct symsrc ss_[2];
@@ -1617,17 +1617,13 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (map->groups)
-		machine = map->groups->machine;
-	else
-		machine = NULL;
-
 	if (dso->kernel) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
+		machine = map__kmaps(map)->machine;
 		if (machine__is(machine, "x86_64"))
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
@@ -2027,15 +2023,9 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
-	struct machine *machine;
+	struct machine *machine = map__kmaps(map)->machine;
 	char path[PATH_MAX];
 
-	if (!map->groups) {
-		pr_debug("Guest kernel map hasn't the point to groups\n");
-		return -1;
-	}
-	machine = map->groups->machine;
-
 	if (machine__is_default_guest(machine)) {
 		/*
 		 * if the user specified a vmlinux filename, use it and only
