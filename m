Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A638C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564F320881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640607;
	bh=iexFoTaFwO36Jeleb/WolXR7z6X+bBz7nxFVc/Qrhus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Afd6w9UgLkBiuuJb2CefIFH4hhSDNBQuBwrogtECLXUNnfuJ3g6JrSheKg/BoMYvY
	 LTWe17rb92ys6pfb7nQ/sgZjtWjBx+qt5kUTX0BhqH7XHB9Wc8HtAn9zTF1m7a8qjf
	 yCTE1TnX9sxZQoDwmNsxXRAPdnFPUQIFdJIcb/vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbfEWTn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389505AbfEWTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:18:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78106205ED;
        Thu, 23 May 2019 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639081;
        bh=iexFoTaFwO36Jeleb/WolXR7z6X+bBz7nxFVc/Qrhus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8JVwpr2lCdmgaoFog1PvVy1ZbYQDw544eW9xKUL5OqB2fTl5kKi8oyosXBD5f3KE
         bp2+5ZyWWLB1UETo3blKNeJ0ROiki3h2uV1eGtRjZc7DlVo+VBgECEgKcZet0yMOiA
         UvKLACVlNsDMRUeF1g2L1qvQ5d8yLMVJV4yjB6xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolai Kostrigin <nickel@altlinux.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.19 070/114] PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken
Date:   Thu, 23 May 2019 21:06:09 +0200
Message-Id: <20190523181738.087242815@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kostrigin <nickel@altlinux.org>

commit d28ca864c493637f3c957f4ed9348a94fca6de60 upstream.

ATS is broken on the Radeon R7 GPU (at least for Stoney Ridge based laptop)
and causes IOMMU stalls and system failure.  Disable ATS on these devices
to make them usable again with IOMMU enabled.

Thanks to Joerg Roedel <jroedel@suse.de> for help.

[bhelgaas: In the email thread mentioned below, Alex suspects the real
problem is in sbios or iommu, so it may affect only certain systems, and it
may affect other devices in those systems as well.  However, per Joerg we
lack the ability to debug further, so this quirk is the best we can do for
now.]

Link: https://bugzilla.kernel.org/show_bug.cgi?id=194521
Link: https://lore.kernel.org/lkml/20190408103725.30426-1-nickel@altlinux.org
Fixes: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4878,6 +4878,7 @@ static void quirk_no_ats(struct pci_dev
 
 /* AMD Stoney platform GPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */


