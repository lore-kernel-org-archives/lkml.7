Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5256BCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85B21924
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVPcvWXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfJ2Lnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbfJ2Lnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1so5814875wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzRJPD/1HGldywpr2/SZcm47DrBumEiDLx/FHjXP3jg=;
        b=nVPcvWXaGDmiEurjXX9F2sU/zrnuaMQomuye3kEdvlC0gsQRugtHZLRRgPbONylqq7
         KrHB1hsyc0qAcRXuq1sphNGEhfrQFbZd6IQiejeChPrvUlTXRpIjThoKbZ698vvhOcDL
         h5+WcaLbrhdzw/yUdORO2K9nEGR1OWak8GzgwVK+SErUEeZ6cR23g0nUCJu632gc+AfB
         9iAjsiKGaMxn5Zt7WO9aXTaNFZXo2oxvRiZu5ys5Hd/VlcbWnWlFshcOO9oEAk4U0GNg
         TCIBMmg/7YwzmU2t2qHtoYCm553UPSgqa93Fpv1rY9UwYFFkNYZ56G5weeMO79FKOuDc
         fTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzRJPD/1HGldywpr2/SZcm47DrBumEiDLx/FHjXP3jg=;
        b=OrQLdttfb3JroL3v4JbLsF7uyYiIMuNXx+iUP1Utm+T8vq/K+o1Helt8cEozg3i1tt
         7twTB/5uZJn99cmth5wnIj10uXMynLNRj1+eSHuwptxq/ORGR8ZgYzeAugKIvRxnvY7h
         5S3TPxWvHDlZuJlJSRWyA8nDjxrp+v9uSPxe9KrUHhdSzYgJmTrg8LwrhM7C4ztoMNee
         OmsLLf3eaBXYPLbD+IloxjooxbyWE0k+udiZi2n65n7mbGX05OA1ahP948ZiwzIGEz//
         t/8mpinD5lBbCtWJ7zm/V5NDIY2wJDAeMatchQd05VWyGvP2Ay3RVq/BI4sdA1iRLitg
         KoXw==
X-Gm-Message-State: APjAAAVmJgmWdHJsuS9QQOetvwxyYe1Qo8BFQz96Jy7g7mniVjMP3xK+
        JHTy5Cj06LYgrw+sThxBW8g+QQ==
X-Google-Smtp-Source: APXvYqx+vYmeYGxMf7Gpn3l3ztO27XzHKD6H862Ti1fndO/+/Fr5FfhNmCTEm1yKcLm68cld3Y0tlg==
X-Received: by 2002:adf:f342:: with SMTP id e2mr20681695wrp.61.1572349417802;
        Tue, 29 Oct 2019 04:43:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/10] nvmem: imx-ocotp: reset error status on probe
Date:   Tue, 29 Oct 2019 11:42:35 +0000
Message-Id: <20191029114240.14905-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

If software running before the OCOTP driver is loaded left the
controller with the error status pending, the driver will never
be able to complete the read timing setup. Reset the error status
on probe to make sure the controller is in usable state.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index dff2f3c357f5..fc40555ca4cd 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -521,6 +521,10 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	clk_prepare_enable(priv->clk);
+	imx_ocotp_clr_err_if_set(priv->base);
+	clk_disable_unprepare(priv->clk);
+
 	priv->params = of_device_get_match_data(&pdev->dev);
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
-- 
2.21.0

