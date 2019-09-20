Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47195C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B567207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MFObRWtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405891AbfITRED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:04:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57766 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405819AbfITREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:04:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8KH3weS012318;
        Fri, 20 Sep 2019 12:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568999038;
        bh=I+xPy3xNOHEoo8tC6L9GoL1DnBDGS+nM7VEaBsreGCU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MFObRWtLbm3cCYWHU0e0yuQyHxnP2jQcfuG7xnFs1yTQCRD1m5hybDfHv3O3bjgrT
         FgSIV1EKgzH/iN2zW4kzPo5tGogRRT+/VHFOBOcykhgkMswwmUnXjE+YSMtkDI3Uit
         yKJPdvrHi/khL/bmWqyA9oa9DhtPkEg1OGuVrR4M=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KH3wRp055945;
        Fri, 20 Sep 2019 12:03:58 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 20
 Sep 2019 12:03:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 20 Sep 2019 12:03:57 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KH3r6x054719;
        Fri, 20 Sep 2019 12:03:57 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 05/13] media: am437x-vpfe: fix start streaming error path
Date:   Fri, 20 Sep 2019 12:05:46 -0500
Message-ID: <20190920170554.29666-6-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920170554.29666-1-bparrot@ti.com>
References: <20190920170554.29666-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When start_streaming fails the h/w module might be left enabled
inadvertently. Make sure it is disabled in the error path.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/am437x/am437x-vpfe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index 66df87d310a2..e0a4c8920df8 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -2008,6 +2008,7 @@ static int vpfe_start_streaming(struct vb2_queue *vq, unsigned int count)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
 	}
 
+	vpfe_pcr_enable(&vpfe->ccdc, 0);
 	return ret;
 }
 
-- 
2.17.1

