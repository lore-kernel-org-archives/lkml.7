Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A45920836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688210;
	bh=vES2JpL9+n3cdTc3aLjIJMgt7Ru9xUrimGD2/EKC1C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GtLTmtqNnJDNXpc2T+5Cbm4cCW/5xVuZ/jenvNK6HaXoNSfYCS2PkLw68RYVSym2T
	 f1lzdPej6s7uyQ7rdpk+OeAiXzpA5ZYW6a9dtAxKDQUNymcuN0IvLKIqkh6MTsCk74
	 PImG0zihegdR7PRgLwd3XoE5KBsTtaNquC5GMoAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCDIaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfCDIaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AFC2208E4;
        Mon,  4 Mar 2019 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688205;
        bh=vES2JpL9+n3cdTc3aLjIJMgt7Ru9xUrimGD2/EKC1C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKTUt05eSx0rjG+sisDOZ5pAXIBA0N1Av7ORnQ5qiGIwt85QuPTQ4dVAoxvidRR44
         +5adXiSyEQyGuFuPMRfYUFTIBkpODd07dtFvqYlVDLAuq4zNRxqX1ImBbDHVpBAg6e
         o1IvndlzBt8aGL/2nWukjxluFOYHyDeQef/T1AEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/78] net: altera_tse: fix connect_local_phy error path
Date:   Mon,  4 Mar 2019 09:22:32 +0100
Message-Id: <20190304081627.684010564@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 17b42a20d7ca59377788c6a2409e77569570cc10 ]

The connect_local_phy should return NULL (not negative errno) on
error, since its caller expects it.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/altera/altera_tse_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index baca8f704a459..c3c1195021a2b 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -714,8 +714,10 @@ static struct phy_device *connect_local_phy(struct net_device *dev)
 
 		phydev = phy_connect(dev, phy_id_fmt, &altera_tse_adjust_link,
 				     priv->phy_iface);
-		if (IS_ERR(phydev))
+		if (IS_ERR(phydev)) {
 			netdev_err(dev, "Could not attach to PHY\n");
+			phydev = NULL;
+		}
 
 	} else {
 		int ret;
-- 
2.19.1



