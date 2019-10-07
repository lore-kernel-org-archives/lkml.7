Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A594BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806F021479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfJGOui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:50:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44554 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfJGOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:50:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK7-0005yK-NZ; Mon, 07 Oct 2019 16:49:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 863B11C0DCA;
        Mon,  7 Oct 2019 16:49:15 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:15 -0000
From:   "tip-bot2 for Steve MacLean" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf docs: Correct and clarify jitdump spec
Cc:     Steve MacLean <Steve.MacLean@Microsoft.com>,
        Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric Saint-Etienne" <eric.saint.etienne@oracle.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        John Salem <josalem@microsoft.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Tom McDonald <thomas.mcdonald@microsoft.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CBN8PR21MB1362F63CDE7AC69736FC7F9EF7800=40BN8PR21MB?=
 =?utf-8?q?1362=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CBN8PR21MB1362F63CDE7AC69736FC7F9EF7800=40BN8PR21M?=
 =?utf-8?q?B1362=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <157045975551.9978.14513940078789578945.tip-bot2@tip-bot2>
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

Commit-ID:     2657983b4c0d81632c6a73bae469951b0d341251
Gitweb:        https://git.kernel.org/tip/2657983b4c0d81632c6a73bae469951b0d341251
Author:        Steve MacLean <Steve.MacLean@microsoft.com>
AuthorDate:    Sat, 28 Sep 2019 01:53:08 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:51 -03:00

perf docs: Correct and clarify jitdump spec

Specification claims latest version of jitdump file format is 2. Current
jit dump reading code treats 1 as the latest version.

Correct spec to match code.

The original language made it unclear the value to be written in the
magic field.

Revise language that the writer always writes the same value. Specify
that the reader uses the value to detect endian mismatches.

Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brian Robbins <brianrob@microsoft.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Keeping <john@metanate.com>
Cc: John Salem <josalem@microsoft.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Tom McDonald <thomas.mcdonald@microsoft.com>
Link: http://lore.kernel.org/lkml/BN8PR21MB1362F63CDE7AC69736FC7F9EF7800@BN8PR21MB1362.namprd21.prod.outlook.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/jitdump-specification.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 4c62b07..52152d1 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -36,8 +36,8 @@ III/ Jitdump file header format
 Each jitdump file starts with a fixed size header containing the following fields in order:
 
 
-* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It is 0x4A695444 or 0x4454694a depending on the endianness. The field can be used to detect the endianness of the file
-* uint32_t version   : a 4-byte value representing the format version. It is currently set to 2
+* uint32_t magic     : a magic number tagging the file type. The value is 4-byte long and represents the string "JiTD" in ASCII form. It written is as 0x4A695444. The reader will detect an endian mismatch when it reads 0x4454694a.
+* uint32_t version   : a 4-byte value representing the format version. It is currently set to 1
 * uint32_t total_size: size in bytes of file header
 * uint32_t elf_mach  : ELF architecture encoding (ELF e_machine value as specified in /usr/include/elf.h)
 * uint32_t pad1      : padding. Reserved for future use
