Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE520872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Nsqp3VPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfDQORd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:17:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41218 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732539AbfDQORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:17:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so12168790pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7U9l9Z6GHkS8NZU3n/DufFluzPmoFXxTyR81064Ui4U=;
        b=Nsqp3VPeUbHfNXbVIWdkFOmar03+iU0ZNB+AAdHlJ6AdSPj9OufhfvPky3fAAprRmr
         alM5mXF3p9H4qj8hWP3L6378VKH4PeWEOYOhdGW37ThH5ejMwx7c+euohyXpOdnZDODp
         683gBp2U4vgdipquT0bAyLAhGPyL7VfZ9g8QM8UrRK3MPZsLyMZXRwZuTZIGQZhd3Xdj
         6TtwfsG4Zo2qCusLSvVOxLHOVEgCBlfQgHrDDfsmAQ/AJ+GyDh9ofUJgFZoMGlkkiFCh
         W6E4PxmmFh3ed1PcKEAvFd0QgeY7dTduGgOcGLsBQPGNlzuSptowJYcJXn7W1ZQeHuK3
         DDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7U9l9Z6GHkS8NZU3n/DufFluzPmoFXxTyR81064Ui4U=;
        b=Ta5IykfnF1cobVeA+u+si2XYpKiHUtrX66SPzyzrWuAaXCcTnsru6v+Q28c+1c0Mzb
         eiJa/kkV8apoIcnUypx5ZCJsCT6chByb4AwysVwlSyJLAxm9NJn3Nkz82HEg6LjTZomW
         CCeT6Lf7/AfP+ijQDNcJBpCEPzpdZlpXTFI8TlPOMn4Mgjg+/br10FECxrFq+tBghreQ
         Vn+7X3sb3vI1xCkII2dVTci8azVMEW95prTYNM8B7/u1kGcpqiMOq4zJATCe5XE0r7Bi
         Zl+i/+lsEmpn+l5gERpO23iCHjY8RqSt10fmm71Z1tF9pZchS6geYAEWzz1ySQPocHu9
         Fzww==
X-Gm-Message-State: APjAAAWy5riM/hR4qOMdJMt1nvN/uVWgrM7JOpNdNLZIKhCYw/hkp33H
        M90avaQYinxewZB4r7RIsLwEPQ==
X-Google-Smtp-Source: APXvYqwfBpMdctKsUngq8yPnoeSpLMTd3uPfmZWTeQjp8gE1vM/xZaXt1Ye5SsJOhpa2RoEBIAq15w==
X-Received: by 2002:aa7:92c4:: with SMTP id k4mr90247063pfa.183.1555510621600;
        Wed, 17 Apr 2019 07:17:01 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id y191sm30126832pgd.78.2019.04.17.07.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:17:00 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/5] regulator: wm8350: Switch to SPDX identifier
Date:   Wed, 17 Apr 2019 22:16:31 +0800
Message-Id: <20190417141633.4730-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417141633.4730-1-axel.lin@ingics.com>
References: <20190417141633.4730-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm8350-regulator.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 0eb3f3a33caa..56d6168a888d 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1,16 +1,11 @@
-/*
- * wm8350.c  --  Voltage and current regulation for the Wolfson WM8350 PMIC
- *
- * Copyright 2007, 2008 Wolfson Microelectronics PLC.
- *
- * Author: Liam Girdwood
- *         linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// wm8350.c  --  Voltage and current regulation for the Wolfson WM8350 PMIC
+//
+// Copyright 2007, 2008 Wolfson Microelectronics PLC.
+//
+// Author: Liam Girdwood
+//         linux@wolfsonmicro.com
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-- 
2.17.1

