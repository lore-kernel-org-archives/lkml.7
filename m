Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D991C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E572A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmIoi8oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfETS5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:57:18 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40959 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETS5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:57:17 -0400
Received: by mail-pl1-f170.google.com with SMTP id g69so7127950plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8Lt7rSnSkayzVvx67ZsDNX8yUH1XBDbeQw+L9abvZe8=;
        b=MmIoi8oqygXCLZy6E+9vNzH0H+XcQpdYN8P2HUH/MXWiF0urxOgo5E08QftQCPg6bx
         1YJ4p50CDP1Nph8zBNIQc7mL2PqtMChBUcWCTbJHNH43+tC3C1Hcm/mFCySjP+ImYnbV
         qqKhTuMgWXz3s3Shx9KcZqWOf4mvchFNq3FD48g3ALRHMHPOOOnUM++tgvnQ62pEGzsm
         h3USo901W3k+/b5bFvdhmwdDI9eZ3nfLz9t+1+L9qbtHHC6PUXRSkdgEu7bEGDiDbHjt
         /BMp2HqmwC7azDnhJNtLO3dnHe9f4mzljiAuXqMIROzSpk+Td5PadV9Kb9DQSDTZzkeS
         0msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Lt7rSnSkayzVvx67ZsDNX8yUH1XBDbeQw+L9abvZe8=;
        b=quLDpLC+Qu1xxwwDNb4wyufBklcYmmLa0y4fkBnwM3JnYU/w3k4M0WecCragNBm12C
         QL4GWV0vsWAaz/1/avKyCAy9F2XQ55xIWyvCm2IJVMVvmRVrBnYrQwtUkys/PNujp/f4
         I9HWGQAMdOUwhGa4cqf4m8UAFnpTZLs279XkzfPVTHPK0t+GCK07kEFV7NEYiB8dQIsa
         SsSa1L8NvgXXk0AK9z+Ga/keCGOGUWWrZZwVVg1t11CMlj1L8dt6wM76usjZB5kJkAmH
         J1AIQGf35Z85tDyS79yLXbj7RJ1uiW3kgMTb4LU1gMeH8eP+Jh/2zG8QiFtckSwHjoP2
         zyeg==
X-Gm-Message-State: APjAAAWkLZ6xlIoqFY1FfW8DwxZ5WuAL3boEIyoi26dkPDNrVDLUIZYq
        owioU0+ETO+YQ+YHm3pFWGM=
X-Google-Smtp-Source: APXvYqxVlxI+C53z9BfpApHBqX5Bh4zPMCrVSRk4CROsV3Nz+iH6IjFXfgCxjIhzf4CaBiwwWe3nUw==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr64516718plz.40.1558378637077;
        Mon, 20 May 2019 11:57:17 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.23.153])
        by smtp.gmail.com with ESMTPSA id k30sm13607075pgl.89.2019.05.20.11.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 11:57:15 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        jglisse@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/nouveau/svm: Convert to use hmm_range_fault()
Date:   Tue, 21 May 2019 00:31:58 +0530
Message-Id: <1558378918-25279-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use hmm_range_fault().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 93ed43c..8d56bd6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -649,7 +649,7 @@ struct nouveau_svmm {
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = hmm_vma_fault(&range, true);
+		ret = hmm_range_fault(&range, true);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!hmm_vma_range_done(&range)) {
-- 
1.9.1

