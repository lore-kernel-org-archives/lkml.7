Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20349C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E18206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1I9FQVpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCLNao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:30:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53234 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfCLNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id f65so2672699wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkmZtCxAXv8U4bmFuUH8w0vl9QQ6qjRD1Do4deqB7FI=;
        b=1I9FQVpi345Z6XDeK1iFU3ZDgPay1ZNZXi27w7ZiExyWt9WADoOtQxggZPfUNo3Z7x
         sITS2icIIAGZr91G1RAYm48qjKYNPPObsO/0I+q+mYjao8ZjjeiuFp2eNur/iscK9S9c
         duB/Qr2Ldw43ep5AgZHEGi67mDeg+SkAiKv0tESRkQ/7aHoKNFT6lZ2sKA1rsSL2gZTX
         nrBBs5Ge60HJLLS3CteynmrdgUq/yJOd5oHdt5LBM8orNGcUk3YRbSba0YFZMoy7CQY8
         UBvFugDUYUO359CmSYEmrkgTK7gEu0SEaHVFHZvH+9vpylLcycrJ7Qismki4TDjafw+j
         Gxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkmZtCxAXv8U4bmFuUH8w0vl9QQ6qjRD1Do4deqB7FI=;
        b=ZAB1VF11GdtOgk0pK0zBVEByPkIMmYDzO2wrDHDjEN9WDjnG3CF49f/rKA4gohnzJh
         J5yPWfq3Swku5x4Ja8TmsRFa8od1ijryvvPVjfC8/fCQcdnT4ka8V3H1DdgojiRC/Ayk
         i0iLDUxPA29TrS+9hifpqgWjVix376l+Voya+sOWM2eOlDQwUMJ7sX1Va+9oaKCJjPqo
         jvB3+5l1dg223BszPqX9VlyaD1pQwZpXxFh1/6soeqMEC0cv6LfBVL/aNkMhPVR54D9c
         Wtp92gFhJ6g0ScWhwM+pFIzPyD0IhZpCqeRkQE3nE4H9O3d16nZVyjywGXM4B0/CdIrp
         in/Q==
X-Gm-Message-State: APjAAAVDoAi+elDLy7CMVGfQPgIoMoStXeH8NUibqjGUkd08ryl2xWyZ
        TQV2kL/yPzzMeJ6nHlAcT1ZKrCGZPpQ=
X-Google-Smtp-Source: APXvYqyMow/IONAp1aqj050CqHZTgabBw4V64qrNTJq5YrZH0k6SHD0i1j0H4MwKIc/lUYu2Y5R8mQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr2578417wme.115.1552397442297;
        Tue, 12 Mar 2019 06:30:42 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-27-140.w90-86.abo.wanadoo.fr. [90.86.252.140])
        by smtp.gmail.com with ESMTPSA id a24sm3355837wmm.1.2019.03.12.06.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] um: remove unused variable
Date:   Tue, 12 Mar 2019 14:30:37 +0100
Message-Id: <20190312133037.5665-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
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
2.20.1

