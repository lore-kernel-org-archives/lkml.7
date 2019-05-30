Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C0DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2940C24A37
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186652;
	bh=uaRMoL5wlZ6kDLSuDyHVPV2xn/4AO4FX8g0HIPN9Oco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WP5rnWlSpR89u40hjMPCmLoyGq42TkJoaVDd8TjUHasCVRbAdZzZA+vq+Pd5ghNNB
	 bsIxcJK+4mfSserIfT/y+dv2uuAnQ9F6t8Wi4Cj9n267D+Wl4sqAlXmqB2MWTTz6LH
	 tVaW9AeaIoIfq3SDwy44xbrBX9wG20ecotWHfFPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfE3DYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731248AbfE3DRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:47 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B015246F4;
        Thu, 30 May 2019 03:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186267;
        bh=uaRMoL5wlZ6kDLSuDyHVPV2xn/4AO4FX8g0HIPN9Oco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Govy9GKyA8CXpPM+VZ6GKrZzgUWw4ZG86RwOG4xAO9Hf+AprTGxKXQMgJKz7/rn33
         SYVYnoFnHZM4dCAHP06h8x1ol3IDYxpfZwp314ySWgJgGRiG9BRwRYJA+3BBreXoHR
         HrubZO7VRqJM5SndFJb+DKag8o9YlkM9vvGgUoXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 203/276] drm/panel: otm8009a: Add delay at the end of initialization
Date:   Wed, 29 May 2019 20:06:01 -0700
Message-Id: <20190530030537.820652297@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0084c3c71126fc878c6dab8a6ab8ecc484c2be02 ]

At the end of initialization, a delay is required by the panel. Without
this delay, the panel could received a frame early & generate a crash of
panel (black screen).

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
Tested-by: Philippe Cornu <philippe.cornu@st.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1553155445-13407-1-git-send-email-yannick.fertre@st.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 87fa316e1d7b0..58ccf648b70fb 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -248,6 +248,9 @@ static int otm8009a_init_sequence(struct otm8009a *ctx)
 	/* Send Command GRAM memory write (no parameters) */
 	dcs_write_seq(ctx, MIPI_DCS_WRITE_MEMORY_START);
 
+	/* Wait a short while to let the panel be ready before the 1st frame */
+	mdelay(10);
+
 	return 0;
 }
 
-- 
2.20.1



