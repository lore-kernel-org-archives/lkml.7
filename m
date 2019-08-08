Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0910E2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565290481;
	bh=BWkyOt3w2GSqFELRkanVFXYtpI7TId3wAEtO2IxtfwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cmKIsjxonwvv/Y+3MkkagA/BnDyhPdDlLPMw9LmenFs6HH9ET2yexmYqCifZFXqIl
	 NnyThTTlTHh0csoeTSblXDfEg7MgcNGc5b+yM0z4O227E5r6r4GNURf0kmVxdNoLD0
	 NZyNO2xRH9YKMwAULBk6QSEdUAgxtlASxvoYeYHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbfHHSyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbfHHSyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:54:39 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.210.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E242089E;
        Thu,  8 Aug 2019 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565290478;
        bh=BWkyOt3w2GSqFELRkanVFXYtpI7TId3wAEtO2IxtfwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDrK8Ypg6ItVtSLguL+8MxewId+zuKKFrrHWf+MNmFfhu3Y8MYaCNdhUd4Xb4yWnO
         0srxDW13HjyL726PZ6zBh2TbylYZ6sIRrDsPF7o7LdhFCT+vKk4DWNSXBY4Okg0xNM
         MUwnQwg03dZQ6enJntAu7sx1MsVNL0E9MFLlFCVs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 02/10] perf annotate: Fix printing of unaugmented disassembled instructions from BPF
Date:   Thu,  8 Aug 2019 15:53:50 -0300
Message-Id: <20190808185358.20125-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The code to disassemble BPF programs uses binutil's disassembling
routines, and those use in turn fprintf to print to a memstream FILE,
adding a newline at the end of each line, which ends up confusing the
TUI routines called from:

  annotate_browser__write()
    annotate_line__write()
      annotate_browser__printf()
        ui_browser__vprintf()
          SLsmg_vprintf()

The SLsmg_vprintf() function in the slang library gets confused with the
terminating newline, so make the disasm_line__parse() function that
parses the lines produced by the BPF specific disassembler (that uses
binutil's libopcodes) and the lines produced by the objdump based
disassembler used for everything else (and that doesn't adds this
terminating newline) trim the end of the line in addition of the
beginning.

This way when disasm_line->ops.raw, i.e. for instructions without a
special scnprintf() method, we'll not have that \n getting in the way of
filling the screen right after the instruction with spaces to avoid
leaving what was on the screen before and thus garbling the annotation
screen, breaking scrolling, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
Link: https://lkml.kernel.org/n/tip-unbr5a5efakobfr6rhxq99ta@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9ad2330f93..163536720149 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1122,7 +1122,7 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 		goto out;
 
 	(*rawp)[0] = tmp;
-	*rawp = skip_spaces(*rawp);
+	*rawp = strim(*rawp);
 
 	return 0;
 
-- 
2.21.0

