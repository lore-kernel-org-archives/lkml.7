Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE05C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0773218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ph5bTJOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCPIHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41733 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPIHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so7898858pfn.8;
        Sat, 16 Mar 2019 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8Qc7H/ruRKYZUprilgo4yb534SAWU+7CioX+kLQF9U=;
        b=ph5bTJOKtyJQdJtSV0k+jqi92ofoKKbWOfGAmeMiUbqN4m1JnAJRrnqEhlZRekrKSV
         awNCrmWhDHt5p4CE0JXav87BcrBtuy0rk9LAXjPFDSQ/JpeQUKbUV/4FNAp/mZ43BFoL
         Q75YvhBERJYpoOpjzyfNRAWPHhaEK6GUjwyuuPveKleDyfKGtbfdwE8sexzqKMd7Ej6M
         d90fG2sGy6kdPHXc4bfEK0sUU/OpaDK7Vu66aFwL41qjfeP+rKlBpSBF/OoJ5XdSsJT/
         tHqua/CKn2FVN0zcR0O9IMLjautFilGB7vO4KZ8/xM18XeIXPaO0ZKP1dar007jib+8H
         WH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8Qc7H/ruRKYZUprilgo4yb534SAWU+7CioX+kLQF9U=;
        b=TcAB7Ap7L6EU7WBQDp4/UzAc3GQd4wArarMwa4LHwu04joPK1yUbuFYDPy7MnmTO2n
         vmvT1D6XrWKazXF9YZyOW96TXtkux44u0Ie8dHWwbeB8ozPHmUqTzodMmoLaJWEoLgcI
         e5qPTFQJG3R1pBFUUtkb+mPCgsSFtZmKFN8EkP1n+kOm2qwKpdld7svftTxkbzJcbjmR
         rX13j4NiXqt/4F6W+KX9hT0GSJ+xqfjpC4albfvo6BzxXOEGdL2wRKGkdDIoaI225yNL
         NhmwJjKXsCQCy2G+t0wLjIAU1tw1i2y8w8gVD17G0aCWWIj9YWdVGM4UOkEYMdB7EnTq
         m76A==
X-Gm-Message-State: APjAAAV2bhRO+eFaX5Wmt/RsVapF/88tSQ+EhfvkRXflan4dYzBuWztN
        ophhZVhtGKMDU0NvEr+XqMg=
X-Google-Smtp-Source: APXvYqx8xMC+oSuOktxBIrzjkSM92gcDqRBBBZg8lU1KJxKcieRm4q4VWovVwQb/ffViQDLdlcYURw==
X-Received: by 2002:a17:902:6942:: with SMTP id k2mr8571969plt.136.1552723639959;
        Sat, 16 Mar 2019 01:07:19 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:19 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 09/16] perf: missed a map__put() in error case
Date:   Sat, 16 Mar 2019 16:05:49 +0800
Message-Id: <20190316080556.3075-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to map__put() before returning from failure of
sample__resolve_callchain().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/hist.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f9eb95bf3938..ae74b82f51ea 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1062,8 +1062,10 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
 					iter->evsel, al, max_stack_depth);
-	if (err)
+	if (err) {
+		map__put(alm);
 		return err;
+	}
 
 	err = iter->ops->prepare_entry(iter, al);
 	if (err)
-- 
2.19.1

