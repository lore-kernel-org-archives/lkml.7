Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE8C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5D521783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BDeT9Q2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJBToQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:44:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfJBToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:44:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so120892pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RG+TGpIbWGK66ii3aX/c/mLwtrL9t7Co+9YPIDroe0=;
        b=BDeT9Q2rS460oUk++puZT/bURg9A9s+tehyWG6BTR4fBXjpn6dnc+y/qwlxbuUmlDM
         EXy+7jMvhu5+8Eg5lHgfSj6UqA8SYT8vNKZQLBcRyAfLAJN6KXBB3/xFFn4vg88dzkEa
         7hB0jLtDHVB7YYKgwEl5/peZADD5F5ENUBB5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RG+TGpIbWGK66ii3aX/c/mLwtrL9t7Co+9YPIDroe0=;
        b=jDguDDir7gndmgnDhL1YpkHRAVdVojWeh2G9K+RnSivlBXNTKocPQbShCuMtoZz+ay
         00/8mJssOtsI4rgsI3gMJfd+Yop3cmg5FEnRSn+oyN2fFe1AuKl+UUNTMXisdoESJBJH
         9IeGIZiyrZq8Xm0optlKLHuNQuHtLePdAbFMGzH5p8hilSa+Gz3m/lfddp2E0mZHDQ7P
         CtCoX8Q/IFe/hAXKCZv/UdwPCA7Y6kNsw+CCtbhOy7W3VJNAcuzAznBeKTDpNPEbaxrL
         VJgKBYTRc9kwOTPxpAF9v5DvIY8MtGF7fJ5OCxx9Fk7ibXR+p/l4kLOyg+fA6NZNfY9W
         CoPA==
X-Gm-Message-State: APjAAAU1sngPiIvJbjOjikmKFJ1NHrsa3V9iH5QEqguRpnXacEREXiND
        Tn/a1yESmTdJy7D7b5yF762Vmg==
X-Google-Smtp-Source: APXvYqwCRR5aDz75Ce/P5Hmy07jPu4Aqvt3K38tktyiDQ8tJemrn+5jUTMbbw8q6Rh4bGgQCLaXTIw==
X-Received: by 2002:a63:6803:: with SMTP id d3mr5361330pgc.183.1570045453990;
        Wed, 02 Oct 2019 12:44:13 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b4sm68127pju.16.2019.10.02.12.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 12:44:13 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Matthias Kaehlcke <mka@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the internal I2C controller
Date:   Wed,  2 Oct 2019 12:44:06 -0700
Message-Id: <20191002124354.v2.1.I709dfec496f5f0b44a7b61dcd4937924da8d8382@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Sorry for the delay with sending v2, I completely forgot about this patch ...

Changes in v2:
- updated comment with 'TOFIX' entry as requested by Neil
- added Neil's 'Acked-by' tag

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 52d220a70362..ac24bceaf415 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -41,6 +41,7 @@
 
 #include <media/cec-notifier.h>
 
+#define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
 #define HDMI_EDID_LEN		512
@@ -439,6 +440,15 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
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
2.23.0.444.g18eeb5a265-goog

