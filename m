Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C834AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588621871
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDPYw9l9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfGYGz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:55:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34153 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:55:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so26460427lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=doVdfLdY6XR9A+JEkzRw69+rd1qNFdcI8alLf1BeFMQ=;
        b=DDPYw9l99zR1XZovJFSnt522upDwMi7JmL2qDbhfn+7et68QwVQZJLIisvrA9CuFtd
         YUc7N7+BmYU8vlZBsSpYRTX/R5xKbz3/yZufAfT8sup6l4SFUv0xXM70BDBB+5XQxf+d
         v6dVmOx6hIvnC8CdAjHX3B02aoGgEnAaPoADaLbyDBbKC311RTZa9DU76bmEcW4twGRA
         8yu3DmdSfBNKCqZbF0GF5NC4k5oVAWTilcRxRzP+jlVdDeh6X2NgSoIx3YI511mVmM2n
         oHJyE0tlcQWPfd3fu4EfjIL0nkb8SIGOzQYkj8SSsTJWM/wrCM5YZQoIkRlXg/eJVtf/
         76rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=doVdfLdY6XR9A+JEkzRw69+rd1qNFdcI8alLf1BeFMQ=;
        b=m4JpJf7m1+iC98c2wgVYsoF1fKfRNhXNBh0SQXuGSrYfux5o4GxCp0Py1xbkCxU4cr
         ywrEkzE9KbbEweo2A9CRFSXBk50bY3b8dbZzUKrlWVVZfeTORxPG6KhwnG++oUT5KWF9
         EZjWUOHdD8DC/WJkUOOx/WQi8NiVBCMF+eFgEQ6W4QP94XrVEnIZWKyyxhlS54XEX7Cj
         AjKQaDW/sbIJimknkVkqeEwTGLQiHMq/2bXvUttMx+Mz0IMv03eDh086t7MLajDR1NEE
         uS82Y68GC024tKNKb4eVjY7RnZDRll3URooM3iODL8Bq8B4lj8k4KTo/Y3awgqirAhB5
         auQg==
X-Gm-Message-State: APjAAAWO5F5XGpSg9FPCPuXvMkI2Yb0OSJmTrEEQZ06WvLGO0jaNzzix
        svwoqchpBE7CHr8MNEKstKQ=
X-Google-Smtp-Source: APXvYqyQnGvQ1MwPeI1rcV0plex7dRzADD6Oyh8xIaY5SLhveif2UR6Fm/R6nnTcgkfiO9oVM1itwQ==
X-Received: by 2002:a19:5e10:: with SMTP id s16mr39369443lfb.13.1564037726108;
        Wed, 24 Jul 2019 23:55:26 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.198.246.10])
        by smtp.gmail.com with ESMTPSA id o3sm7424291lfb.40.2019.07.24.23.55.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 23:55:25 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: max77843: Add IRQ_ONESHOT mask
Date:   Thu, 25 Jul 2019 08:55:15 +0200
Message-Id: <20190725065515.8220-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not fire irq again until thread done
This issue was found by code inspection
Coccicheck irqf_oneshot.cocci

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/extcon/extcon-max77843.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index a343a6ef3506..42b14c333b1c 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -905,7 +905,8 @@ static int max77843_muic_probe(struct platform_device *pdev)
 		muic_irq->virq = virq;
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
-				max77843_muic_irq_handler, IRQF_NO_SUSPEND,
+				max77843_muic_irq_handler,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
-- 
2.17.1

