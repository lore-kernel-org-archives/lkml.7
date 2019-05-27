Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE58FC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 21:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965E320815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558993899;
	bh=XB/xSB3ZuJbHVmp1XvGsw/oWuY+1xSk6qagvXNNgCvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxEHtpZJcmMK14WhqMAMbZiBeXICsG5FgvmGCAt4F5aQ70v4rJ02990mVviIFUk8L
	 hr+8zYvBkTU/rbAL20uj0/kCkkrMOyI6i32AAOjla077WK75LqHdt489kfn+iRgWUB
	 CVseOR43qZflrhk8saXbvfhuuj1GQKTGs8mznu1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfE0Vvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 17:51:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0Vvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 17:51:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A93F873F;
        Mon, 27 May 2019 21:51:36 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-17.brq.redhat.com [10.40.204.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6E58171B4;
        Mon, 27 May 2019 21:51:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/8] perf/x86: Add msr probe interface
Date:   Mon, 27 May 2019 23:51:22 +0200
Message-Id: <20190527215129.10000-2-jolsa@kernel.org>
In-Reply-To: <20190527215129.10000-1-jolsa@kernel.org>
References: <20190527215129.10000-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 27 May 2019 21:51:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

  perf_msr_probe(struct perf_msr *msr, int cnt, void *data)

Together with:
  cnt   - which is the number of struct msr array elements
  data  -which is user pointer passed to the test function

The perf_msr_probe will executed test code, read the MSR and
check the value is != 0. If all these tests pass, related
attribute group is kept visible.

Also adding PMU_EVENT_GROUP macro helper to define attribute
group for single attribute. It will be used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/Makefile |  2 +-
 arch/x86/events/probe.c  | 42 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/probe.h  | 29 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/events/probe.c
 create mode 100644 arch/x86/events/probe.h

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index b8ccdb5c9244..ec29a466444a 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,4 +1,4 @@
-obj-y					+= core.o
+obj-y					+= core.o probe.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
new file mode 100644
index 000000000000..0b190f779ee1
--- /dev/null
+++ b/arch/x86/events/probe.c
@@ -0,0 +1,42 @@
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
+perf_msr_probe(struct perf_msr *msr, int cnt, void *data)
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
+			if (rdmsrl_safe(msr[bit].msr, &val) || !val)
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
index 000000000000..f2c34c25f8a5
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
+perf_msr_probe(struct perf_msr *msr, int cnt, void *data);
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
-- 
2.20.1

