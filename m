Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B20C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C4620679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441568;
	bh=T2Sx5XbxKcUAUg3fm8CFdV0wp8WVisKIMwI4Io0kL08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=co5liNt8nLMs6PE96LtMeW/zPwk+DXEJhJmWKOSr+rQV6L3EQJcfzBfrNBrHsZoLZ
	 G9FUw9tIYF2S8cTdJlgPovkMKFWaI4PU/usHSub4hetl3Q4Bt1Sk+6JRC6RVMUCwPw
	 9zMptZfJNSuznM46fvcwciHu99c2H681J2R4HGd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390442AbfFMP70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbfFMIto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:49:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00A520851;
        Thu, 13 Jun 2019 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415783;
        bh=T2Sx5XbxKcUAUg3fm8CFdV0wp8WVisKIMwI4Io0kL08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQ+KXzWFlB0LTHbHvNS3yYxkrFGqlbgozrgg9yFiIjKngF0bmGuqRD2+ZXnkqBRzP
         KDUGWKfOCf5wVWbd83cTD3IpbleMpE1YFJf67duE7eBA3u/6EXAYSOJrF/uW9LLKPw
         gCPv9xy300AAu9L9DrrmG5qMzEsiIopZQ0U/XsNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Enrico Granata <egranata@chromium.org>,
        Jett Rink <jettrink@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 096/155] platform/chrome: cros_ec_proto: check for NULL transfer function
Date:   Thu, 13 Jun 2019 10:33:28 +0200
Message-Id: <20190613075658.443668307@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
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
index 97a068dff192..3bb954997ebc 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -56,6 +56,17 @@ static int send_command(struct cros_ec_device *ec_dev,
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



