Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A71CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1083C24685
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781627;
	bh=dMGkbPFe123XI7GBxfT6EbFpYp1DKEsZBNIpCaq7Lbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xYDjX/F6qRanDu0zHoG10IM7BUDooKLzn/5XWzyTVbwZw91OHkBd3d996ShE8Twds
	 9zV1r1QMIgsSmgsWs3Qu5gzmF4yYDZehaJqgI87OUcipb38GtWhbhP7eaxD+1AgOES
	 Tlf9+zQowhEWi/hkTjMm8H8tKid2sytQaEM4P5wU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfLSSxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfLSSxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:53:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF46C227BF;
        Thu, 19 Dec 2019 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781622;
        bh=dMGkbPFe123XI7GBxfT6EbFpYp1DKEsZBNIpCaq7Lbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdJuIduz8q8fkxhBGv7mTURK6wicVBFDZkakU7jFGkUsfcaBbgyuYsSZCY2PExoDR
         gbL5m4PB4P+9b64bczcmPXwAclCJ/URS609nvcGE7u5hDx9cAy1YRn5BkSbkdR8MwM
         3LWroxUzv9AJ7cma+gc6Jf6lQgvsw67+9sXChhAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        George Cherian <george.cherian@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 5.4 13/80] PCI: Apply Cavium ACS quirk to ThunderX2 and ThunderX3
Date:   Thu, 19 Dec 2019 19:34:05 +0100
Message-Id: <20191219183049.551524774@linuxfoundation.org>
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

From: George Cherian <george.cherian@marvell.com>

commit f338bb9f0179cb959977b74e8331b312264d720b upstream.

Enhance the ACS quirk for Cavium Processors. Add the root port vendor IDs
for ThunderX2 and ThunderX3 series of processors.

[bhelgaas: add Fixes: and stable tag]
Fixes: f2ddaf8dfd4a ("PCI: Apply Cavium ThunderX ACS quirk to more Root Ports")
Link: https://lore.kernel.org/r/20191111024243.GA11408@dc5-eodlnx05.marvell.com
Signed-off-by: George Cherian <george.cherian@marvell.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Robert Richter <rrichter@marvell.com>
Cc: stable@vger.kernel.org	# v4.12+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4313,15 +4313,21 @@ static int pci_quirk_amd_sb_acs(struct p
 
 static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 {
+	if (!pci_is_pcie(dev) || pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return false;
+
+	switch (dev->device) {
 	/*
-	 * Effectively selects all downstream ports for whole ThunderX 1
-	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
-	 * bits of device ID are used to indicate which subdevice is used
-	 * within the SoC.
+	 * Effectively selects all downstream ports for whole ThunderX1
+	 * (which represents 8 SoCs).
 	 */
-	return (pci_is_pcie(dev) &&
-		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
-		((dev->device & 0xf800) == 0xa000));
+	case 0xa000 ... 0xa7ff: /* ThunderX1 */
+	case 0xaf84:  /* ThunderX2 */
+	case 0xb884:  /* ThunderX3 */
+		return true;
+	default:
+		return false;
+	}
 }
 
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)


