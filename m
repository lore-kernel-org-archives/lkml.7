Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D53C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C503E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="IVn8QXuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfDCIjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39555 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so7068086wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cicV3hBh19tUbYBIe5kwR/IZ4WJNH7yyI3S3DjJXRCs=;
        b=IVn8QXuBJycYTBeyhSovx5KnZwCOoEX5/NaDWk0A8E1MDhVQR63NLkSfIzEkDun2nq
         KOKIJP3ZQoxYORmj2HgQUgB9qwzvQECrYAxkoCOadKwjDp3/xO4DR1NkGpTOKW0ZpF7f
         Co2kbJDfSZaWM2j7iCrTzWJtBYP1eG+ABmLEYTtgl9//929N6QJeuDf3LR8zjoT7NTOc
         +H2jyOihTFOsRov/A0VSCktqGPpzfQmVqyE6deCh8PdNdUfeZxrGLXPW2/VmBRr7fGQ+
         UqV8J6XiB7ocQ5evKzbnZjXUboQsZAg8wWo+VvSsK+arJRupUMiZT4vAlV/2v7ovaMo1
         h82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cicV3hBh19tUbYBIe5kwR/IZ4WJNH7yyI3S3DjJXRCs=;
        b=gfKKEcK4nV5mbIzjYsvHLL1msVVArTmFeWQ8QlxxutJ8WlfmXd6XGoxsEfgtMaxiIU
         Z+ybHslL1XJik6RHIaYfteaA+8VB8E8HmJfKiz7983Gh3UHCgMCr18EXoloMxcz5ULy8
         9iHaJrKIItpYqqEEa8JNgW2/TCllvgDeks+LM3+zatIkkV0EbRZ9eRejKK01QNeA1L7w
         R0HGhy7tFwyG32gSiybkBhUF9m98bRHxpeUaRB37bKny5wiRqyi5H6I2PWVfGQXbujSf
         JBPXI8rBKcYT0tA3pXNRevY+IfKGTendU4nC0Dxt8eASCWA+hIP6GLwaZ9q9XYfe5QyE
         /CzQ==
X-Gm-Message-State: APjAAAXIfNDnUN7uhV7Z6zk2ZGdyxTtpLm1xmXhLKO4kHGC/Z3sDCEEA
        6v9/853qQekT8FamID1n2gAnnuzKiGo=
X-Google-Smtp-Source: APXvYqxi/HydeFY27AIEFk/jwyA6ubDjgsnq2SWwnEFMrOkCKfnc4l71AeznvBjWAKo7kVeUtSN3sQ==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr1187165wmh.127.1554280749296;
        Wed, 03 Apr 2019 01:39:09 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v192sm23655771wme.24.2019.04.03.01.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:39:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 1/4] um: remove unused variable
Date:   Wed,  3 Apr 2019 10:38:59 +0200
Message-Id: <20190403083902.3975-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403083902.3975-1-brgl@bgdev.pl>
References: <20190403083902.3975-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The buf variable is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/um/kernel/skas/uaccess.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 7f06fdbc7ee1..bd3cb694322c 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -59,7 +59,6 @@ static pte_t *maybe_map(unsigned long virt, int is_write)
 static int do_op_one_page(unsigned long addr, int len, int is_write,
 		 int (*op)(unsigned long addr, int len, void *arg), void *arg)
 {
-	jmp_buf buf;
 	struct page *page;
 	pte_t *pte;
 	int n;
-- 
2.21.0

