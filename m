Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55373C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC922087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582415;
	bh=A9wT6JlLYV8gsz20AMaNO++cGHOBZZqejLSuzV1VTBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOyrHqqj1BEL005mRKNw+FCXNgdB+zxHViEmCR8BDU74Ij/usXlirAyLI/LElNbe3
	 yyCxG3mKg1vmEqdaztbAAYMYOpMJA/u4YRGGXK9wk5uCvl+MV0wqq27nAbCe1fxUT8
	 znJYXLAhTVEWYJb2WIgpDSWwj/MU0rVqqBxN6+4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfCZGkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732782AbfCZGkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:03 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F92E20863;
        Tue, 26 Mar 2019 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582402;
        bh=A9wT6JlLYV8gsz20AMaNO++cGHOBZZqejLSuzV1VTBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5IVjlej9yRZUDvg6UwqGE4splF2L1X4SCa0l9X3oa1c4H/IE39kksD90ftuCLW58
         Zf3KPnuRp1yFwOj0aBKVwQxXbWlVwJtv3K+oUZmOxb/cZyrkIDHxelMGS6E+BNI1Mi
         luipfcDXZ1sBRKV6rrX3csqrTf5UrW2ndXtTBqBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xu Yu <xuyu@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.0 26/52] perf probe: Fix getting the kernel map
Date:   Tue, 26 Mar 2019 15:30:13 +0900
Message-Id: <20190326042702.242199777@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit eaeffeb9838a7c0dec981d258666bfcc0fa6a947 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/probe-event.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -157,8 +157,10 @@ static struct map *kernel_get_module_map
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


