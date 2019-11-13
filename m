Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45E221D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611955;
	bh=kL0HXZps80TZHqhI8/x93MmrZiMXxsREYGLIJetJgV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IT6g7JwVlF43arZHQm0oGJTlV8NjV9X7XBNOQei9OVYh0P6gNrrAHDWnSTEDu58jG
	 SEeZvaUkYPyVZ74Z41TTxGSEZ5D2CDLG89j5IbGGl+A6x5slmuVEDows9y2HphQNIc
	 iF9Svccrc0ut0R82tOD/KzgGYlVPkX1qUye+zdBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfKMCZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbfKMBv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:51:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5467A2246D;
        Wed, 13 Nov 2019 01:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609887;
        bh=kL0HXZps80TZHqhI8/x93MmrZiMXxsREYGLIJetJgV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGPJLckZ8LaKVOHnYTezb/o8xeBPfDmnuEXzYNLzHh4L4etdwU2njchcW2TM9WSFg
         cy/b8x7y7gwSy5izAqYlfgGEC9pH6l01tjb33NbwRa/mLgEKMPd170uTsqdworZHgl
         0dl8TVGcy1AwNrBoP0Zyp6WWhmn96gOG4z4jRW0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 046/209] dmaengine: timb_dma: Use proper enum in td_prep_slave_sg
Date:   Tue, 12 Nov 2019 20:47:42 -0500
Message-Id: <20191113015025.9685-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 5e621f5d538985f010035c6f3e28c22829d36db1 ]

Clang warns when implicitly converting from one enumerated type to
another. Avoid this by using the equivalent value from the expected
type.

drivers/dma/timb_dma.c:548:27: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                td_desc->desc_list_len, DMA_MEM_TO_DEV);
                                        ^~~~~~~~~~~~~~
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/timb_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 395c698edb4d7..fc0f9c8766a87 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -545,7 +545,7 @@ static struct dma_async_tx_descriptor *td_prep_slave_sg(struct dma_chan *chan,
 	}
 
 	dma_sync_single_for_device(chan2dmadev(chan), td_desc->txd.phys,
-		td_desc->desc_list_len, DMA_MEM_TO_DEV);
+		td_desc->desc_list_len, DMA_TO_DEVICE);
 
 	return &td_desc->txd;
 }
-- 
2.20.1

