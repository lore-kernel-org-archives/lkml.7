Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F02C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292B42075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPrqjNCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfDVIBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:01:47 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37329 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:01:46 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so4026461ywd.4;
        Mon, 22 Apr 2019 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CkEiS23vA5jUUQv/7xRjl5N4VpfJi8RESzy4gyWHcpk=;
        b=JPrqjNCVqTEicPNpoPjYd256d4m6M24SayNc9I81xwou2yWq+EQJ3mhjbFSabw/Fmy
         Gs/E+Y7CnOWmxJYn6Zk0tP5xpPMduz+1gEggnEmg0p5FmGUUvJOdF2P2fAN4MEkHDUAd
         QS6cWvEAf+Itp+woIvBhgB50M+ZoereZJxSwKQNVEWPm6Dgr48ca/uXOons+xFRV1Urx
         s6swRl+rsHuZn+eIly4FQzbmavO0ZscKupcenz4n6zUTKxubTDwsNa/rjwKbvPNmQlE+
         H2Lyafuw026RCT1mR3iVprXEDBy+lXLPWqcb7kSkW0YDav2U9j/fgUd0lpH3fRHzWRie
         oeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CkEiS23vA5jUUQv/7xRjl5N4VpfJi8RESzy4gyWHcpk=;
        b=qWSeRQBCOXoPyRL8+Ns/viMl/CDOVjva5PXzBBDPAiK3vvo8dZ7Olm6mXsw3ZZAM0r
         /TviG70hCQpr3yM+brUI+ILoB4aU5a509x9ID7CGjQYXUaoFpo6JFQfnB68l6LMXArLO
         3uFWQp/q3sIpC9FYneLL9fQod9gvDenedhqZwc3hyIYvARKsrMB31v1YuBTySzrBIGNW
         didvKN+uEFC4kzLSPUHNXT7USkh79Muew7L2wM0pEEPTm7T8cZ/ja1tY55PtW5L6/30n
         dOd6iIIUkcx15NQAVtwMB3vYfUzsstVPpIcm3ggxZzcNqtjR1DqKDb2sJfoKDHkimyoU
         AZUA==
X-Gm-Message-State: APjAAAUWsBEWJINAxbdSJz8O+QaIp/q+roqbwMLmEADXQ6VuNJM1QSIQ
        kWi+YNAzVJNDVp7stVxFaNE=
X-Google-Smtp-Source: APXvYqwYnwRuRawXqJsgwKHdDr/k0bmTTisfh64ar415UYwIA5lSCKHiY9miVFasZ8TtjaxBDbjVAw==
X-Received: by 2002:a81:48d6:: with SMTP id v205mr15174936ywa.128.1555920105628;
        Mon, 22 Apr 2019 01:01:45 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id h131sm4691113ywa.80.2019.04.22.01.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:01:45 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        adrian.hunter@intel.com
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] perf bpf: return value with unlocking in perf_env__find_btf()
Date:   Mon, 22 Apr 2019 04:01:38 -0400
Message-Id: <20190422080138.10088-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In perf_env__find_btf(), returning without unlocking
"env->bpf_progs.lock". There may be cause lockdep issue.

DEtected by CoversityScan, CID# 1444762:(program hangs(LOCK))

Fixes: 2db7b1e0bd49d: (perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf())
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9494f9dc61ec..6a3eaf7d9353 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
 	}
 	node = NULL;
 
-	up_read(&env->bpf_progs.lock);
 out:
+	up_read(&env->bpf_progs.lock);
 	return node;
 }
 
-- 
2.11.0

