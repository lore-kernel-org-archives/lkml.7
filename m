Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2721A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 21:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569966038;
	bh=EXOOfmyP72S6DF4GjcNc343Kct+Ec+psa0RkkWegYg8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xJ60SfsCwGjUkOmWnuc+L+ehxQrHiRtG4eZHWBpaQsQNqf7jpkYOpTmPq5mgQPNLV
	 zGHmHkcEL9YYnR3t5pZz65pJfCk8/1eerkJ5WNTv0Dzxwr6H88s8rXFmOQpzJDS9yj
	 YjGgvxfZsBHcQqjMSwVKQGLl54976oH8WuK4KxXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfJAVkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 17:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfJAVkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 17:40:37 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B0021855;
        Tue,  1 Oct 2019 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569966037;
        bh=EXOOfmyP72S6DF4GjcNc343Kct+Ec+psa0RkkWegYg8=;
        h=From:To:Cc:Subject:Date:From;
        b=H6yDzxYiIrz42md3od0CYGxSqQx7lSzoEfsymyaa+JYKVjmCENfiWBLZnlf/1grQT
         MWgbYWJVRkRRKqYWD/g0xkm5GA6SzrTJz2PFQmN/6XGKZXXul4F0Dihq2llPSob87U
         RBQK5eElaBFzxadA/etQIIPNxFJF5pg+/kCYoOSY=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux@armlinux.org.uk
Cc:     dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        p.zabel@pengutronix.de, thor.thayer@linux.intel.com
Subject: [PATCH] ARM: drivers/amba: release the resource to allow for deferred probe
Date:   Tue,  1 Oct 2019 16:40:26 -0500
Message-Id: <20191001214026.21718-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit "79bdcb202a35 ARM: 8906/1: drivers/amba: add reset control to
amba bus probe", the amba bus driver needs to be deferred probe because the
reset driver is probed later than the amba bus. However with a deferred
probe, the call to request_resource() in the driver returns -EBUSY. The
reason is the driver has not released the resource from the previous probe
attempt.

This patch releases the resource when amba_device_try_add() returns
-EPROBE_DEFER. This allows the deferred probe to continue.

Fixes: 79bdcb202a35 ("ARM: 8906/1: drivers/amba: add reset control to
amba bus probe")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/amba/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f39f075abff9..f246b847c991 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -535,6 +535,7 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 
 	if (ret == -EPROBE_DEFER) {
 		struct deferred_device *ddev;
+		release_resource(&dev->res);
 
 		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
 		if (!ddev)
-- 
2.20.0

