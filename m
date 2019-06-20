Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9142EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC7C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055327;
	bh=cNcSTqBV/JlD6xYl/mVHboysfBPtx7HlQQDZkb+39DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=giwY51OXu6FU4jtCZIiYud7ZGmlDVI/pzoa4jjDMEDWofOpOd11lZo8fah/AEfbSi
	 RVKNi2pLUku47qC/JieZW+UbYJm3qFkmlUTgMk263SMvdV+TxodveFX88hqgBPB1Vb
	 FIt5vWrSyl3tcUsHULIb/vy0cH6MJY05OuwaXwEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFTS2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfFTSDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:03:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC2E21655;
        Thu, 20 Jun 2019 18:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053810;
        bh=cNcSTqBV/JlD6xYl/mVHboysfBPtx7HlQQDZkb+39DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4we1WFtGeopDl7DGUcMZv+B7TdX8xcuCQl9qsCtKwlUoIUzuN1Alpl4+EFJCu6YC
         gDenwmootPl2F53e8PqId5y3Vgh0hDg8XqSs5q9bGczI5XIR48nCx12aHWC4oEnU0p
         3jNf3p9+jwyBKnbwlaTahOxF7dnQ6z8Q2N82ThkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Enrico Granata <egranata@chromium.org>,
        Jett Rink <jettrink@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 034/117] platform/chrome: cros_ec_proto: check for NULL transfer function
Date:   Thu, 20 Jun 2019 19:56:08 +0200
Message-Id: <20190620174354.036072636@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 94d4e7af14a1170e34cf082d92e4c02de9e9fb88 ]

As new transfer mechanisms are added to the EC codebase, they may
not support v2 of the EC protocol.

If the v3 initial handshake transfer fails, the kernel will try
and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
will be NULL, and the code will end up causing a kernel panic.

Add a check for NULL before calling the transfer function, along
with a helpful comment explaining how one might end up in this
situation.

Signed-off-by: Enrico Granata <egranata@chromium.org>
Reviewed-by: Jett Rink <jettrink@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index cfa3e850c49f..d225a835a64c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -67,6 +67,17 @@ static int send_command(struct cros_ec_device *ec_dev,
 	else
 		xfer_fxn = ec_dev->cmd_xfer;
 
+	if (!xfer_fxn) {
+		/*
+		 * This error can happen if a communication error happened and
+		 * the EC is trying to use protocol v2, on an underlying
+		 * communication mechanism that does not support v2.
+		 */
+		dev_err_once(ec_dev->dev,
+			     "missing EC transfer API, cannot send command\n");
+		return -EIO;
+	}
+
 	ret = (*xfer_fxn)(ec_dev, msg);
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
-- 
2.20.1



