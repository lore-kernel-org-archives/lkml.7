Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B39AC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD37D218A3
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBIMpCaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfHRJfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:35:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43810 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so5620098wrn.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Wzu67dw0GvRFE1y6lo2AReLFisvrnW6U7+9+4cf2Ic=;
        b=KBIMpCaZRQdho2uz3Qe57wLY1xWbAx4/nAj3DaL4m/UCkymmrI11msMTJFn3+uDEIC
         0fPE4UaRxeUgs2H47azemWMw80dBEPACxU6K4hDN/VzfBtGtGFLOonCuv8uiK0Rpm21s
         lnLGbGA2hwNi7IGBRlTk+5fjKxbNemPWIlFBbvNBO83d/RXyRinF6c5D+zF+hHamTUNl
         8iFKXrarL3KuyfSK46qPy0zlpwG5sgnSCSp1QucNIIfn7pFcLDD5OphMUV6dyySpKyvN
         ERUEIXrRCdig9n3JnICgpVYntpyMTHM1NX5s1oJIw777ERRI55aYWSSMX7spcgP9bdMV
         T7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Wzu67dw0GvRFE1y6lo2AReLFisvrnW6U7+9+4cf2Ic=;
        b=iEx/qBZ6Tps2YMxYTtFPo+HOazXNOljk0x4n4rKIlLg11oI/NYAnQyfsaGNMAtbgqO
         LDg1m627FmTmC2OXJwt+xv3LcoirX5TMixYOvojEAkh6Wvp1rQfnDTgUYgjGKkP/IKkt
         8AjhsrnF5ULHK6I5dEpiymnJr66YRSHWWbLDoJb6cKREX4FHTmMaiM9CctBSpTLLJ1HA
         8ZxQV5RT9NTOaYhlvfpAdy4OY4unrDduQ2xrkj30FB9N2I21Pabb31WvfodeKxREHZ3C
         3ihs19hwgRsXFW9yd8MQG9z1EcyPcV8+F2PvipqEflsfnz6Ro9RXIrzaYBRCuGRbuutm
         hdQA==
X-Gm-Message-State: APjAAAWbAOJ+g/2o+IdtTC92pmu6q/JZ2UpnGdTxyml5ZjvkTUMWHsAB
        y9G1MNn07Ijn8Y1mS1/5gB4mvg==
X-Google-Smtp-Source: APXvYqyu70ePP0dKRJImgiz4bpTFINp67ziwbjNdG+JwEFF+s5x8LPNEY7zLNjWadyTULScmlvogjg==
X-Received: by 2002:adf:d187:: with SMTP id v7mr10108722wrc.33.1566120878156;
        Sun, 18 Aug 2019 02:34:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/7] nvmem: imx-ocotp: Add i.MX8MN support
Date:   Sun, 18 Aug 2019 10:33:40 +0100
Message-Id: <20190818093345.29647-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MN is a new SoC of i.MX8M series, it is similar to i.MX8MM
in terms of addressing and clock setup, add support for its fuse
read/write.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 42d4451e7d67..dff2f3c357f5 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -479,6 +479,12 @@ static const struct ocotp_params imx8mm_params = {
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
+static const struct ocotp_params imx8mn_params = {
+	.nregs = 256,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  .data = &imx6q_params },
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
@@ -490,6 +496,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-ocotp", .data = &imx7ulp_params },
 	{ .compatible = "fsl,imx8mq-ocotp", .data = &imx8mq_params },
 	{ .compatible = "fsl,imx8mm-ocotp", .data = &imx8mm_params },
+	{ .compatible = "fsl,imx8mn-ocotp", .data = &imx8mn_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.21.0

