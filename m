Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD35C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693624687
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 00:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="k4Nwt35P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLSAgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 19:36:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35028 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLSAgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:36:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so2169467pfo.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 16:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=k4Nwt35P5Y6vpp5eWeg7ICwByB0EwQyyowsDLV+6ZjXccOSXxzH4VyQAMACbY+sydr
         zIs9Aeq3/V4oDQtaEhQ+NaOQbmBcBOxeuhQ7riNcsbvewq0M4nzTlDfm2cbySiYpdo/T
         fNwlUadrRPTWo5WIf8GgUTYzkrtucd1Al4vdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwvqhmbLPpvanCf4CYPj6H756JJZayFM0Q320MsSZZo=;
        b=QR9O4UYBRQtTDIfTYSTciUg3sEbrEtUrTMdQy7UdkLbnZZ6we0YCOqiJf8aMTu/u76
         hkolDZsC2lBGCMFUh4RBDCugLqj99QFujGwg0jO+g3wEOfu9Oe74JJXqHs9eACj4TAa+
         Cqbkx5cx2mmLDTm3tmqkmegb6wf9wYPz5aEu1fjqcWunkEqlMPkHFBzbJJlXB/Xi0WTD
         SV9wk1rREmN08eCvmp6C081ioPfinSMk/RdEJDqp6Zmwmhf37eNy11DZioqT/EWb7q+j
         dYMtn28QvhOFdx8U+bSrTarEEdBQgNDI283ZHbVKBHj7BKMaJrnSNNSowojAjqfR7W5I
         TeAg==
X-Gm-Message-State: APjAAAUxdJWZd0NSRymwq7pR2pCrj48MoC+HtKDfD/yLY6vuTVIndk43
        Zv0VFi/ODirtR4EHcjJVyno5YOvfleY=
X-Google-Smtp-Source: APXvYqzzS8EOpr5E7586Za1Qh1X/ZSa891rAEoUjLTYK149N03+CJ1w2Dzgoafjj0iCq1zJhp2OB0A==
X-Received: by 2002:a63:211f:: with SMTP id h31mr5808165pgh.299.1576715809809;
        Wed, 18 Dec 2019 16:36:49 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b05d-cbfe-b2ee-de17.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b05d:cbfe:b2ee:de17])
        by smtp.gmail.com with ESMTPSA id k12sm4636303pgm.65.2019.12.18.16.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:36:49 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v4 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Thu, 19 Dec 2019 11:36:29 +1100
Message-Id: <20191219003630.31288-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219003630.31288-1-dja@axtens.net>
References: <20191219003630.31288-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..36a4e1b10b2d 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,4 +2,4 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.20.1

