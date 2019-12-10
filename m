Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23742C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4BB206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012957;
	bh=u3tBobRqyUMAHiZopxd1EyUAizLv/WfR7fzzUyV/pyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qFavGffP5/78ZpMpx5VRQ5uei84zxxS5jhGH6zOBZJztwu655sUQ88OnnhUorLVwk
	 cnsPuDPVwaqC0hMFeYXTa4RQ3tZvWvYxlrtvEm7/U1JZ7JkZiWIwH4ZsFgt7SwXb0k
	 bLXgeoje4/lisO+bmQzcSyVuzFYBlDKBBR5n6yJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLJVL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbfLJVLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01615246AA;
        Tue, 10 Dec 2019 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012273;
        bh=u3tBobRqyUMAHiZopxd1EyUAizLv/WfR7fzzUyV/pyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofPgF8vC9oe5leHb6g7Ct38MUSIaOPvWXQU1F0IEyQ+KSXn/ClivErT+W5ewVgtyA
         fQt04sPOiEW6bltEAHE287rdvGe30sReJGO3NO471uIxqN2QFAMqRJuu9GlTgKGAMg
         G14J3L5C5jYYprXGUFC2iGn/TzUv5s27tl6Cwrcs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 218/350] perf probe: Fix to find range-only function instance
Date:   Tue, 10 Dec 2019 16:05:23 -0500
Message-Id: <20191210210735.9077-179-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index df6cee5c071f3..2ec24c3bed44c 100644
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
-- 
2.20.1

