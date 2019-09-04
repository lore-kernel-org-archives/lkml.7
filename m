Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BEC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272D2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620679;
	bh=6VocBX/cUeMQovf54r30/HgPsxfG/keOsg+hSKLsjPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q26uhPmFHqf3CXRSMabtYNa5U1x6uxyYDx07YjqVXiJ10CQuInZlynNbIBNyFpz/K
	 xRwFPBgwyMum/m9T4sSUVamFAaPvSUXOEIqTl1PFMMQMoIW+T+BPwDYdNdx/BfYmVo
	 ebnclF95vxHfM1ERpVLf74zjbPwL0+EImRc+Tavg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbfIDSLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389078AbfIDSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4937B2087E;
        Wed,  4 Sep 2019 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620675;
        bh=6VocBX/cUeMQovf54r30/HgPsxfG/keOsg+hSKLsjPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1qikXAhjY9nwSoQpREVg1orzn5241AD9Skcu9NCUG2lGZ2MOyD2vojhNVRhfgLU6
         tG1UcxkLSv89zyEFLLA8CpW9UYU6x5U2FAonH2p+QhBKmdh8iuN5UKBJKUD3Xr/AYJ
         x9tH5Ja+F9DOjxTBJqXx9cQGs1mpQd5BY2jHjZ+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 051/143] net: cpsw: fix NULL pointer exception in the probe error path
Date:   Wed,  4 Sep 2019 19:53:14 +0200
Message-Id: <20190904175316.065876752@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 2d683eaaeeb9d33d23674ae635e0ef1448523d18 ]

In certain cases when the probe function fails the error path calls
cpsw_remove_dt() before calling platform_set_drvdata(). This is an
issue as cpsw_remove_dt() uses platform_get_drvdata() to retrieve the
cpsw_common data and leds to a NULL pointer exception. This patches
fixes it by calling platform_set_drvdata() earlier in the probe.

Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
Reported-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2372,6 +2372,7 @@ static int cpsw_probe(struct platform_de
 	if (!cpsw)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, cpsw);
 	cpsw->dev = dev;
 
 	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
@@ -2476,7 +2477,6 @@ static int cpsw_probe(struct platform_de
 		goto clean_cpts;
 	}
 
-	platform_set_drvdata(pdev, ndev);
 	priv = netdev_priv(ndev);
 	priv->cpsw = cpsw;
 	priv->ndev = ndev;


