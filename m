Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C47C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E16218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxc3p+hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfCPIHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45871 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id 125so7987479pgc.12;
        Sat, 16 Mar 2019 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UTevn3yjBhVEl4/8CsN86tu89thYUQB175QmtEgjt0=;
        b=Bxc3p+hgouYogv83cEonJo00HUidoQSYH4KX1tJ33OhXliWrbyCwFviPK9TTIiu/Hy
         ZwELZWb/xDfqxQqEgdZXtWvQcecbKtlsjqSGMPQRM7+BkjD4VY6PD8AoN63YWFEhu9kB
         VFkFkcai5bHm02W36NLD1178IeFNxUUFj0SjOJBk7CyyceqlXC3zJN+WJCfEqGHABxhP
         jlD0sXZ+VUTQfMp9KhMQF3wHah3cL7WZ8BPVILQQIJXhvs1d/HfReP+IULig7LIeb4SG
         zrZ5adWf1MgNr1uIG3i4Sz51upO7QaHI/s9PXCN1ZSpjfNzVnM0w6GwuNl2EpKR8ITG6
         R8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UTevn3yjBhVEl4/8CsN86tu89thYUQB175QmtEgjt0=;
        b=BrKMTvKhaauTEeY1Iq+cJw1rj46VHDp6ygR3Iy0xl3aY2NtkEl+RrxTeuPq0kfVlch
         VhAYHbVFf5j2Hcc116+EKnUS2IKeeLLaNAxtOp8uOkKXLe0ds8W1sEq7VA4OM6NY9l7m
         GYyniwDlWfu7ovOAduBMesuYoLZkRtB1MZiF0RLA79TCZRSl0GDOofteszTEZ7e8R5uY
         3HmUc1cK8fVRe2HjnyZiUM1JoKQMMh1b+n8tawINy3PHuWyNfrkHbDGpEZm9SJgh893p
         fgklVeOECRa//iFZ+b6OWa3t9O/vGbdk1BPIcGYz2TviVelgzLGB77Fj/a+El76j9Cto
         lG1w==
X-Gm-Message-State: APjAAAWR8QCfh06hGxBY3TgoYJHEftEUU7q/g9cdhuFu+sF4/xyUJ6Kg
        xLBmQjXiAXvEl5sT3xkRef4=
X-Google-Smtp-Source: APXvYqy0CrzUWrfqA/btLS1pm7x6hZNVRgO73TO/xxcHDOi5+rhos86Sj0Xm9UpWyBCeIckuvrx9yw==
X-Received: by 2002:a63:f558:: with SMTP id e24mr7386477pgk.373.1552723634546;
        Sat, 16 Mar 2019 01:07:14 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 08/16] perf: top: fix error handing in cmd_top()
Date:   Sat, 16 Mar 2019 16:05:48 +0800
Message-Id: <20190316080556.3075-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should go to the cleanup path.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-top.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 614f278235fa..2508a7a552fa 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1617,8 +1617,9 @@ int cmd_top(int argc, const char **argv)
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

