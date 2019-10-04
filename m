Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191F821D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SpLh2mIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfJDQ1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:27:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35264 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfJDQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:27:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94GRiJI008050;
        Fri, 4 Oct 2019 11:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570206464;
        bh=bkx2umkIIdy9uxIZ1foXzqBI6HyplepwuHHRo5GE/h4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SpLh2mIyNyWh4yzhgy19vCf/G8Ewjta0jtjvV+YwdvGb0g0+m3XoO5qa33l5JRMKL
         It3KauPOKN6sZtZl5vx2w6L9YpfaMXxgELatJuED+sIX19F+wVGZNkrINdSiLhyMXx
         Nk4E1OuCnqy1o99BD6uKDkrU8Wlxo+uTgy1ONET4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94GRiZx067298;
        Fri, 4 Oct 2019 11:27:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 11:27:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 11:27:44 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94GRgA3028904;
        Fri, 4 Oct 2019 11:27:44 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: [Patch v2 01/21] media: ti-vpe: Fix a parallel build issue
Date:   Fri, 4 Oct 2019 11:29:32 -0500
Message-ID: <20191004162952.4963-2-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004162952.4963-1-bparrot@ti.com>
References: <20191004162952.4963-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When TI CAL was introduce as another driver under platform/ti-vpe
adding a second entry into the ti-vpe directory in the platform
Makefile caused issues during parallel build.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/media/platform/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 6ee7eb0d36f4..d13db96e3015 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -19,9 +19,7 @@ obj-$(CONFIG_VIDEO_VIVID)		+= vivid/
 obj-$(CONFIG_VIDEO_VIM2M)		+= vim2m.o
 obj-$(CONFIG_VIDEO_VICODEC)		+= vicodec/
 
-obj-$(CONFIG_VIDEO_TI_VPE)		+= ti-vpe/
-
-obj-$(CONFIG_VIDEO_TI_CAL)		+= ti-vpe/
+obj-y	+= ti-vpe/
 
 obj-$(CONFIG_VIDEO_MX2_EMMAPRP)		+= mx2_emmaprp.o
 obj-$(CONFIG_VIDEO_CODA)		+= coda/
-- 
2.17.1

