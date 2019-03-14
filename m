Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97020693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCNLpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:45:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfCNLpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:45:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 198E07A178;
        Thu, 14 Mar 2019 11:45:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 694AE18258;
        Thu, 14 Mar 2019 11:45:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 68D1711A86; Thu, 14 Mar 2019 12:45:02 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fbdev: list all pci memory bars as conflicting apertures
Date:   Thu, 14 Mar 2019 12:45:00 +0100
Message-Id: <20190314114500.8336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 11:45:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply add all pci memory bars to struct apertures_struct in
remove_conflicting_pci_framebuffers(), without depending on the
res_id parameter.

The plan is to drop the res_id parameter later on.  For now keep the
parameter, use it for sanity-checking and warn on inconsistencies.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/core/fbmem.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cb43a2258c51..e4e5c129a0f5 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1879,14 +1879,35 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 {
 	struct apertures_struct *ap;
 	bool primary = false;
-	int err;
+	int err, idx, bar;
+	bool res_id_found = false;
 
-	ap = alloc_apertures(1);
+	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		idx++;
+	}
+
+	ap = alloc_apertures(idx);
 	if (!ap)
 		return -ENOMEM;
 
-	ap->ranges[0].base = pci_resource_start(pdev, res_id);
-	ap->ranges[0].size = pci_resource_len(pdev, res_id);
+	for (idx = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		ap->ranges[idx].base = pci_resource_start(pdev, bar);
+		ap->ranges[idx].size = pci_resource_len(pdev, bar);
+		pci_info(pdev, "%s: bar %d: 0x%lx -> 0x%lx\n", __func__, bar,
+			 (unsigned long)pci_resource_start(pdev, bar),
+			 (unsigned long)pci_resource_end(pdev, bar));
+		idx++;
+		if (res_id == bar)
+			res_id_found = true;
+	}
+	if (!res_id_found)
+		pci_warn(pdev, "%s: passed res_id (%d) is not a memory bar\n",
+			 __func__, res_id);
+
 #ifdef CONFIG_X86
 	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
 					IORESOURCE_ROM_SHADOW;
-- 
2.18.1

