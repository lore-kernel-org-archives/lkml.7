Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E8C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851A521473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BDM1M+27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfFNUhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:37:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36416 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfFNUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:37:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so485974plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctzVWLxLHqItydbbPUXjVh0gv8n1U7GRnaTqF8ILaog=;
        b=BDM1M+271IQoGfkSDrl85T8Rg7KP/lRKJEOPCJCfChPITi0i6Zs3pcycaA0GBFCgll
         ZQD1tlZUFKuxGUoqIjPaF/Qk+ZU199aERuJ0yHM5V4ez2VXIdzvl/L2iaeThCLAIVS2b
         DdSbS6oQg5U5nGMrQ1vc6prTrvy5arXwJE6ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctzVWLxLHqItydbbPUXjVh0gv8n1U7GRnaTqF8ILaog=;
        b=OW7HSP5R0jlVDOOLlSGufMfkcVfz957k7276gfptX5ShZzUG+JN1YRgpt2iEm0XX6B
         aOn12/aVTzG5iicoi88PnFugf/Z3FGDqzlNXlpzn/Qo81a3Uk+XwCOE925P7JI+ruZae
         jQio0ruH8t0K3Gc2o5Vp/VKxx+AwCDVPME6csQLWhKrRl1P0jjFQANIBHZHQJ7c6htCX
         DjBGJaDrue4pblJUDJPB1CNCEHUQ8JNoUjH55x5n5KDZNVrjpWvYUG0+whGZIlCfJYcA
         BlTOx8ZY1we3ynvr1weAiRGq6gvaIa4cAWjSJwIhTcEo2AiJhJDQ/FGS4AA2V61cohOL
         vAvg==
X-Gm-Message-State: APjAAAWmpMSx867i6SXn/IneAnxQSMa7Bgh6Opbz5GpuW5YjQoPzGYCc
        lkmg+6KcmIjylYem86A+uTZEtudYOnM=
X-Google-Smtp-Source: APXvYqw21FhItxYFfLoN4gG820hTamDRhMvYBgFH74z4L0jEESW79mOUdZTsiokL1tAuHIASvtvreQ==
X-Received: by 2002:a17:902:f204:: with SMTP id gn4mr77051069plb.3.1560544642914;
        Fri, 14 Jun 2019 13:37:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x5sm3673187pjp.21.2019.06.14.13.37.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:37:22 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 4/5] arm64: Add support for arch_memremap_ro()
Date:   Fri, 14 Jun 2019 13:37:16 -0700
Message-Id: <20190614203717.75479-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190614203717.75479-1-swboyd@chromium.org>
References: <20190614203717.75479-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass in PAGE_KERNEL_RO to the underlying IO mapping mechanism to get a
read-only mapping for the MEMREMAP_RO type of memory mappings that
memremap() supports.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index b807cb9b517d..cc33f4c8647b 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -183,6 +183,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
+#define arch_memremap_ro(addr, size)	__ioremap((addr), (size), PAGE_KERNEL_RO)
 #define iounmap				__iounmap
 
 /*
-- 
Sent by a computer through tubes

