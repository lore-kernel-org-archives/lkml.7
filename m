Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9D62196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498524;
	bh=Z5CEjgq2ljlTHK2PBa5/v+pJ3uM3+XprsHPKtfcyc7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lFhNAglCK/nEPSu9tJcpincYOJZArXN3kOEE2TMl6T4Nx5NPj8EEk86LA6k9SNN9A
	 pFJlYGX77zw05aoeX4nYZ1Px3I6IdAVOlR1gfufnuTcpkCfozDGBZvQij2/hu0hvtM
	 jwPTZ1aGtApUH3U7xlXSsq6oYWI9m61s6gyk6RVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfKKSzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfKKSzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:55:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23EF2173B;
        Mon, 11 Nov 2019 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498517;
        bh=Z5CEjgq2ljlTHK2PBa5/v+pJ3uM3+XprsHPKtfcyc7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2GkPkmNwqReNJr9KH5Hv8PjOu6k9wU5nUihiEDyP/GNv3PMfFfASj7A9dtjgnKpH
         0rFI3bRnzg2qRsxUoWVnq6oZLDqwfSvAHoVVrMLsX+wBlMKTFJSB336oWgEOvmayQK
         wt4EN5BTNG5iWpdnePl/+coQe4Jgo5XdW8ZutsU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 141/193] usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
Date:   Mon, 11 Nov 2019 19:28:43 +0100
Message-Id: <20191111181511.558159952@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 9bbfceea12a8f145097a27d7c7267af25893c060 ]

In dwc3_pci_probe a call to platform_device_alloc allocates a device
which is correctly put in case of error except one case: when the call to
platform_device_add_properties fails it directly returns instead of
going to error handling. This commit replaces return with the goto.

Fixes: 1a7b12f69a94 ("usb: dwc3: pci: Supply device properties via driver data")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 5e8e18222f922..023f0357efd77 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -258,7 +258,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	ret = platform_device_add_properties(dwc->dwc3, p);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	ret = dwc3_pci_quirks(dwc);
 	if (ret)
-- 
2.20.1



