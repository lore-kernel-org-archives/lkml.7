Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA88EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C532C20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="KoLgJr45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfKPLle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:41:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfKPLl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:41:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so13779337wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 03:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pR9uF4o4qP6hFR154w2iCrTxAAAU4GSrRoZE0BDXvFQ=;
        b=KoLgJr45iUvuUFP8TUcfty8RAL6k9p+pxVTeRu0CK3/B+FuWPZ7Ji+eJqx4fwU7tnX
         EtJe16nR+SP/8v+X9BBIfv4DVMwXDchB+RJHaOLmQHzAdzYcrafzQE/1d+h5NPS8Yr+X
         b5PQjGDVCzlSGnbNdUwMFydHds3NhChT63JrJ09Cmna4IAbSetUllyuEkkcap5Bqu3K1
         BKo5bIywDxKm8ANqmf68954ShoMFYeE2fYTA/CDHFB2s1N+212xoL2+O9EOJmyQwfRsK
         6EC3cCdtQK+ndFIsxQxoPeif2ecx63IVkXFabXKFm7QNFnLSsUpCtrZBCUAaqt7NqzPc
         i4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pR9uF4o4qP6hFR154w2iCrTxAAAU4GSrRoZE0BDXvFQ=;
        b=BHNtntXLAmUeNLAHwYrhRRKT7kb89WA0HWoq5YS9QS9lVr5oKzcDNt5fWoDisp+pJe
         jNnwbYwRExGo07w5UaU6FSntzEqQXMwedhHUAYr7uLM4AufwmpV0ffllCMT+ScRf+7Wt
         Z+lO1+Mk2XxAbtwqEKExuxb6HTYLfwC0IWpwcmc7pfp1j+6UTwBasIfNGQHdGYvCL9Ve
         FdbEo6GIqHzNE/74tU8mvSf7yUbzlpbfGZWklz9fsqn5OpxVosABSMSzWhT8MgQB6hWY
         pVvwcl9hauGQuH0FeA+H9Igtbha2PUIskqm1kpLiVnjYZT/jJykUfbMAU0AXiymBw6DU
         UH7Q==
X-Gm-Message-State: APjAAAViJh5L/dRcwggs2Zsry97VFj8wBAdUd0yl1AlKD1mhMdm1+U5Z
        fdBT5dNr8/8FB/Xo26VRMQex4g==
X-Google-Smtp-Source: APXvYqxIRKSZXDaEs+mfuWkMVieq83A9iqb3TEeqg8cd1Gf9rkZniFg7DskPcHjGaipwsu2GaVFRsg==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr9687774wrq.40.1573904485051;
        Sat, 16 Nov 2019 03:41:25 -0800 (PST)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id x5sm12539189wmj.7.2019.11.16.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 03:41:24 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     adrian@lisas.de, akpm@linux-foundation.org, arnd@arndb.de,
        avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: [PATCH 2/3] clone.2: Check for MAP_FAILED not NULL on mmap()
Date:   Sat, 16 Nov 2019 12:41:13 +0100
Message-Id: <20191116114114.7066-2-christian@brauner.io>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116114114.7066-1-christian@brauner.io>
References: <20191116114114.7066-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

If mmap() fails it will return MAP_FAILED which according to the manpage
is (void *)-1 not NULL.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/clone.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/clone.2 b/man2/clone.2
index 57a9eaba7..faff2ada6 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -1628,7 +1628,7 @@ main(int argc, char *argv[])
 
     stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, \-1, 0);
-    if (stack == NULL)
+    if (stack == MAP_FAILED)
         errExit("mmap");
 
     stackTop = stack + STACK_SIZE;  /* Assume stack grows downward */
-- 
2.24.0

