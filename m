Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADB8205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6Y1FkWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfHSNGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:06:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34805 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfHSNGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:06:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so1155434pfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0MJOA0ehnVcKagp2PPONz3jZfNumEahBA4DfOKGUOs=;
        b=F6Y1FkWtVt0w8hmLD+i3lRG351Ap5XSaWn5lCIx4ojXVdCDO0P3tSjSfavGTUzZjzn
         IAjj250OLr5KC+RBj+/f5Vz3LBKK93G3q78OoH5mY9KGTXgDh6he/CADlyWX5DUbhF7L
         m+Sxb5NdlIdny2/F7ThgDQhU6LXloBRpXIECfEdAgfyNPaEBDK8zT1UjvEeIgWCsdXJU
         U3ZSKfVpENZQVGvED67qHIb7DPfuOhAJUma6z/N8i196NzdD26/nbGMFuaC+xsPFW5nE
         TRqHGk9qbKN9MlgIHob30DHqiFWU2c0YA+YoUnvpCunhTNtGbje+uSW3PqPYFHfjjpqa
         mFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0MJOA0ehnVcKagp2PPONz3jZfNumEahBA4DfOKGUOs=;
        b=N5oyuoEDYqfTEXPIz/iQCVRMmFDC1dzyJ+Q3QlF75e83BFPYsZx9xVC2egE6MtdOhu
         3O7xaXzM4TaeTB0QYQuenGRf7SaBhID7Qb3jhXARvLm9KU6/byPsT2EIFMsC1kyhNx/S
         qSRuwt/0AuAWJp3ev5aRyLRGb4ffSZQeibTYdc/ktoeQk+SM+6aZOBY+lTwxfQowbVHS
         MayoMbqpe7m6g+iGewNXBD99Rawb7w8mF5fDw6N5EiX8/pzL/00P7m6tyCxZD5jNFheH
         2XleA/ljr0qF2ZnZT6cDOG/jJyFLchHoFgWrMgyj2zRhSNXOlmY5H2YQqotOLa/TNFa2
         t3aA==
X-Gm-Message-State: APjAAAXc2kSn5MtIIo3IwMxsYFCPhqOD0qyn5t2ehQVYwHzuR4L/j7Kk
        sJirmDcjK5G9dhtLsIkBjik=
X-Google-Smtp-Source: APXvYqxTxI+ckLrYqBmhfbTvY3cF/YLWqrHpd7wG8/FyPaDxRkxT1R+xVqL/TlEHzjaMApu6bUzpPw==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr21008549pjt.29.1566219968644;
        Mon, 19 Aug 2019 06:06:08 -0700 (PDT)
Received: from masabert (150-66-86-135m5.mineo.jp. [150.66.86.135])
        by smtp.gmail.com with ESMTPSA id g36sm28225971pgb.78.2019.08.19.06.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 06:06:08 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 62C1A201207; Mon, 19 Aug 2019 22:05:54 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, dri-devel@lists.freedesktop.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] drm: selftests: Fix a typo in test-drm_mm.c
Date:   Mon, 19 Aug 2019 22:05:52 +0900
Message-Id: <20190819130552.28354-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in test-drm_mm.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 388f9844f4ba..bb29e0b67b95 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -2359,7 +2359,7 @@ static int __init test_drm_mm_init(void)
 	while (!random_seed)
 		random_seed = get_random_int();
 
-	pr_info("Testing DRM range manger (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
+	pr_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
 		random_seed, max_iterations, max_prime);
 	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
 
-- 
2.23.0

