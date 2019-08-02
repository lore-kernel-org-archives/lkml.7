Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D7C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D3821773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYCawBcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbfHBMkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:40:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38929 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfHBMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:40:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so33653086pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLZJUYtz9c/vneBc7snc3K+WGGpV37J3xyW0EJcXsTs=;
        b=RYCawBcHwmBhNKJ7E51R+JhmS7cqBiAMsH+ORnvToU1cvZinsI1MQ5+jXqzzbnRB8M
         nPDfFLI4awk40v+XJ/+nPo1Ut8Jf/rR6OWWq4XETJLbS9D8hz6NlE3ZptyYko33HjzJB
         aqocmNA+PWtlfhC1OGBOX2lcE+HxTPdI2UCtGjTiH/J5ozrr0E3rUMdFtgvJ1VmLlrUl
         SrHGJ9M6nDRjSb0EdBc6ZSYM7+dcYi8NHw88D3bmcqOq9gAoLqyEzgJP969+NFuaoTsK
         JqfaF//eB/BtHClNldO9worDkC15RpdVqNXD+QNFWpBTZty6PzqVXXVfyrPLUhIiA14W
         XGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLZJUYtz9c/vneBc7snc3K+WGGpV37J3xyW0EJcXsTs=;
        b=rG2oylIZ5AhHrOUbAolXb50vse+6c0FPk6+PIjc6/qgaYWgCuBg+ierZys04An7BU9
         W5PxlRB3bhPFlkCzYIK8mLMaf7AjRscXH80bm4JG7EqWUTcqNM9VDLMG+Fek7m/EjPRV
         SFH3CRBsnRWhFFbWmg2JyXdhbfICBpd/2z/rmNMYtFTgAkcV+mpUpIgGi0JlhRb0u7X4
         sfzjQiZgFFyJAf9aH45hqzneUYvDGF/qBGs/sHathbzQhfh1Bc1F8a+VBFW1EnjqCfne
         tJj8ki8iUucRtjbXvsnpNgldFH4cxlgDALzEMLOZ5+i4lSako2FB0Ic/+czoSgSyUSF7
         vRHA==
X-Gm-Message-State: APjAAAWK0Jij4zXN3qS+PhwQpb+seo06GAUpCLWqFT4NMsyHXbS0qk6P
        CqTltEhhkyuGMDduPtyNT1I=
X-Google-Smtp-Source: APXvYqxrnjH7ex/6pEQR0PP0CJ0wiDiHlzBBFCGaYn7H9aYWDBJ6+jUqjBc53T0gjKH8X9W0YZFvqA==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr136803582pla.213.1564749619024;
        Fri, 02 Aug 2019 05:40:19 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id o3sm3978851pje.1.2019.08.02.05.40.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 05:40:18 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 2/2] i915: do not leak module ref counter
Date:   Fri,  2 Aug 2019 21:39:56 +0900
Message-Id: <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_filesystem() before i915_gemfs_init() deals with
kern_mount() error.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index cf05ba72df9d..d437188d1736 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -24,8 +24,10 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		return -ENODEV;
 
 	gemfs = kern_mount(type);
-	if (IS_ERR(gemfs))
+	if (IS_ERR(gemfs)) {
+		put_filesystem(type);
 		return PTR_ERR(gemfs);
+	}
 
 	/*
 	 * Enable huge-pages for objects that are at least HPAGE_PMD_SIZE, most
-- 
2.22.0

