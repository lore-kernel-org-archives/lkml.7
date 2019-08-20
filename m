Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A07EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309F322DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329287;
	bh=HN2lzbKZhyQ0eXvDJy7JZM73w7erzIeFXQXVFGRC8rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQB9DO0QkYYaqDOOn5/o2B37G3RojDAnFToWp89xLsI2dTQ8TYRdqWIXBP6KdslOA
	 SfOEprgZ8UhD0UIgH4/jYd4xpzmeY6GXRV7pR439QglDo+rJqvNJraAmDLX7m9WTIc
	 q+f7/K2TkhYX8l02PFN9dKIcWuKCxYd63UZnA1+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfHTT2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfHTT2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:04 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7B8230F2;
        Tue, 20 Aug 2019 19:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329283;
        bh=HN2lzbKZhyQ0eXvDJy7JZM73w7erzIeFXQXVFGRC8rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UlzW6u9EeRKpPXzOgpsM9anzdZ6r57Cb+gMeQvFe6S7C4LqstxUomo8Ujhzqd22Ot
         zaiFh5bSf+eZXzRLVTxKt14f2GItPzWBZMiUapHVJDqxIJgNOsyrtlHukpkRmLLHMB
         JUZlE3RDHzE4ua/TNfF+QctTtwGqKx4GvCZvfMFk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/17] tools headers: Grab copy of linux/const.h, needed by linux/bits.h
Date:   Tue, 20 Aug 2019 16:27:19 -0300
Message-Id: <20190820192733.19180-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that can update the copy of linux/bits.h that now uses macros defined
in const.h and that are not available in older systems.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c2qfcbl58hxyfb5u5xivp7is@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/const.h      |  9 +++++++++
 tools/include/uapi/linux/const.h | 31 +++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh      |  2 ++
 3 files changed, 42 insertions(+)
 create mode 100644 tools/include/linux/const.h
 create mode 100644 tools/include/uapi/linux/const.h

diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
new file mode 100644
index 000000000000..7b55a55f5911
--- /dev/null
+++ b/tools/include/linux/const.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_CONST_H
+#define _LINUX_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* _LINUX_CONST_H */
diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
new file mode 100644
index 000000000000..5ed721ad5b19
--- /dev/null
+++ b/tools/include/uapi/linux/const.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* const.h: Macros for dealing with constants.  */
+
+#ifndef _UAPI_LINUX_CONST_H
+#define _UAPI_LINUX_CONST_H
+
+/* Some constant macros are used in both assembler and
+ * C code.  Therefore we cannot annotate them always with
+ * 'UL' and other type specifiers unilaterally.  We
+ * use the following macros to deal with this.
+ *
+ * Similarly, _AT() will cast an expression with a type in C, but
+ * leave it unchanged in asm.
+ */
+
+#ifdef __ASSEMBLY__
+#define _AC(X,Y)	X
+#define _AT(T,X)	X
+#else
+#define __AC(X,Y)	(X##Y)
+#define _AC(X,Y)	__AC(X,Y)
+#define _AT(T,X)	((T)(X))
+#endif
+
+#define _UL(x)		(_AC(x, UL))
+#define _ULL(x)		(_AC(x, ULL))
+
+#define _BITUL(x)	(_UL(1) << (x))
+#define _BITULL(x)	(_ULL(1) << (x))
+
+#endif /* _UAPI_LINUX_CONST_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index f211c015cb76..5308b3836278 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 HEADERS='
+include/uapi/linux/const.h
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
 include/uapi/linux/fadvise.h
@@ -19,6 +20,7 @@ include/uapi/linux/usbdevice_fs.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
+include/linux/const.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
-- 
2.21.0

