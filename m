Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75568C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403A520863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004515;
	bh=+YjcYkDj2yiD9m6qHDqjHMTxC16tBLn4mcmA1+IBmBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPzTi+HsB3YlP8syJrRmoel0cr+bfOs628nY6deBsVSFuUge+k6U6DmF0nfl0bGJe
	 L+jn2TFuyeGk2vI4NFebwxGZRzxnPGm4IEsZzbuzgxGA84MA1wEw6L1lYby+ft8bzx
	 eBQvvaIrxjnXjd1AKe0W7v2YTNTPdt+nEwRJTG40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgABWfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730778AbgABWfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:35:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215A720866;
        Thu,  2 Jan 2020 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004511;
        bh=+YjcYkDj2yiD9m6qHDqjHMTxC16tBLn4mcmA1+IBmBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3FVrzD5ZTYBPOJi2f8gfBjgJtHvhAS//b2lJ3OybthFbXcGTmsU3Db//NaPSwUBQ
         V/mWajMynbKau6jdWod/4A8/WHv/NEl6qh+A2Mo8lAhZpHhl1rD61geKnZHkghZp01
         kw6JS6a+Apdg6B8zE6BIdOljDc1AT7npIroncezQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 038/137] perf probe: Fix to find range-only function instance
Date:   Thu,  2 Jan 2020 23:06:51 +0100
Message-Id: <20200102220551.761090623@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit b77afa1f810f37bd8a36cb1318178dfe2d7af6b6 ]

Fix die_is_func_instance() to find range-only function instance.

In some case, a function instance can be made without any low PC or
entry PC, but only with address ranges by optimization.  (e.g. cold text
partially in "text.unlikely" section) To find such function instance, we
have to check the range attribute too.

Fixes: e1ecbbc3fa83 ("perf probe: Fix to handle optimized not-inlined functions")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157190835669.1859.8368628035930950596.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index a509aa8433a1..af78d6fc8d12 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -304,10 +304,14 @@ bool die_is_func_def(Dwarf_Die *dw_die)
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
-- 
2.20.1



