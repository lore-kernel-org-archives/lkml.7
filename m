Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D2C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C16227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781621;
	bh=Yy3XFsEZe3sqWetSTqVFGhQUN8SLOL5eBvnri+gU0VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JWuDbac1o1lsuO4tz8L9tUbu0sU+90LlcaDcL3AwmskXjOt5xeiic4314VgIyKg6D
	 ROL0F3/23R76K7cul+lI6LW7YJ760Fg2Oxf6LTXxT+cnYfaqiBT64ycArE0Qvm1n0t
	 AKPB5HwUed8Hek98oWmdk08DtuG1Vqiz3zVn3X08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfLSSxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfLSSxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:53:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ABDD20674;
        Thu, 19 Dec 2019 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781615;
        bh=Yy3XFsEZe3sqWetSTqVFGhQUN8SLOL5eBvnri+gU0VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLTObImYYxcGmucGaSFMCzT/2TsB4NNSH9nvz64qXCuKSu5YhGhz2sbso9IK4VumY
         93NyVGnUcwLAl9TA14L9l88HgSk96cCe5gNkjKZ+Z6w6DlEZx5oCbYyLoa/Cgq4f64
         4IUgh4loR0ffPvaAS5xZixmWhgu2SIe3nr0UJpl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.4 10/80] PCI/MSI: Fix incorrect MSI-X masking on resume
Date:   Thu, 19 Dec 2019 19:34:02 +0100
Message-Id: <20191219183045.268358671@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit e045fa29e89383c717e308609edd19d2fd29e1be upstream.

When a driver enables MSI-X, msix_program_entries() reads the MSI-X Vector
Control register for each vector and saves it in desc->masked.  Each
register is 32 bits and bit 0 is the actual Mask bit.

When we restored these registers during resume, we previously set the Mask
bit if *any* bit in desc->masked was set instead of when the Mask bit
itself was set:

  pci_restore_state
    pci_restore_msi_state
      __pci_restore_msix_state
        for_each_pci_msi_entry
          msix_mask_irq(entry, entry->masked)   <-- entire u32 word
            __pci_msix_desc_mask_irq(desc, flag)
              mask_bits = desc->masked & ~PCI_MSIX_ENTRY_CTRL_MASKBIT
              if (flag)       <-- testing entire u32, not just bit 0
                mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT
              writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL)

This means that after resume, MSI-X vectors were masked when they shouldn't
be, which leads to timeouts like this:

  nvme nvme0: I/O 978 QID 3 timeout, completion polled

On resume, set the Mask bit only when the saved Mask bit from suspend was
set.

This should remove the need for 19ea025e1d28 ("nvme: Add quirk for Kingston
NVME SSD running FW E8FK11.T").

[bhelgaas: commit log, move fix to __pci_msix_desc_mask_irq()]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Link: https://lore.kernel.org/r/20191008034238.2503-1-jian-hong@endlessm.com
Fixes: f2440d9acbe8 ("PCI MSI: Refactor interrupt masking code")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/msi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -213,12 +213,13 @@ u32 __pci_msix_desc_mask_irq(struct msi_
 
 	if (pci_msi_ignore_mask)
 		return 0;
+
 	desc_addr = pci_msix_desc_addr(desc);
 	if (!desc_addr)
 		return 0;
 
 	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	if (flag)
+	if (flag & PCI_MSIX_ENTRY_CTRL_MASKBIT)
 		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
 
 	writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);


