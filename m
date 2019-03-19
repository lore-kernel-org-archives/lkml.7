Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D563720643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEKZkQWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCSMHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:07:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32878 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:07:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id i7so10486101pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ixHSVbyqdXpsAOwrMu3VJG4MBaT5yderip/bcPsCq4E=;
        b=tEKZkQWBkNtX6OH92MH7R/oawytcMSfpjGIQ9ek4VNLUb7Qje0YEX9xQfVBHLNABS6
         AHwp55XFhHfbdYE4590kGJ/9hwhI4qjNx1iTv8k/EhVQ9e5Cfob470K2SS6ZhWBrIAoo
         4Z7rYj+RZGwhg6wotrmSQ2dCRqcLJTvpoBcTqItLCRP0SQd7rDgQEElE0GGvjyOm3s7a
         6/PNEu3xMM36fFu4XNRzlftlostL8FIhZccYdnafldPryrE8zmZjzI7nO1bh1B9Q47cD
         0AV+9l5erfBvq7jbuwVZcaNeGii8rW2xuoR1Gv+1D2PPFpBRGyMDZ29GxiOuR1Ocuw/K
         YZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ixHSVbyqdXpsAOwrMu3VJG4MBaT5yderip/bcPsCq4E=;
        b=IVxKSlPFiv7TnxmtzWGwWzMayUycuGGcbiY83s2Yw7BTy+qX8mpggDGj2ry9X677nv
         TnFDjbzU1G09Mi2jy8d8dx8krv4QnPZ7iO9tTVzY3wWgGCn9eKSRHYXTs0Zto++W57NV
         HqgJSeugeuf7TuhrAJrtkqEOwD1YhgtYBIgeMn46oP1pWd5D++2DKkteysCwRG1V+gvM
         zItuZCS5Cpnwub8ACz19P8rRGPjgOWusXXYsgbvaNkd3gqp5avQHwpc67qfVTJoD3asN
         PLBTh42hlOLObnvypCoUi3Anvhf+bkaaZxeijPaxlgwWTRUuVVccEqIPa0VzV4vBGZOw
         XKQQ==
X-Gm-Message-State: APjAAAXba86rtG/40eBuUFH5xBkpex1/MCQb/sAQRdw2021rNiYFM1IO
        J8ZOxrF7TpVrnok2eVepmpbK2e1d
X-Google-Smtp-Source: APXvYqwuM1BI2KPwzUCEt/u9+WPP5xBrX3DjMU+i+2q2WQyDI8Vccl5Wa1p49TAt0B2rhUrfjlYJFw==
X-Received: by 2002:a17:902:f206:: with SMTP id gn6mr1699695plb.58.1552997269606;
        Tue, 19 Mar 2019 05:07:49 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-235-235.dynamic-ip.hinet.net. [114.36.235.235])
        by smtp.gmail.com with ESMTPSA id s184sm8043901pfb.1.2019.03.19.05.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 05:07:48 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH 1/4] Add support for SUNIX Multi-I/O board
Date:   Tue, 19 Mar 2019 20:07:23 +0800
Message-Id: <20190319120723.3691-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig and Makefile entry.

Signed-off-by: Morris Ku <saumah@gmail.com>
---
 mfd/Kconfig  | 5 +++++
 mfd/Makefile | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/mfd/Kconfig b/mfd/Kconfig
index 76f9909c..efbb3ef1 100644
--- a/mfd/Kconfig
+++ b/mfd/Kconfig
@@ -1916,5 +1916,10 @@ config RAVE_SP_CORE
 	  Select this to get support for the Supervisory Processor
 	  device found on several devices in RAVE line of hardware.
 
+config SUNIX
+	tristate "SUNIX Multi-I/O Board Driver"
+	help
+	  Support for SUNIX Multi-I/O controller.
+
 endmenu
 endif
diff --git a/mfd/Makefile b/mfd/Makefile
index 12980a4a..b70f44de 100644
--- a/mfd/Makefile
+++ b/mfd/Makefile
@@ -241,4 +241,6 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
+obj-$(CONFIG_SUNIX)	+= sunix/
+
 
-- 
2.17.1

