Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACAC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089F21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="oYX641WF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfJHKj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:39:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40009 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfJHKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:39:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so10069519wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Cwwrqaqfkc7a5d/MS5exo0NUOtyUn8PYYYF8oRW8wg4=;
        b=oYX641WFSw3a4b1+F8m3HlnUqFtfehAsO457JIH66/pubSKxy4wW78NtxaPt5V4w7c
         FwzgWzXm3bIcH/njrVzMzjRlr2doGQpG6m7GDizgHWmOaTMj+gA1ROr6vkU+XxgTm1al
         JimpQTTSBnizJNtRfv+7lAaqNsnJlihM8pXejNbm+uDhH9WC8jT+ydRP8JYjl5EKylUf
         O6vqo3iPgBUDcI6ek9Aad7zt0xl7j1tVlx3aSjpBdoWKxjxME5P/4J5+10A8IMqYQWCZ
         PGSkHGaZx90Lk7mZ/pff9L9PbQNmcHRX8rP0bQOALjlQ26VJNYWCKVuDYa+gGtSaMyjm
         K4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Cwwrqaqfkc7a5d/MS5exo0NUOtyUn8PYYYF8oRW8wg4=;
        b=GatY92CbJcesRCr58QEN78cCtUB+rct0pMmgBbXwdMnrBO/cKMz+DYFsjQFw+TSM3i
         lmNgYuyOI6MD2xGEMPGdDy9W5u1e8l4R7bzL5cjDa4oe4XhM1U21gd2JFqPCLwh+BZv+
         /d7Oek8XPoJ0hutLuoydQvd3vPw/aHdIbRcgn/OdLvodQ29dIf8zL5x081N1eRR/6RYe
         jh5THzNoZuFYLlqKEK/+gihPAMVlCgdcXXM2ubRH7sYDXOP3fWKryMiJvwU4BqN0dcLZ
         MImg1kr6yNPFGKLVNV+d6vVxvSKL2T9dDhh80wn3dQyq0OnVlp5SMP7t+APeoSKIGx/F
         xMaQ==
X-Gm-Message-State: APjAAAVumuHhvCQATfGvXWD/DX9Ww2OKhyiFUQ6u/UhK/dmTCSYelvfQ
        JGMAtTzl2J3w75VBnzQOEHn1ylEcBBIFx2cN
X-Google-Smtp-Source: APXvYqyYdMtpc0TZmnqQyW6MCm46p59/czdxjZQ2PqQRtMenCNZMm9BnHBYtnUEPDnYi4OnP5dsHTA==
X-Received: by 2002:a5d:604e:: with SMTP id j14mr9588389wrt.119.1570531164832;
        Tue, 08 Oct 2019 03:39:24 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t17sm38269184wrp.72.2019.10.08.03.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 03:39:24 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for Microblaze
Date:   Tue,  8 Oct 2019 12:39:22 +0200
Message-Id: <e0ead31283c74254e8c02c0e5e5123277ed1f927.1570531159.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuldeep Dave <kuldeep.dave@xilinx.com>

Add Microblaze as an arch that supports PCI_MSI_IRQ_DOMAIN.
Enabling msi.h generation is done by separate patch.

Similar change was done by commit 2a9af0273c1c
("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for RISC-V")

Signed-off-by: Kuldeep Dave <kuldeep.dave@xilinx.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Arch part was sent here:
https://lkml.org/lkml/2019/10/8/277
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..9d259372fbfd 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.17.1

