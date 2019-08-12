Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62271C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D1A208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DvTuwoTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfHLMHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33159 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHLMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so104454262wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGlThzviYa74KjZe20Ku3Xepd8/yx78CuAyvtGlIM58=;
        b=DvTuwoTROuHbVQDxdqWmO0f39ZU0wzX4eGo8P1Qq0wZnKZ7jRQCMZZ/Q0RrCDo8hln
         aqatg2peAcIo1JBQXJUjXd/9raZ7v398jHI1ERa6NAPmzKVUIPIQ+98vi+EEYT0/o1pJ
         Anjes/w6rsqescn13KeKvhzXqbUsd+b9N+rxhNa4xNWcB7tM5rvItjoAXS2BP5m4d+do
         dXoTx1Sz7+XBQCK7TjC1nlEay/35okDkeq7KbV8j4nA9jHROcKJ+JTXqD4qqhFRCf9H1
         cZLxSK3snuiK1FsPN9SijQgW7Ybuwe6e63LvcYiXt0gtnZEUbMV53tL5Cazvny95LWQ6
         cqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGlThzviYa74KjZe20Ku3Xepd8/yx78CuAyvtGlIM58=;
        b=Zox7u0KbDCD+YcHMEee9CtwTcMwWzwTQmFWZHEEwOLYhdFk3Sl7JPYU/1lP91ev3rw
         3Uv68UZGAMfcv0/XOoDzXucr0NtblFT6/L7M62Vqsv/HjO4THsKFW1BfDWk+O2h2fxUw
         mB/fp4L+VuESzU9UFcCNErK4zfO2a7m5CKmoh1SzgWMKr7Hs+gA6B28gxA5u4HBuWIT2
         v1Mn5z6f+RAE7y9AkRG/N83tSzQF29itXIlhIg/fnhU2B5FoYxMMh2G7lENiBqyRbkZr
         iwTA8NWgYAm3EpwG9kYn5B2R6RRxxgdEUP6bZtE0GMhDSOoVbtJKk2+zFJhxcQ/5pTE4
         VZcw==
X-Gm-Message-State: APjAAAXJZA9v9FBQGqxWA3kEe0Tfo/1K7rJc8kkgteCLftjVjz9hQUst
        9NLtQDbKxSET6mFE93qh8tbgtw==
X-Google-Smtp-Source: APXvYqwyPz46p57eTysQVwY46wCsT+0OYu9uGaKrclq3p6YfT4lDPfbi5P4UsmaTt2jiysECa6xwjA==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr38067769wrn.311.1565611652662;
        Mon, 12 Aug 2019 05:07:32 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/8] drm/bridge: dw-hdmi: set channel count in the infoframes
Date:   Mon, 12 Aug 2019 14:07:21 +0200
Message-Id: <20190812120726.1528-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812120726.1528-1-jbrunet@baylibre.com>
References: <20190812120726.1528-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the number of channel in the infoframes

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index be6d6819bef4..bed4bb017afd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -663,6 +663,10 @@ void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt)
 	hdmi_modb(hdmi, layout, HDMI_FC_AUDSCONF_AUD_PACKET_LAYOUT_MASK,
 		  HDMI_FC_AUDSCONF);
 
+	/* Set the audio infoframes channel count */
+	hdmi_modb(hdmi, (cnt - 1) << HDMI_FC_AUDICONF0_CC_OFFSET,
+		  HDMI_FC_AUDICONF0_CC_MASK, HDMI_FC_AUDICONF0);
+
 	mutex_unlock(&hdmi->audio_mutex);
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_count);
-- 
2.21.0

