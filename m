Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA7C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E587218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354909;
	bh=HFTrE6SKibGWzuM7onuwvoLWQLSo1YWFwO0ChtJYcvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m146jm6IZBtVOaSQDXEMHe1dRk1uC52EVhP1cfeeQpgAW8CA1X13zrd0bvXSIv1O4
	 pJU62zrLP3MF6KsCxHLHB125IKGEeCG2FNmC6kh8qqoC7hn35B18rXeAIPGI0GMyKt
	 HWTtoYaioQ0bBXejefsykwSLW32JnGx5OJNdanSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfDOTBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfDOTBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:01:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD28A2087C;
        Mon, 15 Apr 2019 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354906;
        bh=HFTrE6SKibGWzuM7onuwvoLWQLSo1YWFwO0ChtJYcvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBZkALkmGK/8yYkHsaZZdjRahwkHX4FJVzxitGAy8mqH+AtHwSD624i1xuWj4C26Y
         7WQfP9D797DS1uoK0CEpV/QQM1Rchdk+cQnMcNAvDNS/0xwgEWZ6WBckMf01sSHLsq
         ec9zzcsQp2trEurOHndX/YXUq5TMuOOfaFCb96Xs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 4.14 01/69] net: sfp: move sfp_register_socket call from sfp_remove to sfp_probe
Date:   Mon, 15 Apr 2019 20:58:19 +0200
Message-Id: <20190415183726.537386346@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c4ba68b8691e4 backported from upstream to 4.14 stable was
probably applied wrongly, and instead of calling sfp_register_socket in
sfp_probe, the socket registering code was put into sfp_remove. This is
obviously wrong.

The commit first appeared in 4.14.104. Fix it for the next 4.14 release.

Fixes: c4ba68b8691e4 ("net: sfp: do not probe SFP module before we're attached")
Cc: stable <stable@vger.kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a1b68b19d912..5ab725a571a8 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -878,6 +878,10 @@ static int sfp_probe(struct platform_device *pdev)
 	if (poll)
 		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
 
+	sfp->sfp_bus = sfp_register_socket(sfp->dev, sfp, &sfp_module_ops);
+	if (!sfp->sfp_bus)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -887,10 +891,6 @@ static int sfp_remove(struct platform_device *pdev)
 
 	sfp_unregister_socket(sfp->sfp_bus);
 
-	sfp->sfp_bus = sfp_register_socket(sfp->dev, sfp, &sfp_module_ops);
-	if (!sfp->sfp_bus)
-		return -ENOMEM;
-
 	return 0;
 }
 
-- 
2.19.1



