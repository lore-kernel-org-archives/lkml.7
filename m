Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919FFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612D120715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZzLpjE7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLWNcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:32:20 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:59833 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfLWNcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:32:19 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f2bb46f5;
        Mon, 23 Dec 2019 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mail; bh=mmYcYH4LHMbEDE4plGTi5YEIo
        M4=; b=ZzLpjE7U0SsNe56JmUu5gMqPyUB/KF/esW1Y6mi0V74n92J0SsHe6Ra0Z
        NV3N0Yute+5hFoRjc1irW89o83BeyxPb9ph830CkmtjJgi4lyKfC/UKfVveCHo6W
        c4g4PrZKrFye+HqTCvuTA7jAZf71BVN8WShgCvayOeGF/qMILKi6Pzh+E8UqCEvJ
        PluzOfT3kjHdSE97ADU3wSVqPDDmCnffPGn1ZUZQDvqEfRl4YcnkXxd2mvhZqD9H
        1P+44O5ZI8mKlLsd3MoPo+r8W93B0Brnj0IHyFf3co4XuLlE/b+1U9N4PKM7LCSS
        qghCpKAHmg/AphSeJs/Ln/FlAan/Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 12bd8740 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 23 Dec 2019 12:35:04 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     pauld@redhat.com, longman@redhat.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/shared: include correct header for static key
Date:   Mon, 23 Dec 2019 14:31:47 +0100
Message-Id: <20191223133147.129983-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the spinlock implementation grew a static key optimization,
but the jump_label.h header include was left out, leading to build
errors:

linux/arch/powerpc/include/asm/spinlock.h:44:7: error: implicit declaration of function ‘static_branch_unlikely’ [-Werror=implicit-function-declaration]
   44 |  if (!static_branch_unlikely(&shared_processor))

This commit adds the missing header.

Fixes: 656c21d6af5d ("powerpc/shared: Use static key to detect shared processor")
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/powerpc/include/asm/spinlock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 1b55fc08f853..860228e917dc 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -15,6 +15,7 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
+#include <linux/jump_label.h>
 #include <linux/irqflags.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
-- 
2.24.1

