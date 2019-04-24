Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987722175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhZXQcYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfDXKWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:22:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44747 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfDXKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id y12so6499327plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ETa+dFWNCZnNxwVqcCbdkTQv/b5T4kuYZin0xotChMQ=;
        b=qhZXQcYkMNsv8xuOtmo9utP8unEhA51+NsHInSOsCQIazmTUFnYncd5lPryfHab8w9
         fCBuUGfXB57kWC3kySqpZWWkGp5RJz5CWTRcxzBEYP37PuavbPv6gbhFvtFirshJompx
         mw9PcYQQWppU5X7dI5dpi91yEL1+8MaYaUHJQoh5pZX/qJdb1FYjYlvKRcgUPH6IL6qh
         DSwMzQXRsN42SKxSktXIuiAZtXONFAB4Q2CdwVcsQUn0g/KSqKJi0jAFfmwVCNaazUf8
         r/IZyRsPjcsXckYHXuplKMk8WhKRSzy0daCrRsGFliaMqkNlu8Chlv46HTwq41JoUj0k
         FVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ETa+dFWNCZnNxwVqcCbdkTQv/b5T4kuYZin0xotChMQ=;
        b=I7zvHA+cv4030PDnvYUw6C08YMyq+v7LLkeCpke3fYrk3xFWDo2NuHBlWbYfuMrqiI
         O49dcGl9G/4IwWXWBVX0bGLbBd7kk3i4YC46kHMw2lzJzk+xWSDVhEsuJfzqYtAbRwKS
         7bC3M5Gz7RIgDLuiMy1ejFtSCPVmm1ajen53e1rIFMKEB7yX3UeoIJ6qhhqRSG/m4Dxp
         TRaa9POUGDguvahF3Fsu0cMItOTG+2X7bgEmk+UKDsJyCrKvoxof+Sm7LPZn5hVqXU9h
         ygjxuF2U1Y1SfYzuO5PCgMTQGqnft91WWNljE+7THvsTpxhCM/reZLETTkfaCVXksCUn
         Ytpw==
X-Gm-Message-State: APjAAAWvERL5PDHgGHsKhit4sem8j/+HlMX/XWvpLlxYNyY0keccCH9O
        9hQzs5YemMdN6lSlNBKQUV8=
X-Google-Smtp-Source: APXvYqzffDOgwNO5iSsDnJMt9zWfm0cdr+5eSTYXdh599961qACbqpK76Zh5o5wAySyEA4zpYIR3KA==
X-Received: by 2002:a17:902:2ba6:: with SMTP id l35mr27019443plb.56.1556101278435;
        Wed, 24 Apr 2019 03:21:18 -0700 (PDT)
Received: from localhost.localdomain (ch.ptr162.ptrcloud.net. [153.122.97.60])
        by smtp.gmail.com with ESMTPSA id k9sm23310185pga.22.2019.04.24.03.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:17 -0700 (PDT)
From:   Weikang shi <swkhack@gmail.com>
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, swkhack <swkhack@gmail.com>
Subject: [PATCH] lkdtm: fix potential use after free
Date:   Wed, 24 Apr 2019 18:21:03 +0800
Message-Id: <20190424102103.11816-1-swkhack@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: swkhack <swkhack@gmail.com>

The function lkdtm_WRITE_AFTER_FREE calls kfree(base) to free the memory
of base. However, following kfree(base),
it write the memory which base point to via base[offset] = 0x0abcdef0. This may result in a
use-after-free bug. This patch moves kfree(base) after the write.

Signed-off-by: swkhack <swkhack@gmail.com>
---
 drivers/misc/lkdtm/heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 65026d7de..0b9141525 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -40,8 +40,8 @@ void lkdtm_WRITE_AFTER_FREE(void)
 	pr_info("Allocated memory %p-%p\n", base, &base[offset * 2]);
 	pr_info("Attempting bad write to freed memory at %p\n",
 		&base[offset]);
-	kfree(base);
 	base[offset] = 0x0abcdef0;
+	kfree(base);
 	/* Attempt to notice the overwrite. */
 	again = kmalloc(len, GFP_KERNEL);
 	kfree(again);
-- 
2.17.1

