Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA24C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F420663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mtkkTc2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfHMIgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:36:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfHMIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:35:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so693645wmm.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 01:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47pjUZtlYEQsWYFM2ZKdkX9DO8aXhwyKbVTpMW5dD0M=;
        b=mtkkTc2za4MBew4vaNmst2IsNgchFGrls0sMOvN2UhPHs9lHa2U93xFQ5xAKx0CpfE
         KQlsxsYeHq6f4pzn2C0P8AycDtTJr1i+m6XGHohquv8ndV8JTM3VNYq0pGDIajQ4ipsp
         42RTztSe+QkgPim00XYgEC6UFfNpm4kgA5SN5/Gv4/os+EoUuhFvpQ6y2GZD2cvhh8yB
         dAA3XpTMCufeDzI2CUEuBRrZoFpTGbWzg0gn7m/qLDh/Lezo4c0raD++1ElZhdyecGSP
         v1G+d5N5+NKrl8INbMURU99BWGpg1TderUW+X/jciZtLZSi85m9oImE1ogDDEbMFmepC
         i8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47pjUZtlYEQsWYFM2ZKdkX9DO8aXhwyKbVTpMW5dD0M=;
        b=UaeYxKm7C3+CGR4N2HwIBSW4DzXGX/F/44acUtEepRskyEO7UrTcXjCX2owcpSBVy1
         DiegMW6ICBj4eSmbGjumy/+G7LlReIq+wqgVwuECFDeR5QHzZb/bE1qg6qflzRab2czk
         /J+zL8o0wycgEexqTHMGZXgddGxAu27esZYo4aG2eu03gB9dQ0KZqXHZ6PIb2HiDwNjT
         UFIlcDJi5g0yNGK018iZYubHCci+kxS50lrDogu7YjY8TrUwaRa4Z1JjUnmsdr4d4BV6
         cLbvWogqJkDdWK8RsO5+SicimONslaa4gjSRGhHTNOvjxhQFe8+L6yqBROt2ZXn77++2
         hmzQ==
X-Gm-Message-State: APjAAAVT1aOufVKtzyAGEzgX51EOuKl18O0Uszyr0wbhEipN0lRV3bMp
        Xr6E0s2yUN+QtLNYCWj0+l8/FA==
X-Google-Smtp-Source: APXvYqy7DQnahHv4WYLvvV3qcT2SkUUHTBk00iCKoTTLBlhFu6Xsp5qL9efPIajKTBxlJAkv8lkmFw==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr1755383wmf.156.1565685355813;
        Tue, 13 Aug 2019 01:35:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id o11sm8651822wrw.19.2019.08.13.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 01:35:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] soundwire: Add compute_params callback
Date:   Tue, 13 Aug 2019 09:35:46 +0100
Message-Id: <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
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
 drivers/soundwire/stream.c    | 10 ++++++++++
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a0476755a459..60bc2fe42928 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1483,6 +1483,16 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		bus->params.bandwidth += m_rt->stream->params.rate *
 			m_rt->ch_count * m_rt->stream->params.bps;
 
+		/* Compute params */
+		if (bus->compute_params) {
+			ret = bus->compute_params(bus);
+			if (ret < 0) {
+				dev_err(bus->dev, "Compute params failed: %d",
+					ret);
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

