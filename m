Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1275BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02F32064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908198;
	bh=aWboRlYYJPVtFPFt+/6Q+WMiwLA229f1qLxRY3JNZc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pjBOY2aEDxFUZbFxCGKoYzhodFsC66O8Adiukt0TylDiufetc+GkykRoevQDVzv52
	 F1I6CNvGpNbc30M63fjFJtZdZkRki47NRbYg+TskMb9ZQjrlr7PW51QHOr7pOzNUoL
	 Wb7N3UBJ2sL93Ms82q1w0HpkQPWm8uSzeAcCLVSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfC3AwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbfC3AwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428AD218FC;
        Sat, 30 Mar 2019 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907128;
        bh=aWboRlYYJPVtFPFt+/6Q+WMiwLA229f1qLxRY3JNZc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTr64RsYU6UnDkMfaKAikmD9o5Evf1nTbbOP75FSQjj8UhkWapG83ExcJTA88ql/D
         nTgwGZJ6cfLu3n4pnZTP5lb3xuNvHzaAeS9Pbb9FBlwt+IkHYaMvOHv5z2cbLIdIG9
         U9PPL5B1XXqUPxAezm8z+qytb7XELZcgKbjqFAl8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 40/67] perf top: Fix error handling in cmd_top()
Date:   Fri, 29 Mar 2019 20:50:20 -0400
Message-Id: <20190330005047.25998-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit 70c819e4bf1c5f492768b399d898d458ccdad2b6 ]

We should go to the cleanup path, to avoid leaks, detected using gcc's
ASan.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-9-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9b215007924b..369a3daca1eb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1622,8 +1622,9 @@ int cmd_top(int argc, const char **argv)
 	annotation_config__init();
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
-	if (symbol__init(NULL) < 0)
-		return -1;
+	status = symbol__init(NULL);
+	if (status < 0)
+		goto out_delete_evlist;
 
 	sort__setup_elide(stdout);
 
-- 
2.19.1

