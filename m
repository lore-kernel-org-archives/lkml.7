Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A67C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C798520859
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 19:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbrav5s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfDUTil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 15:38:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37512 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDUTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 15:38:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so12333268wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 12:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6fcRlLxWGOK7R0tcaRiZVBc6WdzzkPd+uoXzx6GO828=;
        b=Zbrav5s5JoykLOSy+gIESD89NzlNHIyTWr4UdSzsG2eEkD60DQ+AxZ15TREWY7f67P
         m0tnmKGvV8dz8HOdFFR8wDuoUe03+i18OoqPGbYpzm96ouKjcIuYSzKNvNlMu6WRFind
         AQtWSWT/Q9dLpFSGyYMt/or0CdNxRF4AuPpILlG/UW7zgJkMKGvyzQNUcFkz1Dul2UTB
         zpAilouV3IvIaTg0CxEThpss7OSi5pHpvIHBRwUSe5pOq0z81k9HbOhVb/sfG7rgIaBr
         grL0yH/EWKkTHKAx3G1XXn6xwOKqYCBpkAoH23yZ78NqfVvr+OQj5sIAJjiaVO9C9YEC
         Z4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6fcRlLxWGOK7R0tcaRiZVBc6WdzzkPd+uoXzx6GO828=;
        b=TVAQfhngtRL3885+xCNFGL31RGi26T88JSQPhDPGKp7vvS0bha/gjC3+EjIVigjHdq
         v3Vi+wDHm1BjUsydVgXlRm4q6wk5PiG89aAkMrfxqwsqdm10EIun8dIjt7Sl7PhwMxOq
         ebf0oN3EMIeU83Fd4g9T0jhDv+9tiJNe59008b6xm/u16H598uYG7FLaNuhjWNmmpcQy
         exfw7+lWVcFRw6PmSRDfttvjuCxpQAXCbna+Yet5+NnEpIK/hZ0ldDsWNg/L4HKm9lP9
         D/vft46Spkje3WbjiXI1taGxnyE+cewQ2XNcUjlUxq09qqZoXfmOsBSdjZ8kCIYONJcq
         9fuw==
X-Gm-Message-State: APjAAAWMRggYhUVUzMu5pCDxb28l2075UzmfEgLv71C631R9hHXrn9IP
        IrWpf9uEVCQYFnvSGgXqgxv34bkz
X-Google-Smtp-Source: APXvYqwxfQ3WyXwlHEiNeXL+bjK+h6vDPqXfeX3JDkn0fqdmARO9/HUWR8gi/I2GPqF//Oo7Qk62eQ==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr10455003wml.74.1555875519379;
        Sun, 21 Apr 2019 12:38:39 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id v192sm10342571wme.24.2019.04.21.12.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 12:38:38 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: re-factor goya_parse_cb_no_ext_queue()
Date:   Sun, 21 Apr 2019 22:38:36 +0300
Message-Id: <20190421193837.24289-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch re-factors goya_parse_cb_no_ext_queue() to make it more
readable by inverting the check inside the first if statement so the bulk
of the function won't be inside an if statement.

The patch also fixes a spelling error in the name of the function.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 43 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5100dfbf3acc..ed3c4b81aff1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3859,36 +3859,35 @@ static int goya_parse_cb_no_mmu(struct hl_device *hdev,
 	return rc;
 }
 
-static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
+static int goya_parse_cb_no_ext_queue(struct hl_device *hdev,
 					struct hl_cs_parser *parser)
 {
 	struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
 	struct goya_device *goya = hdev->asic_specific;
 
-	if (!(goya->hw_cap_initialized & HW_CAP_MMU)) {
-		/* For internal queue jobs, just check if cb address is valid */
-		if (hl_mem_area_inside_range(
-				(u64) (uintptr_t) parser->user_cb,
-				parser->user_cb_size,
-				asic_prop->sram_user_base_address,
-				asic_prop->sram_end_address))
-			return 0;
+	if (goya->hw_cap_initialized & HW_CAP_MMU)
+		return 0;
 
-		if (hl_mem_area_inside_range(
-				(u64) (uintptr_t) parser->user_cb,
-				parser->user_cb_size,
-				asic_prop->dram_user_base_address,
-				asic_prop->dram_end_address))
-			return 0;
+	/* For internal queue jobs, just check if CB address is valid */
+	if (hl_mem_area_inside_range(
+			(u64) (uintptr_t) parser->user_cb,
+			parser->user_cb_size,
+			asic_prop->sram_user_base_address,
+			asic_prop->sram_end_address))
+		return 0;
 
-		dev_err(hdev->dev,
-			"Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
-			parser->user_cb, parser->user_cb_size);
+	if (hl_mem_area_inside_range(
+			(u64) (uintptr_t) parser->user_cb,
+			parser->user_cb_size,
+			asic_prop->dram_user_base_address,
+			asic_prop->dram_end_address))
+		return 0;
 
-		return -EFAULT;
-	}
+	dev_err(hdev->dev,
+		"Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
+		parser->user_cb, parser->user_cb_size);
 
-	return 0;
+	return -EFAULT;
 }
 
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
@@ -3896,7 +3895,7 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 	struct goya_device *goya = hdev->asic_specific;
 
 	if (!parser->ext_queue)
-		return goya_parse_cb_no_ext_quque(hdev, parser);
+		return goya_parse_cb_no_ext_queue(hdev, parser);
 
 	if ((goya->hw_cap_initialized & HW_CAP_MMU) && parser->use_virt_addr)
 		return goya_parse_cb_mmu(hdev, parser);
-- 
2.17.1

