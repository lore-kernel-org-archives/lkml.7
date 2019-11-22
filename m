Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BE32070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419974;
	bh=54L7zZCQNF70dbdU0EblUtAgWZSXmhYJn0NofEvp4Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohOvEuzoZdsXVqBfLlnkUwTFjiW0LMVNbkwRb57URzF9wxqNdgIRxV/ZyAIEV8lb7
	 t1Sj1PWy3zOp5vgFEE4MUiFlWTVO5luC2Oo97lePpy8f1u4bYzxbQwW864IOppkVsT
	 2m0J+pvHuRGVGUNVus39IE0C3PLLMSiNySn9lidU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfKVKww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbfKVKws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:52:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2A720718;
        Fri, 22 Nov 2019 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419968;
        bh=54L7zZCQNF70dbdU0EblUtAgWZSXmhYJn0NofEvp4Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kx7wQYbUbPFDG82+uj8J0VCh9FYzJeGyAPqPiDr/lzINkRQUJg56XqhWUoW0XdR/g
         jiC5VoVVzAAbkeho6s5csQQU+8wN2kYoJoWfD1LbvXvBzXlH6QCHDFovNU2rESuWhM
         2eCqsG+raHVnZ8ht/5buU2iEw0KxK28rvih2bnJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/122] qtnfmac: pass sgi rate info flag to wireless core
Date:   Fri, 22 Nov 2019 11:28:41 +0100
Message-Id: <20191122100810.970496400@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

[ Upstream commit d5657b709e2a92a0e581109010765d1d485580df ]

SGI should be passed to wireless core as a part of rate structure.
Otherwise wireless core performs incorrect rate calculation when
SGI is enabled in hardware but not reported to host.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 4206886b110ce..ed087bbc6f631 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -485,6 +485,9 @@ qtnf_sta_info_parse_rate(struct rate_info *rate_dst,
 		rate_dst->flags |= RATE_INFO_FLAGS_MCS;
 	else if (rate_src->flags & QLINK_STA_INFO_RATE_FLAG_VHT_MCS)
 		rate_dst->flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+	if (rate_src->flags & QLINK_STA_INFO_RATE_FLAG_SHORT_GI)
+		rate_dst->flags |= RATE_INFO_FLAGS_SHORT_GI;
 }
 
 static void
-- 
2.20.1



