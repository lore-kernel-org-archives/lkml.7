Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42BF20843
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1KFlnpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfHMIgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:36:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfHMIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:35:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so106982939wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yY3j+tzAidsewEpOKH7pvngWyOrXZYN1znzf8G8c2/o=;
        b=z1KFlnpe7m6oruIQ8cwwyUe0xYtx70XatCj0QTT3fQG0wWPqOetxuINiLncLjFTWTm
         99H1BtzfFj+UnuZcErc7bAJTBHGV4j1+4Z5/JyC7VOEUNZIcuuvAzstG9O1gv1RCckId
         TzAMy2Yy5ely6dY38GSWw68qaAwxhYG8sqLPPCksZXgXydyiUuJ0K3sGK/2ut4K19N5Y
         1RF8aEmiY8gLCqkR3QzdAwpqB9f7CbTOvf5THnii6yVLwT6BZA0ObfQ3ZdJYT2W8rKoY
         ZD6dc/JtTu+Oukif2+WVSMwzax90gO1e/MjO1I4Phxk/93Ispzxbp3zCuDhM3ZTKwCEt
         bcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yY3j+tzAidsewEpOKH7pvngWyOrXZYN1znzf8G8c2/o=;
        b=X/WkpvHe1wIbUi81PVe9UC3QD9IjuANxOL1Tp7xO+ACMwmisnvMkgt1E9nuJwnV4nc
         mkryDLRXzWS/gz19I/Sxsbc0Jf4TXYbPfORSUjjC422Xr4vkLFlxfg3N0AAOO+7SpDmA
         QDiaNIN/LfdIsCHNsN64ioebLmTbfkCJtdq7wWkgRNEXO1UeJ7/+5M2D3EaJ4gQijp4t
         4Xmlbgt7ojee0KYgLP+jphQHyPSEpce/8uq0q2L+0h+J8nJAC6TnIxWT7Dw7vTe2rSpR
         nWUv9qTQMA0ApvJckdbWU32XG1u32lYzdxjEoN2G7OTtvZn+VPR3SWnVqzLEagwvpPTm
         KDRg==
X-Gm-Message-State: APjAAAWha3rj/0Ku9ez22mf4+j+FZ+R57u5m2C1w6/etITxT0OoLDRrY
        tbv3ox4M1IjZLIaNmAwctNmfNQ==
X-Google-Smtp-Source: APXvYqySdA0FxJMGYIhbPWPNlaaNMqY14nOQdlvcbZOf6sDtJJSN0OFSBC4FzOtGc7e8Ynj8q0FmxA==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr47047026wrj.256.1565685356898;
        Tue, 13 Aug 2019 01:35:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id o11sm8651822wrw.19.2019.08.13.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 01:35:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] soundwire: stream: make stream name a const pointer
Date:   Tue, 13 Aug 2019 09:35:47 +0100
Message-Id: <20190813083550.5877-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make stream name const pointer

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/stream.c    | 2 +-
 include/linux/soundwire/sdw.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 60bc2fe42928..49ce21320f52 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -863,7 +863,7 @@ EXPORT_SYMBOL(sdw_release_stream);
  * sdw_alloc_stream should be called only once per stream. Typically
  * invoked from ALSA/ASoC machine/platform driver.
  */
-struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
+struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
 {
 	struct sdw_stream_runtime *stream;
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index aac68e879fae..5e61ad065d32 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -830,7 +830,7 @@ struct sdw_stream_params {
  * @m_rt_count: Count of Master runtime(s) in this stream
  */
 struct sdw_stream_runtime {
-	char *name;
+	const char *name;
 	struct sdw_stream_params params;
 	enum sdw_stream_state state;
 	enum sdw_stream_type type;
@@ -838,7 +838,7 @@ struct sdw_stream_runtime {
 	int m_rt_count;
 };
 
-struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
+struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
 void sdw_release_stream(struct sdw_stream_runtime *stream);
 int sdw_stream_add_master(struct sdw_bus *bus,
 		struct sdw_stream_config *stream_config,
-- 
2.21.0

