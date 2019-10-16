Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C35AFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4211F20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvNQylRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393649AbfJPQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:18:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40330 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJPQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:18:40 -0400
Received: by mail-yb1-f193.google.com with SMTP id s7so7993827ybq.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLHuUAI51zqpOoY4mLBl+fp0NibSGRXA+wwSOeMW2Ic=;
        b=rvNQylRzWjq/sDxLXksL1A5D7OVt0fv1VWMAQUOp3axuwKdUIgf5tbL8gr0T4DKdi5
         ZFJrsYtCO847NNxoDTqX9vapUBRbPitGsZDOwONFhBaGiopmAN8nAI58Fcs7VIgtO2lm
         bYneVujpt3dX1gj8sQaZq8kY40rzC+NFypsPb3vvbnVoOAyV/QaqcQ7i/GXOytITeGE6
         knmd9xZ+nlgweNjb+LJnd1uOy1E6ICn8xqOuT3QyrwCun0YrwFI4IkP3rkG10JlRn8l9
         vKwsdmsOJTDO8CRqTnT/56MLs2Vxv9fktWaM4zvDSes/80088NJzk5eXs95AfAEu8Ryf
         ixLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLHuUAI51zqpOoY4mLBl+fp0NibSGRXA+wwSOeMW2Ic=;
        b=fppm1X3rquQw9qi4XGYomk/NDxSYVrXaBiOnjSV2JIixvf37x+FzjJSrQXEnyM44Ij
         NB2E8mtGgbYssgTmF83PGwYYS4OPSuJVDuSeNDJC/lO2OlSYyepfbUjbM1JsveZstWkz
         7Z+c3C8AIWv2X+8GOScoex8EIrg9eXXyTnys6cRWuyd3nLcDepWJ0D9Czb+4VItA+vqi
         oCcmdo/4Yshq7NMSeiWh+ZaRurfY3pJk53GiQinEMVBP1A76i5PjrERKlOTcmb0+XTzv
         aXnBwxIRBvQw33HyNQ3BKUiUoiiHu0Amtr0O3R0qsxBkcYbJsVyrPYwOP7t3yLUoKtPa
         /Cqg==
X-Gm-Message-State: APjAAAW8ZW93Xi6GR3mBi5DNHk9j83OXEPglIx7UnXeqCKxUfrNZ6moT
        U5eN9P4Qss0pPtjAxIyHO9M=
X-Google-Smtp-Source: APXvYqxUdwndWyzgAzuSdir0CRTy89OMPv/sP13h8hC81Pqrz64D/iPT34B8yMayZLpuiltGgdbJRw==
X-Received: by 2002:a25:3086:: with SMTP id w128mr29101340ybw.385.1571242719670;
        Wed, 16 Oct 2019 09:18:39 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id 5sm6037910ywb.73.2019.10.16.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:18:38 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] linux/bitopts.h: Add for_each_set_clump8 documentation
Date:   Wed, 16 Oct 2019 12:18:25 -0400
Message-Id: <20191016161825.301082-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document in kerneldoc form the for_each_set_clump8 macro.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 include/linux/bitops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index fb94a10f7853..76ec8f0ce3e8 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -40,6 +40,13 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
 
+/**
+ * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
+ * @start: bit offset to start search and to store the current iteration offset
+ * @clump: location to store copy of current 8-bit clump
+ * @bits: bitmap address to base the search on
+ * @size: bitmap size in number of bits
+ */
 #define for_each_set_clump8(start, clump, bits, size) \
 	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
 	     (start) < (size); \
-- 
2.23.0

