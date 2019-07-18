Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D3C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6813421019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S2OJTrzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391648AbfGRW11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:27:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43537 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfGRW10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:27:26 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so54325453ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=/Nlsaz5MlWmeG7OKcfAd5EyR46Qw5/w4N5D2o/Xi5j8=;
        b=S2OJTrzZNoGv5Oe95478I33bsvRX3JhcvnGALVidpZsmcTGK7KRJc0EDSlqlS4L4XA
         0STBB7lVgcwjS/IJSIpaTAgsMJnKFFMooSAji1SDqJfCwsZ/f8u/vDaB4UocHIDdSTH1
         XKm5HvoVMCi1p5S0NGTQWcZCnpZH7a1YeTvkvdFiKe4szmrxwWlNeyUi1kTax0/HFPEM
         irdA7TC4I480cdukehKRLpNoHfzK/SsYlSnepp4W0TipFZowgpq/XEsK9gcipqh3RU4I
         EAIZy1rv4IuAp2RGvqEmTiTAwoPuYEUOPEvWt0KOLEUH5St9R+4BVVV04coqkRHolTwa
         9KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=/Nlsaz5MlWmeG7OKcfAd5EyR46Qw5/w4N5D2o/Xi5j8=;
        b=g518xeIbKdJKLTu7jHZJwBNpSY9A08ZEY/TQOt/WIZxHpyggC6QBM3YbjftjorAktL
         t5aGLDMkmta8IW1xutiaOWVFbCIVmF5plID4Bun6+C3DhCNqUSBRIjwn6jMOjRRuozKy
         2GCREWaNGEf7n95kBeGeocp9ODJXgAFLqCrb6SQGGdzsQJAA5YswihvDnf3cuBK4iChC
         LeXGTFW6VTBQdYo53dbDInckPoCiHPvWRve70LFdX1gbvKZfS1IstATumUDXVKSNnsCD
         xes04EYxF2WkfVWFi132a/PnfY9ns/I9K2i45DeeRWROl5av05ngS6/3a7AOUEEqyhhP
         yOGQ==
X-Gm-Message-State: APjAAAX6X0oaJrPTKOkC2Nco+wJpLcLELHmY2EyKZc7f+ySZr4rkjaN5
        gJIOO4ef0I4HIqquNn+0YVuKhg==
X-Google-Smtp-Source: APXvYqxYmBc5hPbEHd8dKBbXsXLhJPs3Zt6OYV7PpRmuLIRO9YvaCy8DLBta9gqpmIwjP84gIIx/Dw==
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr40561759ioc.13.1563488845967;
        Thu, 18 Jul 2019 15:27:25 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id f17sm26051739ioc.2.2019.07.18.15.27.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 15:27:25 -0700 (PDT)
Date:   Thu, 18 Jul 2019 15:27:24 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: include generic support for MSI irqdomains
Message-ID: <alpine.DEB.2.21.9999.1907181525540.20168@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Terpstra <wesley@sifive.com>

Some RISC-V systems include PCIe host controllers that support PCIe
message-signaled interrupts.  For this to work on Linux, we need to
enable PCI_MSI_IRQ_DOMAIN and define struct msi_alloc_info.  Support
for the latter is enabled by including the architecture-generic msi.h
include.

Signed-off-by: Wesley Terpstra <wesley@sifive.com>
[paul.walmsley@sifive.com: split initial patch into one arch/riscv
 patch and one drivers/pci patch]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
Planned for v5.3-rc.

 arch/riscv/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 3d019e062c6f..b0a9fa34be5a 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
-- 
2.22.0
