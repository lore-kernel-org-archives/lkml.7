Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4930C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52FB2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfCMLIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:08:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCMLIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:08:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 923D43082B6E;
        Wed, 13 Mar 2019 11:08:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDBC60165;
        Wed, 13 Mar 2019 11:08:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4182711A86; Wed, 13 Mar 2019 12:08:20 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [RfC PATCH] fbdev: list all memory bars as conflicting apertures
Date:   Wed, 13 Mar 2019 12:07:41 +0100
Message-Id: <20190313110741.6541-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 13 Mar 2019 11:08:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply add all pci memory bars to struct apertures_struct in
remove_conflicting_pci_framebuffers().  That allows to drop
the res_id parameter.

TODO: actually remove the res_id parameter.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cb43a2258c51..e8223c231de2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1879,14 +1879,28 @@ int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const
 {
 	struct apertures_struct *ap;
 	bool primary = false;
-	int err;
+	int err, idx, cnt, bar;
 
-	ap = alloc_apertures(1);
+	for (cnt = 0, bar = 0; bar < PCI_ROM_RESOURCE; bar++) {
+		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
+			continue;
+		cnt++;
+	}
+
+	ap = alloc_apertures(cnt);
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
+	}
 #ifdef CONFIG_X86
 	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
 					IORESOURCE_ROM_SHADOW;
-- 
2.18.1

