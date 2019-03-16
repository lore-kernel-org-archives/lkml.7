Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E134C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBE1218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5zBP7eP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfCPIGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:06:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43920 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfCPIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:06:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so7997599pgq.10;
        Sat, 16 Mar 2019 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgzEfOgCr8vqVuMIo/FFofdpmPOyzi7oCw3Jm8x3KtE=;
        b=C5zBP7ePwtlYPJqO1Jk5YeMrp4ENlY5Z6BUTygKhVD74gGV2valvOaJcUBGcU9AjM0
         /oE7r79Kq8bZ3mo7BrmlHDwEr3gQflh3zhwexu51xOQNFJulJbEgp4KQ/Kp1Ep5LaGWw
         vht+JsOWRDXzKV190ypLU3pNaBW/zMGJfR3x5cDPxcdtr3sw081/uEc81Ntk1xs6Gjda
         vw3usQBhq/cbWaxRCU3BQ2IvEpLsrCLDo+dzN5bcr1vbggnrgeMroeOBU+FXdnI0jQf2
         SrOyY0bzdKzNFuRkECN/WfxPny6B/dkKMpBcrHXMXNgZaFGVetwsWfH/yWjcildr2DOi
         +6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgzEfOgCr8vqVuMIo/FFofdpmPOyzi7oCw3Jm8x3KtE=;
        b=uRkUzyIAwb7f3XVBCdQz+fpsk150W81W1s29Gxyihg8s16ZWmq8mG06dVLCjbQmltU
         2K+sAYF90vkE1qmNfvzgzTl9vHwk2jwoDJSZK4WdutnssxB8vb3zBAMYDPgDQ30VEU6F
         HEkFPtJU38wpRg/myf7aplSmiThEo/gd+MkTHwjwgxtqJbUVrskXJAdNIa915oSHolGf
         p2eMfI/hOX1DwyB6ZpWsTqh67IJW6jiArvBQget/rQ5Zd/NHqnqgdaMvNJWjoQJoIS/2
         MkxLGCQH/RMucFUWcmmRsXBjoECyxUViWgP7u9P9eOPAd5nZN2VPQdPXfYpvBuqPVGtY
         xD6w==
X-Gm-Message-State: APjAAAWlPtJQEzS8iely/0KKHvYefLlu+0+Ub68LvpU5Tn2u/6ZjBnsQ
        m1vA/8FlgwBUG/IViFvDvx4=
X-Google-Smtp-Source: APXvYqy/CEmclWXHp+N1rdEw50IJ1fiLXRHH0nrAHL9D+2lKTWPi89qW73qG2DRmIaiWqXRbGrRR0Q==
X-Received: by 2002:a63:35ce:: with SMTP id c197mr7430635pga.281.1552723594985;
        Sat, 16 Mar 2019 01:06:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:06:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 02/16] perf: list: fix memory leak in function is_event_supported
Date:   Sat, 16 Mar 2019 16:05:42 +0800
Message-Id: <20190316080556.3075-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't forget to put the allocated thread_map.

Direct leak of 2048 byte(s) in 64 object(s) allocated from:
  6     #0 0x7f606512e370 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee370)
  7     #1 0x556b0f1d7ddd in thread_map__realloc util/thread_map.c:43
  8     #2 0x556b0f1d84c7 in thread_map__new_by_tid util/thread_map.c:85
  9     #3 0x556b0f0e045e in is_event_supported util/parse-events.c:2250
 10     #4 0x556b0f0e1aa1 in print_hwcache_events util/parse-events.c:2382
 11     #5 0x556b0f0e3231 in print_events util/parse-events.c:2514
 12     #6 0x556b0ee0a66e in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
 13     #7 0x556b0f01e0ae in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
 14     #8 0x556b0f01e859 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
 15     #9 0x556b0f01edc8 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
 16     #10 0x556b0f01f71f in main /home/changbin/work/linux/tools/perf/perf.c:520
 17     #11 0x7f6062ccf09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dcc01b2532c..2e9035c4c252 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2271,6 +2271,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		perf_evsel__delete(evsel);
 	}
 
+	thread_map__put(tmap);
 	return ret;
 }
 
-- 
2.19.1

