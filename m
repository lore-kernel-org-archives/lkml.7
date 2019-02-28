Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6472BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C0B218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNz0WOYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfB1Irl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:47:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34461 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbfB1Iqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so20978751wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bKeIQCMhOcpvOKCIwPrJtwWUZ+z6GJCv8Q37k5zG6FQ=;
        b=GNz0WOYOmdBFtOebyIrYmHsLk6PAtTJ1eaG6SkrkWDdZ3cYo0YrALf5aelmhdewKH3
         nWMd9EUnP0/PKDkljQoElw9SaaYOgycO92ZAOC8hrxszLrYsAAwtt0HgQ5zvLetJIBg6
         Ni7VnGhSYsmKTAeW8fJDpm51F1Ne57WFxcA6al9hAkB5SdG7wfr0Azi78eI4R8DQqhZN
         afruSlmeqCQcMHXUbXVzuXctK9iLL6LSBUy5EtQupIFfmgTTpEzh7gwCOjTbNoHzghrq
         7McUploYzNGR31JlK6TzmJuK+E9q5m3Pv414JgZCpKOiYoA2J+JDo4QnRt7HFtK1o0z6
         wKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bKeIQCMhOcpvOKCIwPrJtwWUZ+z6GJCv8Q37k5zG6FQ=;
        b=kQIMAg6fAJIePeMIzTiNNlXpg1aAn7MpZkIlB1rmUr+dazlEUSnHHEmn+ZDEgzEjqa
         XNlpwrEiOy28kLn1sNe6jBvQXeWgFEz5aVWMyLtN5JPflqkThhCKj4AXsNC1dGwBO88h
         TPc2VrJrH8Su5W68Ca5tMtveFL15P6zdeHAw6E+RQnj48F7lSU4BXXRYP7pqD3wXhXNl
         //lgxDQEOww7tgiMCQKlpymQ8SKWplgDTBxwlGEgLKQrW2YIKHrmo/pj0szlwk8lgC1s
         K6aYg+BF7Ian1ttmvakLUcWZa/Bs27PHdIrTZLrQRBFURpBzWatyvF6zjl8qzuLb9v8M
         W/lA==
X-Gm-Message-State: APjAAAUPZ7FLRThfqS+8dLIPrV7hy016I2PYgbs0pys4Oz2DWTPT4c1j
        YS2rdhkxKxYpkEJ4owA2sAc=
X-Google-Smtp-Source: APXvYqwttk/Jd9l1AuNIVREqgAaIC62Qtr8JhKlsbkduB8P7aIYZI8lJZ7wgCaeyswLsxdQy2eJzeQ==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr5700824wrq.17.1551343598865;
        Thu, 28 Feb 2019 00:46:38 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:38 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] habanalabs: fix mmu cache registers init
Date:   Thu, 28 Feb 2019 10:46:13 +0200
Message-Id: <20190228084624.25288-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix an incorrect initialization of the MMU cache registers. The
shift operation was done in the wrong direction.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5780041abe32..5444cd0824b4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2675,8 +2675,9 @@ static int goya_mmu_init(struct hl_device *hdev)
 	goya->hw_cap_initialized |= HW_CAP_MMU;
 
 	/* init MMU cache manage page */
-	WREG32(mmSTLB_CACHE_INV_BASE_39_8, MMU_CACHE_MNG_ADDR >> 8);
-	WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR << 40);
+	WREG32(mmSTLB_CACHE_INV_BASE_39_8,
+				lower_32_bits(MMU_CACHE_MNG_ADDR >> 8));
+	WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR >> 40);
 
 	/* Remove follower feature due to performance bug */
 	WREG32_AND(mmSTLB_STLB_FEATURE_EN,
-- 
2.17.1

