Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D6218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjT2XMSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfCPIH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38459 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so7908450pfn.5;
        Sat, 16 Mar 2019 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdhJ3vOifZxoisUoWr/yeElyHsYBLZr9BMOSGuNz/Ks=;
        b=qjT2XMSH54j2+oY7xLa08Y035TH3+lCuu0SLUSIN7ZaHMm67m8MWZv/qQcJeZJ9MMF
         X7pW9H5LmF0NsnDjekJ+YqHKyKG6HvOWoj82vVKViT1oGOQGsKlZ7zEq95d9yJYZiGRZ
         H6JzwEvK3hvFC2cbAHYqSQ2uHgMnAKPGjuRQAuymqyp8b7pZ5fsT9XJUDrthxvn7OIBM
         GpvDu7iu9/ub46avC2sSFYP7W2OpeVWZoRSoMIQxAobYkIiatjq2yyNI0iuc14nyvkVM
         m3DcW7OPQSQetFJXAMzyS4rBNAhrbZKgOYrL/XzoZBWFAiiAR6/BP33u83WcPzp6XLBQ
         mQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdhJ3vOifZxoisUoWr/yeElyHsYBLZr9BMOSGuNz/Ks=;
        b=f9pVi+aFAn/t4CcvN27KHWSNnh/ZCUCGLebXkISIatW43r/7dKOwsdmN34mafsJ797
         MFSKq5oSkdqFgIJKlszfJObj8cGBrk7z/hChQ7lAK5+70xYYDC2Ac1oolN6xv+mCCaWn
         daTe+kJSVNIK66+tD8ZGZWsfWlrmCb03UhSkuq1Zdgpn3ZdwhrrapdgPHb8pRqlhErKy
         k+BX4oJKM494a3ajhAOvgrx4HoEyoounLGpvwgguXEGK1LDgzOYMwcrrIUZW9lgnYnJC
         ivYECGt+FRG+EcUlqhzcKduJrlW2bOkjdJynN1P/UyKL5hpvgqNFQo4mlRW6Ih2Jg1FM
         7jZw==
X-Gm-Message-State: APjAAAU7rsK24BkeL5HchD8n/KbjWg0LWwB3fW2DeqfQsdqL8qkmPZLU
        vi3TkWbIcDAajAHsiCYf9IA=
X-Google-Smtp-Source: APXvYqyyW5PwqWkHvaN3fym8TBn+nsdlDHYX4siCz5t7PWVt9CSlwc+r+1IMZuAdevEHBkBcINg0aQ==
X-Received: by 2002:a17:902:7c0f:: with SMTP id x15mr692993pll.98.1552723645371;
        Sat, 16 Mar 2019 01:07:25 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 10/16] perf: remove map from names tree in __maps__remove
Date:   Sat, 16 Mar 2019 16:05:50 +0800
Message-Id: <20190316080556.3075-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There two trees for each map inserted by maps__insert().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fbeb0c6efaa6..64bea5eb8bf6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -917,6 +917,9 @@ static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
 	map__put(map);
+
+	rb_erase_init(&map->rb_node_name, &maps->names);
+	map__put(map);
 }
 
 void maps__remove(struct maps *maps, struct map *map)
-- 
2.19.1

