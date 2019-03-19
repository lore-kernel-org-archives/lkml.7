Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A575C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D712084F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgUJvZ/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCSC6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:58:01 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45372 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfCSC6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:58:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id j128so7821029ywg.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Yckzi4lGrOXCq0n296dhz5of4prQGgh+StK2FP8Zk8=;
        b=vgUJvZ/8JBFlj/MV6Xc5IPMUPfWRzXrzYvZCk2VsAazzB1H4fbOe5wZCBInTwWXcXO
         56MlJ3CLb2AfT2lmxE8j1O8+yG+/vzquInWvK/ltqyYigcuK2EEbhTPAHBCglicMv2U4
         mvThy4mm0dl2e+dc1nSvmhWc/x6ZAIVuinVP2y9uA1NW9S02dBDMw8LpB//j9CHPzelo
         HgzhmoQ4NYWeC381OKP2nhYnJTOMadE8sWQ8qLI2p6FPzPFPcO9eyrbz7M15r6I19Y4D
         9tE9KnikLWI4cZqQgnBdJVX6jaf/ynWCDVwUTh7gExDfvky8/WeQuYnxwebX/PD7DVAO
         e8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Yckzi4lGrOXCq0n296dhz5of4prQGgh+StK2FP8Zk8=;
        b=fb/wuiSMiY2RdDfj22rWc5aYMeyaekdgBiaUNtxE46hxXy8YUL/M7YlDm6BjSohb8M
         iGQkcPx+mW8nj32Xqp59SjHc96chquKMJvCJwiX/OHmo9Uug/a/6582IQLTHwcvIv63N
         rDTvk9tktBKjX9CoFogRzyfJodlR7W2VgNSwEcgzWxaaz7HVn+HBgOTBCgT9RBsEZ42g
         R1BT8jgDf4JHyRXjYtFVpPYosLFQ4qrTQVcvKMz4lX6/VpilL4pv6xQJbCTY2/RbzaT6
         HbYEZPY4gsI9Zy+jFt5btpUirh3d36CiqNjacwQErH/NHQs2GXY+NS0Qnj93B8o5hwTG
         WADA==
X-Gm-Message-State: APjAAAXUV51j2FkvD9QUcrMPqLfIiia5z8WpqbatBxsQXEP2opoJRnts
        Beo5tFQ1I0jWAccsoqHPpWqg2Uftlp9O0A==
X-Google-Smtp-Source: APXvYqzTqM4OFCdZqKqhcRItmI4Vwfg8heq4xFIpYi1klLMvItrMGfIw7l8rvw54ziQZ259A4NSTfg==
X-Received: by 2002:a81:a350:: with SMTP id a77mr127940ywh.66.1552964280145;
        Mon, 18 Mar 2019 19:58:00 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 67sm633042ywb.108.2019.03.18.19.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:57:59 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        etnaviv@lists.freedesktop.org
Cc:     Bo YU <tsu.yubo@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: [PATCH] drm: etnaviv: fix strncpy sizeof argument
Date:   Mon, 18 Mar 2019 22:57:55 -0400
Message-Id: <20190319025755.15394-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling strncpy with a maximum size argument of 64 bytes on destination
array "domain->name" of size 64 bytes might leave the destination string
unterminated.

Detected by CoverityScan, CID# 1443992:  Memory - illegal accesses
(BUFFER_SIZE_WARNING)

Fixes: 9e2c2e2730126 (drm/etnaviv: add infrastructure to query perf counter)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
index 4227a4006c34..08ca3c44be48 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
@@ -414,7 +414,7 @@ int etnaviv_pm_query_dom(struct etnaviv_gpu *gpu,
 
 	domain->id = domain->iter;
 	domain->nr_signals = dom->nr_signals;
-	strncpy(domain->name, dom->name, sizeof(domain->name));
+	strncpy(domain->name, dom->name, sizeof(dom->name));
 
 	domain->iter++;
 	if (domain->iter == meta->nr_domains)
-- 
2.11.0

