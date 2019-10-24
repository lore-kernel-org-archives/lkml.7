Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09699CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD90420663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="UZwvrj0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406276AbfJXKNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:13:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54217 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405332AbfJXKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:13:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id n7so1309250wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WGkdSgyk5QDs0H3YBMShx1APwkt+CxEDuO/NO19ZPMk=;
        b=UZwvrj0eqMSzhF9AmKHoK2Nz33TVc5K3v1H8uZFHVVTc2ub/XCKNrdd5KbEDNBsZvM
         wzeUa/9Z/8VTv4RpuhZME4Yd8knecXXNBqTfiU0IT8VtcAcLQGI2qDP7NSHcx8DDIqHm
         JyWQuVMshTWYX85tj6K6FAqQvUxBebQDha0P/d4ibdcqUBe5iICnxuy/2MZes/XL8yla
         oL0s8tL2gmpOpTgAWggH4RHBFvwCRNaKXTwevgNC+TsPhXveLZLVkazARaL1gebA+/Le
         OMrxwTEEzVylkBIGCcwxEo63tfV+YBlzXjJ3aZcLKc88h5fNpLMRggv0PaBc9rxzaNAp
         LdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=WGkdSgyk5QDs0H3YBMShx1APwkt+CxEDuO/NO19ZPMk=;
        b=qAEui+Uf7TknsCit/6P+lwjv9gFxYQDLv5q4f74gGjgIsYVgh3BTjYnMffaajXwUje
         jEe/WC6VCyvK8ceDPfaikmVV3Qg2JqPVs7k4XeACwRwZgZakFUh/nAzJySoixEXPkWOE
         0PFvatL3SJXkasbqtZ3NQMTlnpQ6tCrhMjc+IXtMByZWxmdPopLt4zLVXKuiBuqQI1Ad
         OP+ZdN8ytIufQL0UdZ/jsWkRYzfR3D+O1RtOgzgbplLXQKJIMVFl6EhY+eYrTIOII4KR
         RfvDQD4TZ85euW+V2+FpFYo53S1fOEpAoVoM+tThTlgkcAsD7RmWHlecesrb3Y0Jhzy5
         rbng==
X-Gm-Message-State: APjAAAViALISHXKM/fYV3YZpHYnoB6IpfGGNModhwhfL83qXq/6u/Dna
        wr1xHw5eAEsbEpgu6YwihJF1NrPUV3fe3A==
X-Google-Smtp-Source: APXvYqwITaHJW8sYBW/ZnIhYqk4waxD+Srrn1VRnWsk47+PN9e4+4f6vp0kjCW4Yqb/fDMZQIB39+w==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr4131264wme.115.1571912003060;
        Thu, 24 Oct 2019 03:13:23 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i18sm22736686wrx.14.2019.10.24.03.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 03:13:22 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Thu, 24 Oct 2019 12:13:12 +0200
Message-Id: <ac4cb87e8483ab5a4e97dfec95849aafd5c99e54.1571911976.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Origin patch here:
https://lore.kernel.org/linux-pci/20191017181937.7004-4-palmer@sifive.com/

---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..77c1428cd945 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool y
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.17.1

