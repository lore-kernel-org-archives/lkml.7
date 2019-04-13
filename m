Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F4C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE7B214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En8RBYuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDMQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:30:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43507 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfDMQak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:30:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so6565394pfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0/1XtYdFgP3o49tMxTMcOWeCG4XebFfbdD+lHttYzOY=;
        b=En8RBYuuEURsWtlEBdMePx2Jar15L2wse2KZWEiD4/VJVfUMIjUHkaB3+9gpSb0VdM
         YooLISHPk8Zh3GQuUx6kbI4UZEd6ZqcyLecZtU7u9+siP1OMbUvfoxKIF7GHF5AZGk0X
         e8N9tZS8UWhCc1k0EEHyoyLY2apQH6X+A9Er64cc23Y0ZHLSX86sgWNPbh4skQceIPSA
         enqtYLp8PHE+yrhCg0nOCZghbsVFvPH/iAMup367NB2Imq9WZk+d75/dov8YvzpAsyHy
         I42xdxFWozDrSPy6eQnLUvtM/Ca4oG+w7Cei0pYR0M5WOb6VgZPIZOjrsCVmWyV+OxEY
         DatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0/1XtYdFgP3o49tMxTMcOWeCG4XebFfbdD+lHttYzOY=;
        b=b/KG12shGfEalDbNed8woxAh3B/WrNs98tMh9kmOhzWgZ7dq2ZlE1XyYG1EGBfUb2P
         cdpVCAu9eFnsqb1NgEuEEyKs4jyBMWUZVDC8uW03+KSeIgirNIjP/lJuqhnqaaChRm9Q
         yPKnPGW1vfksu9R7x+rLtIYC2BqbPyJVA0gmbUMdIoXrwEggT/c6bxImg/Z552J1nGHd
         16C6yVOqMYbvfPj5VHUCNyMknV3+TxfrZHGt/cShxQGeX1mXvFpLm/iqAdGK1Wj19Q8v
         m166BYJHFKCCcB0c5+hEYic0ovhzwIMOBptvlff6R1LM8lxyffUcssN/78rX4q1PlNAx
         WFyA==
X-Gm-Message-State: APjAAAUR4PrD3pKZ9bKfbJ1iFa5y2WeD0tIOFqHxNt+jwh30CJfFFYSK
        /VQiblHo0t5T7YA346DQOdI=
X-Google-Smtp-Source: APXvYqxcj4vOlWTFBIxNRiI8DWIaZ/QOGbvi08ff+E/l+Cdf1CMp3oVRUsS5gK9geHuT1/uoSwupqg==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr61225090pfc.229.1555173040102;
        Sat, 13 Apr 2019 09:30:40 -0700 (PDT)
Received: from localhost.localdomain ([103.227.99.109])
        by smtp.googlemail.com with ESMTPSA id 10sm61846358pft.100.2019.04.13.09.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 09:30:39 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
Cc:     moseschristopherb@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Feder <jacobsfeder@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: Add elaborate description in Kconfig
Date:   Sat, 13 Apr 2019 21:59:03 +0530
Message-Id: <20190413162905.29324-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - The Xilinx AXI-Stream FIFO IP core driver description is elaborated.
  - References: Xilinx PG080 document, axis-fifo.txt

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/axis-fifo/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/axis-fifo/Kconfig b/drivers/staging/axis-fifo/Kconfig
index d9725888af6f..ecb7811fd387 100644
--- a/drivers/staging/axis-fifo/Kconfig
+++ b/drivers/staging/axis-fifo/Kconfig
@@ -6,5 +6,7 @@ config XIL_AXIS_FIFO
 	depends on OF
 	default n
 	help
-	  This adds support for the Xilinx AXI-Stream
-	  FIFO IP core driver.
+	  This adds support for the Xilinx AXI-Stream FIFO IP core driver.
+	  The AXI Streaming FIFO allows memory mapped access to a AXI Streaming
+	  interface. The Xilinx AXI-Stream FIFO IP core can be used to interface
+	  to the AXI Ethernet without the need to use DMA.
-- 
2.17.1

