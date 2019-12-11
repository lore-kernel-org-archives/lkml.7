Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8EAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A452B2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079605;
	bh=ZWq1Lc77NiXidFXGIZ92vEpsjRzsESPxWGQ82ejVK3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2RgNK/SdRKkJ7ipCmsNtSGI+Ru0N7pDHMA4/33EEpZwSMA6SRAq670FUOHGloaiZ
	 PhdQFyg0f4m+7XmFH3KYE32SZ5D9Z8PRotCT6wleiXqlmqMjwUjVHocQZxHQm18Fb2
	 lYDd4cVNTq+NmvUrSmI6QiWdRzhFrYv7r4xX/FRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfLKPTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732183AbfLKPTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:19:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2512073D;
        Wed, 11 Dec 2019 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077548;
        bh=ZWq1Lc77NiXidFXGIZ92vEpsjRzsESPxWGQ82ejVK3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tc3vGzWgPQyYPIXvvb7Ct9wLvBEkXZUk+D8EtDZNq6gqSoplza56lKYhE98vp1Cwe
         jhAF5UpHZX0SfcpYyzhBDGvTKL48lPIr+h9cr/BVLqOuAVmp+MA04G0FjPrlThS+Rh
         hNhMAzfFHMaWYkTzjNtGb5oM50CWxpr83yZGvKH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/243] net/smc: use after free fix in smc_wr_tx_put_slot()
Date:   Wed, 11 Dec 2019 16:04:03 +0100
Message-Id: <20191211150344.576230307@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ursula.braun@linux.ibm.com>

[ Upstream commit e438bae43c1e08e688c09c410407b59fc1c173b4 ]

In smc_wr_tx_put_slot() field pend->idx is used after being
cleared. That means always idx 0 is cleared in the wr_tx_mask.
This results in a broken administration of available WR send
payload buffers.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_wr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 3c458d2798557..c2694750a6a8a 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -215,12 +215,14 @@ int smc_wr_tx_put_slot(struct smc_link *link,
 
 	pend = container_of(wr_pend_priv, struct smc_wr_tx_pend, priv);
 	if (pend->idx < link->wr_tx_cnt) {
+		u32 idx = pend->idx;
+
 		/* clear the full struct smc_wr_tx_pend including .priv */
 		memset(&link->wr_tx_pends[pend->idx], 0,
 		       sizeof(link->wr_tx_pends[pend->idx]));
 		memset(&link->wr_tx_bufs[pend->idx], 0,
 		       sizeof(link->wr_tx_bufs[pend->idx]));
-		test_and_clear_bit(pend->idx, link->wr_tx_mask);
+		test_and_clear_bit(idx, link->wr_tx_mask);
 		return 1;
 	}
 
-- 
2.20.1



