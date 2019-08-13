Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BFAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2956020663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1FmOmZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfHMRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:35:07 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:35349 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHMRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:35:06 -0400
Received: by mail-vk1-f202.google.com with SMTP id y187so5750303vkf.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K1Nopzn8E5w6xxPX8EZ7wQNhZHTJKAbpf6C6skqulkU=;
        b=K1FmOmZ5IMVR0BNedZOr4GB2zQvL7rVlDUbSzD6PtoQZc4ndAohnOijfpXxCoB2+uD
         CQdNgO9d0/lxTMSpPPmHDd3vHzNFCtkWdE0A+deyemOOXppbXGk5WKu7EcGrc3M93cbZ
         hbzg+X9j0lz6L7ng3X4HUUrsx4P7XMqW/jlBOIsu6fYPDMmSi26Oxx+iuavhC/FhYYlE
         VSuhxLOFHbto4Vwr/cLQcS3KRVsKeNo8oQPPQd434J7w5XH5W/tHytXlBnohOPZZPnCs
         1aSx1F4ToDKE9dvPrg+R+vXpfcW+cfHCzVO183GTDE/hGX6jFhtFXl4se/C1obt2hhE2
         LaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K1Nopzn8E5w6xxPX8EZ7wQNhZHTJKAbpf6C6skqulkU=;
        b=D9YRNrhTLtzuji61sDeKNsE1+n9MOUMq1suU+jkxEu8nsJD8nzKaJXZPDdnZTPjyGD
         vygX8wLraR5ANjizrudvZDPinwqVkQdTiG2JScMFGR5IzuueXZ4sXfdx3xYkLrAgKS8K
         90cB/NeGl/ImijZvwmCefT0K77ifrX0lwO4QPNrlrfGl8qAi4qWF8uML3K0fqmgk833H
         jVQwjLHDW0gcn2zuKbRp7nX5lr5sfmTOIO+aLfrZLjyRjMpmNoEDGM04eZ1WIknTTN0U
         i6inrfxXpLiKpY/P95Z6oCQHRe8w+ZpIO1I6Jj5EKxGN+j+YrFE/vUDQx0nBewtcAj33
         o0GA==
X-Gm-Message-State: APjAAAWxUBkkbeAr+61OlFWc+NwPRulexJBVjDhRywqIuSrtjhS1xKz1
        tumnbU+7+9Sz+NIVBfZbifXVe2a+2Q==
X-Google-Smtp-Source: APXvYqzyRnx0nhZiia/0rlGfB9FACFA33kMZkCzl4rJGb9jVVUrknMeViBeOVjEpzaMrOd+f0Ftj8pQCfA==
X-Received: by 2002:a1f:22d5:: with SMTP id i204mr8797732vki.90.1565717705476;
 Tue, 13 Aug 2019 10:35:05 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:34:48 -0700
In-Reply-To: <CAKwvOdkAJcOCGvveBYaDD2kf4vx7m=b+Nxyn3_n=9aCBapzDcw@mail.gmail.com>
Message-Id: <20190813173448.109859-1-nhuck@google.com>
Mime-Version: 1.0
References: <CAKwvOdkAJcOCGvveBYaDD2kf4vx7m=b+Nxyn3_n=9aCBapzDcw@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2] dmaengine: mv_xor_v2: Fix -Wshift-negative-value
From:   Nathan Huckleberry <nhuck@google.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/dma/mv_xor_v2.c:264:40: warning: shifting a negative signed value
	is undefined [-Wshift-negative-value]
        reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK <<
	MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
drivers/dma/mv_xor_v2.c:271:46: warning: shifting a negative signed value
	is undefined [-Wshift-negative-value]
        reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^

Upon further investigation MV_XOR_V2_DMA_IMSG_THRD_SHIFT and
MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT are both 0. Since shifting by 0 does
nothing, these variables can be removed.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/521
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/dma/mv_xor_v2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index fa5dab481203..e3850f04f676 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -33,7 +33,6 @@
 #define MV_XOR_V2_DMA_IMSG_CDAT_OFF			0x014
 #define MV_XOR_V2_DMA_IMSG_THRD_OFF			0x018
 #define   MV_XOR_V2_DMA_IMSG_THRD_MASK			0x7FFF
-#define   MV_XOR_V2_DMA_IMSG_THRD_SHIFT			0x0
 #define   MV_XOR_V2_DMA_IMSG_TIMER_EN			BIT(18)
 #define MV_XOR_V2_DMA_DESQ_AWATTR_OFF			0x01C
   /* Same flags as MV_XOR_V2_DMA_DESQ_ARATTR_OFF */
@@ -50,7 +49,6 @@
 #define MV_XOR_V2_DMA_DESQ_ADD_OFF			0x808
 #define MV_XOR_V2_DMA_IMSG_TMOT				0x810
 #define   MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK		0x1FFF
-#define   MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT		0
 
 /* XOR Global registers */
 #define MV_XOR_V2_GLOB_BW_CTRL				0x4
@@ -261,16 +259,15 @@ void mv_xor_v2_enable_imsg_thrd(struct mv_xor_v2_device *xor_dev)
 
 	/* Configure threshold of number of descriptors, and enable timer */
 	reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
-	reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
-	reg |= (MV_XOR_V2_DONE_IMSG_THRD << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
+	reg &= ~MV_XOR_V2_DMA_IMSG_THRD_MASK;
+	reg |= MV_XOR_V2_DONE_IMSG_THRD;
 	reg |= MV_XOR_V2_DMA_IMSG_TIMER_EN;
 	writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
 
 	/* Configure Timer Threshold */
 	reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
-	reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
-		MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
-	reg |= (MV_XOR_V2_TIMER_THRD << MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
+	reg &= ~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK;
+	reg |= MV_XOR_V2_TIMER_THRD;
 	writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
 }
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

