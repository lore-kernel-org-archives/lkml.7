Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0584EC17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7C22077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl/KUg5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKJVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:55:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39496 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKJVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:55:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so974130wrp.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Ahm4sjelJizmUwrKM6BXNKd2J0fpN6qeUm7Wg6xd2s=;
        b=Nl/KUg5/l/wiPEaMql5yPDLTDVftpJEvxe1QOAQpKzUnucUyM6FpIDP3p0S82PGCWg
         pt+Pd3BpYr0mXTad0MQxSjfXoSOfTPKXy7GjEi61J2P1+F9PcsIkdMIR3/BKgO5Zq3Rf
         3L65Hx6Iv7wN7zYqahuAiRNS7SJZNVkX8vKQPX9QBAsX0hoeyqDKOg6/am8iGydkHPZe
         sOyxHeWD77Xk+Hqp0liYRE1faQmhCf4SOOZ16Z2l9nvWylWeJJ7Caw8qI4NRy6HndTzb
         t0cZ9r5gehx3K9vGa4w2EU5ODKJKsGEFPUOs93kshFGBUtKbU1BmevLMlEZA6tvpG6yb
         VbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Ahm4sjelJizmUwrKM6BXNKd2J0fpN6qeUm7Wg6xd2s=;
        b=jKip1CY1ZfmTrNqXtwTgDA1atiqsnWHUW0dLiaoYtQW28NXVoTWB+trwJOt4vHeZDj
         iesYoP7YxjmPtkmkyrOohpXvf5LZbBm1520Eo13QpQZWWWCoLR6LA0WXEdJc3/UCD8OC
         b/g3jDYhFvC83ZmIdi+uYK8O3ex284l+vQiWXS6U+jo/x/B9acNmc+hHxs+V85PDSEF2
         4pHzz7PD4BlyCAp6hhoR6FbBP7fUDd5AExN736ZIR3Rz6acKsj8e32DT8E6gg6x10boB
         xXLRvDanr2XMHWiRTi4YdYdYVwh6leasE+R89rbwu9XbqzhgLRMgJBKqViSdy9Y9J8VD
         h3qA==
X-Gm-Message-State: APjAAAUk9Nor0j0108NaHvKR4Y+xTCkmYuKzi+WrJCn2xfLUQbaFoMgU
        XEwR9FwSUAZ5EzIcqV79y4JhurYlBf0=
X-Google-Smtp-Source: APXvYqyTobWsNRI94CP2m6MHZCb3Oi2WDAfI1mClM4x6glNvmOpZmhkAm6CXbloAZZ7AusDsV18V3g==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr11636312wrs.191.1573422939110;
        Sun, 10 Nov 2019 13:55:39 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id d11sm14555824wrn.28.2019.11.10.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 13:55:38 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 4/6] habanalabs: increase max jobs number to 512
Date:   Sun, 10 Nov 2019 23:55:31 +0200
Message-Id: <20191110215533.754-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191110215533.754-1-oded.gabbay@gmail.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In training, there is a need for a large amount of patching to the recipe.
This results in many command buffers contains a lot of DMA packets. The
number of command buffers per CS is larger than the current maximum of 64,
which is an arbitrary number that is enough for inference, but it has no
real affect on the code and/or resources of the host machine.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 4ff2da859653..0813041f669a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -40,7 +40,7 @@
 
 #define HL_MAX_QUEUES			128
 
-#define HL_MAX_JOBS_PER_CS		64
+#define HL_MAX_JOBS_PER_CS		512
 
 /* MUST BE POWER OF 2 and larger than 1 */
 #define HL_MAX_PENDING_CS		64
-- 
2.17.1

