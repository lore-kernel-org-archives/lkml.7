Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A422133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552933286;
	bh=BDv7wKHyp5/IPl3EAu1b7bypSBdztelGqucG14ekfHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GuSyYQR4C22ofoXEGdwNkQowbMV/O0mYod0XGOCZYfZU9gAyyC9xbIPV1RV/8jGPy
	 fKv2BQk/DFm4yeBtGaephA+wKlDp2C9XHul+Zj8dHseViiG894qEuQhKK+L8j6bj4l
	 3tmCmLkI2VQsLC1netTRPaSgOqewVNSdtdhYl0Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCRSVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:21:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCRSVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:21:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29241C057F59;
        Mon, 18 Mar 2019 18:21:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A755D60123;
        Mon, 18 Mar 2019 18:21:19 +0000 (UTC)
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/8] perf/x86: Add msr probe interface
Date:   Mon, 18 Mar 2019 19:21:09 +0100
Message-Id: <20190318182116.17388-2-jolsa@kernel.org>
In-Reply-To: <20190318182116.17388-1-jolsa@kernel.org>
References: <20190318182116.17388-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 18 Mar 2019 18:21:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_msr_probe function to provide interface for
checking up on MSR register and add its related event
attributes if it passes the check.

User defines following struct for each MSR register:

  struct perf_msr {
       u64                       msr;
       struct attribute        **attrs;
       bool                    (*test)(int idx, void *data);
       bool                      no_check;
  };

Where:
  msr      - is the MSR address
  attrs    - is attributes array to add if the check passed
  test     - is test function pointer
  no_check - is bool that bypass the check and adds the
              attribute without any test

The array of struct perf_msr is passed into:

  perf_msr_probe(struct perf_msr *msr, int cnt,
                struct attribute **attrs, void *data)

Together with:
  cnt   - which is the number of struct msr array elements
  attrs - which is an array placeholder for added attributes
          and needs to be big enough
  data  -which is user pointer passed to the test function

The perf_msr_probe will executed test code, read the MSR and
check the value is != 0. If all these tests pass, related
attributes are added into attrs array.

Also adding MSR_ATTR macro helper to define attribute array
from single attribute. It will be used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/Makefile |  2 +-
 arch/x86/events/probe.c  | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/events/probe.h  | 22 ++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
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
index 000000000000..0052b730c55e
--- /dev/null
+++ b/arch/x86/events/probe.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/bits.h>
+#include "probe.h"
+
+unsigned long
+perf_msr_probe(struct perf_msr *msr, int cnt,
+	       struct attribute **attrs, void *data)
+{
+	unsigned long avail = 0;
+	unsigned int bit;
+	u64 val;
+
+	if (cnt >= BITS_PER_LONG)
+		return 0;
+
+	for (bit = 0; bit < cnt; bit++) {
+		struct attribute **a = msr[bit].attrs;
+
+		if (!msr[bit].no_check) {
+			if (msr[bit].test && !msr[bit].test(bit, data))
+				continue;
+			if (rdmsrl_safe(msr[bit].msr, &val) || !val)
+				continue;
+		}
+
+		while (*a)
+			*attrs++ = *a++;
+
+		avail |= bit;
+	}
+
+	*attrs = NULL;
+	return avail;
+}
+EXPORT_SYMBOL_GPL(perf_msr_probe);
diff --git a/arch/x86/events/probe.h b/arch/x86/events/probe.h
new file mode 100644
index 000000000000..42dd666533c3
--- /dev/null
+++ b/arch/x86/events/probe.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARCH_X86_EVENTS_PROBE_H__
+#define __ARCH_X86_EVENTS_PROBE_H__
+#include <linux/sysfs.h>
+
+#define MSR_ATTR(__n)				\
+static struct attribute *msr_##__n[] = {	\
+	&__n.attr.attr,				\
+	NULL,					\
+}
+
+struct perf_msr {
+	u64			  msr;
+	struct attribute	**attrs;
+	bool			(*test)(int idx, void *data);
+	bool			  no_check;
+};
+
+unsigned long
+perf_msr_probe(struct perf_msr *msr, int cnt,
+	       struct attribute **attrs, void *data);
+#endif /* __ARCH_X86_EVENTS_PROBE_H__ */
-- 
2.17.2

