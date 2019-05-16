Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499BFC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160C220818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQKmujFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfEPVdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:33:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43782 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfEPVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:33:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so4819525oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RLsybBG6sLbUggVAi7bXCzaTyEG1llzt4l8NvXBkWD0=;
        b=kQKmujFhtAo72AB0snHcaDCif3+naULFQoilmAIC6cMGnoXGg8ewZ21JUB4lOVYrqn
         ziRwjT6PsQTzua7xc3imb9UZ4NgeYhIEclPb/biFpQyoDbDFAidppg+ZW3qHPFUXx0ze
         5IfccJ4XP9KqRDLcfeOaEywCQOBdZZYgC0GDrZWN+2m3m3f856Op6UdFGfgCGpOJ6QAl
         XXlLDRMeCUo3PgBP/hzld3xTl1ISadWuhZWoCvRqCNp1Qkc85SGbOHdmYMnoRrFT0++7
         rMqZUYKbrckThZrps3MkJEXsX5U4dRBUE5FB9eYeCVbeOysRMEsHfr2+3ePDXRIYTIjy
         zJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RLsybBG6sLbUggVAi7bXCzaTyEG1llzt4l8NvXBkWD0=;
        b=gLeE93IzZHs5M92UagAJiw8DXP9WxfjfQApMVqrxSWZT54dA17UPtYOfO5bK2JRMAa
         T4LYS4SvndmqpQRZ9aZnf/oI4kknLofG405UL1kpq748t1QjBqdpjlIzQTPqXOhzj5sp
         JN5sugvL72wlin78sE+b0l0B7V6U9We+JzW2Qp3zLv/7g063PZaoVzqgcRgf/uXjgM2t
         Aw+p2+XbN5u2UVHYwFDYlm59QEfKGdA1tze22goT/xknb6pAdPHuwt9mSPXjG5HtpWUv
         13DLUCCcmmQCqfDdPrdPoB8vrOu43urBsww0mNeu5RE6M0NvZkL9j4F8cl/CqyQ3OHbv
         LMog==
X-Gm-Message-State: APjAAAVlLEBSH0lECjQxss1mBsEAJgf6rnzWGTHpuW0c/NKZvTkF0Coc
        cTf/LvY9aaXpakAPIfoPgHA=
X-Google-Smtp-Source: APXvYqw0GRwZ6MwUBRMhC/o2jF6nAxZtFpTyzX3MJ5sppTLWqV91vvWY1S8vKT1erdagGfEuy/oJcg==
X-Received: by 2002:a9d:7154:: with SMTP id y20mr7131771otj.369.1558042425977;
        Thu, 16 May 2019 14:33:45 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:10b5:228a:3958:f004])
        by smtp.gmail.com with ESMTPSA id 69sm2282544oty.46.2019.05.16.14.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 14:33:44 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v2] Staging: bcm2835-camera: Prefer kernel types
Date:   Thu, 16 May 2019 16:33:40 -0500
Message-Id: <20190516213340.9311-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning issued by checkpatch
Prefer kernel type 'u32' over 'uint32_t'.
Along with that include a blank line after a declaration
to maintain Linux kernel coding style.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>

---
Changes in v2:
- Modified subject line
- Included one more change in control.c
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 3 ++-
 drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 74410fedffad..5ad957e23895 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -52,7 +52,8 @@ static const s64 ev_bias_qmenu[] = {
 static const s64 iso_qmenu[] = {
 	0, 100000, 200000, 400000, 800000,
 };
-static const uint32_t iso_values[] = {
+
+static const u32 iso_values[] = {
 	0, 100, 200, 400, 800,
 };
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
index d1c57edbe2b8..90793c9f9a0f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
@@ -309,7 +309,7 @@ struct mmal_msg_port_parameter_set {
 	u32 port_handle;      /* port */
 	u32 id;     /* Parameter ID  */
 	u32 size;      /* Parameter size */
-	uint32_t value[MMAL_WORKER_PORT_PARAMETER_SPACE];
+	u32 value[MMAL_WORKER_PORT_PARAMETER_SPACE];
 };
 
 struct mmal_msg_port_parameter_set_reply {
@@ -331,7 +331,7 @@ struct mmal_msg_port_parameter_get_reply {
 	u32 status;           /* Status of mmal_port_parameter_get call */
 	u32 id;     /* Parameter ID  */
 	u32 size;      /* Parameter size */
-	uint32_t value[MMAL_WORKER_PORT_PARAMETER_SPACE];
+	u32 value[MMAL_WORKER_PORT_PARAMETER_SPACE];
 };
 
 /* event messages */
-- 
2.17.1

