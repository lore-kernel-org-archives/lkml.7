Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE819C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DE520830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOYnNsDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393496AbfJCRLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:11:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55608 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391824AbfJCRLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:11:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so2807158wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hR9NNmOdT5rcLSqoSR1KORhykwTT8D7K6IAvdiYy3eY=;
        b=QOYnNsDv1gwHX85of27SNOuKONUoPfvQQVqfYJXpU7xrtANp1JXm7xGADM1k3Rj39Y
         wuEN2+2O2C9I9LdjX2F7mBAyEVCIGHm6Al93ev4WyxORN1ftWok0/BHnDXFQHll7PeQW
         57RmpTRhynLJQ9lNlZqwsMBzCsQL7Dso5s0kzp+ULgpB/k/lAjcIpucQqATRQsIMfQ1c
         WHEhHVw1Dovos6057W/7VftABpYCbqQ50TSG+rOZX/hcpDK9MxdR7TnnNkpx0YCi9R8e
         Ck6HmcUhdjcqQ95uUvLZ+QT3T130Wdr9O4GRiGvKgxzTWZI1fQMlVMsjwipZV4n1BE2Z
         1Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hR9NNmOdT5rcLSqoSR1KORhykwTT8D7K6IAvdiYy3eY=;
        b=hbeu3EXutnBy8QFLZc64kTw6FAkDkRTdp0b+NocAKy5TyuT/VsrA1T1dfTNoTIeJOg
         81oiZJdKiXtqoLMkwOQlV1Q9M+qeBfBCSk/1E5ZZXJViMsI24vS16iwV2R8clfksCEHp
         3Kba+8br7FdgjRrFt+Ay5s04vPlyWlzUG+Uxk6i61wLJ0YfWB2UwinjAIwnbax84KJbx
         q1f0F385KuP1qVkqPZLlh3ekz0GfhulkIo9wgCMffINuR4Hkp48yOeMSfuFNO7xgyVGO
         mrJKQcwV3WOJS5WIc2T/elhTVVDoH/itIRLtaRu7gdwl7gvAl3t7v39ADmt2q6bhDrLz
         4jQA==
X-Gm-Message-State: APjAAAVvER+esBZcLZv/MEHqzdFpNXRPmkyoqDqFa5ENyg7+/5n44b5D
        iZPECYOVCeAJ00UKBZEkCz4=
X-Google-Smtp-Source: APXvYqwzNl97/31p82hYFMmIP42XrnTxQ54nVpHrRq2BnlaXiNtiYe932Md3/2GqXlh2M/GZAlW6BQ==
X-Received: by 2002:a05:600c:2057:: with SMTP id p23mr7495542wmg.17.1570122699103;
        Thu, 03 Oct 2019 10:11:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id j1sm7067386wrg.24.2019.10.03.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:11:38 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] usercopy: Add parentheses around assignment in test_copy_struct_from_user
Date:   Thu,  3 Oct 2019 10:11:21 -0700
Message-Id: <20191003171121.2723619-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

lib/test_user_copy.c:96:10: warning: using the result of an assignment
as a condition without parentheses [-Wparentheses]
        if (ret |= test(umem_src == NULL, "kmalloc failed"))
            ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/test_user_copy.c:96:10: note: place parentheses around the
assignment to silence this warning
        if (ret |= test(umem_src == NULL, "kmalloc failed"))
                ^
            (                                              )
lib/test_user_copy.c:96:10: note: use '!=' to turn this compound
assignment into an inequality comparison
        if (ret |= test(umem_src == NULL, "kmalloc failed"))
                ^~
                !=

Add the parentheses as it suggests because this is intentional.

Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
Link: https://github.com/ClangBuiltLinux/linux/issues/731
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 lib/test_user_copy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 950ee88cd6ac..e365ace06538 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -93,11 +93,11 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	size_t ksize, usize;
 
 	umem_src = kmalloc(size, GFP_KERNEL);
-	if (ret |= test(umem_src == NULL, "kmalloc failed"))
+	if ((ret |= test(umem_src == NULL, "kmalloc failed")))
 		goto out_free;
 
 	expected = kmalloc(size, GFP_KERNEL);
-	if (ret |= test(expected == NULL, "kmalloc failed"))
+	if ((ret |= test(expected == NULL, "kmalloc failed")))
 		goto out_free;
 
 	/* Fill umem with a fixed byte pattern. */
-- 
2.23.0

