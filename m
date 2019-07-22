Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E02190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MURvjPXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfGVSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:19:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43897 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGVSTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:19:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so17769247pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEY3bYOzp3RlSizWjVehuryQ18nF3wYfUG0Q8twJJZM=;
        b=MURvjPXpQv5UN7mAWkHfdQhSjEwS47X0WVij4lXD6DFvDLOxfR9xyMTRP16hP5J4eJ
         RPGo+ay9cCo0tGH8itIzhdtsLIADAq2Wk8JgklQ9PW1rEW7SJvZ0B0eztFO8ExaQLn/C
         DTGohGh7GIxojqBTtmb63srZUTv7lTEhhtuTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEY3bYOzp3RlSizWjVehuryQ18nF3wYfUG0Q8twJJZM=;
        b=UgrgqIMLCGbCTfOnXWhGy2yjPo6xF8FR9mzAy6SGfmIDP1SxUj87ZGepclaApDyvs8
         eDea+FemKi5wK/emLCA9NmXWHJeHqzb7MPoeFftzOS2RDbL7A4rNNLYDQiTOQT+ZX6aP
         SHZMTlpBUJRYXsZ46Mgw8cuyemj+1x3UJaak4+BpAZx2iVrmhvoVwyFhdmTCvEW5AICZ
         mhdGqxzItNBWjA5yRKuRbRgE2V6Az8GtQ8PVKy7vj5CzJI+X7Nwqc8IsDHAxaPJza1zQ
         Zl07k9EpjwbMOiU/ocxw6iZNEpq91FPGD2sYlsGm5N+sYFUIHWTT8SZdaeZe/EYv+OZ9
         vFWA==
X-Gm-Message-State: APjAAAUqDQIFm4d96MVN2OoJG+Au/9RszTjHqP8dWO7auSVANVh9plbU
        aYsPpr0FQxf9k6Y37Jk7o/ZTMnUOypk=
X-Google-Smtp-Source: APXvYqzcCvGl88snNa9+grlHY4RHCbVeyINhZTleoFs/SYk/vhYy08CTLaQNOJJrxO9skTUVFTtHJw==
X-Received: by 2002:a63:6c02:: with SMTP id h2mr71668487pgc.61.1563819590479;
        Mon, 22 Jul 2019 11:19:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v10sm41283234pfe.163.2019.07.22.11.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:19:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Douglas Anderson <dianders@chromium.org>,
        Adam Jackson <ajax@redhat.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the internal I2C controller
Date:   Mon, 22 Jul 2019 11:19:45 -0700
Message-Id: <20190722181945.244395-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
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
---
Changes in v2:
- changed DDC_I2C_ADDR to DDC_CI_ADDR
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 045b1b13fd0e..28933629f3c7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -35,6 +35,7 @@
 
 #include <media/cec-notifier.h>
 
+#define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
 #define HDMI_EDID_LEN		512
@@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
 	u8 addr = msgs[0].addr;
 	int i, ret = 0;
 
+	if (addr == DDC_CI_ADDR)
+		/*
+		 * The internal I2C controller does not support the multi-byte
+		 * read and write operations needed for DDC/CI.
+		 */
+		return -EOPNOTSUPP;
+
 	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
 
 	for (i = 0; i < num; i++) {
-- 
2.22.0.657.g960e92d24f-goog

