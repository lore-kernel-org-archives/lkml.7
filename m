Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B35C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2242168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhDwx/7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEQQr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:47:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:47:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so3962284pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hE0fe9lMVv6/FQxLkF3fQ4UQY6bw1uWnd2q8EpUNjIc=;
        b=ZhDwx/7uQqUnTIHD1PA1Upu1Y8Z3YXS3B9HztVGpVhQ1tAXH449NhmdQCurju4ZJB9
         vNhIXcRedwThXY2BekwHNiWsmcH7xI5RXQTxVxFuMqKhuiq90bGAcOc8hj9Vd5FEss09
         u6kj7HIYJx12jSex16z82pa6RCUW1/cmEbwHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hE0fe9lMVv6/FQxLkF3fQ4UQY6bw1uWnd2q8EpUNjIc=;
        b=Hqpv9ld8eenymc7KUM3nCKdQAoAR7wl2SoFf96XU6peTtFL5wd7/EW+Yfq1H6Ooa45
         JlInKOghhC3SzZ48aWCpubF1tbeNG3wgG5fH7WDlx9ixtdyktZTs2WRq4E98Spi3tK8R
         yrsz5K1RpH7rPPqauRD1dzHpCacUoFgZW1JkjCxmomT/4KAw5lDAHi2OXnidNA4oh0MC
         eRvd7lU4maNV70B+kTf81g2ppvK5QDbu2pGM7B4PF7hYRKo6kXOL4b6mU9Nri8vCtyHP
         4Lm/aJWt1edL+YRAy36zp340DYWcABWxrqw5Im3FGJrkJ3RVlmzn/KFAZuUVM0woaGtS
         1EwA==
X-Gm-Message-State: APjAAAVUYvrJguFJdOtW8gibTVFJ495ppV5x0AGOPYwproI4VFNZ8NV5
        Vv+tOmDeW9XbaUHjIZqcEJmXmsJrUpYoVQ==
X-Google-Smtp-Source: APXvYqzuCXeovIOaR4RbpVXx1csND1I5sP1Zmc0ZU68p58V4I5232ilFAA9A/gPdohyIIkl9VXHhPQ==
X-Received: by 2002:a63:785:: with SMTP id 127mr54984321pgh.230.1558111674612;
        Fri, 17 May 2019 09:47:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l141sm12229810pfd.24.2019.05.17.09.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:47:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC/PATCH 4/5] arm64: Add support for arch_memremap_ro()
Date:   Fri, 17 May 2019 09:47:45 -0700
Message-Id: <20190517164746.110786-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517164746.110786-1-swboyd@chromium.org>
References: <20190517164746.110786-1-swboyd@chromium.org>
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
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 8bb7210ac286..245bd371e8dc 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -185,6 +185,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
+#define arch_memremap_ro(addr, size)	__ioremap((addr), (size), PAGE_KERNEL_RO)
 #define iounmap				__iounmap
 
 /*
-- 
Sent by a computer through tubes

