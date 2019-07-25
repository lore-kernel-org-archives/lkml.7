Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21515C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF04B22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EOZ/BMGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfGYV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:28:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43684 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfGYV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:28:09 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so100341370ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=3RH1zSlyd07j64FiG6c56vosTfF67VZPnHTjO5XPI6w=;
        b=EOZ/BMGIWOdAj5Vnd3MYOVEz3cefj8pjrEdXl5iPoQCB2A7GPF+woWHVnm8k9xigez
         g3xjAsmtfn7Z95N8JtEYM19jcXGgmOmAF/TMVLY81K++RkiZhRJxxw6z/Zi6cj0P2crZ
         6jbUWGZ0OGzThcxAVxOLtSlRgAOUkMhWP5n8DdY7wDDGBMVTmsrv3aXCP8nX2TpQFMFO
         t+6JzAzXDmpSUtQMjbRfX9qtceI7QH1nY00yBmhS5Avtu1VLBBkKzAkphHjSLBDzmiyR
         R/+U6LN++pbSDZBytpZoLkKkmY9FfQNPqxVckN+KnwzUnC5NqJeLQsrxYS4y9Tp+TRrB
         1fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=3RH1zSlyd07j64FiG6c56vosTfF67VZPnHTjO5XPI6w=;
        b=YBZieXEwtLat4A3COlfYSf+S6FHFwDMuuaGnfQp4LV043Vc7YXXOtGwozPiMneVJ4t
         D4EKYlT9NaWOZrC5XYXo5APj9HAE69X8yTTOAC5KsD2iHhrwGX2LXgBFq1I2n2vUhIR/
         QxqJKFl51Hrb+2znFrFaj1mZyprrCxtRkiJk2P9ntWyW3rzV5KwGZWRcQbSvU1baqtu1
         sYNt9ybGBCq6KXdkHKZ6Fgnn2S3DZg1W1+7bzhDwA13D9pPyR1qmRyazfBatUBgTQy2U
         rPllvSRvNw0bEZqlQk2n70evLUyrfHhxEvzFOyWK/Bk27vMQUeKYI4YB2m8y5+0QfA5f
         Tehw==
X-Gm-Message-State: APjAAAXfs9VouXAK2Qgc4OPNe1tU66PCm5SFgzPS6MG61Nw/4CnVPI+r
        6z6rCDtUBe/KUAlI/2PV7Z5hww==
X-Google-Smtp-Source: APXvYqwcgbG8zch7ZKO4A5O8SJtdUcK7Nhlw2/y/EAEaxhmIHdnGrBKmHWDCbVWOWssqVb37HE40xg==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr18868186ion.239.1564090088618;
        Thu, 25 Jul 2019 14:28:08 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id t14sm41996376ioi.60.2019.07.25.14.28.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:28:08 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:28:07 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     bhelgaas@google.com
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, wesley@sifive.com
Subject: [PATCH v2] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
Message-ID: <alpine.DEB.2.21.9999.1907251426450.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Terpstra <wesley@sifive.com>

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
 
-- 
2.22.0

