Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBBBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3C2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="E+5wdSia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404649AbfHHURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:17:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404505AbfHHURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:17:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KH2Qr3320867
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:17:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KH2Qr3320867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295422;
        bh=YHzO+rxceAKaS+8pRZnoYFfwJtlfkCsZwZ8KWSe3oFg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=E+5wdSiauD9p2py2xXm4XitdMjO25lCVAuV70uHbQHYVknkuW/0rMsQOQPvKnoQ9D
         2kynjUEwo3KNLRpcmSC/qGyLgOUI5QgH8gy/tnvKPMFZ87Plm0dxLA0lXK8jGRdYs0
         l7jf8Ydyv4Cth+fK8bk2Otsz4Xus7G5+eFG8F+MqbILID1Gmrg84vb2oS0P8r96Ggy
         3pHjhON/xDfAjepo9dfm30vX09+qDLEnuTSoDG8S/Uyq6d83A3wp3bP32DuIAzf3kq
         NVQK8U8XpD8CglpwdJx1aVRLSPyQAoT6SxUhrIJPIcqrEvvcRWV/WHidMAhnBNgm+Y
         4jwvr2ZOGJx0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KH1D83320862;
        Thu, 8 Aug 2019 13:17:01 -0700
Date:   Thu, 8 Aug 2019 13:17:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-unbr5a5efakobfr6rhxq99ta@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        songliubraving@fb.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, songliubraving@fb.com, acme@redhat.com,
          mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Fix printing of unaugmented
 disassembled instructions from BPF
Git-Commit-ID: 85127775a65fc58e69af0c44513937d471ccbe7b
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

Commit-ID:  85127775a65fc58e69af0c44513937d471ccbe7b
Gitweb:     https://git.kernel.org/tip/85127775a65fc58e69af0c44513937d471ccbe7b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Aug 2019 11:24:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:40:56 -0300

perf annotate: Fix printing of unaugmented disassembled instructions from BPF

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
 
