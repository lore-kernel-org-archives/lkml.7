Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867BFC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4D2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIKwZn9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGUO1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:27:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46602 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:27:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so36697645wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9C+PRN/qmZzPOz1gGNAlmor/pg0u3GEIo8Ix0gYu9R4=;
        b=SIKwZn9fMmK5l3EPW4QpFg3iL00QD5phWtqdqWhDs+mSmO1fQ9OKtnwZ2aS8NW9168
         xQmHLxmDRjMeIq7+gxfMXEfuMEBrhOUuQL0ocfpJJ8MGbA0nj5Jd5CfILZiSTcXSb2AL
         LqqTatoY2mrc+DzM/aW4UVNgzCTvZ/UL4pNuhCCwq8PP+yUSxDFqsOOy0stR70nj8xmS
         yNNWBedhKkbSPRTv6oefTutJH+URpPRok6dJAYdlCll5E+ySyDf0NgoppAiCwOTDhZCg
         s20T1GsCJvx8uJN7ZlWCY930M1vvhlg2LedEK4a+hZXqymPHhh6pcwjFTvoLHyBr44ji
         RmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9C+PRN/qmZzPOz1gGNAlmor/pg0u3GEIo8Ix0gYu9R4=;
        b=jio0nJF07gSLkcvHSwbuwC4V9N2uy1smmZwM2Q7aixDV3o3VucfNKgm+nQtahUd7L0
         uVHvdbq14/jCfGjAa+n53Fm12vXTcpayFT0K5quPz37TJenst8fX1A4uIO0xoi9iVzYa
         skV2asVqSWqIJW/HY0bDBGMSkE9ONZgntmExYYLrH4yshWXgjW7LSeee9i3PZe6KT3h6
         FUdnC9lYBwDYqzqrLULeH08ZwG+lTa58fZ7Y2qSdmbIlk+IXyHCQIXuC3zfHmIT98o/+
         x8d4LDLbE19gIzolml40ZHrElrs+WIt1qSz6DIXrXhP5BbLLufl3rR9L/fT4CP1VmWC7
         FtJQ==
X-Gm-Message-State: APjAAAUzREVARRgvCxjdX81HSLOjn/5+2UohBs+uUtVGh0MQtO82zXtf
        frWWhiwJOWTCv2aA7+DubaUzwJXHIHQ=
X-Google-Smtp-Source: APXvYqw/49TviTsiK0ZYwgyz83t65zsAlYm2IZPoXMxW8N8O1bscM5zq3UKqtP9rqT/iMfscxg5PjQ==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr69102413wrn.37.1563719255969;
        Sun, 21 Jul 2019 07:27:35 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id l8sm65174639wrg.40.2019.07.21.07.27.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 07:27:35 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: don't reset device when getting VRHOT
Date:   Sun, 21 Jul 2019 17:27:33 +0300
Message-Id: <20190721142733.18513-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VRHOT event from the F/W indicates the device has reached a temperature of
100 Celsius degrees. In this case, the driver should only print this
information to the kernel log. The device will shutdown itself
automatically when reaching 125 degrees.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 60e509f64051..1a2c062a57d4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4449,7 +4449,6 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	case GOYA_ASYNC_EVENT_ID_AXI_ECC:
 	case GOYA_ASYNC_EVENT_ID_L2_RAM_ECC:
 	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET:
-	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT:
 		goya_print_irq_info(hdev, event_type, false);
 		hl_device_reset(hdev, true, false);
 		break;
@@ -4485,6 +4484,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		goya_unmask_irq(hdev, event_type);
 		break;
 
+	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT:
 	case GOYA_ASYNC_EVENT_ID_TPC0_BMON_SPMU:
 	case GOYA_ASYNC_EVENT_ID_TPC1_BMON_SPMU:
 	case GOYA_ASYNC_EVENT_ID_TPC2_BMON_SPMU:
-- 
2.17.1

