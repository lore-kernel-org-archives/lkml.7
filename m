Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC2C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4082133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzcDMMv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfFGI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:57:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50365 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfFGI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:57:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so1191314wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUhboSAFmz5mtk8bqOkf7FrFn2o/dLGKQrpvRYoaznc=;
        b=qzcDMMv6/dC+W88mLNVStn/1exwxI5WCsOypC3gl2r3+gaoDMIOQYEYcuG41mZg4K4
         W1+wDi7jZIIjYFe0bNSdJb8dlG/Hdk64D0lQNdVEqzyU9mQixYMn/sVvGQUgfbOb4OqH
         n96hpVWConp+8aolrBLU5RAXiICd9cEHnv2TAUrcSEaayPHCnj6dJSpJrXjOzMRw5IA0
         mBvyCeu658+xZPj40wPPTfT7en/Xiv5jINsfwExCLe7XtZ4ZG2ApUlR4ftF4W3DT1GzV
         tVPKkImfEiPpV3dHfL4xblmzzRC5VoTyVg0NLYHV3VcSB2vR8W52pxL4AhlnKiak1Hy5
         V9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUhboSAFmz5mtk8bqOkf7FrFn2o/dLGKQrpvRYoaznc=;
        b=inNOC4Gtk6bDrpwoymyraucovozfktxcLwFuiWvef0CYKovxL7pgM3RuT5kUx4SKum
         gV1837RVMwQFqU8XcICoeVJnrGWOJ1Gp3g+ScUCwj6hAeNRjEz3ij2Xw+BmeA1WBcgY0
         4/+XW9U04XIc1+OHsdsrhJgv2W7xtmbawnfIYeexcwFed6yPEOkTHWmuo96GjiO/Riw6
         OFzjgf8WA+wA5dv4nG6JC2MdREUjAqVRB4YwNKasUXo+mzAwuiE5ExKgu41srPro+dh6
         tM4tgly1IhSG9kUNf01w00udvJtGT1Q06oyJGwKF04/EpqY5DOd7tsUv1caYcsXGFwJf
         fhyA==
X-Gm-Message-State: APjAAAVgm68aABx96NQhyz+oDcnaqy7SqUdRNC0qUu/53ElnDwWzeU2N
        0rJoIxYJq8CF5vCEwVbseNYyAQ==
X-Google-Smtp-Source: APXvYqzJ0U31BGjMNzkX8zVESpp3QIDFY+q4gJbhCTHx2fmvyIfqZREqJHenhK+kiiD0Nec89G7cWA==
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr2627868wme.173.1559897829451;
        Fri, 07 Jun 2019 01:57:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d10sm2035308wrh.91.2019.06.07.01.57.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 01:57:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 2/6] soundwire: Add compute_params callback
Date:   Fri,  7 Jun 2019 09:56:39 +0100
Message-Id: <20190607085643.932-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This callback allows masters to compute the bus parameters required.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c    | 9 +++++++++
 include/linux/soundwire/sdw.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 73c52cd4fec8..b86992145799 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1485,6 +1485,15 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		bus->params.bandwidth += m_rt->stream->params.rate *
 			m_rt->ch_count * m_rt->stream->params.bps;
 
+		/* Compute params */
+		if (bus->compute_params) {
+			ret = bus->compute_params(bus);
+			if (ret < 0) {
+				dev_err(bus->dev, "Compute params failed: %d", ret);
+				return ret;
+			}
+		}
+
 		/* Program params */
 		ret = sdw_program_params(bus);
 		if (ret < 0) {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index bea46bd8b6ce..aac68e879fae 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -718,6 +718,7 @@ struct sdw_master_ops {
  * Bit set implies used number, bit clear implies unused number.
  * @bus_lock: bus lock
  * @msg_lock: message lock
+ * @compute_params: points to Bus resource management implementation
  * @ops: Master callback ops
  * @port_ops: Master port callback ops
  * @params: Current bus parameters
@@ -739,6 +740,7 @@ struct sdw_bus {
 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
 	struct mutex bus_lock;
 	struct mutex msg_lock;
+	int (*compute_params)(struct sdw_bus *bus);
 	const struct sdw_master_ops *ops;
 	const struct sdw_master_port_ops *port_ops;
 	struct sdw_bus_params params;
-- 
2.21.0

