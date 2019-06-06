Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97010C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F9F206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tByYYT12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfFFUAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:00:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50476 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:00:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so1153965wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0YY5mZvqd08FU5MVoEHGPtFV0QtzdJbDbJfnotzqrg=;
        b=tByYYT12nhnXVO7GVnJZreSXJy1G/1dKFZMq6S9zEUxwQr7NraEnFYkkGSuTELurKn
         TxpQ0NrvHPmQ00dnbsCqbhaeIpTzQ5ZwaXaXiuB5Zr+/76GxctTLpIeDxRxDXZ8iyM+B
         sqkIz97UT6D0Ca57QBehn2WmQC0JyoEnrskZ7b30QOIPIAivCQFdaKVPmvIM+Y52zfhh
         qPCQfvMj0WaJOEBYOeCUJy0Isa51pF55fd0pT0GhMUQ2eKCAfos/Sdd1k6bA/oY1fxtN
         mN2SplaGWD+PIVapoNQM/WFyQcE0hO8ptZzxxHhX7eNgKVgnadBPdbN5LdmEPiuZxxDo
         xFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0YY5mZvqd08FU5MVoEHGPtFV0QtzdJbDbJfnotzqrg=;
        b=cLJlZVPzx+eslmueA+oNRdjkC0Ityzp9n4nvjD4ZTepE/ehnitSMsBWI7B3UGXCZtL
         k0wWc5H2vQbZz9Rd1ZjogkIgY7GMhLiYlmcx69LkGcS8Wh5bmkpELz6hBYCedPJp61gb
         5MNQFUsLJnK33zPkBrs8prSihqsZGDg1uofH9KVqaZZIRP/KzrFXRuK6iYPFccyFhk7E
         NL78Qs1xaj5DyTypSsh7YO2MIAAn9NKChVMgM3FpxVXKrZdvCLVq36TvVsVkeBgL2dQH
         3DoQ60cG6CYIUhnXOQUx3RVyfa0tNPPPUUKsxhof/OOyX673Chh9TYU4pzYQAOJycFPu
         fFoQ==
X-Gm-Message-State: APjAAAWPV4rgU2nsxMEuMC7xeXLLEjLQ7APHOfUVFN9Udip5sOT8q+9V
        gYkk83RFcRUanb2C5ysg8oyzl1ni27Y=
X-Google-Smtp-Source: APXvYqxxwpEGHSNpiiPCHk91Lf03JKfgy/lQGvppp2BMniKDowvRTKV7FP47EK1ZKnb5ZBlu5dbiPw==
X-Received: by 2002:a1c:c011:: with SMTP id q17mr1144228wmf.105.1559851252154;
        Thu, 06 Jun 2019 13:00:52 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id b69sm2590957wme.44.2019.06.06.13.00.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 13:00:50 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org
Subject: [PATCH] x86/resctrl: Use _ASM_BX to avoid #ifdef CONFIG_X86_64
Date:   Thu,  6 Jun 2019 22:00:44 +0200
Message-Id: <20190606200044.5730-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on CONFIG_X86_64 _ASM_BX expands to either rbx or ebx.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: x86@kernel.org
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 604c0e3bcc83..09408794eab2 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -431,11 +431,7 @@ static int pseudo_lock_fn(void *_rdtgrp)
 #else
 	register unsigned int line_size asm("esi");
 	register unsigned int size asm("edi");
-#ifdef CONFIG_X86_64
-	register void *mem_r asm("rbx");
-#else
-	register void *mem_r asm("ebx");
-#endif /* CONFIG_X86_64 */
+	register void *mem_r asm(_ASM_BX);
 #endif /* CONFIG_KASAN */
 
 	/*
-- 
2.21.0

