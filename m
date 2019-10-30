Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A30CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE92B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572419376;
	bh=dhv8JdjxHbw9EaTr7zUckwhTfoLvm9Uv9z/iSbeG5Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QALZXREG3t5fgtNq7Xp4gqhEIveJ0MfeRIlcPW5Dsb9PMyi0S03XY/QlGkRbVg+R8
	 QFe+QdnlQHevPjI1citJGOSSuKJ4X+8WiJTru2OM7kw+U2FrFOJ9H1DV35g7U+BWxb
	 s72hWdW1Riw0XPTq8mk+x+8u3ZBzk6U/f+LjFuMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJ3HJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfJ3HJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:09:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D11F20874;
        Wed, 30 Oct 2019 07:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572419374;
        bh=dhv8JdjxHbw9EaTr7zUckwhTfoLvm9Uv9z/iSbeG5Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+Ga2SdEj2jnjupLLVhdvnQ3i9eIVzKypJrs2Wlyo2UKLbhTFLurb+1c8w8f4K/08
         qDJQ+yu9irFZq7780sZ1HuYm65P8oBQ6H7bvLY2Oztf+tpoz8YNf5uANad2frSpXDI
         oG5o8fYN7LGzeDh/2Gnu9VixH+auuVQEFxg6na8U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH 2/4] perf probe: Filter out instances except for inlined subroutine and subprogram
Date:   Wed, 30 Oct 2019 16:09:30 +0900
Message-Id: <157241937063.32002.11024544873990816590.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157241935028.32002.10228194508152968737.stgit@devnote2>
References: <157241935028.32002.10228194508152968737.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter out instances except for inlined_subroutine and subprogram
DIE in die_walk_instances() and die_is_func_instance().
This fixes an issue that perf probe sets some probes on calling
address instead of a target function itself.

When perf probe walks on instances of an abstruct origin
(a kind of function prototype of inlined function),
die_walk_instances() can also pass a GNU_call_site (a GNU
extension for call site) to callback. Since it is not
an inlined instance of target function, we have to filter
out when searching a probe point.

Without this patch, perf probe sets probes on call site
address too.This can happen on some function which is marked
"inlined", but has actual symbol. (I'm not sure why GCC mark
it "inlined")

# perf probe -D vfs_read
p:probe/vfs_read _text+2500017
p:probe/vfs_read_1 _text+2499468
p:probe/vfs_read_2 _text+2499563
p:probe/vfs_read_3 _text+2498876
p:probe/vfs_read_4 _text+2498512
p:probe/vfs_read_5 _text+2498627

With this patch,
# perf probe -D vfs_read
p:probe/vfs_read _text+2498512

Fixes: db0d2c6420ee ("perf probe: Search concrete out-of-line instances")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index f31001d13bfb..ac1289043204 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -334,18 +334,22 @@ int die_entrypc(Dwarf_Die *dw_die, Dwarf_Addr *addr)
  * @dw_die: a DIE
  *
  * Ensure that this DIE is an instance (which has an entry address).
- * This returns true if @dw_die is a function instance. If not, you need to
- * call die_walk_instances() to find actual instances.
+ * This returns true if @dw_die is a function instance. If not, the @dw_die
+ * must be a prototype. You can use die_walk_instances() to find actual
+ * instances.
  **/
 bool die_is_func_instance(Dwarf_Die *dw_die)
 {
 	Dwarf_Addr tmp;
 	Dwarf_Attribute attr_mem;
+	int tag = dwarf_tag(dw_die);
 
-	/* Actually gcc optimizes non-inline as like as inlined */
-	return !dwarf_func_inline(dw_die) &&
-	       (dwarf_entrypc(dw_die, &tmp) == 0 ||
-		dwarf_attr(dw_die, DW_AT_ranges, &attr_mem) != NULL);
+	if (tag != DW_TAG_subprogram &&
+	    tag != DW_TAG_inlined_subroutine)
+		return false;
+
+	return dwarf_entrypc(dw_die, &tmp) == 0 ||
+		dwarf_attr(dw_die, DW_AT_ranges, &attr_mem) != NULL;
 }
 
 /**
@@ -624,6 +628,9 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
 	Dwarf_Die *origin;
 	int tmp;
 
+	if (!die_is_func_instance(inst))
+		return DIE_FIND_CB_CONTINUE;
+
 	attr = dwarf_attr(inst, DW_AT_abstract_origin, &attr_mem);
 	if (attr == NULL)
 		return DIE_FIND_CB_CONTINUE;

