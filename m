Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0221CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2293217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU6Xnz2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfI0QO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:14:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38071 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfI0QO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:14:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so1870571pfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AaR5OzYbcf+jLy/yyQ0UWIR5YGUMCNa32EYa96X1oJo=;
        b=OU6Xnz2i+u94fO/4vIXoNMGssGeVRLpSzW0wIhwvEMx8Y60FFwy62xt3kSN3R1HmpE
         6u0LIltGp7e8/jYBbLcEFwWU4q/6MYQfBgoictKGKl6DV3wL+8bvdKIR0Y+9p5WNTiCW
         xg2VL3vFZTH5QZpl3Kb5tICrDZ3uvpcLTaO14gpR/Hk1MP1xqmFviLPirLm3NKM+OIgY
         SLI0rUruCbcNrJnwlpzmIA0LXYpe3b4I42qHQ2EeXjggkxQDHd27yvIJRVmSpWM96Dd1
         HLM2nxjfBBN0jDGNYYVu7IDjrwhaBYiDN6I+/O0fYxs0haDyrMl6DNIPE9r6CYlnG5Yg
         +4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AaR5OzYbcf+jLy/yyQ0UWIR5YGUMCNa32EYa96X1oJo=;
        b=ASKPbTwkw6hxHhR+pQVlMMVIsqBt07fkV2nVFatPsAAg5tyNeZ36jCvj1pZsSDtzzG
         +ZhQE4yCElnS2Iucw2B2+VKvE0/85wttAkBaSBxsWjuks3dX0qNnnpjcDPcs+D2fYm0+
         rdxVAwUca3wU0eH8BghU7Le1smf3EsiaC1nKX3Z7w27s7mrifuwcmQUd39gG1Nzmgkda
         HxNgaUlpbN2jUJmBJAVc6F3BTV2eHKX4e2NA711HPXsauH/8a4nLYexneR4WR+j1viFm
         hxe3vVQNfCiTm+TVbVdelN27xVivFGDocsM+xPX+CP3VTsnUbXwSm/GIoCOmgBCimmcK
         PDsA==
X-Gm-Message-State: APjAAAUR33D0Tpmr86OucbJ3iP0nPZarXdDM8okEYX2LN2w0ytxFbaiT
        7LuZumZHKfRw0dAp4/3YcpU=
X-Google-Smtp-Source: APXvYqz5zLIqBwCG/BiEZQZeWj2tUuWueP32I5tc9JMG6yJk1r+WK8zrdAsy9jvcTn/5F4VaJ1HnNA==
X-Received: by 2002:a63:120a:: with SMTP id h10mr9671403pgl.29.1569600866827;
        Fri, 27 Sep 2019 09:14:26 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id s17sm10386912pgg.77.2019.09.27.09.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 09:14:26 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     sashal@kernel.org, mhocko@suse.com, osalvador@suse.de,
        mgorman@techsingularity.net, rppt@linux.ibm.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com,
        pavel.tatashin@microsoft.com, glider@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        Muchun Song <smuchun@gmail.com>
Subject: [PATCH] mm, page_alloc: drop pointless static qualifier in build_zonelists()
Date:   Sat, 28 Sep 2019 00:14:16 +0800
Message-Id: <20190927161416.62293-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to make the 'node_order' variable static
since new value always be assigned before use it.

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3334a769eb91..c473c304d09f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5597,7 +5597,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	static int node_order[MAX_NUMNODES];
+	int node_order[MAX_NUMNODES];
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
 	int local_node, prev_node;
-- 
2.20.1

