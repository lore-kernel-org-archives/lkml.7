Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CB6206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mB3Sko2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbfIEOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:41:29 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53825 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfIEOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:41:28 -0400
Received: by mail-wm1-f52.google.com with SMTP id q19so3115735wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gvXZWVwHpbdck37kQtyWXbSqSEeeYIFeArcoXQY5L9I=;
        b=mB3Sko2ifz0tOSCJAHjX283XAID1lWJHxJ8+5TDxf+6IIqPTfr+z/PPEttOLXQQH+b
         8VhpLSs2Xx38CdkqQN3H01l2xCICqrXkssFgkSPUbXJ7w82PFNTO/EflDqdaBZrjTBr4
         OPh0RTFzOYZ9LW56DmIi7VmHRBlGKptwDvVx48791iI0/CHvG7SloF7JfIgzVPVxd9SI
         Rs/Blwyl15h0QvyK0ESbbrFGhGmV1HOpEJtqRhDWTDXP8pDPRI+cycCzopj1+4fHb/Dm
         IQ1Epwi19TWJKlDbg2Ewvh51NYJmGcEGrfcOJBcKHYIVsbxVndIy9Vz+arcpx4sv7wik
         J4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gvXZWVwHpbdck37kQtyWXbSqSEeeYIFeArcoXQY5L9I=;
        b=VlPxL9/Rvth56nkcZFDwm+2E7KTtqyMgZCFTHAZWjUBTraNvzfwLxPGzxZJn8TiQj2
         6TP4GJwXH8ix84pEY19XWXb9aTJv48OC6ja8IGAQLS8ux98Fwylm50kgdyJ2s5SA8SS6
         HpqvIrkLSyPVBT5BPVg1YdY0k23N3FlXv2OaMHVdoqPIiuB02a1zHuV0otJjwJw7DE4Q
         08iHavoJ5To4Q27HDAZau2UVjuUz/eR3S5pBOTaOG7onksZ85Sj+DuppSe98DEtDmLQa
         GepWuHLzgkRWtgswEp90c+RA2zAqwdZ+P1ChkDyOx5Rs3iNMZjH5qmAJCLSgnBSSpEEf
         2Xrw==
X-Gm-Message-State: APjAAAUcAHn/31VFNXL7Oeo9dzXtsH4BcbCJqs+QknzB+B2bGsXOMe/9
        FRlhR6OOqKb38V8NeU5Gea6Mjg==
X-Google-Smtp-Source: APXvYqwSsdzWd7u9Fz8nhhPSzaTVwwrjIYP4HGLSO8rAw+8XajRcLI9Thgj6+E2e/hZXiqvdsbjQ7w==
X-Received: by 2002:a1c:be04:: with SMTP id o4mr3387448wmf.60.1567694485991;
        Thu, 05 Sep 2019 07:41:25 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id c132sm4191392wme.27.2019.09.05.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 07:41:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org, vkoul@kernel.org,
        wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [RESEND v3 1/1] i2c: qcom-geni: Provide an option to disable DMA processing
Date:   Thu,  5 Sep 2019 15:41:22 +0100
Message-Id: <20190905144122.5689-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
a rather horrific bug.  When I2C HID devices are being scanned for at
boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
When it does, the laptop reboots and the user never sees the OS.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a89bfce5388e..17abf60c94ae 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -355,11 +355,13 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 {
 	dma_addr_t rx_dma;
 	unsigned long time_left;
-	void *dma_buf;
+	void *dma_buf = NULL;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (!of_machine_is_compatible("lenovo,yoga-c630"))
+		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+
 	if (dma_buf)
 		geni_se_select_mode(se, GENI_SE_DMA);
 	else
@@ -394,11 +396,13 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 {
 	dma_addr_t tx_dma;
 	unsigned long time_left;
-	void *dma_buf;
+	void *dma_buf = NULL;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
 
-	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+	if (!of_machine_is_compatible("lenovo,yoga-c630"))
+		dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
+
 	if (dma_buf)
 		geni_se_select_mode(se, GENI_SE_DMA);
 	else
-- 
2.17.1

