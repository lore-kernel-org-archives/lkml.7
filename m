Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE684C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8297D217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LN97jJeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfDRE3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:29:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37784 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfDRE3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:29:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so574116pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TKvJUjK7viyJQFwyOe6XFkoQSCknOeuCFER0aL1PpnE=;
        b=LN97jJehjH6C+AEZXWqpJM/QmCuaEeYRfVcKRKtIX0XHD9/txxYDIJIEQsJnNY2air
         oW+d/jhPbFMHyys7m7G99Ntcwp48/kwzYNYScNkMBVyDlR9TnzSwn5XaqgoK8EXR04bH
         Mgl7+n7TdO+8NEPlY3WDSsgAZbNPgPfFXIVwejkXFf+nm8uyfcSC+XIFvhjMo91Cut8M
         9gSGtYyz2M9E9LnA/3Bz64Wb18Yp6pThW5q9SsqhGyU1akORmC73MfTyXfvIqzUGMuFy
         Rod2az/Byy9Kkru5rpPg1+mdGtz5af542PshLgnEGUeFZs26KPcVChjI11DxWr6ANyP2
         OzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TKvJUjK7viyJQFwyOe6XFkoQSCknOeuCFER0aL1PpnE=;
        b=YiTwt47g4lSNhC3MpJS8MBh58r84/pvBrVjdX/M5a/8zLS46+TjxAprV4XNObJvyqV
         eWZMpy2ocf3QK0+WLLkuUZuDxj2I1NWReEQ3AnTQpLQLFQ5AXt/6C1tS8WqRIL/Hmiea
         xx5b9mnM2hfFWHS/yOsjeAA72CUm0jCCsEtJJjZPFG7r+0pqh5snT+rLGUMZ+R2JsWZg
         0v5zzDWeZsm8VPHBZHXdEmYTgKIBJiFVM9XH0gouhTD1Co7Fp0Kx7xevHBrz7m0X9jxN
         JzxE9QqwESk0htUYi0LZdPoD3RvTS8baNBi6hfaCtkYwnYI4T1vtnsnMFnTdpoS8QL4q
         QGFA==
X-Gm-Message-State: APjAAAVBzQRhzf2Jp7CCbqz3FZeZm/lBjyPUNWaU7q4dkQi40aMH5Y/s
        hFA0YG44dFgUzyoXqHBy/j2tNQ==
X-Google-Smtp-Source: APXvYqyPR9I0aFxUwfIB+7p7sCs57vqBajhu7HZzpzQrdvXMC1XKboTBisJzlsl1qxnlI4ok/P3zzw==
X-Received: by 2002:a62:1881:: with SMTP id 123mr93460803pfy.25.1555561772724;
        Wed, 17 Apr 2019 21:29:32 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r24sm1003922pfd.120.2019.04.17.21.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 21:29:31 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] arm64: mm: Ensure tail of unaligned initrd is reserved
Date:   Wed, 17 Apr 2019 21:29:29 -0700
Message-Id: <20190418042929.20189-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that the start address of the initrd is not aligned, but
has an aligned size, the base + size will not cover the entire initrd
image and there is a chance that the kernel will corrupt the tail of the
image.

By aligning the end of the initrd to a page boundary and then
subtracting the adjusted start address the memblock reservation will
cover all pages that contains the initrd.

Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6bc135042f5e..7cae155e81a5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -363,7 +363,7 @@ void __init arm64_memblock_init(void)
 		 * Otherwise, this is a no-op
 		 */
 		u64 base = phys_initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(phys_initrd_size);
+		u64 size = PAGE_ALIGN(phys_initrd_start + phys_initrd_size) - base;
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
-- 
2.18.0

