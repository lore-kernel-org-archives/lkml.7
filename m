Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A1DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3398206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611055;
	bh=VqlPx26gYG/Kz7tJvElCH3R3HKtZqAYIL8cnZmXJpbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZ1MTO43eCz6rnNSBuuEbgKOq+Pj2PjFv2A1qkMA6STFRFqA84Nz8y4dz3dxOZVy7
	 kVWKG6DbInCBRVdQ3N+IRfsUUeEq0Mf2YycuOhgxAtrGodnjsfQhsDwUw6g4kgl0Hv
	 ygSqR1TwbJkyN7eM3rriNt4AuJhUMGykIFeEiDHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404195AbfDRSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403870AbfDRSKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4055B218AE;
        Thu, 18 Apr 2019 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611048;
        bh=VqlPx26gYG/Kz7tJvElCH3R3HKtZqAYIL8cnZmXJpbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rl52wMDPP35GqcVX87rs1ct2nH4FDZ3qhYweJb17Vzjshcd/JqvCpW3NkLQoBd58m
         UYuHLT22km83vtnHScJfkQ23DWmN6kdJ7IxDYq9+vqspUpAbr912YwETN+wSKmhwmm
         hEK8OHG9rHHk/J0fNXyVGplRfN7/HF57i6GMAdzk=
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
Subject: [PATCH 5.0 40/93] perf top: Fix error handling in cmd_top()
Date:   Thu, 18 Apr 2019 19:57:18 +0200
Message-Id: <20190418160441.470647906@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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



