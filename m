Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32457CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0928721928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="b3/XSJ+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfJXW6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:58:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39806 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732966AbfJXW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:58:54 -0400
Received: by mail-io1-f65.google.com with SMTP id y12so214023ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zeQmt6u0IaAwxJA3Xr74ItciPuMbvDn1BaL/hvbUKXg=;
        b=b3/XSJ+O5O2Gq9FzuNn0Uu/akEHr9eQLEYece+tdjHUli0bi76e6mlu+ecEXZFxiAp
         Ljc0byqB0MIV/CHTl9B2bAoogNrlyv2uDqSL0iZo0tmNiB5NVzbVzYpyvUIptUanpWlc
         z1q1gdmzwiadf0IqBYOkY9mgq1ei4hrlGza2QhKB4ND1IJVbO5jku2EL1Up8rgjGxcg+
         8foDFH3Q4l2Zhp0C2CcIxj3XuApoxpJtHgcZNet0LrTPt+Km0qS1edVy81+DMeUEfJrL
         +Fpok6BHiKFbB7czCXWxGcVrYI+4rXcyY83WEIM2h6jAdYBrJILWmr4qJZHPovdQUJad
         WFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zeQmt6u0IaAwxJA3Xr74ItciPuMbvDn1BaL/hvbUKXg=;
        b=sBvzTP15BQ0MmKUbOhjUTgX4TusBHQBArPeqMShGmPajsmwyNsIbt12WtX/xTDHDna
         IOTLPe7oxqmBvNj3FRaJ6LAnTTqsUWGyD67ptRk/dfwZLFbyF7reczUvMvwUI4E+CZIO
         nhQtZejnuu/AdJlb2OvNM36mp7jYi34LIMIUA/9Mdo4bBL0mcuN8o/nJybDJDTQhfJDt
         16+xRPTMsDcVAOSOYVlUL8FsrlWvnEnwPHYkLUBGFTiMD3c/9E8RayaxENgDVmHxP6fW
         DeVamV8Dn/osIykGCc/vhxvdaKXovX9Z7UASO6AIn+Agri8IvSOPaaVFjk+eu0fC1rD2
         fi3Q==
X-Gm-Message-State: APjAAAWXWwz4SJ7lrnPXTLeE4kAySX2LV1b19iNQT/HvGqjZc9mkg1lg
        r/rlFGU+2z7G+l+uhDAXuOgZBg==
X-Google-Smtp-Source: APXvYqyFQvQ7ooZCu9FvinAHLoiUHRgF4BxNJh1ys5uNZfuLn4uFT7NwtQG/gV4UiS3gGJsl5Rb5ZQ==
X-Received: by 2002:a5e:9e07:: with SMTP id i7mr649587ioq.42.1571957932920;
        Thu, 24 Oct 2019 15:58:52 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm58112ilo.70.2019.10.24.15.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:58:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.dev, greentime.hu@sifive.com,
        luc.vanoostenryck@gmail.com, Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v4 2/6] riscv: init: merge split string literals in preprocessor directive
Date:   Thu, 24 Oct 2019 15:58:34 -0700
Message-Id: <20191024225838.27743-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191024225838.27743-1-paul.walmsley@sifive.com>
References: <20191024225838.27743-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse complains loudly when string literals associated with
preprocessor directives are split into multiple, separately quoted
strings across different lines:

arch/riscv/mm/init.c:341:9: error: Expected ; at the end of type declaration
arch/riscv/mm/init.c:341:9: error: got "not use absolute addressing."
arch/riscv/mm/init.c:358:9: error: Trying to use reserved word 'do' as identifier
arch/riscv/mm/init.c:358:9: error: Expected ; at end of declaration
[ ... ]

It turns out this doesn't compile.  The existing Linux practice for
this situation is simply to use a single long line.  So, fix by
concatenating the strings.

This patch should have no functional impact.

This version incorporates changes based on feedback from Luc Van
Oostenryck <luc.vanoostenryck@gmail.com>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-riscv/CAAhSdy2nX2LwEEAZuMtW_ByGTkHO6KaUEvVxRnba_ENEjmFayQ@mail.gmail.com/T/#mc1a58bc864f71278123d19a7abc083a9c8e37033
Fixes: 387181dcdb6c1 ("RISC-V: Always compile mm/init.c with cmodel=medany and notrace")
Cc: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/mm/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 07af7b1e4069..573463d1c799 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -339,8 +339,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
  */
 
 #ifndef __riscv_cmodel_medany
-#error "setup_vm() is called from head.S before relocate so it should "
-	"not use absolute addressing."
+#error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
 #endif
 
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
-- 
2.24.0.rc0

