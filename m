Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E0DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5032C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD64EKNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfCGW0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:26:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35956 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:26:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so14839849eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUJgMnuKuf55+FYpU2WmLf4w+CdzngJ4XWM3G1QEr5A=;
        b=hD64EKNJsp1TMp3aDJlV0VDJEqllqIfA7l3sJHLpru8SNfVDdPYhC4UO+H+kIsR4E1
         tNmd8YPT30rKASkzFKiHnif5eO25ffu84s1vZQd6lkIlt7jRzVQvOdjiSI/r6V/Yj8DE
         h5ZYSbExYmw53cC42jnRk13l/m9pj8LEUqQO3/j9jqZV2PZ40zcj5hBamiIuFG3zwhAT
         38mp+N8WyhOZHV4OE0Unwk++HtdCtoAIIauDOYYED7jPRdmgcmhbsQSLR1fN1QHeHA35
         Z6lRDW7PscL9dY9Gcij9X0JvxQaM33Bx5qRphQIX2dJoShZPv9MipjZlmJRaVkGBTEca
         fUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUJgMnuKuf55+FYpU2WmLf4w+CdzngJ4XWM3G1QEr5A=;
        b=Mop6H16G9gayyE12Ihk/hjqHr2/zRUsyXvaQyazQEG1ahxXmkApBd2oN5jro7j8dZo
         D4uSM2PkXxndSuHCig5c19KKFS0AiqesWZRD+swkaggFySaI1BlkQ7dLx1Enruwi7uda
         alTgIwFvBp7Lzi9VVlOfrg8MHu1P6Sfekj5njT/oYCSEFDb7SHysEGBK9+ZZcFl+qXmR
         9fVWLcACbzsmUmglkOXbgYkiPOVf+ZKpAk364fn4qQQSlx5Khu8kTJvPuhuvcqCCROSN
         tDDAvb2V+C/3yuTrrPd0RsdBIRIZqLfLv2UlFqkgBshiPqVoMOaSW3Wg84owE6LYKwBY
         oL0g==
X-Gm-Message-State: APjAAAWhSf48lgRebtZV2OfqIwmKvCC8sxatkLhSdB++UWecmeX1DKqJ
        kv1wfI/hr1zigZiMtHCH0dg=
X-Google-Smtp-Source: APXvYqzclbHsjnrsA0Fl6OVwMXJ949Y/jZbNuErHaWod9+HLYsk+/O1dajKPW7s48h2fl9q7XO+FPA==
X-Received: by 2002:a17:906:4bc8:: with SMTP id x8mr9294133ejv.114.1551997580995;
        Thu, 07 Mar 2019 14:26:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id n25sm1668242edd.83.2019.03.07.14.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:26:20 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/vmwgfx: Zero initialize handle in vmw_execbuf_process
Date:   Thu,  7 Mar 2019 15:26:11 -0700
Message-Id: <20190307222611.18100-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:3964:7: warning: variable
'handle' is used uninitialized whenever '?:' condition is false
[-Wsometimes-uninitialized]

It's not wrong; however, in practice, this is never an issue because
the value of handle isn't used when user_fence_rep is NULL because
vmw_execbuf_copy_fence_user returns immediately when that is the case.
Just zero initialize this variable so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/397
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 88b8178d4687..4ba06c2828a1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -3829,7 +3829,7 @@ int vmw_execbuf_process(struct drm_file *file_priv,
 	struct vmw_sw_context *sw_context = &dev_priv->ctx;
 	struct vmw_fence_obj *fence = NULL;
 	struct vmw_cmdbuf_header *header;
-	uint32_t handle;
+	uint32_t handle = 0;
 	int ret;
 	int32_t out_fence_fd = -1;
 	struct sync_file *sync_file = NULL;
-- 
2.21.0

