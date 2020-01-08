Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08361C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1823206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="QZY6MBVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgAHVIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:08:24 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:21357 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAHVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=IiLQ8L4byxFjqeoXMTCaKip09HlTH/MmHbs7tvCMQgY=;
        b=QZY6MBVwCoiFczU0Yk1QbJ21nztZH9gSab5fT8k1H2iFTQzNvEBWLBY0+YoN0Q842XEv
        2hkPSem+2EyrQiihbig19wLY64BzUXeLMEFVR3aPIGNUkzHRPzJhPS9QWP6S81841ZdrQO
        j9FF1hZMldTKtfBaYXujMVXjnTXXhi3F4=
Received: by filterdrecv-p3mdw1-56c97568b5-qqd9g with SMTP id filterdrecv-p3mdw1-56c97568b5-qqd9g-18-5E1644A5-63
        2020-01-08 21:07:49.736716731 +0000 UTC m=+1974280.387268561
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id hoZ7RMZDRoGVWKvqnwa5Ig
        Wed, 08 Jan 2020 21:07:49.497 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 06/14] drm/rockchip: dw-hdmi: allow high tmds bit rates
Date:   Wed, 08 Jan 2020 21:07:49 +0000 (UTC)
Message-Id: <20200108210740.28769-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h8Xinh+Au1Telh56G?=
 =?us-ascii?Q?QM1R2oYBoKtJxxom=2F=2Fq1tL5H6tWAbppEAfKC+cw?=
 =?us-ascii?Q?YyRuoQxeebeSuP8PHev4goIzTUYj7DE7umFNIzo?=
 =?us-ascii?Q?hxGSIHx7HXtGiQB4TZqWlV9E0sKeR2hJdPAC8nI?=
 =?us-ascii?Q?h8pm2eaZnaxIhaMIJmtyHk+cd8H8mezGWii6GD0?=
 =?us-ascii?Q?E0oYIsuhx1oou5Z7uKx8Q=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare support for High TMDS Bit Rates used by HDMI2.0 display modes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 7f56d8c3491d..fae38b323a0c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -318,6 +318,8 @@ static int dw_hdmi_rockchip_genphy_init(struct dw_hdmi *dw_hdmi, void *data,
 {
 	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
 
+	dw_hdmi_set_high_tmds_clock_ratio(dw_hdmi);
+
 	return phy_power_on(hdmi->phy);
 }
 
-- 
2.17.1

