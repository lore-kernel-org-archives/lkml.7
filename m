Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FAC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764FE222CE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928414;
	bh=WH6I5t8eoCSjD9gkLayn6DnsGmhlINWQmAEd38zJLoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9O5+eQcUOh50Ir8R1q6WuXg9iICWzHM8afhNVjFrreSriSAO9DCi2ZnfpNHenrRy
	 G7kiEbqiRuT38JtoKnnEWW89cuCvZ8WXjvpL2/cJK2U2brjnyzChopsq3D9bRFzBQy
	 34LaJ1V6PvUolt9Eg1rdDUAejBjF+XLd4yXXLo1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfJALNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbfJALNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:13:33 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716E621D71;
        Tue,  1 Oct 2019 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928412;
        bh=WH6I5t8eoCSjD9gkLayn6DnsGmhlINWQmAEd38zJLoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zNX8OEJcPMshplnO/Adm3KU/RkcYjCqOyzF9m8QvmVa4OYy5omi8fkiBZ50w/opVi
         40yvakrpmFeU3tlz4PIxnpaCeWrLhg9gzhp2iRCp5vbtlga7ju/yKiED12GYS1EXs3
         pFXnao53giUOjJTJQTR0gal2QLwv8v/bWvDXOtpY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steve MacLean <Steve.MacLean@microsoft.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        John Salem <josalem@microsoft.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Tom McDonald <thomas.mcdonald@microsoft.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/24] perf docs: Correct and clarify jitdump spec
Date:   Tue,  1 Oct 2019 08:12:06 -0300
Message-Id: <20191001111216.7208-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve MacLean <Steve.MacLean@microsoft.com>

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
index 4c62b0713651..52152d156ad9 100644
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
-- 
2.21.0

