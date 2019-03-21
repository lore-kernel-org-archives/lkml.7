Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C3B218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="MBb34mTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfCUKUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:20:33 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:34200 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfCUKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:20:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id A045D27E04A8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:20:29 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JvcpK5qT283i for <linux-kernel@vger.kernel.org>;
        Thu, 21 Mar 2019 11:20:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 55E9D27E04A9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:20:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 55E9D27E04A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1553163629;
        bh=1PKu7m2ySLQ6dGkcX7EbvNjxXkfSKrK9SlKSQgok6M4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MBb34mTwT2NGzK6vc7iv7PQTN1hM1aULAib/vHmZLyZ5fOVwLZ30ThU5I48DIl8pK
         wH0FPLA4XMeFaxJVQalip4T837bdUEZWHcjTw5HK3fuQCZdQ9++7CkFY6nvV9MlWZs
         es8emSMH4aUMg+izb3poozb3bcvZnXxFO3dXP6WI=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wuGVQ2zbxVS7 for <linux-kernel@vger.kernel.org>;
        Thu, 21 Mar 2019 11:20:29 +0100 (CET)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 3624D27E04A8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:20:29 +0100 (CET)
Date:   Thu, 21 Mar 2019 11:20:29 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     linux-kernel@vger.kernel.org
Message-ID: <1741404498.4767335.1553163629182.JavaMail.zimbra@kalray.eu>
Subject: [PATCH] dma: select GENERIC_ALLOCATOR for DMA_REMAP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - GC71 (Linux)/8.8.11_GA_3787)
Thread-Index: NGPCvDoj7yFWRpAnvrjujfr+mHAQTQ==
Thread-Topic: select GENERIC_ALLOCATOR for DMA_REMAP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DMA_REMAP is enabled, code in remap.c needs generic allocator.
It currently worked since few architectures uses it (arm64, csky) and
they both select GENERIC_ALLOCATOR.

Signed-off-by: Clement Leger <clement.leger@kalray.eu>
---
 kernel/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index a06ba3013b3b..6a43c4ae77f9 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -58,6 +58,7 @@ config SWIOTLB
 config DMA_REMAP
 	depends on MMU
 	bool
+	select GENERIC_ALLOCATOR
 
 config DMA_DIRECT_REMAP
 	bool
-- 
2.15.0.276.g89ea799

