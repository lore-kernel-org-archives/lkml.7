Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C25C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mvC/tSy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDZOuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:50:44 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5987 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:50:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31aa70000>; Fri, 26 Apr 2019 07:50:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:50:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 26 Apr 2019 07:50:42 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:42 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:50:42 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31ac10003>; Fri, 26 Apr 2019 07:50:41 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 4/6] usb: ehci: Adjusted for usb_hub_clear_tt_buffer
Date:   Fri, 26 Apr 2019 22:50:39 +0800
Message-ID: <1556290239-9523-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290215; bh=hakNu7nmlWRRhwVrRoWCmmF4BvpmgMEUjJOZfH40V9I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=mvC/tSy0BCim/OS5OhaITsNFD6MLHUL8mubBGIbYdqszQ8DVXJmxNpq0Q0fTTfOWK
         ZtajKN/7XVfk5udTTEsd2dGWfAQqAWnv0NV6l+wsHGyzHChFWuSSsTZDXb3arZVoXs
         Xac9zoyg9zRBuTcROvSGr+04PtDhDOcH3RJKjum24od7BVmKZhdaFq5NK0LkxonLx+
         8mzc/Ua6hBSAGGLcZpOTFQ2JIJ9zNtMVhCvEuc1SwA4Xwp77pcWP6FzFtmQtcbDeV2
         8jTYBP751IOeLPc43CSVVDuatUDmU2JkSK0L+VLpJdXYkO+Xtx67LhNPa0+Xr+SNbj
         RqQQqHl1mJPtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add argument for usb_hub_clear_tt_buffer to specify device number
that will have the TT state of its hub cleared.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/host/ehci-q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index aa2f77f1506d..9f64c260239e 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -169,7 +169,7 @@ static void ehci_clear_tt_buffer(struct ehci_hcd *ehci, struct ehci_qh *qh,
 		if (!ehci_is_TDI(ehci)
 				|| urb->dev->tt->hub !=
 				   ehci_to_hcd(ehci)->self.root_hub) {
-			if (usb_hub_clear_tt_buffer(urb) == 0)
+			if (!usb_hub_clear_tt_buffer(urb, urb->dev->devnum))
 				qh->clearing_tt = 1;
 		} else {
 
-- 
2.1.4

