Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A14820868
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639399;
	bh=KYikK1JLLVyzvW7pXda+GM9WVHPirwtjFfbWEW8PFiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z1Mw5LNw1lXJCtrPYJIPb0b+CeoW0cS4RWOiipQC6kpnNfZ+krEkEdbpxE2Pvv+uT
	 EJfqi67gwv5ZoSVjgNEcd8dJhadiv+Gypxm8akeYCmEaq6mTN7Qjki0mZpbqhtEZsm
	 vYoUjTsO/XFp03iQCWyjRHiMkGzbG6J/uAdE85tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbfEWTXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390633AbfEWTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:23:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1B82054F;
        Thu, 23 May 2019 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639387;
        bh=KYikK1JLLVyzvW7pXda+GM9WVHPirwtjFfbWEW8PFiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pin7bLv9LB1msOpVB3z4m3hSrkHfH/072XeJofxWz7tH/p0PM3fmywZyGtS5jrvsK
         wnLiMz3ctihlHHu4kvuJIV4mAaiXrMPe4jjo5i5WQ1HlnT8OvVIKK1FXdepVcARNJg
         Uu25C2K6zOMPr1rswPRloy4Sn1yXhE10Z6MEqfYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Prestwood <james.prestwood@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.0 086/139] PCI: Mark Atheros AR9462 to avoid bus reset
Date:   Thu, 23 May 2019 21:06:14 +0200
Message-Id: <20190523181731.943827021@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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
@@ -3408,6 +3408,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_A
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
 
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus


