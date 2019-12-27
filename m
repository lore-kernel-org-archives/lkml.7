Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423E0C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171102176D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469199;
	bh=Cm/FXUokmBwUWaazZYSM4VH0fK5k9FrRbUsXO20vaLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDDM5rJ/+m00fttMmczYksF8LDCO/XD8VQb4QlaXutSVKdNioIBi+ix4uO0VVvDYf
	 84X8oU3RB4B9Zy7y0OUiyo7Tj09++mtfJ8xam4IYwBGLX4Z5gkgq4ilIqdp9iCiOuN
	 mSZ7aYE85ORy52kmSQwK9YzyJSUoOJ7wtVR1rs1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfL0Rmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfL0Rmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B335B21582;
        Fri, 27 Dec 2019 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468568;
        bh=Cm/FXUokmBwUWaazZYSM4VH0fK5k9FrRbUsXO20vaLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yaCmE9o2ffTnqy8VXug5x6RyU8vFhvvVJ8Bf8vKoC7/EKLKz5AFSUDX06sY6if2lx
         3vfc1DJx4eDRHEUXLMNVwdedYWTrumadSPg/vDb4MmKKK2qRk493L58BTJAzPosY9o
         HZTL4kx1U89dpAdQUu4JU+NTW+n0CiPd0uBAspSM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 093/187] powerpc: Ensure that swiotlb buffer is allocated from low memory
Date:   Fri, 27 Dec 2019 12:39:21 -0500
Message-Id: <20191227174055.4923-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit 8fabc623238e68b3ac63c0dd1657bf86c1fa33af ]

Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G.
If a system has more physical memory than this limit, the swiotlb
buffer is not addressable because it is allocated from memblock using
top-down mode.

Force memblock to bottom-up mode before calling swiotlb_init() to
ensure that the swiotlb buffer is DMA-able.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191204123524.22919-1-rppt@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index be941d382c8d..14c2c53e3f9e 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -260,6 +260,14 @@ void __init mem_init(void)
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
 
 #ifdef CONFIG_SWIOTLB
+	/*
+	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
+	 * 4G. We force memblock to bottom-up mode to ensure that the
+	 * memory allocated in swiotlb_init() is DMA-able.
+	 * As it's the last memblock allocation, no need to reset it
+	 * back to to-down.
+	 */
+	memblock_set_bottom_up(true);
 	swiotlb_init(0);
 #endif
 
-- 
2.20.1

