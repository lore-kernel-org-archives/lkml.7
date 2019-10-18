Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61ECA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03955222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436220;
	bh=ZZLlPeXBR+EVEvw0FmNfaS2VKB63dks1AB/dmDQjob4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1V1jF6HZP+sujLsZTLsGbpa0EDcM6m0NZUK1+XC/kqivugl9MrgJ3sfDeQvqrIw7s
	 tbdkAN857y4LypPK6N5qV7j3D+te3kC6U7mA1A7yQ661+85VTYUr4miHT8LtFObhQS
	 w+oft9OpyqzSPncHqEP6/vMEj2BnqJicZsGao8Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfJRWDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfJRWDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:03:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D20820679;
        Fri, 18 Oct 2019 22:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436214;
        bh=ZZLlPeXBR+EVEvw0FmNfaS2VKB63dks1AB/dmDQjob4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFlIqN1csDiw2nIX23IlWSBIxLnxG0TTpRu1aRMM0uFqJQocEHInBVBqlew0xhJ1v
         UMqKK4Mtggu1wf3lzPS7C7ejj41FZgh0QgcCbH+v/IdKSoBve9wy50W6Egt04flZpS
         ZyAleIrx+J05VUSj5cw8mvbF5k0RX4OFeCJnx9xE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 06/89] perf script brstackinsn: Fix recovery from LBR/binary mismatch
Date:   Fri, 18 Oct 2019 18:02:01 -0400
Message-Id: <20191018220324.8165-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

[ Upstream commit e98df280bc2a499fd41d7f9e2d6733884de69902 ]

When the LBR data and the instructions in a binary do not match the loop
printing instructions could get confused and print a long stream of
bogus <bad> instructions.

The problem was that if the instruction decoder cannot decode an
instruction it ilen wasn't initialized, so the loop going through the
basic block would continue with the previous value.

Harden the code to avoid such problems:

- Make sure ilen is always freshly initialized and is 0 for bad
  instructions.

- Do not overrun the code buffer while printing instructions

- Print a warning message if the final jump is not on an instruction
  boundary.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20190927233546.11533-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0140ddb8dd0bd..c14a1cdad80c0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1054,7 +1054,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			continue;
 
 		insn = 0;
-		for (off = 0;; off += ilen) {
+		for (off = 0; off < (unsigned)len; off += ilen) {
 			uint64_t ip = start + off;
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
@@ -1065,6 +1065,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
+				ilen = 0;
 				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
 						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
 				if (ilen == 0)
@@ -1074,6 +1075,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 				insn++;
 			}
 		}
+		if (off != (unsigned)len)
+			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
 	}
 
 	/*
@@ -1114,6 +1117,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
+		ilen = 0;
 		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
 		if (ilen == 0)
-- 
2.20.1

