Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60B7206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892593;
	bh=WNAYaTCm/DuIV/YTw8PphHpZoUionmMISLX3azyMnY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1q6UW91QUhtRIC3LmPoI9D8Nv/nA5BuD8q94Ja86U2m2uxJitA2dLAHEITN5OgRG
	 tpUypVZMtioXz4LnFFgutH+fdyTRFM31jZTpyNGsbeBmyNqRLfYU3Q8UTWfiHlPdig
	 M/uDHF2DhlmfJZIkTrgYE9X/SOeJyf1XvGnecQ/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfH0H4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfH0H4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:56:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674EA206BA;
        Tue, 27 Aug 2019 07:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892589;
        bh=WNAYaTCm/DuIV/YTw8PphHpZoUionmMISLX3azyMnY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIWP6/hKtFTNrBobYYuHI2cbOdWc/GA2rUaxTruR/zYqZMtM95BMnljj7fEnlaUN7
         Ij95Vxb1BApgisbDwd4bRsY8QglMhITu6xwkM3r05WWZAvU3ofSXuFSo4oiJjetJwE
         YzJa8T4W6GShC+kYgCaP49pqfLemDcIZ5sZWo9Yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/98] net: stmmac: tc: Do not return a fragment entry
Date:   Tue, 27 Aug 2019 09:50:23 +0200
Message-Id: <20190827072720.543253959@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4a6a1385a4db5f42258a40fcd497cbfd22075968 ]

Do not try to return a fragment entry from TC list. Otherwise we may not
clean properly allocated entries.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 58ea18af9813a..37c0bc699cd9c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -37,7 +37,7 @@ static struct stmmac_tc_entry *tc_find_entry(struct stmmac_priv *priv,
 		entry = &priv->tc_entries[i];
 		if (!entry->in_use && !first && free)
 			first = entry;
-		if (entry->handle == loc && !free)
+		if ((entry->handle == loc) && !free && !entry->is_frag)
 			dup = entry;
 	}
 
-- 
2.20.1



