Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47EDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFF20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207278;
	bh=Nn5AKjwbyyKxt2/OxRqIHa1NJ6FZcLAmngoexODc1M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q7+8H4cPboXRAJz4t05O/GywWYVQUeRkVCos0DCDFwrmQc/S1sqJZQdjImz9zYIaw
	 NvdC0Ns5SASRDiq+xuvaboYJEznIs+emg0QQCbocIYHTJ4LQ6E0rMmoj2W82tkdULL
	 G8Sm1DR478n9tiXTsQ/dCDM4cpy/IjLBTSvveLlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfEGFeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfEGFeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:34:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7758B2087F;
        Tue,  7 May 2019 05:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207271;
        bh=Nn5AKjwbyyKxt2/OxRqIHa1NJ6FZcLAmngoexODc1M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJyNplFHZ5Ady6rByIgATYSGS8a6SCT2Zae0O/yP67r0mpmk2/7+eikJpOJwPqIA8
         IC1KJFqkF/g0v8srDPuZMM0OukuWOkjImwkMQGQBgx+6V4V/PzgUiMEhmcEPmhA2ob
         NgMdVvu4RwacGm5oemp4SRs9joBaw38EP67LOk6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>, Heiko Stueber <heiko@sntech.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 60/99] drm: bridge: dw-hdmi: Fix overflow workaround for Rockchip SoCs
Date:   Tue,  7 May 2019 01:31:54 -0400
Message-Id: <20190507053235.29900-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit d15d9fd02575ecfada92d42f655940c4f10af842 ]

The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
also been identified as needing this workaround with a single iteration.

Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Heiko Stueber <heiko@sntech.de>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/AM3PR03MB0966818FAAAE6192FF4ED11AAC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 64c3cf027518..14223c0ee784 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1655,6 +1655,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	 * iteration for others.
 	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
 	 * the workaround with a single iteration.
+	 * The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
+	 * been identified as needing the workaround with a single iteration.
 	 */
 
 	switch (hdmi->version) {
@@ -1663,7 +1665,9 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 		break;
 	case 0x131a:
 	case 0x132a:
+	case 0x200a:
 	case 0x201a:
+	case 0x211a:
 	case 0x212a:
 		count = 1;
 		break;
-- 
2.20.1

