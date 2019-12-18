Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B51C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5946820684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FHCAjQd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLRPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:46:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46501 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfLRPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:46:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so2766682wrl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9tdpVSfl48TElavVgqhWWyanYwTXJeuWxrfu0hiAW4=;
        b=FHCAjQd4y3iLKbv9a4+0jgFrCRVKlJcXXyEE8djCrmS1HqnAQOSIzjRPhU58PIOqSP
         qLQGfl8t/kpeSD0jjGyEVg1gzI7FEKVnZAyyu39Tk6J/jW7uzg1fwpsQc2fyyl23X2yQ
         vx2zPKIvq/gYsfcl93bHNdkA2/unThznbtJ2q2ZKLbNEnXIQ5oxLximvIxutQNUADsdL
         BwiZ4sdCrvm5dC0Eebf8yxE+oGqYOpmKb8L9WZ0aEGYZfHzh65OS5C6JY2duUiV03LH1
         CJRX/8PaypTs/svctTJXJCDjVfDFrXgCpW7vljEnXhEOYVbMN/BioNDaVzE/VFhKtnzp
         M6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9tdpVSfl48TElavVgqhWWyanYwTXJeuWxrfu0hiAW4=;
        b=B8PEAbqrKXvxHxxuSoe+IGZoETLztGN1V0yNR+sG3TCIDueaoKhnHcYepqgOubVlMJ
         vFKhMu7+MhAgB9gjompE9UoyPJ7lahAedgNZW/zXDp81IzlgPwo4NrVjtZAah+y/9lwv
         aywT4hwtRyDWJA/M8JybpWFRwI+Q6S1FdMDgleJ42eMyH5MY3kRt4XFiJRkUDZYXZde0
         s2SztqkFeIl+tH07R0UeMxU1DBtsp2mQhTOL8TsbtJPMe1KnLNcZdMPGz3SR3Ug7XZNp
         q2Ta0MxXyhEzjqeVugTU14Dpws9G+1tVoFMKnRwdNvG5DY1E+a47RcwnwG8ln9W2EeKv
         2T1w==
X-Gm-Message-State: APjAAAVI3MQHTkT8sayyT9Ojl52gFLoGZ8yS4JvtepwHed/76gvPaHB8
        8ykzMtJkJMhVPrKMbh/XTVDMNA==
X-Google-Smtp-Source: APXvYqzuM/qSpRgPBzy3PCHjbAbAOHl0IflSqZ5d6XsQf2QHxW6iMGwcohpjIcXJFGEUXP4EJk3xAA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr3545462wrs.11.1576684001310;
        Wed, 18 Dec 2019 07:46:41 -0800 (PST)
Received: from bender.baylibre.local (lfbn-nic-1-505-157.w90-116.abo.wanadoo.fr. [90.116.92.157])
        by smtp.gmail.com with ESMTPSA id x1sm2891492wru.50.2019.12.18.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 07:46:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 01/10] drm/bridge: dw-hdmi: set mtmdsclock for deep color
Date:   Wed, 18 Dec 2019 16:46:28 +0100
Message-Id: <20191218154637.17509-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191218154637.17509-1-narmstrong@baylibre.com>
References: <20191218154637.17509-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Configure the correct mtmdsclock for deep colors to prepare support
for 10, 12 & 16bit output.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index dbe38a54870b..6a0b4b3a6739 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1792,9 +1792,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 
 	dev_dbg(hdmi->dev, "final pixclk = %d\n", vmode->mpixelclock);
 
+	if (!hdmi_bus_fmt_is_yuv422(hdmi->hdmi_data.enc_out_bus_format)) {
+		switch (hdmi_bus_fmt_color_depth(
+				hdmi->hdmi_data.enc_out_bus_format)) {
+		case 16:
+			vmode->mtmdsclock = (u64)vmode->mpixelclock * 2;
+			break;
+		case 12:
+			vmode->mtmdsclock = (u64)vmode->mpixelclock * 3 / 2;
+			break;
+		case 10:
+			vmode->mtmdsclock = (u64)vmode->mpixelclock * 5 / 4;
+			break;
+		}
+	}
+
 	if (hdmi_bus_fmt_is_yuv420(hdmi->hdmi_data.enc_out_bus_format))
 		vmode->mtmdsclock /= 2;
 
+	dev_dbg(hdmi->dev, "final tmdsclk = %d\n", vmode->mtmdsclock);
+
 	/* Set up HDMI_FC_INVIDCONF */
 	inv_val = (hdmi->hdmi_data.hdcp_enable ||
 		   (dw_hdmi_support_scdc(hdmi) &&
-- 
2.22.0

