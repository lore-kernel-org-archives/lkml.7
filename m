Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9CBCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBD0222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZxKJbb75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439161AbfJRAuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:50:13 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37573 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408907AbfJRAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:50:00 -0400
Received: by mail-il1-f196.google.com with SMTP id l12so3947150ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDNARAWoiAFizEyliYmITz0WDECsamFFfEfTjTwse14=;
        b=ZxKJbb75JUb8XtdmyH6ELjVl2TxKr+2knfv6zeJLtjAEUY6blYfLbV5wIOiq5g1CJf
         qAm4Xy0ZpmQ4dUJXLg3NJ5XiOzOGpaZFsChkS+2oZxuR0aiBeCYVk/q+rwVTGjsdktpd
         3tXdvHYaEM6JwRgXysZe7f/u7TBtDC38uEEpA4QGBXtUYqCraU2/mCey9hW93unnycaY
         rnWIVszNZcwyXk2NQsUP3zRNqNthv4y3wgNgvavnmiFryMA2SRsFocr38S+W6naLIWn4
         cmwq9gUuIcIYuKutu2aUOk7ZArHCf6J/7MC0nNg1HyYXzPatkxiSdOBS/jfm+47+SH/t
         QWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDNARAWoiAFizEyliYmITz0WDECsamFFfEfTjTwse14=;
        b=kBsC6+jggykY0NP99nzEhi0jTTf8mHUYtXmA0FUkQWn1jQCU3hTQ4wP0VRL7K5OnJv
         Jk88o5PZsIpzOuD0Nd7ZvZe6iKode5xpz0l4AwjmfyVG2EGyCG/Ny/rmTqGj9O4d+svT
         csEtboUYz9uaA5fO5C85evAywDIa3nYMM8aoiEL6Ud7wUcCqR5lqNIYV3scGcpre+1+1
         qDsUuYEpLXcI3K1ImCaE78gcYBTC03G5KHQCfO5SWLcRVKfDSh1EqRwa+k7XUb5xYpuB
         X3IoNLRrCY/uvWV8uOFuoM5CB1hVUeqHzmy98wMkNJbLBe+BFsk06Q49TLWwEt2uCg7B
         BsDg==
X-Gm-Message-State: APjAAAV4LVL34KDMVpcStAURcY3X4Z9MAzNA4TtFJQMOyEMBmCQlYrns
        315CEjxAoRuyZEzJ/oBtwfMtJg==
X-Google-Smtp-Source: APXvYqz89Az5yviOLCd30UK04C1xP1O6eNU91MfQje3M5l58kOclitK04wId42uS1RkuH8Tus8v5MQ==
X-Received: by 2002:a92:7f0f:: with SMTP id a15mr6918766ild.116.1571359800009;
        Thu, 17 Oct 2019 17:50:00 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Alan Kao <alankao@andestech.com>
Subject: [PATCH 8/8] riscv: fp: add missing __user pointer annotations
Date:   Thu, 17 Oct 2019 17:49:29 -0700
Message-Id: <20191018004929.3445-9-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __user annotations were removed from the {save,restore}_fp_state()
function signatures by commit 007f5c358957 ("Refactor FPU code in
signal setup/return procedures"), but should be present, and sparse
warns when they are not applied.  Add them back in.

This change should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Fixes: 007f5c358957 ("Refactor FPU code in signal setup/return procedures")
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 85c700ad47e9..9437167f463e 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -28,7 +28,7 @@ struct rt_sigframe {
 
 #ifdef CONFIG_FPU
 static long restore_fp_state(struct pt_regs *regs,
-			     union __riscv_fp_state *sc_fpregs)
+			     union __riscv_fp_state __user *sc_fpregs)
 {
 	long err;
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
@@ -55,7 +55,7 @@ static long restore_fp_state(struct pt_regs *regs,
 }
 
 static long save_fp_state(struct pt_regs *regs,
-			  union __riscv_fp_state *sc_fpregs)
+			  union __riscv_fp_state __user *sc_fpregs)
 {
 	long err;
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
-- 
2.23.0

