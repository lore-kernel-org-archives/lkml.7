Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA671C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0CE2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEe0bJ+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfJLMb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:31:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43388 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfJLM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:29:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so5746362plj.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUVTcUa5b8bKD7FsmBN2tFeSI1tiWWw4BFpLw9k7yCs=;
        b=ZEe0bJ+1FUWHAd7hQeuzlNX/YuaFs6XETmII7Fd2roFyVU7ZxUZYSJZhvRfCSh+oHF
         r8e8KobZ2Zq4aJTgsCnVidrK+K/dMHb5sBZjt10nA6Q9jNReWqzoN5bfqw4nUYd7fxQA
         Y1zLqclmF7IIT8xZCXLaBwjHUzcAUQXayGM1/rlc58V1KcjSqPQrLVs45eA2ylNa6LCp
         YbrrnOQxWJIi5GLbiiv2MhgkrevEbQMHw0FwbzryLbL/cYAqRlLMGBF0JQ5jDsS7cs38
         Swn1LU0gK6Uywm6QOej3PSgbkqGk8NUU9DofCGqnR4mvK/O31ju8G/C9VulR78+z3ElB
         IGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUVTcUa5b8bKD7FsmBN2tFeSI1tiWWw4BFpLw9k7yCs=;
        b=RAPWfn/57+RSLcVw47/BNrgDi7YdZliZ8F1SUzwPWyWf9feTpstTAzan2/9XgbvrOX
         RIwDsW3B/ShzJRJh3wI3XIb3CH3Sx4kEFn2w0ZNSJ4q3PnsAyQZ8VX1UPEyUZu6NFSak
         jUJw46pNmrDNM0fPRCNdZrzpvYX2nUHw0D1Xrmh9j/yQUjLa8ACzmvnvSgYPPoRzU17F
         vu86abil+1IES8wK+MJFRvWA807SKyxJuLDeTY8NK/9Ua6qqndXUujixQDkTxx5Bj5hd
         Cn2EbjvnSn0qUye8wfxxVVptzBLn1Vu+XqYXa2B5lcV1dw8mp+qVcT2P+gaURsBUCAmQ
         iNXA==
X-Gm-Message-State: APjAAAUx/IIijaJ9BpF4cJMiquEoDXlHQtFFy4500+zVmUZbzyzR2u8P
        Jll5vE/Fk0of/547O2BzTxI=
X-Google-Smtp-Source: APXvYqyoYkM83GDHs5E3PNlXmZYrHsdzyiSKwuZ0dy6B4Pl7gdC+716gQxKin/hT8FITw6cUNd+2Dw==
X-Received: by 2002:a17:902:144:: with SMTP id 62mr20399568plb.100.1570883395203;
        Sat, 12 Oct 2019 05:29:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:95a:fd75:24a6:4bd:55a6:4f65])
        by smtp.gmail.com with ESMTPSA id v8sm33708697pje.6.2019.10.12.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 05:29:54 -0700 (PDT)
From:   Shyam Saini <mayhs11saini@gmail.com>
To:     kernel-hardening@lists.openwall.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shyam Saini <mayhs11saini@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
Date:   Sat, 12 Oct 2019 17:59:18 +0530
Message-Id: <20191012122918.8066-1-mayhs11saini@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This parameters are not changed after early boot.
By making them __ro_after_init will reduce any attack surface in the
kernel.

Link: https://lwn.net/Articles/676145/
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
---
 kernel/dma/contiguous.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..1b689b1303cd 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
-static phys_addr_t size_cmdline = -1;
-static phys_addr_t base_cmdline;
-static phys_addr_t limit_cmdline;
+static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static phys_addr_t __ro_after_init size_cmdline = -1;
+static phys_addr_t __ro_after_init base_cmdline;
+static phys_addr_t __ro_after_init limit_cmdline;
 
 static int __init early_cma(char *p)
 {
-- 
2.20.1

