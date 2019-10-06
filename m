Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D342ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7573B2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382575;
	bh=WvrT+YqFB9XJFBgglofhWHy2h/WI6wolVdh3GnWYFJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVhNZE2BUrsV07KRv0sDXtgdLBoFSb2cDQ+xzDpMbZohsTpi2oMPCK0MvU0FBPBYh
	 yRGNiIifma5llf8DXnjdSlP8VHJAaQBuBZgDnlbSJNq/6xbsZi+e78CbDYg8eQKkf0
	 lwD1vxMmDSjVtgu3pqraTbJdKF7Skt5nm1ZjZD8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfJFRWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfJFRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:22:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F36F2077B;
        Sun,  6 Oct 2019 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382573;
        bh=WvrT+YqFB9XJFBgglofhWHy2h/WI6wolVdh3GnWYFJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yWKj9cN6BLiENxcyWbMZkQUYb01X2qEJ2WX2YIu1wpLe9KWX3OiYMqFQJ2gYcs7or
         ifqyop04Qw26Nmo3bDTMDwmR9JZUXXc1JQiHXQN0B2vp+A3IaOjswuA5LqY4/NjEq+
         +fKcxdLhjXySW1apCUwtwUJqATHW4xAGsBeEpy1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/47] drm/bridge: tc358767: Increase AUX transfer length limit
Date:   Sun,  6 Oct 2019 19:20:48 +0200
Message-Id: <20191006172016.964736192@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006172016.873463083@linuxfoundation.org>
References: <20191006172016.873463083@linuxfoundation.org>
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

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit e0655feaec62d5139b6b13a7b1bbb1ab8f1c2d83 ]

According to the datasheet tc358767 can transfer up to 16 bytes via
its AUX channel, so the artificial limit of 8 appears to be too
low. However only up to 15-bytes seem to be actually supported and
trying to use 16-byte transfers results in transfers failing
sporadically (with bogus status in case of I2C transfers), so limit it
to 15.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190619052716.16831-9-andrew.smirnov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 80993a8734e08..8b6f8fac92e89 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -300,7 +300,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
 	struct tc_data *tc = aux_to_tc(aux);
-	size_t size = min_t(size_t, 8, msg->size);
+	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
 	u8 *buf = msg->buffer;
 	u32 tmp = 0;
-- 
2.20.1



