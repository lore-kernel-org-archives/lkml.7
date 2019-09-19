Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A0E21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931321;
	bh=m/1Ui7lAw5nP6U+SoRc1jCytiCdOOcqC8BgRxhVGmxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J0MTj3Ov8PUUqV//VhDO4ljmS8iErhuEDydPOhK+pdWdRDbMItBMdHWD3OkVWmxRd
	 9LtvadMCqjqqGxSW9RZX3abu4XMUinm//Yn7NT1AS1M1s+Bv8t+q0COrucmhfiG2VN
	 pkh2g7DbWStLc83GAv2PXIBgy8vkIUZ7S/eSGXnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406106AbfISWPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406086AbfISWPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E930121928;
        Thu, 19 Sep 2019 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931315;
        bh=m/1Ui7lAw5nP6U+SoRc1jCytiCdOOcqC8BgRxhVGmxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuaQQzL8WJP486rtmsbKcEQh2yRiV/Egd3+E6OYEsn7fyyVFvIKP4Ur3z1Jlw6wVK
         uNhVJm041mm9mmcjMflQTnrlAovHHHGYZphW8IEobLze/BzV4k8kQocJj01Kv5U+3R
         Ve/kOIyJGysUlMUstOk/Z9ckwuq4ICB8vPXFFbg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.19 74/79] PCI: kirin: Fix section mismatch warning
Date:   Fri, 20 Sep 2019 00:03:59 +0200
Message-Id: <20190919214814.234695061@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 6870b673509779195cab300aedc844b352d9cfbc upstream.

The PCI kirin driver compilation produces the following section mismatch
warning:

WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
the function kirin_pcie_probe() to the function
.init.text:kirin_add_pcie_port()
The function kirin_pcie_probe() references
the function __init kirin_add_pcie_port().
This is often because kirin_pcie_probe lacks a __init
annotation or the annotation of kirin_add_pcie_port is wrong.

Remove '__init' from kirin_add_pcie_port() to fix it.

Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-kirin.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_
 	return 0;
 }
 
-static int __init kirin_add_pcie_port(struct dw_pcie *pci,
-				      struct platform_device *pdev)
+static int kirin_add_pcie_port(struct dw_pcie *pci,
+			       struct platform_device *pdev)
 {
 	int ret;
 


