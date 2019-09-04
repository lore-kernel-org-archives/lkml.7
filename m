Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C62C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013620820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6B+fLtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfIDLgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:36:20 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39020 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:36:19 -0400
Received: by mail-wm1-f52.google.com with SMTP id q12so1487150wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6n1x8bAGsyaVUn7RCRrZd6pcUeSbUTUlFO1sD7W+jdE=;
        b=h6B+fLtpSONhSBxg/IJPOu8ZrT+zjGIRlQ9PafT3Q+SZuugLTW6Ms+HeiIs199by73
         /y+NK2ynYGk5Q1wiraznmv2S5N8Lz0qJIog53PZqHuAG5OFvBaAac4XnhbVk0k+0NGWi
         IUHCcEYDqbyRKZZp2QJ8hxBdm7rxewdpV32Cn9jFMFQB3McBI0q5ZjtIQTG3kzNunl+J
         wd5cfQNbtsC+bA9G4OAwDPM+UzwfqTBSFiXdOXS2MFlj5hQCg4AYNsTJ3GCer+YjaTp7
         TYsyWv5RGnBfWrv689OK75VW6sakK4tDIkVN+13SPqxEk7zGNRbD7F3Sp3yWfKoTo0bU
         rcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6n1x8bAGsyaVUn7RCRrZd6pcUeSbUTUlFO1sD7W+jdE=;
        b=KCeDae7ckHyLNXNNC8tD0nYOsnfihXwwRlv3DZkrKd3dAE81ZJplPmPZj3I5F0GMb2
         3WokzhkkXhpGzU3QdstS0MkWgWre0WktjDY+UPQ7Let7l3BF4X/2dVubV3gtbJpNZZCH
         nrq3CiCKSUDrWvNAlqmhGla/LEVpAfaKfvGMWSRBaR03gXzjZzphmisyNhUXgh15ePE9
         hQ24/ZsreEISFIjD45ZqL+OZx7SY1zTWgbFAt9ONx/HhtbKAcgF/dE0qbk+wye7IuaHb
         I+qhmyV8AGUI+s29nIpckvY0kHoQqOgnvob5IkKrZdZE6boKZN9LyccziIqvraDllJaW
         nsBw==
X-Gm-Message-State: APjAAAWy/9qu7+uB0RP6jz9LbM+RB6l+y1T3vor95nvrw+iaaIWtCTKj
        JxPoJivjgN0jPSRaNweOfTWPmkvAHmw=
X-Google-Smtp-Source: APXvYqzrtOfOuNj6frgLWfYGsNvZUObicbYASkZ26jqaCnscUAcwcq1/Gwrc40q+OpB0xe98gVVB7A==
X-Received: by 2002:a1c:20cf:: with SMTP id g198mr4199256wmg.66.1567596977066;
        Wed, 04 Sep 2019 04:36:17 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id d9sm10823933wrc.39.2019.09.04.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 04:36:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] i2c: qcom-geni: Provide an option to select FIFO processing
Date:   Wed,  4 Sep 2019 12:36:12 +0100
Message-Id: <20190904113613.14997-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a89bfce5388e..dfdbce067827 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -353,13 +353,16 @@ static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev *gi2c)
 static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
+	struct device_node *np = gi2c->se.dev->of_node;
 	dma_addr_t rx_dma;
 	unsigned long time_left;
-	void *dma_buf;
+	void *dma_buf = NULL;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (!of_property_read_bool(np, "qcom,geni-se-fifo"))
+		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+
 	if (dma_buf)
 		geni_se_select_mode(se, GENI_SE_DMA);
 	else
@@ -392,13 +395,16 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
+	struct device_node *np = gi2c->se.dev->of_node;
 	dma_addr_t tx_dma;
 	unsigned long time_left;
-	void *dma_buf;
+	void *dma_buf = NULL;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (!of_property_read_bool(np, "qcom,geni-se-fifo"))
+		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+
 	if (dma_buf)
 		geni_se_select_mode(se, GENI_SE_DMA);
 	else
-- 
2.17.1

