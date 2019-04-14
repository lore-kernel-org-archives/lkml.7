Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F34C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2092084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZaHshhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfDNXh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:37:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38243 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfDNXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:37:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so17229020qth.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apJnCVkg9SlI3LejkbS9xZBwpDP1otabvwHbIvfC50c=;
        b=ZZaHshhj6swMBkXkMG5U9BNcG9CIr/BELD7OuMBpC02n6g1o2AtyD1wLfRMiLGv05M
         zZb/CfarBOWdk/9RM4CAOOjm8yoef3nxUKtRvc3aHMImAwunIT1xn6j/RS4LYlWlqfLB
         xIqKst9jGWgyVqw3OXkDThVlHtvFqkXMQxP/AuzntOQWJr9F23KToAzHsz1ENpZzkIx3
         pdnjlZV09lgFGflePZsrnk+pVLUmvdheH7wMF+CWQFLbNrfhmwB1ycVMCjRpQAd8QZwJ
         tAGIqo7laU5EFzfWwCJUxnAJ0HLw01af7t2PuUCWTgl6GcKtJ6h0rQVIFtoCAQ78/7Gf
         t8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apJnCVkg9SlI3LejkbS9xZBwpDP1otabvwHbIvfC50c=;
        b=aLgeVp1Y+5x4TrsAC82lQZmgpLszdWm33bkkFpUOnN6nwvXvjUb8cRgcK0vV0qMDFE
         Edio4pak0FgiqBtP9eqrzQ7JYJawc2tyZo5PjVot3tMFrv8F2Ja+Gf2PjOdP4W6WI9UQ
         IMJlnqrDnAemqORpdg5C17Tb9rhv+o+sDkz28HMwJwchCGXCIdpXTIoByzmzd0HYwzPF
         4IxZNMnwJ1a3JAslbxCsaqVhcDYGJgSnJejNr3tgB9Eo5eMrBoOPVIZUU0oCR2fGRSjX
         s1T3ZzNEnv9uTj6VxOVCJVTLrL1Ub3nCIdu4pBsKEt5NLHhWkkK9KDBqXZPBfNSOcNkD
         rhRQ==
X-Gm-Message-State: APjAAAWkkqEFOAzeWevN38SfBSoM9Eri32ndI3FzoNhjxJ6NFufwsoKi
        mKgPybCsPXbwYDUpe4IvKeJedi3o2Bg=
X-Google-Smtp-Source: APXvYqxdkO/g/gHSY+RC72TrM04vEjOVJwcgF/9dzmwhMaXaLUFUlVqfH/LCLoxcOn2aSf+LRePocQ==
X-Received: by 2002:a0c:b096:: with SMTP id o22mr44360249qvc.170.1555285075780;
        Sun, 14 Apr 2019 16:37:55 -0700 (PDT)
Received: from debian (hlfxns017vw-142-68-56-253.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.56.253])
        by smtp.gmail.com with ESMTPSA id q6sm31001548qkj.87.2019.04.14.16.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 16:37:55 -0700 (PDT)
From:   Brian Yip <itsbriany@gmail.com>
To:     christian.koenig@amd.com
Cc:     ray.huang@amd.com, Jerry.Zhang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Brian Yip <itsbriany@gmail.com>
Subject: [PATCH 3/3] drm/ttm: Fix ttm_bo_glob.kobj state on cleanup
Date:   Sun, 14 Apr 2019 23:37:29 +0000
Message-Id: <20190414233729.17956-4-itsbriany@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414233729.17956-1-itsbriany@gmail.com>
References: <20190414233729.17956-1-itsbriany@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup ttm_bo_glob.kobj when its reference count hits 0
so that it can be re-initialized by future ttm_bo_global_init calls
without dumping a stack trace.

Signed-off-by: Brian Yip <itsbriany@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 988416fb8a0b..1e1844f4a4fa 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1535,6 +1535,10 @@ static void ttm_bo_global_release(void)
 	kobject_del(&glob->kobj);
 	kobject_put(&glob->kobj);
 	ttm_mem_global_release(&ttm_mem_glob);
+
+	if (!kref_read(&glob->kobj.kref))
+		glob->kobj.state_initialized = 0;
+
 out:
 	mutex_unlock(&ttm_global_mutex);
 }
-- 
2.20.1

