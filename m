Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69688C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD3B20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014607;
	bh=aC9SQ5EkNhTjwOn53SQkNmPSz9YG183WcWTkmu/cwfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Moh/TdYYnrSh8CTzvolrBj6yyt4NAHTaN7wcmvbrOLDwhoVmlXdqux2Qaol2RY0+l
	 0FxRKK1/+X9w0ARgHaSH3EdVlCYLdhDLTqv3dwmepDnlTXeQZ+vrTZq3aySiuwkeCk
	 93bRbMmUASCi9lgbdpYv/mWbeeC9RSUfjz5tcar4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfLJVI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfLJVIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8DD52468F;
        Tue, 10 Dec 2019 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012092;
        bh=aC9SQ5EkNhTjwOn53SQkNmPSz9YG183WcWTkmu/cwfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+L9EZGjAJ6v74Rw/yNgRuZYKMpEFwQquYNBXX4BoiTBNL6Z1PRQpFfdbSUs305pj
         MF4StD7jQmeCrb2VEDrY2A08ifxo+khp5K3AaFt8Cv5gDaCgfurEQ06OypG96L/zqd
         Qk6QNFWziXo2Fzagm0Mbgopo6qLoCg3VJ9fCGK1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 069/350] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the internal I2C controller
Date:   Tue, 10 Dec 2019 16:02:54 -0500
Message-Id: <20191210210735.9077-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit bee447e224b2645911c5d06e35dc90d8433fcef6 ]

The DDC/CI protocol involves sending a multi-byte request to the
display via I2C, which is typically followed by a multi-byte
response. The internal I2C controller only allows single byte
reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
supported when the internal I2C controller is used. The I2C
transfers complete without errors, however the data in the response
is garbage. Abort transfers to/from slave address 0x37 (DDC) with
-EOPNOTSUPP, to make it evident that the communication is failing.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sean Paul <sean@poorly.run>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191002124354.v2.1.I709dfec496f5f0b44a7b61dcd4937924da8d8382@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 521d689413c8c..3e82d604201ee 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -36,6 +36,7 @@
 #include "dw-hdmi-cec.h"
 #include "dw-hdmi.h"
 
+#define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
 #define HDMI_EDID_LEN		512
@@ -398,6 +399,15 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
 	u8 addr = msgs[0].addr;
 	int i, ret = 0;
 
+	if (addr == DDC_CI_ADDR)
+		/*
+		 * The internal I2C controller does not support the multi-byte
+		 * read and write operations needed for DDC/CI.
+		 * TOFIX: Blacklist the DDC/CI address until we filter out
+		 * unsupported I2C operations.
+		 */
+		return -EOPNOTSUPP;
+
 	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
 
 	for (i = 0; i < num; i++) {
-- 
2.20.1

