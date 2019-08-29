Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C33C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2618223428
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567075836;
	bh=/J/pL/ZILwbj2fpr2R1wl8p3szobp5UMq8WAj4cQep8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DxFK3U+6OjOsiOFKYLoJDHJAWrMfKfOf6vRpL5vd0uhOcOV2n79m+f7Pj7X3QvbuS
	 +tPFleLSg6Nm7ZZEBrM5UPn8MZF00UxfCZ54WbuaoFI9MN6X5s+VkRvJy6D7moNk1L
	 so7RT/PCRRf9kSzyfv1WoXZLnwFG4nK2X6LdN4RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfH2Kue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbfH2KuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFBF7233FF;
        Thu, 29 Aug 2019 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075824;
        bh=/J/pL/ZILwbj2fpr2R1wl8p3szobp5UMq8WAj4cQep8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpuqgoxHIjxCqYQ9XuuKOMrw1P4gqLHLePnoFnxfyzOpAODLeUIjsXddSqiI18QC8
         kolrxpn2knIiqMyiWcFDesFj50ZhlazMQkSNX+/vGJwtGUIeZ6lUXvJ4PRRMbc9lpr
         QDTJOOE7VP9AV1yyAQL3f0+VP5dXMEle2QGOmK30=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Pavel Machek <pavel@ucw.cz>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/29] media: stm32-dcmi: fix irq = 0 case
Date:   Thu, 29 Aug 2019 06:49:53 -0400
Message-Id: <20190829105009.2265-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105009.2265-1-sashal@kernel.org>
References: <20190829105009.2265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

[ Upstream commit dbb9fcc8c2d8d4ea1104f51d4947a8a8199a2cb5 ]

Manage the irq = 0 case, where we shall return an error.

Fixes: b5b5a27bee58 ("media: stm32-dcmi: return appropriate error codes during probe")

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index d386822658922..1d9c028e52cba 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1681,7 +1681,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	if (irq <= 0) {
 		if (irq != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Could not get irq\n");
-		return irq;
+		return irq ? irq : -ENXIO;
 	}
 
 	dcmi->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.20.1

