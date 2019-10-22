Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2EBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB9420684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20150623.gappssmtp.com header.i=@hazent-com.20150623.gappssmtp.com header.b="EMe+Ib7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbfJVITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:19:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32897 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbfJVITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:19:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so3117175wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDa3VnBT23L9dvMYIxsGdPSjONQzum8y5hGoC5q7sNA=;
        b=EMe+Ib7CMnddao0MTq/n4feJ1cOdAhbnKH4v/Ih316dUI5ksR8Ln3J58CBLkid9TTy
         +3kLvmgw3lGnYvoPL2yCxjrhKNAgXlSDGJZ7s8thbeWppNKhW+Yvv3LNDpIMRTVjCUI9
         a3NnopicdCmrLV4YzKLz4fd3YmORebKVFeimYbkK2hg5Jj7H2dnJ31KDxKXbfigk/aEx
         qwG0VlnHp8frquqAhjJ44xKFP+sk5d3SY+Lk2d21fGb5RwK2mMMjhYPV4zI7TfwjThbZ
         SdnxLP10dU7J/F9Ul0nFhYxYYUl0WWL29GcfQzv0y6Otefzn7RMY/TWS5aWih+YoDI1z
         ryuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDa3VnBT23L9dvMYIxsGdPSjONQzum8y5hGoC5q7sNA=;
        b=baVtGjtc3sEp/ci+VVNmf1PG9K+H2YlXXImgZ1/6wqzBRj7kFu9D4ueHzRXENPdO4X
         ZLR5zQKZb53jERCxYnkS9EG9KJ1J/QELyBRDxSMyn/tW22MTcZvBIG0oh+ThN/9BYNM3
         X2AXpla0wyUcNebVUwXAXjAmk1+ZhwTohBMCVGEUwmyfJxIuPXkAOR9+1T7f03RlkwGB
         rbKcBkOdUqaDnL6UcwFcoW+xetCtkNdSuQAjJKHunLP+oU+ozY7zqELI6mHO1mt4H6nI
         PtbS26eKy73fcIUsQZfv/bljIIlJhza9Qf1FFCXspnDMJw/9Y6N2rIMA5NEulJb9aN0u
         xXZA==
X-Gm-Message-State: APjAAAUyE9/XkcUZa2uQxf78Al4vhsG4BlJ6xHTtnhDaoco2KZYKl3yi
        mw9hBp6vtZPA1tykt9Jd6jYHYg==
X-Google-Smtp-Source: APXvYqypsdIq7EqYlwd4a8KcjxGdNyb1fAfBBGqiaA5OpcRH1d15bQzYxEYZ1Uq5QHplYObrwWr6hA==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr1939922wme.92.1571732384504;
        Tue, 22 Oct 2019 01:19:44 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id a71sm16308513wme.11.2019.10.22.01.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:19:43 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <monstr@monstr.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH] arch: microblaze: support for reserved-memory entries in DT
Date:   Tue, 22 Oct 2019 10:19:29 +0200
Message-Id: <20191022081929.10602-1-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 arch/microblaze/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index a015a951c8b7..928c5c2816e4 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/export.h>
+#include <linux/of_fdt.h>
+#include <linux/of.h>
 
 #include <asm/page.h>
 #include <asm/mmu_context.h>
@@ -188,6 +190,9 @@ void __init setup_memory(void)
 
 void __init mem_init(void)
 {
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+
 	high_memory = (void *)__va(memory_start + lowmem_size - 1);
 
 	/* this will put all memory onto the freelists */
-- 
2.23.0

