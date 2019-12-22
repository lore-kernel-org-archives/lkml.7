Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C2C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D7720665
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 09:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVoapp3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfLVJ0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:26:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36520 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLVJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 04:26:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so13584432wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 01:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIitWunSyeLnMHtEeiGjmeyIPwUVMl1eIhxu+Sfy5hc=;
        b=oVoapp3EJ6Nidja1fo2Z8uXslQjYT3eUXevOEqCDO5PgOl+9fOOiwzobx1rJh1Zmea
         trsIqBu5tWK+83cG4BpennmZjuoZhCJ3k2HHWixxvuNLJNNFldgeAgmZLVn4rqfd9umq
         WqyPwLgd/VBCh+Vns+cT3lysddhCVkCvU3YuKZdlF5rKy6y7oVi9TvfQk7L4n0cECICk
         Bp7RPyijKWafJpEkMgZYGnKG1rs1RIv+pRnOEu28YozZ0fJUSvvY1Z6ZuR9Kl3RunMfy
         jVoYmm11hwry416wwWt57nLY2oDpwFCiQ3dIGCGqfV8a7GLaSvyFEuljJMXQN92uzC8o
         K3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIitWunSyeLnMHtEeiGjmeyIPwUVMl1eIhxu+Sfy5hc=;
        b=m5VHNB/yVcRsFkoHF/eu5ZZaCxNvJHmSxTyYilHoZnGn/zW2GROwr5qWIqTjXnfKG8
         l2anM2sneVcAokkuWVnnAfkJWmcGtVYQ9bojffVnDCnGAl3QDEZ0QiurNm+4t9ib08k+
         FcgV3H6uMaoukXBvJNOFWq5c+ifszlCZw1lTpQX82M3kO+tFwvSg8XyRssoDQo0dWVt3
         Cv3EJb+NJI9RzYReN7bEe5KmqeN6nDcyC+4y7jgMFKNdz1WM6jOQWEy30a29pwhwN6me
         RUvrFupWTdd5ZHDF9g2Svq4OHP5AJvbNEAwS8xfDdiUHZSyyGx2tX56C/ekACmRlYZpf
         T0tA==
X-Gm-Message-State: APjAAAUc7by+g8q9MUkOVxckYNenR+WNqxC8nbLXE5ExpZV77xqaXHEo
        GLlgX1cKa79D3N3I9YWP2ou4vpda
X-Google-Smtp-Source: APXvYqx8WI8Dl7wc0dw2T0b0O/LScVz7TvfFgr+xY+c89yZJ60OKlIBw6cXDKGyBc3rXZBEJcJaxcQ==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr25575258wrv.0.1577006773068;
        Sun, 22 Dec 2019 01:26:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40f6:4600:2964:178a:86d6:5be5])
        by smtp.gmail.com with ESMTPSA id 18sm8009947wmf.1.2019.12.22.01.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 01:26:12 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] riscv: fix compile failure with EXPORT_SYMBOL() & !MMU
Date:   Sun, 22 Dec 2019 10:26:04 +0100
Message-Id: <20191222092604.92217-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When support for !MMU was added, the declaration of
__asm_copy_to_user() & __asm_copy_from_user() were #ifdefed
out hence their EXPORT_SYMBOL() give an error message like:
  .../riscv_ksyms.c:13:15: error: '__asm_copy_to_user' undeclared here
  .../riscv_ksyms.c:14:15: error: '__asm_copy_from_user' undeclared here

Since these symbols are not defined with !MMU it's wrong to export them.
Same for __clear_user() (even though this one is also declared in
include/asm-generic/uaccess.h and thus doesn't give an error message).

Fix this by doing the EXPORT_SYMBOL() directly where these symbols
are defined: inside lib/uaccess.S itself.

Fixes 6bd33e1ece528f67646db33bf97406b747dafda0
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---

Note: this is only compile tested, not link tested, because the 
      config given in the bot's report gives me several other
      unrelared failure.

 arch/riscv/kernel/riscv_ksyms.c | 3 ---
 arch/riscv/lib/uaccess.S        | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index 4800cf703186..2a02b7eebee0 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -9,8 +9,5 @@
 /*
  * Assembly functions that may be used (directly or indirectly) by modules
  */
-EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(__asm_copy_to_user);
-EXPORT_SYMBOL(__asm_copy_from_user);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcpy);
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index fecd65657a6f..f29d2ba2c0a6 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -1,4 +1,5 @@
 #include <linux/linkage.h>
+#include <asm-generic/export.h>
 #include <asm/asm.h>
 #include <asm/csr.h>
 
@@ -66,6 +67,8 @@ ENTRY(__asm_copy_from_user)
 	j 3b
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
+EXPORT_SYMBOL(__asm_copy_to_user)
+EXPORT_SYMBOL(__asm_copy_from_user)
 
 
 ENTRY(__clear_user)
@@ -108,6 +111,7 @@ ENTRY(__clear_user)
 	bltu a0, a3, 5b
 	j 3b
 ENDPROC(__clear_user)
+EXPORT_SYMBOL(__clear_user)
 
 	.section .fixup,"ax"
 	.balign 4
-- 
2.24.0

