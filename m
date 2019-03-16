Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099CBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CE3218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCzeE4u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCPIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35840 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfCPIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:06:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so1095124pff.3;
        Sat, 16 Mar 2019 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOaDX1hsZoPWJDl/vrGSk9KyxT5THHHiveid6Gt2K+Y=;
        b=BCzeE4u2kEYn7eVuMA39y7usPvWu4kNwKu9PT76dpLmr3n7wTXvOadapc24C+dmdFB
         xqwuqxskhWnji4/66ATuOP0n/Jp0zQlCqO+41LjMsRtC9JUa7ra6zBf7A5l1sp+9ydW3
         VE/0TJK2y2rdqfz/eR+7lxg5sWMLgmFHFXu1kRHu6DSdDXjZyjvGfgSLDjzLB5rWe4zI
         TkG1Wjau+Tl8QmGDtqCFw9WjCK20FA88t4RlruwA93Hb5QN5D5V3AP2O5Av01TqaTKlz
         SOo9ZndQ+4pxRg6+KjDfIvCgVNLlwmk6qFFQ554DHldvFmL/zjUgEu7wccyYiIbjBmed
         ilKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOaDX1hsZoPWJDl/vrGSk9KyxT5THHHiveid6Gt2K+Y=;
        b=ZVAPB2kqxGJMuywe8UgaZP7mEI7PJE3j35pA8ZHSFgNQB/8XEfGRwdDSi9HVhWBm6b
         GqYb6JsQxdNIzfNA82bj2VkkBTzOuxnQowvubbnbfCHgXqMnw2DiyeDnNbO/i5rIVNix
         m0B6coOo7rBZxAklUcurAtXZCnBgDwxYjnk+PuynB2pB/QYCD1JMyBwM2MuI5qNR+QF5
         XewRWATrvJa7AzzzufByCajaTboVPnZtUC0F0oO4bBfO5xJloD23UIb7Tmr/izX4hxPw
         mGXknUmLn2qUaGIfSTm6u6f6NKbQ0nWz84/IFwWL79oiTjPrH0l3l8EF8OTB3Kt39Go4
         A/yQ==
X-Gm-Message-State: APjAAAUseY3wybSLk9qf+NLkoY17BSfRtNrYTGipVE1WwSgK7Scc9gbN
        lNP92Ntl3xrojE0/b/w+QpU=
X-Google-Smtp-Source: APXvYqzJBwEOMugL3AYjHx3vwhPxhL94g11QVNAr0Eix94y5A/3exVs1gamF4/QFRp9ZJLtn98+rgQ==
X-Received: by 2002:a63:6a48:: with SMTP id f69mr7361758pgc.7.1552723617553;
        Sat, 16 Mar 2019 01:06:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:06:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 05/16] perf: fix a memory leak in collect_config
Date:   Sat, 16 Mar 2019 16:05:45 +0800
Message-Id: <20190316080556.3075-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct leak of 66 byte(s) in 5 object(s) allocated from:
    #0 0x7ff3b1f32070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
    #1 0x560c8761034d in collect_config util/config.c:597
    #2 0x560c8760d9cb in get_value util/config.c:169
    #3 0x560c8760dfd7 in perf_parse_file util/config.c:285
    #4 0x560c8760e0d2 in perf_config_from_file util/config.c:476
    #5 0x560c876108fd in perf_config_set__init util/config.c:661
    #6 0x560c87610c72 in perf_config_set__new util/config.c:709
    #7 0x560c87610d2f in perf_config__init util/config.c:718
    #8 0x560c87610e5d in perf_config util/config.c:730
    #9 0x560c875ddea0 in main /home/changbin/work/linux/tools/perf/perf.c:442
    #10 0x7ff3afb8609a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index fa092511c52b..7e3c1b60120c 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -633,11 +633,10 @@ static int collect_config(const char *var, const char *value,
 	}
 
 	ret = set_value(item, value);
-	return ret;
 
 out_free:
 	free(key);
-	return -1;
+	return ret;
 }
 
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
-- 
2.19.1

