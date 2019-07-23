Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25637C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99B229EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hdTfU/+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbfGWVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:47:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbfGWVr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:47:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLllPA253046
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:47:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLllPA253046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918468;
        bh=u4RDWDypJDchH1SwnWJOJfGC57FMLGZ4vRb8EMK3emU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=hdTfU/+QpN4iAgGyinfMOj82vBablSDoR4VmvwK6fh+GWt0qznF3pkUJw0gZB10r3
         X7IkSixLtGyZ2PdrUBru0OTMYVNuLmdvB9EAqiIAwOaQZR5O7JORooxRiMAh3UqQCg
         x0TCOBk2QNAayIb679S1yMt0MG8SIikJkh9hSzFBnDCK/j6cVLqIRBQY3l9JpLDg+z
         hGdcdTY46wBAicZncLlKrdDeDlkjfn/vgA4UoaiZ3sbEe00Koa4KWMMBQvLwfsLXXY
         LexNWaicKB5QBa+lFLO2MqjtroTln3A3INJzuw3jq7S4u0uVuSTeGq6YGnKNkImBnX
         9PmfzFD0XOLDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLllEp253043;
        Tue, 23 Jul 2019 14:47:47 -0700
Date:   Tue, 23 Jul 2019 14:47:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-dde4e732a5b02fa5599c2c0e6c48a0c11789afc4@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
        denis.bakhvalov@intel.com, ak@linux.intel.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          jolsa@kernel.org, denis.bakhvalov@intel.com, ak@linux.intel.com
In-Reply-To: <20190711181922.18765-2-andi@firstfloor.org>
References: <20190711181922.18765-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Fix off by one in brstackinsn IPC
 computation
Git-Commit-ID: dde4e732a5b02fa5599c2c0e6c48a0c11789afc4
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

Commit-ID:  dde4e732a5b02fa5599c2c0e6c48a0c11789afc4
Gitweb:     https://git.kernel.org/tip/dde4e732a5b02fa5599c2c0e6c48a0c11789afc4
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 11 Jul 2019 11:19:21 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 08:59:37 -0300

perf script: Fix off by one in brstackinsn IPC computation

When we hit the end of a program block, need to count the last
instruction too for the IPC computation. This caused large errors for
small blocks.

  % perf script -b ls / > /dev/null

Before:

  % perf script -F +brstackinsn --xed
  ...
        00007f94c9ac70d8                        jz 0x7f94c9ac70e3                       # PRED 3 cycles [36] 4.33 IPC
        00007f94c9ac70e3                        testb  $0x20, 0x31d(%rbx)
        00007f94c9ac70ea                        jnz 0x7f94c9ac70b0
        00007f94c9ac70ec                        testb  $0x8, 0x205ad(%rip)
        00007f94c9ac70f3                        jz 0x7f94c9ac6ff0               # PRED 1 cycles [37] 3.00 IPC

After:

  % perf script -F +brstackinsn --xed
  ...
        00007f94c9ac70d8                        jz 0x7f94c9ac70e3                       # PRED 3 cycles [15] 4.67 IPC
        00007f94c9ac70e3                        testb  $0x20, 0x31d(%rbx)
        00007f94c9ac70ea                        jnz 0x7f94c9ac70b0
        00007f94c9ac70ec                        testb  $0x8, 0x205ad(%rip)
        00007f94c9ac70f3                        jz 0x7f94c9ac6ff0               # PRED 1 cycles [16] 4.00 IPC

Suggested-by: Denis Bakhvalov <denis.bakhvalov@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190711181922.18765-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8f24865596af..0140ddb8dd0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1059,7 +1059,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp,
+				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, ++insn, fp,
 							    &total_cycles);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
