Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CC321897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568796960;
	bh=JgQpefjkkAsTjVJ1iplWrehIsbTZX1YcAfQLpNTlTU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcTpkmX09P4I0VaBPmSm18D4ptOoWwKbksRK+eXMz9GzSq/P/XSV4UuKhf6XiuPkM
	 vqGxDlTC2kE6pvDo7OF/6IqqLDGuabySNSt5ZI5BsEGvN9PjFdWKP55H/lhMmU9Hxn
	 b2Es8+8Uql9kYztvB4K4WdwY1T5v6FoYI0yp7l1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfIRIz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIRIz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:55:59 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895902053B;
        Wed, 18 Sep 2019 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568796958;
        bh=JgQpefjkkAsTjVJ1iplWrehIsbTZX1YcAfQLpNTlTU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JNufiQtAM/8T3LDbiijeKyd79SI02OF3tocRQ5/Ny7EPDN21NyrBSXuZBolN+ch9
         8MNbAVcaUL8xeqIxqL8NwiN1fZ+WDLr5Pldu+83KrYzz6nYIX7hHNXjCPJSOlBfOuK
         Kx4STkgLhHC8Tqc2s5oBVC0HhntIX+D1P1tr1llM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com
Subject: [PATCH 3/3] selftests/ftrace: Update kprobe event error testcase
Date:   Wed, 18 Sep 2019 17:55:55 +0900
Message-Id: <156879695513.31056.1580235733738840126.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156879692790.31056.9404391078827158266.stgit@devnote2>
References: <156879692790.31056.9404391078827158266.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kprobe event error testcase to test if it correctly
finds the exact same probe event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 39ef7ac1f51c..8a4025e912cb 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -95,6 +95,7 @@ echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
 check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
 check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
+check_error '^p:kprobes/testevent _do_fork'	# SAME_PROBE
 fi
 
 exit 0

