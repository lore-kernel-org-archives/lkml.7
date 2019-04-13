Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677B0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E99D20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHW8eSLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDMKdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54541 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfDMKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so14195870wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nptnDJR99QeM/FrXgUlEziNHJ0JezRkAyQKy55fvHkU=;
        b=eHW8eSLURcZAhLZQSigqQbpnc7W9hsOtj9DtyxZhveO9mNmXOajfwMRvYU6v2eiaqF
         y2dhYCpwCceSi8tuHSOtk9rx0XzbVsgd0uAukQvFr25hGb+sy3BgXyjekSGUv2V3xdSG
         fBC1lvshCdwtQCZdD94ELjABYs5GvG6lZU2HhGofCmT1cTgt++Cl6grGI73mYUVZ+1qZ
         wBvaJck/ibyLStYf1rY8lr77IR/B+ybwTuFbuZvUrzkaLP3NLc3pY3R1yoiLypwslkCm
         Mgw5qDwfd2dFoMuW2dHn7O8B/IaFgwP5bInxAgzw4RUeD5CKJOzvejO+L4Y3M7RQs8Jc
         6g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nptnDJR99QeM/FrXgUlEziNHJ0JezRkAyQKy55fvHkU=;
        b=QHaV2pryuAhd0wvHyQY8pDOKRPGkTvFV0NIgHZaliuiQaHhfR6a37iMbe9t42pZ03X
         etk2BKgBpovmH+Pa7WJt7GAMfHcO2CqMUH8fbdI3Q06RbxfQwVpJq+a9x19BHQdYiyGq
         dr8/fttuvQWTOepVJmip8Qdk1Orcd6/e9ZolVPB+EqnMfjI2lw26cnB8RjstvyU/c+f3
         YRWfVKlqCNQkQALfFsdUi423S7An9LB/oivDATMtVxcuzRbzka2hmyYwghoWVHIuwPg+
         DICQt79vC4DGuCNCtd1CAItc7KkeyeVpM0rmufMJQdAXIZk5PfXPloEAjOMS+IjtMBDq
         TGBw==
X-Gm-Message-State: APjAAAW2+u8/yvMPU7kly3bEe4C7t+AK2GwznJ/9So4PjnWeFcdFgJdj
        OALv+9F4I8T3bueRG+iO67kZaA==
X-Google-Smtp-Source: APXvYqx+QsTRXQQo9wW3DCXC0WruTsT3E3/+VgMeMKv8HLjsbmrcarPPPd2vftyH3XhNn/HN62qfRA==
X-Received: by 2002:a1c:1d97:: with SMTP id d145mr14050463wmd.136.1555151607702;
        Sat, 13 Apr 2019 03:33:27 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 20/20] nvmem: sunxi_sid: Support SID on H6
Date:   Sat, 13 Apr 2019 11:33:05 +0100
Message-Id: <20190413103305.9576-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add support for H6's SID controller. It supports 4K-bit
EFUSE, bigger than before.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 7013f9cc43c7..a079a80ddf2c 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -188,6 +188,11 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h6_cfg = {
+	.value_offset = 0x200,
+	.size = 0x200,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
@@ -195,6 +200,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.21.0

