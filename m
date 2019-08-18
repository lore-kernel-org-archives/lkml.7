Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39EC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900EC2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyHCBtJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfHRJet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:34:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50620 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfHRJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so517282wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWXubkdQ7PXTVA4rbdbQWeUwRLODNAVnbs8nKr10Ngk=;
        b=uyHCBtJPhL2t4HoFPsFqz7jdzBHiKXfNwqItD4QKr43QD8qrjY+Qrrc5UoqruaC5EI
         /8gfBxgFrTwdT7XyNxcMkI+Z839MJspBP2/mlj+fX7eNQpt7VaicafitA9LBNWLfSevL
         dBfLBEKlxmuOqsxcd0Cb0nEk+g1eC/yfT3EEu4FnFcWjXRRTLHk1kUqJ/E1qCxkFRalr
         JdDMb4bGgjChdDt1FAXYZCPOHTjLrVb4mh14Opq9JpSBMr5sY9RcRl3ql3TCgSHkuhZE
         e8rjxPdpQW6w53adpFZ7I+nAmW/lepchXEELn1pWkQyjczgVf91fiVSytMwfe6VL/1zp
         jJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWXubkdQ7PXTVA4rbdbQWeUwRLODNAVnbs8nKr10Ngk=;
        b=jzLTMDUVqrjgjrmqRGdbg5jUoQTzn76xEuhSVR6ulAN5z0m9un9SxOPm4KNMZi68dJ
         IrgibqsE4kozO4GnlV/4X5D0MHiq36XoBcOI95/bQvzm2EGvVcNo6wtvI4hHRtm4/TFf
         WXKxCMANeQkU+EfakpVDodAzB4ai0qpIVaP6MRaVXfqHQR3ESpEbXf1TKY+NqnA5X9va
         sAT1DMhEesvJoTbmPGlzFM8k5qj6eSfWrz/0G0YGOZaZJE4ZqF6fVYweXQv+Xz092T7T
         P8QTZIdOabgqtlvpYJiaLCTQvxG2ek+/XmNVUY0h0ZlMrAU1lEM8qRqzUAY/yruHbCBV
         WCLg==
X-Gm-Message-State: APjAAAV3aFyfxX44VodwyTGHu2zefsmWzT+6w+dYBb0J8i23GkdmQjZr
        4aAYkdyVK46ouUsUXisgXa1O0PwCvrA=
X-Google-Smtp-Source: APXvYqwsHX1QOJttTO1GzHnVF2kwAcsgAKki8b7Cs+oTlRP/XGtLQnKN8xiuPQVe9G+4ByRsZQbIIw==
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr15310917wms.141.1566120882869;
        Sun, 18 Aug 2019 02:34:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] nvmem: imx: add i.MX8QM platform support
Date:   Sun, 18 Aug 2019 10:33:45 +0100
Message-Id: <20190818093345.29647-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

i.MX8QM efuse table has some difference with i.MX8QXP platform,
so add i.MX8QM platform support.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp-scu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index d9dc482ecb2f..61a17f943f47 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -16,6 +16,7 @@
 
 enum ocotp_devtype {
 	IMX8QXP,
+	IMX8QM,
 };
 
 struct ocotp_devtype_data {
@@ -39,6 +40,11 @@ static struct ocotp_devtype_data imx8qxp_data = {
 	.nregs = 800,
 };
 
+static struct ocotp_devtype_data imx8qm_data = {
+	.devtype = IMX8QM,
+	.nregs = 800,
+};
+
 static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 				     u32 *val)
 {
@@ -118,6 +124,7 @@ static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 
 static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
+	{ .compatible = "fsl,imx8qm-scu-ocotp", (void *)&imx8qm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
-- 
2.21.0

