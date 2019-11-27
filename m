Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18651C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA371215F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888487;
	bh=cgHiA7DDTWxGxz5X7SG64ZBTuO5N5bph52IcLJ9ZLyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SwXNHo2FP4KVdhRICNHMqi+QMpjsnd0hYJsXspxWCo7/BIke1FZOw1dnD0vYHWaQG
	 4DPot8oH/TaA0QiXD5autw48a3+nzmHfcgdNau3cTVLRXMtpvUtASD/qae37gZf3gc
	 /ZeOKkoHL/cN/YVQJ5NY5zSTNUvo2lfrcjhFWHiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfK0VB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730869AbfK0VBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:01:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2760C215A4;
        Wed, 27 Nov 2019 21:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888481;
        bh=cgHiA7DDTWxGxz5X7SG64ZBTuO5N5bph52IcLJ9ZLyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ai551BFz9tH9JAnr03nxiOpCzMQDxPnOjEa2ruyh2Np9cSZyX0deXUyHCvCWTbDAC
         W3HCIeuzPE1Oeo8K8MQEvLSr8B4S3ipoFw5hRW3sxVuQVaV+66ciuTo7cgukd6ocvk
         agZt5gLGnO/dLynyR19xfc8ggEJ+7CIMJRlgzAOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Radu Rendec <radu.rendec@gmail.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 152/306] macsec: let the administrator set UP state even if lowerdev is down
Date:   Wed, 27 Nov 2019 21:30:02 +0100
Message-Id: <20191127203126.795033991@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 07bddef9839378bd6f95b393cf24c420529b4ef1 ]

Currently, the kernel doesn't let the administrator set a macsec device
up unless its lower device is currently up. This is inconsistent, as a
macsec device that is up won't automatically go down when its lower
device goes down.

Now that linkstate propagation works, there's really no reason for this
limitation, so let's remove it.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Reported-by: Radu Rendec <radu.rendec@gmail.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 50acd8c9d7f53..10a8ef2d025a1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2813,9 +2813,6 @@ static int macsec_dev_open(struct net_device *dev)
 	struct net_device *real_dev = macsec->real_dev;
 	int err;
 
-	if (!(real_dev->flags & IFF_UP))
-		return -ENETDOWN;
-
 	err = dev_uc_add(real_dev, dev->dev_addr);
 	if (err < 0)
 		return err;
-- 
2.20.1



