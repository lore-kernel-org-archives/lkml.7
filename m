Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2752084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EUtlKO63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDKJtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:49:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35787 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:49:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so6469566wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xe3zmOtQX79CwAOJYMJZBdjtOgtgwy/PDbrk/AW3QHA=;
        b=EUtlKO63GfGO67aOehAec8SmGd/nk3JLaWunxIeLqrs03R2drBMWkLb1pOegpiQqGT
         eyNXOAMg4Z2/6mFQHW1OG9LhxmAJYcB9scdJzEOjDeQC5OB+ETTl657UxPuM7MJz3553
         hZejMWqQ02gpnX46/xky2+RTeJE3/fGdve6+iT9Rsy8sLqVFAgpnaiog2ahF34ICcz1+
         MHzskzz1NlBZFNR1q79R3cdbCyyMmleA3A1xGR9BZHP9XhJrJtiPNJe1CYlTfUD4epjm
         jiZqcHtkI+udR8QLmigJ914twXcdH97S6iUmVGZzMM96gp44GdQ4Zd/Y+zy+j1BoSu4J
         OhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xe3zmOtQX79CwAOJYMJZBdjtOgtgwy/PDbrk/AW3QHA=;
        b=G32OhqFOQcQPsLDfXxM1S5cXt6svFkdll8yNz0O87yQv/SIpYHgdAms2YHjnrH/M95
         Q9S0udCR2oWfj441GWsfeIYui7MN3uSnA1RZW5L11wyTO/hdQDL4ixSnI349ofKMaHTf
         N2sHI9uV54K5eUmt7oyPad0nVGkMh+aae9RpL8Vv2uHCjwhqIMJuSdDfSqY0bGeXNE6y
         qcuA6ype8zKPoXpYfcogsCcZ16i8dtIlLxyd3ln29/y3sk/mXrNsW0k3M1qH5CSYZvYl
         R4QZQ6FSt/KWgGf+Dij8hvC9lrwR7EWqhET4KkjZvAh+D7T9Tc+KMCfpzBeYKn0wMZCg
         nzww==
X-Gm-Message-State: APjAAAW6zxYtfhsmrsXLF2Jyt21cM0Es38gbXN9PcTx82CxDw7lX6u4u
        2dU7SPjy6rJUZC9MG5WHiF3Iwg==
X-Google-Smtp-Source: APXvYqwumXD8ejWGGa6gXojFGDwIV6EOoGJqjUJHNLy9yffPzWFblPtKyobOwFTiAttBQcod6p17IQ==
X-Received: by 2002:a5d:6b10:: with SMTP id v16mr32563689wrw.294.1554976188382;
        Thu, 11 Apr 2019 02:49:48 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm6434066wmh.0.2019.04.11.02.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:49:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 1/4] um: remove unused variable
Date:   Thu, 11 Apr 2019 11:49:41 +0200
Message-Id: <20190411094944.12245-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The buf variable is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
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

