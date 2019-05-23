Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A08C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84D52173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fs3cKvK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfEWCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:32:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40894 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:32:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id k24so4978556qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1BRoEDPELMK0Gyp9/s2p/rcYNsdRckdJGf7yGafkuk=;
        b=fs3cKvK0NKboTT76WS2fOatBli8xun3JE9RHPbc8Y7ra9i2bA9b+aNHPVgi2NOuEh9
         Sd5ZMaa4Iqwn3Y0zFXXwS/t9vhQ7qx3cqzUWZd6BtEVHeKeT/2YC8ACuc89T9bhYBlBN
         tAwI7GH7qRt/ANpVMLvKLfRpD27QtExgoc+e0V3JY4w5S1QSuTnhvAFsxpzZ6+ZmVE4J
         BUBbKREis/mvL9qmSOyoE+eKFb9VFUnaT2QHpkA9LuxeAYAX2w8eNE5f+G+deolb8+tt
         Hlbd1wFXYtOudAn3gYWzSAfpsEbdY+YIY9zLQx04JTViMMr+MJjbn2lIZC+kUWlObBTD
         Yvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1BRoEDPELMK0Gyp9/s2p/rcYNsdRckdJGf7yGafkuk=;
        b=Z+NeFk+DqIGjOjIRO6PnZ1SBtV5fttRSrDHdX0Y4POCriBf3IAylL0qUfzxmJ8jKWH
         ZZupE4t8zOy6ID1oKurO+ZYY4SMl/PaanTTP2qc8/MejSkk4H0Te9HWaXVSWFZ8jaGsh
         X35RjIVyILEtWmqTUacj9WmTRxa0uL2TaRT0shjQl/Rb8Ck95rbBT3DlvTwOfglFfeYt
         WtA6pO2yiReLzsiOhI8wKCu/fGTUfHGOZrz6VBc+oqAphxPa/XhmgPe6JPhyvsJHM3oL
         pwbSqZe3dIK/fFZ45X9RvmozQREZ3K9BywCJeyqhxOm3/FHxzTK8963fxra9/NAdr9Rb
         PHHw==
X-Gm-Message-State: APjAAAWXUHyKXv0igs0oyPCpYE0P5ZbovmQzUtumbZHKv64A05Z7xjwD
        qVllcLvI1kC61qyVTzr2oCtIag==
X-Google-Smtp-Source: APXvYqwXTOyP/ZR1b0OccJMZC/QtNGYrA/lcBr6HbpCaQNFLZZ1gWevztbjKZgn+0FbHLGRp5kaoRQ==
X-Received: by 2002:a0c:9228:: with SMTP id a37mr15950616qva.221.1558578756618;
        Wed, 22 May 2019 19:32:36 -0700 (PDT)
Received: from ovpn-121-0.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q66sm12891044qke.66.2019.05.22.19.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 19:32:35 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/powernv: fix variable "c" set but not used
Date:   Wed, 22 May 2019 22:31:41 -0400
Message-Id: <20190523023141.2973-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 58629c0dc349 ("powerpc/powernv/npu: Fault user page into the
hypervisor's pagetable") introduced a variable "c" to be used in
__get_user() and __get_user_nocheck() which need to stay as macros for
performance reasons, and "c" is not actually used in
pnv_npu2_handle_fault(),

arch/powerpc/platforms/powernv/npu-dma.c: In function 'pnv_npu2_handle_fault':
arch/powerpc/platforms/powernv/npu-dma.c:1122:7: warning: variable 'c'
set but not used [-Wunused-but-set-variable]

Fixed it by appending the __maybe_unused attribute, so compilers would
ignore it.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 495550432f3d..5bbe59573ee6 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1119,7 +1119,8 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 	int i, is_write;
 	struct page *page[1];
 	const char __user *u;
-	char c;
+	/* To silence a -Wunused-but-set-variable warning. */
+	char c __maybe_unused;
 
 	/* mmap_sem should be held so the struct_mm must be present */
 	struct mm_struct *mm = context->mm;
-- 
2.20.1 (Apple Git-117)

