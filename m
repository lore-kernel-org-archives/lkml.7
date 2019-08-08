Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98116C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEA72173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="htp++ycS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbfHHQZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:25:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34544 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403833AbfHHQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:25:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so121018637otk.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Sh9FQDMasmY5vtQdSiQoK5tO+xz0p3eGu1ZERt15qJc=;
        b=htp++ycSv4CkfO5k4hhbR1c5pz+jcLYDMM9onORrmnPqr2zXHtSMUdHfSpaejVGxm6
         1iUtb8fy+qUbYNbYlj4vc4ysrm12p8atovPDzumyNBfwmL6LWMFILpb55bYTZd4nUAvM
         kk7mR+F2CxE1MNxH6mciDwgla8tKM1V4azlME9VN88ToYJjE74MGZ60BAsb20aoL5zQM
         WDpNA4qBvSgWOn6/X1Y0n+vuEzqbDFi+onk59s1lf0DSiH2R1Qqerulz2Qi89a8ZFzYG
         Uw+qEJNsTPTaL9AXDJ+2PAwpnN2Lh89SLPog8RVL1ilqI9Ax2mmK1C3YSNRdtozOp+39
         A+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Sh9FQDMasmY5vtQdSiQoK5tO+xz0p3eGu1ZERt15qJc=;
        b=KDybqUwqaqs11QmmNdkppyOs+HL7gEPPvKAZWDUWohpXEygN+OLFWEZfuwAQutKxB8
         uXmYYWwUSEKNf7K/unzMNoLVY2WgHqGW2ZuxidHgVNB8DPMFOBSEgP/V6kqNfKXkXCzr
         Z+4WgRHHLQmR1mktEF42BHUrTIKCaTfEqD8eL9SDPOahRgZt/oz4B8P7JUf3CjEszUwS
         jbSR1FxsTJXfuSmDtm0v9f4qYKjaumhl24M30fmi39RSUUQiPBt+rLyO3m1qKHGIVa7e
         HB63pQiZTXl5T4zVaDuePF1j/g+E2rZ25J0TjBIQDKUKg2WUF0Uu5hYHIOPK90bPioAq
         ejpg==
X-Gm-Message-State: APjAAAXZxPlqJaJsx5OXB/ek7IcF5Gimy1RTiMgKV5lGXTsVNq3zXPd6
        YEDmmvCh3B42trilxfLgG4Jtqw==
X-Google-Smtp-Source: APXvYqytWnigO89QXdNbJ/WyY0oBdo7zxtKLAlx2YBEnBuVEX31JdfD5sKmrXhp2sBu9PWy+U0ezPg==
X-Received: by 2002:a5d:9690:: with SMTP id m16mr15546380ion.180.1565281527716;
        Thu, 08 Aug 2019 09:25:27 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id x1sm2315281ioa.85.2019.08.08.09.25.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 09:25:27 -0700 (PDT)
Date:   Thu, 8 Aug 2019 09:25:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, schwab@suse.de
Subject: [PATCH] riscv: fix flush_tlb_range() end address for
 flush_tlb_page()
Message-ID: <alpine.DEB.2.21.9999.1908080923320.31070@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The RISC-V kernel implementation of flush_tlb_page() when CONFIG_SMP
is set is wrong.  It passes zero to flush_tlb_range() as the final
address to flush, but it should be at least 'addr'.

Some other Linux architecture ports use the beginning address to
flush, plus PAGE_SIZE, as the final address to flush.  This might
flush slightly more than what's needed, but it seems unlikely that
being more clever would improve anything.  So let's just take that
implementation for now.

While here, convert the macro into a static inline function, primarily
to avoid unintentional multiple evaluations of 'addr'.

Reported-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/tlbflush.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 687dd19735a7..b5e64dc19b9e 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -53,10 +53,16 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
 }
 
 #define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
-#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
+
 #define flush_tlb_range(vma, start, end) \
 	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
-#define flush_tlb_mm(mm) \
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long addr) {
+	flush_tlb_range(vma, addr, addr + PAGE_SIZE);
+}
+
+#define flush_tlb_mm(mm)				\
 	remote_sfence_vma(mm_cpumask(mm), 0, -1)
 
 #endif /* CONFIG_SMP */
-- 
2.22.0

