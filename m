Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88502C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5877722467
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610223;
	bh=dlyw4oCcyKNR2SNh/XhvBtQMONKlvoPuARJ9KYHE57U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sp602xN5kRXAxv8dzV6SeD/XBtiDhVjCJx5CP+U2nnkJn1NNk8twBW7zf2mGNDken
	 yns1ya6UP7T5Ahusn0UXe86XeXkYHCiVW0r/+haWxIq7YGan3Xkw+mAESbKCts8wC4
	 rl+nRqDQHqjr+JOz6NsYS7qjbxsT0itb2xgOMA7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfKMB5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbfKMB44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B52E222D4;
        Wed, 13 Nov 2019 01:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610216;
        bh=dlyw4oCcyKNR2SNh/XhvBtQMONKlvoPuARJ9KYHE57U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfjFVb2Ozm1tf4c+hsjxeUur8kO4A1cdrctsFV6B8UJaAkDBVFGKJtQkVzcVl6Tjw
         u0f4y0YSTi0CTrJS2U6BdEMOqvXYugN2D3CFhT2FxyMk7uF7UXitWQ8c3SxF0QXeoF
         uXDaIAWZXGiBEXS9iCTFQbMc5DLi8AG4E+Amucn0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.14 023/115] dmaengine: ep93xx: Return proper enum in ep93xx_dma_chan_direction
Date:   Tue, 12 Nov 2019 20:54:50 -0500
Message-Id: <20191113015622.11592-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 9524d6b265f9b2b9a61fceb2ee2ce1c2a83e39ca ]

Clang warns when implicitly converting from one enumerated type to
another. Avoid this by using the equivalent value from the expected
type.

In file included from drivers/dma/ep93xx_dma.c:30:
./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
conversion from enumeration type 'enum dma_data_direction' to different
enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
                return DMA_NONE;
                ~~~~~~ ^~~~~~~~
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/platform_data/dma-ep93xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
index f8f1f6b952a62..eb9805bb3fe8a 100644
--- a/include/linux/platform_data/dma-ep93xx.h
+++ b/include/linux/platform_data/dma-ep93xx.h
@@ -85,7 +85,7 @@ static inline enum dma_transfer_direction
 ep93xx_dma_chan_direction(struct dma_chan *chan)
 {
 	if (!ep93xx_dma_chan_is_m2p(chan))
-		return DMA_NONE;
+		return DMA_TRANS_NONE;
 
 	/* even channels are for TX, odd for RX */
 	return (chan->chan_id % 2 == 0) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-- 
2.20.1

