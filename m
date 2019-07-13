Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2061C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B3B20651
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b35H3vg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfGMLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:08:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:08:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB83F93841227
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:08:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB83F93841227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016084;
        bh=ziEIKICZ43jtphkbOjTGumodmwY4UyzdSBwgT+AR+q4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b35H3vg/CaytkA6oaPI2O9iXoVyCW85JDRP3+UG/8h16/DoyJnWJTHMl7tloe3/M1
         J+XpBDB5cNRQAdW21CNAM1XwGj0obowhL04qcf62CpNrH3US18qPe42Gl1/BkLN46T
         byKcnmdmgYIuRcePgOEiBhCM3yKSHq63blJnGsi/5H3URl3B1/juGnm5593pU4I1GI
         hjYJ5SgaGXhPSXfwT026LT1Di4IK0OnFmdUoKnva670HrgjTLlqdbf6jygjReqsROm
         EJpoHoHSwLzESkrBWjMfyAAvdysrn6y5OpT7ACouH4Uq8JN3kOBt/UoO0ZP75QIJr9
         H/nzGvS0I5Oqw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB82pd3841224;
        Sat, 13 Jul 2019 04:08:02 -0700
Date:   Sat, 13 Jul 2019 04:08:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-9d49169c5958e429ffa6874fbef734ae7502ad65@git.kernel.org>
Cc:     hpa@zytor.com, ak@linux.intel.com, mingo@kernel.org,
        acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
        songliubraving@fb.com, jolsa@kernel.org, davidca@fb.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, davidca@fb.com, jolsa@kernel.org,
          tglx@linutronix.de, songliubraving@fb.com, namhyung@kernel.org,
          acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
          ak@linux.intel.com
In-Reply-To: <20190621014438.810342-1-songliubraving@fb.com>
References: <20190621014438.810342-1-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Assume native_arch for pipe mode
Git-Commit-ID: 9d49169c5958e429ffa6874fbef734ae7502ad65
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

Commit-ID:  9d49169c5958e429ffa6874fbef734ae7502ad65
Gitweb:     https://git.kernel.org/tip/9d49169c5958e429ffa6874fbef734ae7502ad65
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 20 Jun 2019 18:44:38 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:28 -0300

perf script: Assume native_arch for pipe mode

In pipe mode, session->header.env.arch is not populated until the events
are processed. Therefore, the following command crashes:

   perf record -o - | perf script

(gdb) bt

It fails when we try to compare env.arch against uts.machine:

        if (!strcmp(uts.machine, session->header.env.arch) ||
            (!strcmp(uts.machine, "x86_64") &&
             !strcmp(session->header.env.arch, "i386")))
                native_arch = true;

In pipe mode, it is tricky to find env.arch at this stage. To keep it
simple, let's just assume native_arch is always true for pipe mode.

Reported-by: David Carrillo Cisneros <davidca@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: kernel-team@fb.com
Cc: stable@vger.kernel.org #v5.1+
Fixes: 3ab481a1cfe1 ("perf script: Support insn output for normal samples")
Link: http://lkml.kernel.org/r/20190621014438.810342-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b3536820f9a8..79367087bd18 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3752,7 +3752,8 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 
 	uname(&uts);
-	if (!strcmp(uts.machine, session->header.env.arch) ||
+	if (data.is_pipe ||  /* assume pipe_mode indicates native_arch */
+	    !strcmp(uts.machine, session->header.env.arch) ||
 	    (!strcmp(uts.machine, "x86_64") &&
 	     !strcmp(session->header.env.arch, "i386")))
 		native_arch = true;
