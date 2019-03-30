Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E89C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA412184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfC3Sqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:46:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40703 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfC3Sqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:46:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so6538380wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mgzR/UO00hrwzwegx+/3pOLuebweelH9rTXvJw1XzrI=;
        b=johq95jiGzHPYLHr+u/ADyvJBgUdeTYyVehGI/tQo6d3iORVvtjsmyBzcWIQAYvLKY
         ujh7MZFV5bvCdAWb6zZduXFVknAr22Xva+IyFeClCxygEXbfPRAT5Adb0GZotgsDqzs+
         b8AJka8XjphJ7qSZTHsfhD+yGU5PExml/TzRephkPWXb+FpoxRhFN1JJ56jgnk/4fhTO
         YM7vXcHrLKyc+RU0XOg8GCz8xkRUuea3na5tvzoVdAitGoeSOvY2WVL51FTqgfxjwTNX
         hTl5fZQHBa0wuuuJpzZMSCC2flzl3bTxR4xnFIld/+xFAYGFROhbqlShb3h3v3SPOr01
         TzhA==
X-Gm-Message-State: APjAAAUrO7HHs8q53XrlDupwAOujuM7jSWLptd8toCeEawO2ATEfQ0SL
        QztCpC4aKKcnmERPSuwo18kmng==
X-Google-Smtp-Source: APXvYqxqzdBoUCZg9KlDWnsuJ4JrJaJeN6c2yioqoS2zfm+AfUd/9gvLE+k3ws9nn8EPPnnkhG+5pw==
X-Received: by 2002:a1c:7e51:: with SMTP id z78mr7543481wmc.82.1553971600253;
        Sat, 30 Mar 2019 11:46:40 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id t15sm9363203wmt.2.2019.03.30.11.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:46:39 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] arm64/vdso: don't leak kernel addresses
Date:   Sat, 30 Mar 2019 19:46:38 +0100
Message-Id: <20190330184638.16219-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
two obfuscated kernel pointer are printed at every boot:

    vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))

Remove the addresses from the print, which turns into a more discrete:

    vdso: 2 pages (1 code, 1 data)

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kernel/vdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2d419006ad43..fdfee0ef5bc5 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -146,8 +146,8 @@ static int __init vdso_init(void)
 	}
 
 	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
-	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
-		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
+	pr_info("vdso: %ld pages (%ld code, %ld data)\n",
+		vdso_pages + 1, vdso_pages, 1L);
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
 	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),
-- 
2.19.1

