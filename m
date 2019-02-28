Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE686218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="0WT5rtTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfB1Qaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:30:55 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39024 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732762AbfB1Qap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:45 -0500
Received: by mail-yw1-f67.google.com with SMTP id z191so10920574ywa.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q68vDKJoy4wkBVCCNbeXOOo5XkzY9NuLFWEJjvpu9MI=;
        b=0WT5rtTI1WKxMYjRHLUdNtdc8IsHgN6ifmKk4VfIC2ys+4BaRMElBPNWBkf1sY9V2U
         DBgNNGgwSI8YyW0YqocogXheOlD1uDjEimiRXYZJFO7GLlIfOGc7HZOuSUQbFN0Wgl1d
         eJLi29oGq6b4efRD83YQPz5IeBD+wxIvU7zwz00xHyxcAQHlzkPJtLGBmEugCfx+CAo/
         t9J/UmkKoI48HsTy46tNW8AazNXmo6bE09T4Z3Do/iURkSM9AcI7iW/B04LO2pfr8aNp
         KuY3Qr8xk08bXRBFWC7Pt7v78/5OFVDijamJDggw/hKAruJeHvrhKmbmi12rUfPQd8zW
         1FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q68vDKJoy4wkBVCCNbeXOOo5XkzY9NuLFWEJjvpu9MI=;
        b=XWOM/geHO6YcmVi2TAmMcYn3dNbSsqu7WIdoEW1G5zWrDiloJDTwbk/uHMJZSDQ0iD
         ZbWJ4io3xXbMARKzeaxoL1UAEaaRva5HpfNxkbIjP/jJSzCS4xn/o4Xv/zIG3zYxAimf
         UPwVrjpO4pH3tsrmBGs2xrOi8s/H3LrJvlcGBYcknnsSQ3K9hfJaDxx6R8nl+6h5csmv
         IHbUqJIx2G5ZFQto0OuggkdHyIPoZiHWQ755rBcn6VQJfiUOHQGu9ulKqaZwbsz4+rnK
         1Euoxmzef1cpGswTOQQ2fvDr848iIKek7YBVXDXQpC5cZK0ehO5GsgkaHcNG3BBKSUQ+
         fz1A==
X-Gm-Message-State: AHQUAuZiNKFbfg96YYYGH1uiMOWTkObXKLniz7KeOJhO/UfQliQra/nJ
        d/N0utTNDW6ZiLkDsUwMa8Ivzw==
X-Google-Smtp-Source: AHgI3IZ6bGtIf2tq3DoaxA0LIWJUB3eGOgT9AKeaRU8ncx3MetLp/EgLeJPv1RfxuCwzXTOtLICJWw==
X-Received: by 2002:a81:3d48:: with SMTP id k69mr6149601ywa.313.1551371445217;
        Thu, 28 Feb 2019 08:30:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id 142sm5053954ywl.31.2019.02.28.08.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:44 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/6] mm: memcontrol: replace node summing with memcg_page_state()
Date:   Thu, 28 Feb 2019 11:30:17 -0500
Message-Id: <20190228163020.24100-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228163020.24100-1-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding up the node counters, use memcg_page_state() to get
the memcg state directly. This is a bit cheaper and more stream-lined.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d85a41cfee60..e702b67cde41 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -746,10 +746,13 @@ static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
 			unsigned int lru_mask)
 {
 	unsigned long nr = 0;
-	int nid;
+	enum lru_list lru;
 
-	for_each_node_state(nid, N_MEMORY)
-		nr += mem_cgroup_node_nr_lru_pages(memcg, nid, lru_mask);
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
+	}
 	return nr;
 }
 
-- 
2.20.1

