Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3138DCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31F218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450832;
	bh=MlSn6EG/sX4eezoHVRHjn2g4KK7MWQrmhKBVyLDiuts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ykmp5OvfrlwvrwZRq/nsgKMEvwHlT/w1vQD2RyfHE9mYVaUuOb/Wx5RpThbkZF9xz
	 dcXxB81Okl8zsiYxcqjwwIF3iR2Zm7T1KHWUobpT1k4wnlA68ONw4nVPOcFS404LnB
	 usM+1QLSFthjl7f5lXLm34pmyYYBaKXhRz81x9SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfJ3Pxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfJ3PxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:53:25 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A24D21D7C;
        Wed, 30 Oct 2019 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450804;
        bh=MlSn6EG/sX4eezoHVRHjn2g4KK7MWQrmhKBVyLDiuts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYrnHZLnucQaqDg8+lfcRBGdOQ0yYmtU8ghEReKUFRc30zBPza3+zCucelY1mJDs/
         Mg8Q5nLyIEydzU1uy/2hMZmfK4E6R2IdmA0IeOx+C+z+dP0C0GWHuMSKJkJ5l2uuKT
         B3VXAP20xWdCRthAzKK2diRztIYQWJ3ieCRP5cD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 54/81] ARM: davinci: dm365: Fix McBSP dma_slave_map entry
Date:   Wed, 30 Oct 2019 11:49:00 -0400
Message-Id: <20191030154928.9432-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 564b6bb9d42d31fc80c006658cf38940a9b99616 ]

dm365 have only single McBSP, so the device name is without .0

Fixes: 0c750e1fe481d ("ARM: davinci: dm365: Add dma_slave_map to edma")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/dm365.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2f9ae6431bf54..cebab6af31a2d 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -462,8 +462,8 @@ static s8 dm365_queue_priority_mapping[][2] = {
 };
 
 static const struct dma_slave_map dm365_edma_map[] = {
-	{ "davinci-mcbsp.0", "tx", EDMA_FILTER_PARAM(0, 2) },
-	{ "davinci-mcbsp.0", "rx", EDMA_FILTER_PARAM(0, 3) },
+	{ "davinci-mcbsp", "tx", EDMA_FILTER_PARAM(0, 2) },
+	{ "davinci-mcbsp", "rx", EDMA_FILTER_PARAM(0, 3) },
 	{ "davinci_voicecodec", "tx", EDMA_FILTER_PARAM(0, 2) },
 	{ "davinci_voicecodec", "rx", EDMA_FILTER_PARAM(0, 3) },
 	{ "spi_davinci.2", "tx", EDMA_FILTER_PARAM(0, 10) },
-- 
2.20.1

