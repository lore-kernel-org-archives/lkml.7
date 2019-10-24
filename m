Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD56CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447C421928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AwQ/GBlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbfJXW7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:59:03 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43124 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733065AbfJXW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:59:00 -0400
Received: by mail-il1-f196.google.com with SMTP id t5so136273ilh.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5KV2n29ZA7BXjN3Y21njjBxjV2pNglFMNBgoB7YcYc=;
        b=AwQ/GBlVPgcIlLC4Sz/TLy68Iu5WlrEziKexLo20EOOhnOJCLLC7tK4d9senB7m7Yx
         F31VlYhaKSRm2QeYIefbveHAgiZa9TrM+k2RltL5z/xyL+5UX+yISBZBRL//ng104mXv
         A6R2+QiwlBQjOWYXI5eaeoAvNhtkY4L88va7tSPfPh8J/M7zOo02GvWCE4YigmSylWpI
         8qs3so4altTKneB1SGpHUUP7n8QMWNYB3ZXZQ/0aD78eLG6Rvar9OiGpul2o6DQzi+pi
         Lr4ll73jrjmh6lyLkOvhUbzLyUx4iqxXF3U3RvPuIIrKReqWIQ3TriyvXIxE9EGZ7yeu
         j8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5KV2n29ZA7BXjN3Y21njjBxjV2pNglFMNBgoB7YcYc=;
        b=QZfOBY+YnCFrzWGu/EHUbuwY/tGAUKsGJK47b+OxeowELrjJEJNwc7cW2uG/pKYJkM
         TZivcxR2ZR19AXgvjGQszGAW3Q7C5RtPGuCzyoqtwY2Nha0UW1ElGUZfEBjWJ0mrHDFF
         IPhD1lA1X3P/YE61pp65F5bly487fyO94PAVv+j/u5y+RnI3F16Yococ5vOmQyY4a+LE
         vi6oEtDRFid5//Zd84Hp9IMvWWRrMJyM8Yr2kkCuqV5xFoT7FIT8pArO4catyr4qD3Jn
         I7gkpE5+Oa28j/3CGU6y3HsKcMEWc1OKcboyibLJ4q7K66neZ6AnxFkH8k6dG9gDWqX/
         cKUw==
X-Gm-Message-State: APjAAAVnuKhMkWpuXyjJgGTSJNjhQOrTBKZ6KXwmSTUrc69Anxbc0cC8
        P6dZmAfepmIzEb65YqnQ1R1SNA==
X-Google-Smtp-Source: APXvYqyuaLpurKP3sYFT1l56Mh0m3g+O8f4mbnU9sC69yPy8H58pn6tcUvY8iUsSnGMwiU617okvKQ==
X-Received: by 2002:a92:d601:: with SMTP id w1mr522719ilm.281.1571957939415;
        Thu, 24 Oct 2019 15:58:59 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm58112ilo.70.2019.10.24.15.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:58:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.dev, greentime.hu@sifive.com,
        luc.vanoostenryck@gmail.com, Alan Kao <alankao@andestech.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 5/6] riscv: fp: add missing __user pointer annotations
Date:   Thu, 24 Oct 2019 15:58:37 -0700
Message-Id: <20191024225838.27743-6-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191024225838.27743-1-paul.walmsley@sifive.com>
References: <20191024225838.27743-1-paul.walmsley@sifive.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index b14d7647d800..64bc914ce9ff 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -26,7 +26,7 @@ struct rt_sigframe {
 
 #ifdef CONFIG_FPU
 static long restore_fp_state(struct pt_regs *regs,
-			     union __riscv_fp_state *sc_fpregs)
+			     union __riscv_fp_state __user *sc_fpregs)
 {
 	long err;
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
@@ -53,7 +53,7 @@ static long restore_fp_state(struct pt_regs *regs,
 }
 
 static long save_fp_state(struct pt_regs *regs,
-			  union __riscv_fp_state *sc_fpregs)
+			  union __riscv_fp_state __user *sc_fpregs)
 {
 	long err;
 	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
-- 
2.24.0.rc0

