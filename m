Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEAF2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366901;
	bh=GrpIzYDqKCUF86PlPs6S1AUk/5j64nuWlzocAijdptk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qcfLVWX41ndtO5McFLc7vKwvN5NfH2AHnOaac5Syp9liKE3gfvCiniUx2q9YXz2Z
	 m/SxnlYI9cQiSvIETTurpJL0OsRM98iRAtaIzpGJRXiqF/q5GYrMoSqu4GVxBZ2j5e
	 zUoVREqv6Q49U0rDzyXhO/AaG/yhBNznqwwlLO10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfB1PPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388741AbfB1PO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:14:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9CD620C01;
        Thu, 28 Feb 2019 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366894;
        bh=GrpIzYDqKCUF86PlPs6S1AUk/5j64nuWlzocAijdptk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnyJDTRV3XYhv1e3bLLRPum1onhdn8LMEXln+eiLKbjH/u3B25VgT5tbj4Ia4RVhi
         r7coji/+3OcRHbb8Sg7koPaJY0VBJbR1uzcgVNPNA9sXXeTTs0OJGoqB2kUwwfAD0b
         GPE7Xid1tJWHxPTwke3JNQexQ3vAjAeSObbmcIXw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 29/36] perf symbols: Filter out hidden symbols from labels
Date:   Thu, 28 Feb 2019 10:13:30 -0500
Message-Id: <20190228151337.12176-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit 59a17706915fe5ea6f711e1f92d4fb706bce07fe ]

When perf is built with the annobin plugin (RHEL8 build) extra symbols
are added to its binary:

  # nm perf | grep annobin | head -10
  0000000000241100 t .annobin_annotate.c
  0000000000326490 t .annobin_annotate.c
  0000000000249255 t .annobin_annotate.c_end
  00000000003283a8 t .annobin_annotate.c_end
  00000000001bce18 t .annobin_annotate.c_end.hot
  00000000001bce18 t .annobin_annotate.c_end.hot
  00000000001bc3e2 t .annobin_annotate.c_end.unlikely
  00000000001bc400 t .annobin_annotate.c_end.unlikely
  00000000001bce18 t .annobin_annotate.c.hot
  00000000001bce18 t .annobin_annotate.c.hot
  ...

Those symbols have no use for report or annotation and should be
skipped.  Moreover they interfere with the DWARF unwind test on the PPC
arch, where they are mixed with checked symbols and then the test fails:

  # perf test dwarf -v
  59: Test dwarf unwind                                     :
  --- start ---
  test child forked, pid 8515
  unwind: .annobin_dwarf_unwind.c:ip = 0x10dba40dc (0x2740dc)
  ...
  got: .annobin_dwarf_unwind.c 0x10dba40dc, expecting test__arch_unwind_sample
  unwind: failed with 'no error'

The annobin symbols are defined as NOTYPE/LOCAL/HIDDEN:

  # readelf -s ./perf | grep annobin | head -1
    40: 00000000001bce4f     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_init.c

They can still pass the check for the label symbol. Adding check for
HIDDEN and INTERNAL (as suggested by Nick below) visibility and filter
out such symbols.

>   Just to be awkward, if you are going to ignore STV_HIDDEN
>   symbols then you should probably also ignore STV_INTERNAL ones
>   as well...  Annobin does not generate them, but you never know,
>   one day some other tool might create some.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Clifton <nickc@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190128133526.GD15461@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/symbol-elf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8ad4296de98b0..3d39332b3a06a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -87,6 +87,11 @@ static inline uint8_t elf_sym__type(const GElf_Sym *sym)
 	return GELF_ST_TYPE(sym->st_info);
 }
 
+static inline uint8_t elf_sym__visibility(const GElf_Sym *sym)
+{
+	return GELF_ST_VISIBILITY(sym->st_other);
+}
+
 #ifndef STT_GNU_IFUNC
 #define STT_GNU_IFUNC 10
 #endif
@@ -111,7 +116,9 @@ static inline int elf_sym__is_label(const GElf_Sym *sym)
 	return elf_sym__type(sym) == STT_NOTYPE &&
 		sym->st_name != 0 &&
 		sym->st_shndx != SHN_UNDEF &&
-		sym->st_shndx != SHN_ABS;
+		sym->st_shndx != SHN_ABS &&
+		elf_sym__visibility(sym) != STV_HIDDEN &&
+		elf_sym__visibility(sym) != STV_INTERNAL;
 }
 
 static bool elf_sym__is_a(GElf_Sym *sym, enum map_type type)
-- 
2.19.1

