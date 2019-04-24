Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71885C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4076921907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126437;
	bh=LN2voPDActjR24xk3cI/yEzC16cZ+zLR9KKx6Rn8lWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snAMfmnn+RU5P8OcbozxA/2Yhje3wOhpD7lGYOc5Rz8KJlBGt0XebIHBb1SWvRB40
	 GKHV9woAqKmFE9cw7ybzeVUMZTxPURs1BEDXLAIsBCeDp3510sfG7RlrHw9P00EqwG
	 FIT7KwCebcTTKZbNgRxbmDzGkGj05+gq3sNAm1Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbfDXRUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389168AbfDXRUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:33 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF67420675;
        Wed, 24 Apr 2019 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126433;
        bh=LN2voPDActjR24xk3cI/yEzC16cZ+zLR9KKx6Rn8lWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bf/nY+gmV4WG2wqrIihWY3H7LkUHyq3dLePCLGYfkYZRl5U4j5Gta6z4HGFy1HGNx
         rF6N5j5Px5uVoakI0U7bKq+q+/BwpdYQRjMmePNCL0uQcFWMm41M4v/Zq0LcVE01FK
         kLmc/246YQTYRMU7KxUVICmNo5jN4ONDLntzwbIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 109/168] perf top: Fix error handling in cmd_top()
Date:   Wed, 24 Apr 2019 19:09:13 +0200
Message-Id: <20190424170929.995955017@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 47719bde34c6..4e64ba8163bb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1320,8 +1320,9 @@ int cmd_top(int argc, const char **argv, const char *prefix __maybe_unused)
 	symbol_conf.priv_size = sizeof(struct annotation);
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
-	if (symbol__init(NULL) < 0)
-		return -1;
+	status = symbol__init(NULL);
+	if (status < 0)
+		goto out_delete_evlist;
 
 	sort__setup_elide(stdout);
 
-- 
2.19.1



