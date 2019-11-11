Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E1FC17446
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF37222CB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497762;
	bh=boVuMqcEnGMRstoh8fNoMGlF8Adg0acWdJ1pVff/OK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LXxoCNZAUDWbtPUwecprhJckm7O7spWi8LwbsoMuUzPOri4ZshpluSiAmSW6k9LUp
	 v2xaL1jbQhAF7LEynqZ/1uy+mfCRT6i7Zdv1CvyhDLAXPyW+KOR57l7OGWGHI0s8n1
	 Du5ZsmK45m1ayR9BwWUDufmUPXLWfIijnarB6TA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfKKSml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfKKSmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:42:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843FB214E0;
        Mon, 11 Nov 2019 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497756;
        bh=boVuMqcEnGMRstoh8fNoMGlF8Adg0acWdJ1pVff/OK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lm1mjRgna3oMQZyjuB2U6JY3fAwjYMxZVGWdDZiIsyFQ3XV2FEwdV2adQtDWC2yIU
         X/jH/HcKkeWKpAxVEjbIXsJkw+VjXhr1RbAJu1a/2NaUKAZncpaCJEu8XlpoWMflQO
         vc9dnoQdseZUKNdduBKzD3kw0lwOhPK/XhTp5lr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 049/125] can: dev: add missing of_node_put() after calling of_get_child_by_name()
Date:   Mon, 11 Nov 2019 19:28:08 +0100
Message-Id: <20191111181446.878045148@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

commit db9ee384f6f71f7c5296ce85b7c1a2a2527e7c72 upstream.

of_node_put() needs to be called when the device node which is got
from of_get_child_by_name() finished using.

Fixes: 2290aefa2e90 ("can: dev: Add support for limiting configured bitrate")
Cc: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/dev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -853,6 +853,7 @@ void of_can_transceiver(struct net_devic
 		return;
 
 	ret = of_property_read_u32(dn, "max-bitrate", &priv->bitrate_max);
+	of_node_put(dn);
 	if ((ret && ret != -EINVAL) || (!ret && !priv->bitrate_max))
 		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
 }


