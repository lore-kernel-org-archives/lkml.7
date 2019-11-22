Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0530220679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420330;
	bh=OpXDIx5xOYY97zeVa/FNBxT/29iZH3I1AKxSms1pfW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d+VVL69TYe8YuQpMx7VOXjr1XN8rT4FqJyzF6uBIEG/nt2HP/IukUL3nCWv1IEtx9
	 yGQGeX1em9dY7dRZ0lsdvHPr3ZdQM1WiIfpHaWFXS//QkouJkRW+dxQXacjy2O9RaC
	 cAX7D4zPfWWw7s4es+GczEbo3ppNOOw5kyWpYR54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfKVK6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbfKVK6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:58:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3400C20706;
        Fri, 22 Nov 2019 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420312;
        bh=OpXDIx5xOYY97zeVa/FNBxT/29iZH3I1AKxSms1pfW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XoAPSufW4JmHJCMUj0/8zLH37ZRDv3UtjeR11Tdx63eME4HF5sl9eg4mej+kow/Ea
         kfsykfy/vafJGyp5DWTj4U5PFkR5ToRLiLNGvZ1pQvNreeHnhkhWiMtRIpxXEhpm25
         hXmeDU6FfOfvmK6UTLtjJ1shkiGUNGNYbJotlMdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/220] x86/PCI: Apply VMDs AERSID fixup generically
Date:   Fri, 22 Nov 2019 11:27:08 +0100
Message-Id: <20191122100916.631460501@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Derrick <jonathan.derrick@intel.com>

[ Upstream commit 4f475e8e0a6d4f5d430350d1f74f7e4899fb1692 ]

A root port Device ID changed between simulation and production.  Rather
than match Device IDs which may not be future-proof if left unmaintained,
match all root ports which exist in a VMD domain.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/fixup.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index bd372e8965571..527e69b120025 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -629,17 +629,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
 static void quirk_no_aersid(struct pci_dev *pdev)
 {
 	/* VMD Domain */
-	if (is_vmd(pdev->bus))
+	if (is_vmd(pdev->bus) && pci_is_root_bus(pdev->bus))
 		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334a, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334b, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334c, quirk_no_aersid);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x334d, quirk_no_aersid);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
 
 static void quirk_intel_th_dnv(struct pci_dev *dev)
 {
-- 
2.20.1



