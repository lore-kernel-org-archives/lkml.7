Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAEECA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB0206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572080479;
	bh=dT3VBbGodAYDaXlAzhc9xkeBX8hX0UBHad7K6i+wRmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D+IbAcXtTQBTXubWZ3PotA5uq59tC+g0Y/sBkfwqpj5TbMvDBseh2dBzM5Vwp4ZVA
	 XRHt8K9GxxwRFZGBuOKDWwqFkfldv9XLsPtQ9hjNG6rV3tZBqHTX515ROmPS+E3Pa3
	 nKyH17PslyXWFLGHaHOWJetOn+qG4vpbFzWe2MZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfJZJBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJZJBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:01:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE5C206DD;
        Sat, 26 Oct 2019 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572080477;
        bh=dT3VBbGodAYDaXlAzhc9xkeBX8hX0UBHad7K6i+wRmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osWcp25J+M2OpcatyBmtCSfOrMVPQ2Do23ErYWlFs/YSqXAQU/2Z6IpOSVK9ctkby
         zN92uyIv4N5xjAqSRHAScsykZ7F1ZLZo5JY3vqpBRN5kh/y9lPZoCL/zYHIN6mHdmf
         o89O6VnpQSPLg01b90999+LTCDtLTUaniU+WH2jE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH V2 6/6] perf/probe: Fix to show ranges of variables in functions without entry_pc
Date:   Sat, 26 Oct 2019 18:01:13 +0900
Message-Id: <157208047363.16551.12586684059797077302.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157208041894.16551.2733647209130045685.stgit@devnote2>
References: <157208041894.16551.2733647209130045685.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to show ranges of variables (--range and --vars option) in
functions which DIE has only ranges but no entry_pc attribute.

Without this fix,
  # perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
  	@<clear_tasks_mm_cpumask+0>
  		(No matched variables)

With this fix,
  # perf probe --range -V clear_tasks_mm_cpumask
  Available variables at clear_tasks_mm_cpumask
        @<clear_tasks_mm_cpumask+0>
                [VAL]   int     cpu     @<clear_tasks_mm_cpumask+[0-62,104-109,1881-1888]>


Fixes: 349e8d261131 ("perf probe: Add --range option to show a variable's location range")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index e0c507d6b3b4..ac82fd937e4b 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1019,7 +1019,7 @@ static int die_get_var_innermost_scope(Dwarf_Die *sp_die, Dwarf_Die *vr_die,
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 
@@ -1082,7 +1082,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 	bool first = true;
 	const char *name;
 
-	ret = dwarf_entrypc(sp_die, &entry);
+	ret = die_entrypc(sp_die, &entry);
 	if (ret)
 		return ret;
 

