Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05BD205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155065;
	bh=MCUL7sTU/DfR1NNw9dpHQY2ENyUBKOeryycYkC5qzuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u/jQOZTHgMCCDs89twqo3RespRhJEgEZeAzzCggd//m5wbMIYdP+4hr5b8Gd9yHlJ
	 gny54GCRmdljpdnsR+m3C9eTyP2W/3Y/Rqafdr19hdNl4OB7cghrr43L/OOhSw6P2a
	 9Kb56kMT/t9UsQncULqtMSO+mkJRl5UuHJVMEzeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfGZPbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389155AbfGZPaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D7F22BF5;
        Fri, 26 Jul 2019 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155053;
        bh=MCUL7sTU/DfR1NNw9dpHQY2ENyUBKOeryycYkC5qzuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkJfCpMfFf+N/rM25SPdQrLpz3B9Up4AhaZCxgrXuNA1EPA6kzSuL42KogwixMGsb
         7wuRIRoB/B5t/dgFO95ioOw/aTcdrilfG97cQfOagUbVNYMD9vUS5r82s9BNtBP9G2
         CfF1er+3/pXuZ4UQuszL98zoRpKDCmB8SOSDlEBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Carrillo Cisneros <davidca@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, kernel-team@fb.com
Subject: [PATCH 5.1 48/62] perf script: Assume native_arch for pipe mode
Date:   Fri, 26 Jul 2019 17:25:00 +0200
Message-Id: <20190726152307.086370026@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

commit 9d49169c5958e429ffa6874fbef734ae7502ad65 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/builtin-script.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3669,7 +3669,8 @@ int cmd_script(int argc, const char **ar
 		goto out_delete;
 
 	uname(&uts);
-	if (!strcmp(uts.machine, session->header.env.arch) ||
+	if (data.is_pipe ||  /* assume pipe_mode indicates native_arch */
+	    !strcmp(uts.machine, session->header.env.arch) ||
 	    (!strcmp(uts.machine, "x86_64") &&
 	     !strcmp(session->header.env.arch, "i386")))
 		native_arch = true;


