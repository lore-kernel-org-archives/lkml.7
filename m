Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AF5C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A0C218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AWXlfRnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfGYVZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:25:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33405 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfGYVZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:25:37 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so100433594iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=0OE6CkyrftBD3Ku7P1YRVsn9jYbz8x68WmGWVUa6hzY=;
        b=AWXlfRnEtLM74XglQGEkne+2wpRMQ3s+jTBHVl27BvwSaVklVPQBOEl+vVl2AOmA5q
         qv9xXCge4s0vMUla2SYNdU3WfUuDpFqt6iVunAkr8kVIuSSqBhDFCulVS6VMtoNBW2nW
         a3G2ZcfFBZNVDiJHDGaVNLBfRDN7Awy4HmWGgAy3K0bwPm+wqk1zOeXXbb/TXMI5b+i0
         DnvM6BNfb/FAc68JxHuQRI2poAaDUJAcgX3JFh0zp6NFcq0rNvNxGTWgwNBKhLE/Hkyp
         MdU+cjP7xzKxethms3zDzEPZwpyPFzGC5cDQqCSu2QqadqaB+iA26yhrhCOZ+AgVap5e
         mmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=0OE6CkyrftBD3Ku7P1YRVsn9jYbz8x68WmGWVUa6hzY=;
        b=pyf0wpPJc06w0ZDsbgK8pmLie3grkylxPr31668BDZNxr0HQTn/hjttCgTNIrnq910
         uAcV/LNLQqULjmEc4kvYKRIYpmcOiC92uTMMPej45B++DCTFEhsstwoBk9TPeyTN3JVj
         v4/8dIy+VoZxyHbURCOZQH+ZNJNFc5roxVqBcwo0UD96MbfdEHpeXQ6LtylSjZCKY3by
         u9Luv5uW0NoVfyjE2AqgYhneNBmhSoIq2TnMnItM6iQVa48jP7i6fmqMIiAHbS5qj0Z0
         nPFQgavw4SXYfOI5zIbQOhGTvakcKKog+deRiwOwEO0+tYRtOC7s1pdDiNJWIQLbN3wR
         dX/w==
X-Gm-Message-State: APjAAAXyhVMcQhwzxohC8Bhqlw8/oFhOEpWkHMLTT7JZathwYdaA9gLL
        KrN37FKsoBot2cFAZruWfoyyxQ==
X-Google-Smtp-Source: APXvYqyXby2GabhLGrmfNxGRSjjzbJ/o7K20JIc5pwz0S+rpYgbr6bHq19jJS94ZBSI/g1gq1f+w5w==
X-Received: by 2002:a6b:b556:: with SMTP id e83mr81812981iof.94.1564089936348;
        Thu, 25 Jul 2019 14:25:36 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id s2sm36154569ioj.8.2019.07.25.14.25.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:25:35 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:25:34 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     bhelgaas@google.com
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
Message-ID: <alpine.DEB.2.21.9999.1907251422040.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is part of adding support for RISC-V systems with PCIe host 
controllers that support message-signaled interrupts.

Signed-off-by: Wesley Terpstra <wesley@sifive.com>
[paul.walmsley@sifive.com: wrote patch description; split this
 patch from the arch/riscv patch]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab92409210a..beb3408a0272 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || X86 || RISCV
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
