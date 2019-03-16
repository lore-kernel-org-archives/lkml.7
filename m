Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8160C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F9C218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bod/pmqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCPIHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfCPIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id i7so4803397pgq.0;
        Sat, 16 Mar 2019 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4XMzDEhPnOe52ZtceC0afDHSWcXxrtxBKlRnVkyr0M=;
        b=Bod/pmqBVbduYNTjEzoULdxWma8iVXnw/RoLO8AlkvvsVxLsDkhNnoEPF/j9o0YIZ0
         YAcT+NuPP9Blaihm3YcokJu+eyBKZxTdivp1Vkc4EfngyPFbt7oaWd7lcFMj+rsul1In
         Tv9dM2s5Tr1gG/1G9QsUm5NA6axdmRrk+FTYCcD9mJpMAHa5P+4Se7Pfj5gHp55n9XQM
         l+b8JjqY74E2bDrsVgF6kY/140xRhFF/u4YOp5OuX62Yclo8aLlfo52LFZFoHorUzJJc
         jw0GJM2myZw7wVQxK/r8jo1WnqrJX5P36dpV6nRUpZzGKYIImk541wP3LpyDYye0n1tP
         a7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4XMzDEhPnOe52ZtceC0afDHSWcXxrtxBKlRnVkyr0M=;
        b=VHh9cSztmCIVoyEnZ2jNE+i5Sa7gLhzs13gAtCgj9h2piVBouqQj72m11qxM7H4tRh
         20Ude/l2IJJsgRgygZBv/HoWvmGTHz02znp2jUE4+uo+U09BspuRWsTjXOR5Wt1z4SO7
         eOv/2URSyrhZtjvAh2GVFu51OncjwSipT3wtJXCxO1WdlC1yvGepMTDylsZk3stsZWNe
         p7zXBYUWbybAZVLcDIQ2/lwivXV3Wp/GqaRyeLCMw+WNRsqqFpIe/xOd5eU43BXKWngT
         OGyOvGL+XIhWG+WGuVY8PM1vZC/XN+waOtPvu6ivNJH7G4GsS5/rtERN6DYtCLtodozK
         FO9g==
X-Gm-Message-State: APjAAAUoLPn8ImRuq1rdW1IUkqs+CUrR7YiAtkcqMs+0Bio6TkMqWTOO
        SkgjdC7xse6lm5IqrzkXILo=
X-Google-Smtp-Source: APXvYqw+G7mRpjwCy8H2DzwET3S2y4s+ieUrGYbOK8OnWQgiQEj1u3nyfd7nDF6dWPgBhEaSJpSaUA==
X-Received: by 2002:a62:ae04:: with SMTP id q4mr8200018pff.213.1552723650883;
        Sat, 16 Mar 2019 01:07:30 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 11/16] perf: purge all maps from the names tree
Date:   Sat, 16 Mar 2019 16:05:51 +0800
Message-Id: <20190316080556.3075-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function __maps__purge_names() to purge all maps from the names tree.
We need to cleanup the names tree in maps__exit().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/map.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 64bea5eb8bf6..e32628cd20a7 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -577,10 +577,25 @@ static void __maps__purge(struct maps *maps)
 	}
 }
 
+static void __maps__purge_names(struct maps *maps)
+{
+	struct rb_root *root = &maps->names;
+	struct rb_node *next = rb_first(root);
+
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node_name);
+
+		next = rb_next(&pos->rb_node_name);
+		rb_erase_init(&pos->rb_node_name, root);
+		map__put(pos);
+	}
+}
+
 static void maps__exit(struct maps *maps)
 {
 	down_write(&maps->lock);
 	__maps__purge(maps);
+	__maps__purge_names(maps);
 	up_write(&maps->lock);
 }
 
-- 
2.19.1

