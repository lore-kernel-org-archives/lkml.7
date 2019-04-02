Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A092084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INw0CMrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfDBPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:45:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43427 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfDBPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:45:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so6758959pgu.10;
        Tue, 02 Apr 2019 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFFTfhLy6qm86XkOlWp4trauKJ3kmEOKlYTBp1fQxws=;
        b=INw0CMrzVrJK43sbFU90adMOEfRQdJ7SSyQMJT085qwwHrmKvQRCo1bnsTQ7SxApFB
         UjYDfxvmAOK8OSTxYuUupWlMdUiKMr1KFfPVDB0GaImbqWdnyD3F2dLRymS4Vart/kQS
         LdfBbrOSO6VnHM7Ayq49MzS7UC9bf6ZmoBlvBnLmVMrPqW0k/B8+gsVq+JwkvEGYa+KP
         OZXPJ2NWj8Y6FWc6SPskYqw/UUxWLEwlzjs08rxzCDKko7Gvpe+AtKwTy8riUUUy3j53
         3i4p9E0Uc3PMZBVNmnDewsNdwel/HqHULnjxmcXx5rb93mwL08NEmMAHzCowRMSphvCj
         /AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFFTfhLy6qm86XkOlWp4trauKJ3kmEOKlYTBp1fQxws=;
        b=tdjozL/qTAmmnQ5BuShDcuweegpHHASoDzpb/pPVjGldRB5XB7Tog0DeG3o1iRsKHn
         wMoniYaw+ZlLYHVUho9XF9R49TFVYS1SWlptONVdipewbSNQ2ENCGzE/H4xIPP/5Ib8R
         g/YPJJ1NvVEv1XxKXbSzne20LlR8klqikdoCXlcy2hhsA9YWvSeH6yvsHEuuu5lwVxK/
         VKt/7cYCQrRLDUsOGuBzp0BfT8BMlAijGrCNxQq64G1dM7qPNbJk7eANVJPUFkAFBgYb
         rOLw6J2QeFTikZQqSJkh96a84YhWgiGRqmPqVxYwiz/Sk6drtIgFn6Onn6WzYm8YqZ6R
         XuLQ==
X-Gm-Message-State: APjAAAXR0YRVeuZUZesCuJGt94Ja93X7KTdFveAYymHbBrK4zgEEZhvU
        M/Zpx6Dj8CZ6mQZ6otEiiPs=
X-Google-Smtp-Source: APXvYqxEgsK3I3Otq75CIGSEIel6eEaHkxfxeAj6w3Ia6+3PNLwlv5E4uR0MSw6wtkFtWDoWbETZjA==
X-Received: by 2002:a63:e70c:: with SMTP id b12mr67787121pgi.399.1554219929754;
        Tue, 02 Apr 2019 08:45:29 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s5sm15986916pgv.8.2019.04.02.08.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:45:29 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 4/5] nvmem: sunxi-sid: add new reg_read func
Date:   Tue,  2 Apr 2019 11:45:13 -0400
Message-Id: <20190402154514.11284-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190402154514.11284-1-tiny.windzz@gmail.com>
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because there was an endianness issue. It seems that reg_read
function which the nvmem the driver currently exposes is wrong.
So add the new read function, the new function is used when the
native_endian flag is set.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 54620d72ddb9..5b8a42f686cd 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -37,6 +37,7 @@ struct sunxi_sid_cfg {
 	u32	value_offset;
 	u32	size;
 	bool	need_register_readout;
+	bool	native_endian;
 };
 
 struct sunxi_sid {
@@ -75,6 +76,31 @@ static int sunxi_sid_read(void *context, unsigned int offset,
 	return 0;
 }
 
+static u8 sunxi_sid_read_byte_native(const struct sunxi_sid *sid,
+			      const unsigned int offset)
+{
+	u32 sid_key;
+
+	sid_key = ioread32(sid->base + round_down(offset, 4));
+	sid_key >>= (offset % 4) * 8;
+
+	return sid_key;
+}
+
+static int sunxi_sid_read_native(void *context, unsigned int offset,
+			  void *val, size_t bytes)
+{
+	struct sunxi_sid *sid = context;
+	u8 *buf = val;
+
+	offset += sid->value_offset;
+
+	while (bytes--)
+		*buf++ = sunxi_sid_read_byte_native(sid, offset++);
+
+	return 0;
+}
+
 static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
 				      const unsigned int offset,
 				      u32 *out)
@@ -169,9 +195,12 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	econfig.dev = dev;
 	if (cfg->need_register_readout)
 		econfig.reg_read = sun8i_sid_read_by_reg;
+	else if (cfg->native_endian)
+		econfig.reg_read = sunxi_sid_read_native;
 	else
 		econfig.reg_read = sunxi_sid_read;
 	econfig.priv = sid;
+
 	nvmem = devm_nvmem_register(dev, &econfig);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
-- 
2.17.0

