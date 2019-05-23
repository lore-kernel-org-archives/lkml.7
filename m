Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2361620881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640882;
	bh=GfdQrzFnILVL/cZ7o1nFes1sgizpbXYSspF2anDWiXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S5f/PU0V0Ke6XA97dKm5W5BdVbZn639xzcEjs7r51SDh0HszwhBx3bsofDC4n3Zmq
	 N0Phs3ZVT7xODJ4F5yJF7kCHaUaJNayb6dzMSs3wwGQ6snf8vZz8g1JSEmLJUQmInC
	 MkDWqXRF4ENzh9WYIDZu1q5tNmwb+FI8I1EzN4Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfEWTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388474AbfEWTM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:12:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D0720863;
        Thu, 23 May 2019 19:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638748;
        bh=GfdQrzFnILVL/cZ7o1nFes1sgizpbXYSspF2anDWiXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNah54MoBLFcq+fF+XzGOmz6VbTKzz5f1mG4Q5cxzslvW2RacOijBAYDen/wxQu70
         COmUqPa3/VEtOnM/5nJKMtblqBNjmaUM6Vg80j2oFvAho9kcM9GWxcbPXSWzi7NUgR
         kYO4gcewqjYDWw6vFDP6s/w80vvFThP+T9oNqTC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Prestwood <james.prestwood@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 50/77] PCI: Mark Atheros AR9462 to avoid bus reset
Date:   Thu, 23 May 2019 21:06:08 +0200
Message-Id: <20190523181726.950315112@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Prestwood <james.prestwood@linux.intel.com>

commit 6afb7e26978da5e86e57e540fdce65c8b04f398a upstream.

When using PCI passthrough with this device, the host machine locks up
completely when starting the VM, requiring a hard reboot.  Add a quirk to
avoid bus resets on this device.

Fixes: c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")
Link: https://lore.kernel.org/linux-pci/20190107213248.3034-1-james.prestwood@linux.intel.com
Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v3.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3369,6 +3369,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_A
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
 
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {


