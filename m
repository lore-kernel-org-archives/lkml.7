Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12BCC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A431520879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5hzPWG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfEMNoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:44:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39751 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfEMNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:44:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so6523744plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmS1tHJZuu1TzBbhnzD6ESGOsCR6ApPpfTs/I1lOhUY=;
        b=D5hzPWG6gtCd0TMFcL+cgKdSZm0s3l4fWz8loMtKRxjuhvmhXs9bxiwu2cFEEpRuRN
         +HrmDtqBudGQeIwXdHJiN6WAVYlyMLk9RdYL2TK4LeYQw6Grtn7nMVoz2DHPW+uB/Jj+
         zT2Gz2Cs8Mj0+KwHadXJ9DgqeoQJyLaYElrB9xyZiN6i21GOKBK3psU8JAM/K4290UQy
         CPXVf+4jgS9UixHWfwoOPFevF4zBKsf82FBrlYYCnGR69vTCyvAD918uBAPXNeCeBaBa
         cIK0VZKjnrVq8GBKrhrpo4kN9UoVt6nbVG5OsN3U7sbL6PVDqMEgQxhzFZEc/ELQd8oK
         v5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmS1tHJZuu1TzBbhnzD6ESGOsCR6ApPpfTs/I1lOhUY=;
        b=Nq+gXcUtcFdav3PrFPnMHhKj4u/S6Omy4fkNnMW8HdtNPmTrHYm2MhKGaYz0ULqFZ5
         FJbPfSdFI6X6qCvC7ML82UknJoO8DdtQAjuO7PH/aUpJZSFem0BQXKJhV9Z33jtDzfNK
         7f3Q/0v1epXLM5jZW1Dxhqmb2Q42XbvWguA6UsKpL/DXEbfJ+DDIXVc4Hc3GvAZoLz2r
         kRk3/RpwBTAKA97BA05Kmi1Ibln16Vf7qIJql1OOKkcT9Tk0drlLL10yBEsKMiE0GcV9
         dI3+3DCgcY3ye7hbEmhJUhwlZUA+a+Y5lmRs55ngXyfaWXJKzEQpA42NV6XLUP2A+0WC
         9k0w==
X-Gm-Message-State: APjAAAWH0fwaIoUeIbOecLYxtL3AF8QDcAyTRyjPLdH7n/4QAm8+qZZB
        8ou3WvKDyUIzJU1AwioSz2A=
X-Google-Smtp-Source: APXvYqxyxzhUjqIhmL52JnWQuGs9wpsgd3PD7MTpjvxbqgt+3ubDZ4fb6ZOa0zYZyzBmiQHyvc5jxg==
X-Received: by 2002:a17:902:7082:: with SMTP id z2mr8052506plk.176.1557755044642;
        Mon, 13 May 2019 06:44:04 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id e10sm10874261pfm.137.2019.05.13.06.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 06:44:04 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v4 5/8] Staging: kpc2000: kpc_dma: Resolve checkpath errors Macros in paranthesis & trailing statements on next line.
Date:   Mon, 13 May 2019 19:13:24 +0530
Message-Id: <20190513134327.26320-5-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513134327.26320-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513134327.26320-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below errors reported by checkpath
ERROR: Macros with complex values should be enclosed in parentheses
CHECK: Prefer using the BIT macro
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
v2 - split changes to multiple patches
v3 - edit commit message, subject line
v4 - edit commit message

 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index 0b8dcf046136..e996ced77bd6 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -14,7 +14,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@daktronics.com");
 
 #define KPC_DMA_CHAR_MAJOR    UNNAMED_MAJOR
-#define KPC_DMA_NUM_MINORS    1 << MINORBITS
+#define KPC_DMA_NUM_MINORS    BIT(MINORBITS)
 static DEFINE_MUTEX(kpc_dma_mtx);
 static int assigned_major_num;
 static LIST_HEAD(kpc_dma_list);
@@ -55,9 +55,11 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 {
 	struct kpc_dma_device *ldev;
 	struct platform_device *pldev = to_platform_device(dev);
-	if (!pldev) return 0;
+	if (!pldev)
+		return 0;
 	ldev = platform_get_drvdata(pldev);
-	if (!ldev) return 0;
+	if (!ldev)
+		return 0;
 
 	return scnprintf(buf, PAGE_SIZE,
 		"EngineControlStatus      = 0x%08x\n"
-- 
2.17.1

