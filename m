Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A54CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C521D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cEtvxQFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408121AbfJRAt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:49:56 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39530 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407271AbfJRAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:53 -0400
Received: by mail-il1-f193.google.com with SMTP id a5so3941219ilh.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fja9Gt2B2/DBj4SCSTf44z+mXpP45MXj3+t8BNYs+ic=;
        b=cEtvxQFb6Wq310iPciXVgojndV2bclFUO+ObVlogs2+0qitTmU0a1m3cCj+69z9HYQ
         c1cKLE0d4qBkVBQTVu9uL+fbRXh70eiIyrt4lI8EHOdpssngWDrt5lVpRPhCwWz3vdCO
         FHVKdKL4eNBtCX2R6sAo5oq8f+fNAICzCjSa2W1fPVbgehN6xvcXIEt/14F9rOtMnxxF
         eG6jNz37+PJ9sn2ZO9G1T/B///TzwQvmYzqKJEyHjmziNymtMfVY5ueDdR31rq387Hu5
         rP2XAc2+icZEuyKdnWiPyYdUScxT4YuTQmjTfuBoW+9rPseXZ2Nh4wPf1yuhTnZYPPZU
         UV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fja9Gt2B2/DBj4SCSTf44z+mXpP45MXj3+t8BNYs+ic=;
        b=i+vUFES34luzDzuHoSlU77yoqPAQzo3hlKLGDn9GGpCbHAcCuMUidTvnkCCZOTRU0L
         Ty9hWLYM+8/XQmmFQFBkWy6V87hmQ0MtCg2VLWhQoQ0NmtNR4XhSpCYlOy59gxluB/DJ
         7Fr94ZtZkbwgHkYLeX99POH8cMjM81TzTD+bMqMBZCILZgsNQSnGOgBKDp4CtrRdg0BM
         de5mtyD8FD4ihwBXSguE4P3CKAqz2BrnMMb0+16luF7g6RR6ulrNjDAXFcY163z8h4w3
         rCH/RV05D2EG13t5jcuC1MbRsizqJQ6bjBEkUWBFWMdUTgLlVVx4vX+0Rf0s3qcnTOsg
         bOyw==
X-Gm-Message-State: APjAAAXOCy8m07FEqx1gyzNaobEJGwLryR2aMHeCi0tmUZWGT3UqOAUP
        jvJmY0dpK6GNeTY/w9wU5H88YvOXjPA=
X-Google-Smtp-Source: APXvYqz1+jP5/P6UwcpWfctwKEvC91RjkSu+uplBMR8C/0xEP1mUNR9mhUV1bfxIW/s/E0pjZ9Asew==
X-Received: by 2002:a92:dd88:: with SMTP id g8mr7007262iln.221.1571359792718;
        Thu, 17 Oct 2019 17:49:52 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] riscv: init: merge split string literals in preprocessor directive
Date:   Thu, 17 Oct 2019 17:49:24 -0700
Message-Id: <20191018004929.3445-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
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

The compiler doesn't seem to mind the split string literal, but it's
pretty ugly to my eyes - enough to outweigh the value of the 80-column
warning from checkpatch.  Fix by concatenating the strings.

This patch should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/mm/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa8748a74414..fe68e94ea946 100644
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
2.23.0

