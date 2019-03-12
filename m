Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF515C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901C12171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356161;
	bh=qd1SRnb5eHzOYvL6+BQRCEs1INkWBNeuPOjficgLPKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hEkXcJB4TB3/Xnc6SnqlJ2zg5WQ1opPBh6EPCnzfjWhUaL2P2gj0Ookl3F/MUIhwT
	 OYriNeu60sSd7fkTC8xbZJ7mphaDv/2V/twjDYnLawNSbefkXdJ5XU/kYgjW0hyi7C
	 jZhfyGIy0nK3TqzkpgIbZ7gTndi42TnhEyz/A0SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCLCCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfCLCCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:36 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E54B214AE;
        Tue, 12 Mar 2019 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356155;
        bh=qd1SRnb5eHzOYvL6+BQRCEs1INkWBNeuPOjficgLPKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0QJuVg6fWLFIxsTP5ESz3DD5GUBIQMv9CSaV/AZXhIpqbtKEQ1/WeMcfqDTO+XGlx
         kE94tYsyCuvkKSiGUI7vsQ9oN4d5UFeU9jbJd4xbnUfPFhFXyHVzrGq2hHb9+jnUTt
         VarWiiKG8p4AGUD/dkgE/mfdBJeku7OM0cCjpku8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Xu Yu <xuyu@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/30] perf probe: Fix getting the kernel map
Date:   Mon, 11 Mar 2019 23:01:40 -0300
Message-Id: <20190312020204.22092-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Since commit 4d99e4136580 ("perf machine: Workaround missing maps for
x86 PTI entry trampolines"), perf tools has been creating more than one
kernel map, however 'perf probe' assumed there could be only one.

Fix by using machine__kernel_map() to get the main kernel map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Cc: Xu Yu <xuyu@linux.alibaba.com>
Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Link: http://lkml.kernel.org/r/2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a1b8d9649ca7..198e09ff611e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -160,8 +160,10 @@ static struct map *kernel_get_module_map(const char *module)
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
-	if (!module)
-		module = "kernel";
+	if (!module) {
+		pos = machine__kernel_map(host_machine);
+		return map__get(pos);
+	}
 
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		/* short_name is "[module]" */
-- 
2.20.1

