Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9247C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E3A20665
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JC4fDjkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfHGCHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:07:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35839 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfHGCHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:07:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so21451137otq.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 19:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=MuFa6tZ7vFSe1LOVI7ekbYPMVwhBLKkDTybz3Yw3r44=;
        b=JC4fDjkU965cDljrf9f9H+35WfdDcOLRBf4d4ck2STxWjiyn613K80IfbXIV3yjt8F
         TaxsxQSVs/4+2cFoiO+YzykT21aoLXLSG3wELNAjtQAbQqwTVS6vp8AZpXutrzNEtHs2
         03mhxA0YfSdoqbgMZdbgIGx/odmQ/pVngBPraMDIe2T8BLV5G/b2yzLMgkELXP4+AXmA
         fstCg3FK/zG6HxmSpCXsLx0aDbBr0a4c0CUgL7QlbAVN+Lpdg4RpMokPM66xLHO9o9V0
         3tkCHFklHn3oMNZz3aI/azdbQ/aY+d3txBL9HIzwxyqlEEpCPhJP1ZGIdLenH6lvgwI2
         b4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=MuFa6tZ7vFSe1LOVI7ekbYPMVwhBLKkDTybz3Yw3r44=;
        b=uimWofHU5ueFonSOtPnLSgzMSGR4P2hBl9HB92vYngFxCqzIyQYCrOmlYA5+CsCBqq
         yEriv5cIDQMu+KT9KZnfz4gJwY77CFsnqqSJBInehZeILbjdCJZEPIsdf9snITBrXh21
         3PojNaarGEHRPoMKerZXUMbkZQBfqT2L612ZmXEhwmINAGnKvcTGECWFrPUqTG002M/+
         EWZbDzNWIbAHjPcb/sDsbX/KyqDZnrlFZphitpI/eOBZIXSqq4h/9Hd5TzRV4GSFWcyf
         jNU5ZvPliukfaidTPD8zHfistia5vK7HAzxqsFriJalcnDG6j/vGKeOA8pUmlb48q1PO
         NZEQ==
X-Gm-Message-State: APjAAAXGQaLACUo/CwDZLRzOfeVwrUnrMjImFjofJdO8qKV3gNBQ526N
        LGvYrHZTBOB9JF68a3GauSTjGQ==
X-Google-Smtp-Source: APXvYqyRjgjRUfPtCrkI5GZQR86YZZs4UWw3xYp+cV8dbhHh18X0tcLi4UP7kagxmb+VJst8/pQJ1A==
X-Received: by 2002:a02:1441:: with SMTP id 62mr7791725jag.21.1565143627162;
        Tue, 06 Aug 2019 19:07:07 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id h18sm69825603iob.80.2019.08.06.19.07.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 19:07:06 -0700 (PDT)
Date:   Tue, 6 Aug 2019 19:07:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: delay: use do_div() instead of __udivdi3()
Message-ID: <alpine.DEB.2.21.9999.1908061906240.25231@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for removing __udivdi3() from the RISC-V
architecture-specific files, convert its one user to use do_div().
This avoids breaking the RV32 build after __udivdi3() is removed.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/lib/delay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
index 87ff89e88f2c..8c686934e0f6 100644
--- a/arch/riscv/lib/delay.c
+++ b/arch/riscv/lib/delay.c
@@ -81,9 +81,14 @@ EXPORT_SYMBOL(__delay);
 void udelay(unsigned long usecs)
 {
 	u64 ucycles = (u64)usecs * lpj_fine * UDELAY_MULT;
+	u64 n;
+	u32 rem;
 
 	if (unlikely(usecs > MAX_UDELAY_US)) {
-		__delay((u64)usecs * riscv_timebase / 1000000ULL);
+		n = (u64)usecs * riscv_timebase;
+		rem = do_div(n, 1000000);
+
+		__delay(n);
 		return;
 	}
 
-- 
2.22.0

