Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7B0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEAC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571908380;
	bh=FOUerdrheijCvjew7DBXUYpeJEGdlbuS2KUUUJvtZBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdY5Cl8s4w2/NowPiWcIqHQk+88LT+Lp++O4JEZhu0Olpmyf2/p4DAyoFEEd4ESKq
	 jDJkjTNtq7z25Emb/i7SLTyj+KiTMc2ZvoHnZu+DgMp9/8XPerUl1fsrvIKOCJlwiT
	 Xax4VIvfL4v0V35M3j6Ehm/ephaxff7EHnGXcjeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392979AbfJXJMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389524AbfJXJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:12:40 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AAB20856;
        Thu, 24 Oct 2019 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571908359;
        bh=FOUerdrheijCvjew7DBXUYpeJEGdlbuS2KUUUJvtZBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUApmMcXf+y8xbI2rSWa6Ahs12qf6eCEggXg/ksMKbCUCiEOHLRneezZx1fn9JA7+
         cCqBWiZsppmU0jGJun+3yC0KXmyn2n0Lt3qwWW25P9HLZ9b9y2xc2+TAElZMGyzSto
         /EmnyJn+A1D6DMsTxmACzdmgmSOF3t7tlAv7W+TU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 1/3] perf/probe: Fix to find range-only function instance
Date:   Thu, 24 Oct 2019 18:12:36 +0900
Message-Id: <157190835669.1859.8368628035930950596.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157190834681.1859.7399361844806238387.stgit@devnote2>
References: <157190834681.1859.7399361844806238387.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix die_is_func_instance() to find range-only function instance.

In some case, a function instance can be made without any low PC
or entry PC, but only with address ranges by optimization.
(e.g. cold text partially in "text.unlikely" section)
To find such function instance, we have to check the range
attribute too.

Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index df6cee5c071f..2ec24c3bed44 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -318,10 +318,14 @@ bool die_is_func_def(Dwarf_Die *dw_die)
 bool die_is_func_instance(Dwarf_Die *dw_die)
 {
 	Dwarf_Addr tmp;
+	Dwarf_Attribute attr_mem;
 
 	/* Actually gcc optimizes non-inline as like as inlined */
-	return !dwarf_func_inline(dw_die) && dwarf_entrypc(dw_die, &tmp) == 0;
+	return !dwarf_func_inline(dw_die) &&
+	       (dwarf_entrypc(dw_die, &tmp) == 0 ||
+		dwarf_attr(dw_die, DW_AT_ranges, &attr_mem) != NULL);
 }
+
 /**
  * die_get_data_member_location - Get the data-member offset
  * @mb_die: a DIE of a member of a data structure

