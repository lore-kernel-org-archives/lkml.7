Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1740F22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892331;
	bh=wfm3p1mSjCIv3JJ5U8S/ye/6/qwD8rPoPH5Qc/F+lTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LT41M+Oc/0/zYqLDv3sElW6mrT2MMcbYOhYZ403Pcep5NU4qU3DyreBl8aSKtGWNV
	 K5PgTbw1+ENJsErozhXbqyoI2ydWj3KZsBeXJl7ZLYE1ExYcgAO9/AkVsBD/QFQMEh
	 O1MGLvLBW3dtsunnyNQceYKLZEc9bsNsEEiJWUKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfH0HwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfH0HwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:52:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0473217F5;
        Tue, 27 Aug 2019 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892327;
        bh=wfm3p1mSjCIv3JJ5U8S/ye/6/qwD8rPoPH5Qc/F+lTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f97nO4OqiZ36dXAkzIMhhT2cMH1x6kSaLoP/7jQ1wW6wZulMCAJ8sLDOWpDrXUo3/
         4iJndNZXSlcwLaHVeYAh7fWP5xAhcztHxh4npm2MJYQcnmckGu/cccpBul0HSFa7j9
         vxG3NSrpyc9XADWN0yM9jJBJyusm8L+k+/9v1p8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 18/62] can: sja1000: force the string buffer NULL-terminated
Date:   Tue, 27 Aug 2019 09:50:23 +0200
Message-Id: <20190827072701.398701306@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cd28aa2e056cd1ea79fc5f24eed0ce868c6cab5c ]

strncpy() does not ensure NULL-termination when the input string size
equals to the destination buffer size IFNAMSIZ. The output string
'name' is passed to dev_info which relies on NULL-termination.

Use strlcpy() instead.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/sja1000/peak_pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index dd56133cc4616..fc9f8b01ecae2 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -487,7 +487,7 @@ static void pcan_free_channels(struct pcan_pccard *card)
 		if (!netdev)
 			continue;
 
-		strncpy(name, netdev->name, IFNAMSIZ);
+		strlcpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_sja1000dev(netdev);
 
-- 
2.20.1



