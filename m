Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5AAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F22084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413458;
	bh=UxEp8ox6OzQg67AWkKUhgIDhv14VbLfTIqTETNkCDyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6JesYqf64PlLJcmJ5ruBrA+dNSi/hfCNFyDZ3oOAPg0xrg1dziQsj5eJdRKcJKFZ
	 5Yr551CHWi8us1JJgOVr56qWEeifwP4sbbuljmMIQ8x7pRNOI27a4Lv5JQ+QQjwNDp
	 YoA0dGg9AujhpRFJfR4O0+94m5hCCG+2KwhE8eFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfLCWu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfLCWuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:50:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8A32054F;
        Tue,  3 Dec 2019 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413454;
        bh=UxEp8ox6OzQg67AWkKUhgIDhv14VbLfTIqTETNkCDyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjEFN5Rqe6ezSQRiwre4KETt4a5uKtX12TjWbXbpn0OXgCyZPQRnECWYmThQZW2jh
         4RvBVsP8f2Tw6bRmpDj+vajFbTcsepjFCy8Prlimp1a72B3fl9NIdqEIANaKcPxxLR
         z4bmB2B7ZuherE4DZmSIbWCz8MamoSPOqVySNdVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/321] xen/pciback: Check dev_data before using it
Date:   Tue,  3 Dec 2019 23:33:13 +0100
Message-Id: <20191203223433.759938991@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 1669907e3d1abfa3f7586e2d55dbbc117b5adba2 ]

If pcistub_init_device fails, the release function will be called with
dev_data set to NULL.  Check it before using it to avoid a NULL pointer
dereference.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xen-pciback/pci_stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 59661db144e51..097410a7cdb74 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -106,7 +106,8 @@ static void pcistub_device_release(struct kref *kref)
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
 	__pci_reset_function_locked(dev);
-	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
+	if (dev_data &&
+	    pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
 		pci_restore_state(dev);
-- 
2.20.1



