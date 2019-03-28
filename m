Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB132183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q06eU4nZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfC1XJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:09:49 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52079 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfC1XJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:09:48 -0400
Received: by mail-yb1-f201.google.com with SMTP id b137so40989yba.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w0KX0MrKI562oiJMkFTrJuBzCgg2x3LmcQQhqNCSwRU=;
        b=Q06eU4nZH+2gDYcrsSxwtvJ4k69KpNMAnnN+VjmVe7gr9acBrgDBxSfboLQYgpl9+j
         gO5yLvh5qk7g1PkHHLou2E7cG4hhYADxVDrXWZFBHw+7oxjElU9lS2nP3Jtpvn36ngv6
         0FRyf3iQimSJ1brzqP50nBdBeJUI17NYOnU+c4EW6LCEzZaRHtzER3wjYUlet0hum5fz
         6F9b8XQdAaKWg6/hOUshli9hqVprhZPbMGPKN0zuCmbn7sXXyIsRVZrM0C/vnygpHvun
         x9KkkXgy/sV0+aVtxtg18eXUpU6+Qgh4PnWmmpXecj4vI2t3VOhZigAhvDq3Yp4j6RUJ
         Mibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w0KX0MrKI562oiJMkFTrJuBzCgg2x3LmcQQhqNCSwRU=;
        b=neSpwwiIgwf99lY5uzZAxAoUjTHNJhXDKR9Ht8tUsXQG11wEnFECqq1JvH9CESzfkb
         BYMcwyNTOI2YJJfnHdU1BbNkz41qlWJrHp68FYUmnYNIFik12DaLTfrb9Tiytk/iZ9ba
         cNihbk2ss2QHK1dNBtrpnZ8bftbj00UHlJ+ZZNdhWR1ZVchMLIcRSeEQPEZvh1Aysu9u
         KYjEGICDhu4irHY/8GF1wB0gq9dqOiVzdviSE95LKH/H0ovKzLd6sfo53wOm4gZdI8v6
         Z18zWRFIqENLQMbQ0F6JjtfET8C8Iq9fejMFTss8PyYMjursYCpvf+F0eONMPkGa1os+
         tIvw==
X-Gm-Message-State: APjAAAXffHlnDMcU8UFMDsPEddMUAh9qPomtJmS1wHakCw+YSx8uKlJI
        vE5Ytfzjq8wI3ubyOt2HscS++vimYQ==
X-Google-Smtp-Source: APXvYqyYIwQCETtrnSGcNjl9AxrItndgcGnJ0rHF/2Wtx7aqv1E+QMeQp1clWO5gNI1vj+giZxnbc2C1pQ==
X-Received: by 2002:a81:3296:: with SMTP id y144mr3008466ywy.22.1553814588061;
 Thu, 28 Mar 2019 16:09:48 -0700 (PDT)
Date:   Fri, 29 Mar 2019 00:09:39 +0100
Message-Id: <20190328230939.15711-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] x86: define LOADED_MM_SWITCHING with pointer-sized number
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains that LOADED_MM_SWITCHING's definition casts an int to a
pointer:

arch/x86/mm/tlb.c:409:17: warning: non size-preserving integer to pointer
cast

Use a pointer-sized integer constant instead.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f4204bf377fc..90926e8dd1f8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -167,7 +167,7 @@ struct tlb_state {
 	 */
 	struct mm_struct *loaded_mm;
 
-#define LOADED_MM_SWITCHING ((struct mm_struct *)1)
+#define LOADED_MM_SWITCHING ((struct mm_struct *)1UL)
 
 	/* Last user mm for optimizing IBPB */
 	union {
-- 
2.21.0.392.gf8f6787159e-goog

