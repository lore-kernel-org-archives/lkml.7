Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9257C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D9F215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qMGAk2W0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfFYIib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:38:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfFYIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:38:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8bvcC3532221
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:37:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8bvcC3532221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451878;
        bh=jN6T068MbezBtUjC1FjYfBtOle/2afKpdoOjlrY8SKs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qMGAk2W002ukx88cKhF6atpe/8O9W2qGpeUKiZ5okUwjHBGf7qyE99XWLrtdxmoab
         qtN/vpssulYVW8FuO8U8XT1eaqmITYXyY6pqC3QBYXTgBGJMP3jz3Ox6ww/RSMzGyn
         pINgJVRsvP/oassRBfpOcx7lPLcuoSFkml5DCmGH/iJ9YCuW+0O82Ibf+1+KnG3o9E
         x9ADy5aDFA4WjTZdiXmzaObmwrf2gYytV8aqsy7Gd15jFDkq5mUV+Noz0c6hxbSWWY
         fbw32ido6sKmLa28Drb9ndWFNy3VmPoCu5SrwTDeGRcpE6D6yPwPVXt6yjOU61jEtA
         AEfSVfc7MGyvA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8bvGl3532218;
        Tue, 25 Jun 2019 01:37:57 -0700
Date:   Tue, 25 Jun 2019 01:37:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-98253a546a468d88b7e782ab67cdf447d3c7bbe2@git.kernel.org>
Cc:     acme@kernel.org, vincent.weaver@maine.edu, peterz@infradead.org,
        hpa@zytor.com, kan.liang@linux.intel.com, namhyung@kernel.org,
        mingo@kernel.org, luto@kernel.org, acme@redhat.com,
        jolsa@redhat.com, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        eranian@google.com, tglx@linutronix.de, bp@alien8.de,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: acme@kernel.org, vincent.weaver@maine.edu, peterz@infradead.org,
          kan.liang@linux.intel.com, hpa@zytor.com, namhyung@kernel.org,
          luto@kernel.org, mingo@kernel.org, acme@redhat.com,
          jolsa@redhat.com, torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
          eranian@google.com, jolsa@kernel.org, tglx@linutronix.de,
          bp@alien8.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190616140358.27799-2-jolsa@kernel.org>
References: <20190616140358.27799-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Add MSR probe interface
Git-Commit-ID: 98253a546a468d88b7e782ab67cdf447d3c7bbe2
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

Commit-ID:  98253a546a468d88b7e782ab67cdf447d3c7bbe2
Gitweb:     https://git.kernel.org/tip/98253a546a468d88b7e782ab67cdf447d3c7bbe2
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:51 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:31 +0200

perf/x86: Add MSR probe interface

Adding perf_msr_probe function to provide interface for
checking up on MSR register and set the related attribute
group visibility.

User defines following struct for each MSR register:

  struct perf_msr {
       u64                       msr;
       struct attribute_group   *grp;
       bool                    (*test)(int idx, void *data);
       bool                      no_check;
  };

Where:
  msr      - is the MSR address
  attrs    - is attribute groups array to add if the check passed
  test     - is test function pointer
  no_check - is bool that bypass the check and adds the
              attribute without any test

The array of struct perf_msr is passed into:

  perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)

Together with:
  cnt  - which is the number of struct msr array elements
  data - which is user pointer passed to the test function
  zero - allow counters that returns zero on rdmsr

The perf_msr_probe will executed test code, read the MSR and
check the value is != 0. If all these tests pass, related
attribute group is kept visible.

Also adding PMU_EVENT_GROUP macro helper to define attribute
group for single attribute. It will be used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan <kan.liang@linux.intel.com>
Cc: Liang
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190616140358.27799-2-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/Makefile |  2 +-
 arch/x86/events/probe.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/probe.h  | 29 +++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index 9cbfd34042d5..9e07f554333f 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= core.o
+obj-y					+= core.o probe.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
new file mode 100644
index 000000000000..c2ede2f3b277
--- /dev/null
+++ b/arch/x86/events/probe.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/bits.h>
+#include "probe.h"
+
+static umode_t
+not_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return 0;
+}
+
+unsigned long
+perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
+{
+	unsigned long avail = 0;
+	unsigned int bit;
+	u64 val;
+
+	if (cnt >= BITS_PER_LONG)
+		return 0;
+
+	for (bit = 0; bit < cnt; bit++) {
+		if (!msr[bit].no_check) {
+			struct attribute_group *grp = msr[bit].grp;
+
+			grp->is_visible = not_visible;
+
+			if (msr[bit].test && !msr[bit].test(bit, data))
+				continue;
+			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
+			if (rdmsrl_safe(msr[bit].msr, &val))
+				continue;
+			/* Disable zero counters if requested. */
+			if (!zero && !val)
+				continue;
+
+			grp->is_visible = NULL;
+		}
+		avail |= BIT(bit);
+	}
+
+	return avail;
+}
+EXPORT_SYMBOL_GPL(perf_msr_probe);
diff --git a/arch/x86/events/probe.h b/arch/x86/events/probe.h
new file mode 100644
index 000000000000..4c8e0afc5fb5
--- /dev/null
+++ b/arch/x86/events/probe.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_X86_EVENTS_PROBE_H__
+#define __ARCH_X86_EVENTS_PROBE_H__
+#include <linux/sysfs.h>
+
+struct perf_msr {
+	u64			  msr;
+	struct attribute_group	 *grp;
+	bool			(*test)(int idx, void *data);
+	bool			  no_check;
+};
+
+unsigned long
+perf_msr_probe(struct perf_msr *msr, int cnt, bool no_zero, void *data);
+
+#define __PMU_EVENT_GROUP(_name)			\
+static struct attribute *attrs_##_name[] = {		\
+	&attr_##_name.attr.attr,			\
+	NULL,						\
+}
+
+#define PMU_EVENT_GROUP(_grp, _name)			\
+__PMU_EVENT_GROUP(_name);				\
+static struct attribute_group group_##_name = {		\
+	.name  = #_grp,					\
+	.attrs = attrs_##_name,				\
+}
+
+#endif /* __ARCH_X86_EVENTS_PROBE_H__ */
