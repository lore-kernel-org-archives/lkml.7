Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8BC4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9E20882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 14:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfIVOFj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 10:05:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfIVOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 10:05:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iC2UR-0002wh-EZ; Sun, 22 Sep 2019 16:05:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D3441C0084;
        Sun, 22 Sep 2019 16:05:26 +0200 (CEST)
Date:   Sun, 22 Sep 2019 14:05:26 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers uapi: Sync prctl.h with the kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-y8u8kvflooyo9x0if1g3jska@git.kernel.org>
References: <tip-y8u8kvflooyo9x0if1g3jska@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156916112642.4511.15623631686793353349.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7b678ccdf5f608c408e1368e525ed191ca456bcf
Gitweb:        https://git.kernel.org/tip/7b678ccdf5f608c408e1368e525ed191ca456bcf
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 20 Sep 2019 14:40:30 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 14:59:05 -03:00

tools headers uapi: Sync prctl.h with the kernel sources

To get the changes in:

  63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")

that introduces prctl options that then automagically gets catched by
the prctl cmd table generator, and thus supported in the 'perf trace'
prctl beautifier for the 'option' argument:

  $ tools/perf/trace/beauty/prctl_option.sh  > after
  $ diff -u before after
  --- before	2019-09-20 14:38:41.386720870 -0300
  +++ after	2019-09-20 14:40:02.583990802 -0300
  @@ -49,6 +49,8 @@
   	[52] = "GET_SPECULATION_CTRL",
   	[53] = "SET_SPECULATION_CTRL",
   	[54] = "PAC_RESET_KEYS",
  +	[55] = "SET_TAGGED_ADDR_CTRL",
  +	[56] = "GET_TAGGED_ADDR_CTRL",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

For now just the translation of 55 and 56 to the respecting strings are
done, more work needed to allow for filters to be used using strings.

This, for instance, already works:

  # perf record -e syscalls:sys_enter_close --filter="fd==4"
  # perf script | head -5
               gpm  1018 [006] 21327.171436: syscalls:sys_enter_close: fd: 0x00000004
               gpm  1018 [006] 21329.171583: syscalls:sys_enter_close: fd: 0x00000004
              bash  4882 [002] 21330.785496: syscalls:sys_enter_close: fd: 0x00000004
              bash 20672 [001] 21330.785719: syscalls:sys_enter_close: fd: 0x00000004
              find 20672 [001] 21330.789082: syscalls:sys_enter_close: fd: 0x00000004
  # perf record -e syscalls:sys_enter_close --filter="fd>=4"
  ^C[ perf record: Woken up 1 times to write data ]
  # perf script | head -5
               gpm  1018 [005] 21401.178501: syscalls:sys_enter_close: fd: 0x00000004
   gsd-housekeepin  2287 [006] 21402.225365: syscalls:sys_enter_close: fd: 0x0000000b
   gsd-housekeepin  2287 [006] 21402.226234: syscalls:sys_enter_close: fd: 0x0000000b
   gsd-housekeepin  2287 [006] 21402.227255: syscalls:sys_enter_close: fd: 0x0000000b
   gsd-housekeepin  2287 [006] 21402.228088: syscalls:sys_enter_close: fd: 0x0000000b
  #

Being able to pass something like:

  # perf record -e syscalls:sys_enter_prctl --filter="option=*TAGGED_ADDR*"

Should be easy enough, first using tracepoint filters, then via the
augmented_raw_syscalls.c BPF method.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
  diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-y8u8kvflooyo9x0if1g3jska@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 094bb03..7da1b37 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -181,7 +181,7 @@ struct prctl_mm_map {
 #define PR_GET_THP_DISABLE	42
 
 /*
- * Tell the kernel to start/stop helping userspace manage bounds tables.
+ * No longer implemented, but left here to ensure the numbers stay reserved:
  */
 #define PR_MPX_ENABLE_MANAGEMENT  43
 #define PR_MPX_DISABLE_MANAGEMENT 44
@@ -229,4 +229,9 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+/* Tagged user address controls for arm64 */
+#define PR_SET_TAGGED_ADDR_CTRL		55
+#define PR_GET_TAGGED_ADDR_CTRL		56
+# define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
+
 #endif /* _LINUX_PRCTL_H */
