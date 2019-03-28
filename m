Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A22183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUTO3bWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfC1QWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:22:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1QWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:22:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so23655100wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBwsKuOZmljYQRDf22yDXymVd8t2rdhLoRL6JMRCqac=;
        b=VUTO3bWQKsei8M3CvwM8l3W2irNVm3lJZoY2azFY8r0dMt91JxH6mIm2hZbqAZU60w
         ZYiqJzDhW/NKZ5AZ0GECXza7DCWLDlu41uKRR/Izk9R4oApp5/TXSFeyVmsckUfPH3Wq
         lM8e/MRRGRXehN9j4wVxCYWX753/aN0fHxyxgwQxDB6FbBSK6uVtM9Hc5w9Siv7Isj4E
         QkgR8rmMNmzcr8KHakfe3guWhE3BaLL2SY45XZo3s4Bt+CCWiVATHmosD57oaPBg15Jm
         JJSfKyFl3zHSilWg/JbXTGhtXizf49wRW+gAiF7UJST6lJldrT5CwLjRKNfe6HDD4dIt
         LO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBwsKuOZmljYQRDf22yDXymVd8t2rdhLoRL6JMRCqac=;
        b=XaY5b8xZrS4Y/BmknOWiP8scffCh5XHQvScpYO7sdTsPYKaV65ELbbzOun3AQzyaAE
         kZtMwRko5d5xFGNjzxkiaziUOHIsMbHNYgElPhVUJRVZECKekMc9MzbpTNXkLUj70C6j
         7Nx1kmcK/VDPNSykV+t2aoJ8ouoRrIj4ZHuF0cRmJ5fppw4O07lDAp7pbeSwuYwvWS71
         OtbEsXvkN2QGQPSJN0URt6UNDcL0mAN3B+5J2Vgvt/1OF3Q3KL851Fpd1qc3Fow6Hljc
         I+E+E9GAHEvmWxvTMlOxYUkiVlDLIbN8kIbL8mhP+02OhWxBk7a+ikLBKwr16ydNTumb
         MwGQ==
X-Gm-Message-State: APjAAAUHG2ixTp5hPudKNfl3nG7rWGyHHyPO6/8aEEuhX1RCP/kCLJoS
        AtIfSxQkSNhtrJnZysLKL3TSgw==
X-Google-Smtp-Source: APXvYqzOWNc5tNnWCzsLQz/CSkEu1YTt8Ic+7jub5R+A87emDRCi7vP6HjVNC9/2vcXcVnuDZ89JKg==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr5659011wrv.18.1553790166922;
        Thu, 28 Mar 2019 09:22:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 3sm34887905wrk.68.2019.03.28.09.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 09:22:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] regmap: regmap-irq: fix getting type default values
Date:   Thu, 28 Mar 2019 16:22:18 +0000
Message-Id: <20190328162218.14569-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for value of type default value just after allocating will
always be zero and the type register default values will never be read,
so fix this!

Without this patch setting irq type will be silently ignored.
Patch "regmap: regmap-irq: Remove default irq type setting from core"
did remove the default mask but it forgot to remove the check before
reading the default type register.

Fixes: 84267d1b18ab ("regmap: regmap-irq: Remove default irq type setting from core")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap-irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 5059748afd4c..02eb75646141 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -761,9 +761,6 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 	if (chip->num_type_reg && !chip->type_in_mask) {
 		for (i = 0; i < chip->num_type_reg; ++i) {
-			if (!d->type_buf_def[i])
-				continue;
-
 			reg = chip->type_base +
 				(i * map->reg_stride * d->type_reg_stride);
 
-- 
2.21.0

