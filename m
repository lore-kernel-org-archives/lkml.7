Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1496C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9585120879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJNIwt+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfENRiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:38:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39213 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:38:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so9506765pfg.6;
        Tue, 14 May 2019 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Af+6okQBbBqI283SlkSp5KD4CPy+AkHPzwyEcYQ+9Mg=;
        b=jJNIwt+ZFeGtfVTmguA4D9aqTzf2cxOJrbHR0IEggfMsNQeVWgXzt0abGeCQMlYhXQ
         w/o57RsBIDGHNpK7XVdc76kBsShQnwYTF4ID20XulNLJreRlzfOE1pxW0vU8I81Q84Yr
         15d7mELFQrG8HcTmlOhLkifOf308+DOm0dZnzwb78easI3YE12cFxb/GXix29ArQqpTf
         UROmvsACUMWLe3ciAbFTBWgA0Tm0GzN4kUprUHg7D2GOW3q7riXsy+BtBMAH9yL2iMBS
         y/AKAKvestQ0aQKuyAQK640mEQOTpsRqEPRCsU3EgRtbmCPUUxDLoLEEvLXi1dtucLz/
         HVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Af+6okQBbBqI283SlkSp5KD4CPy+AkHPzwyEcYQ+9Mg=;
        b=sns3i0u+qd9FMlLnMdZ7xU91Q8ayTbMsJHGhHbkeaIFtBBQ39f8H5okk3Lt7Is9j6a
         7Zk+5qGQJP/hccX5hlQLbZTq8Z6MPy7MTWw+ZzVl+FxFo7F2UTZr8Iabr1e0hEi70RZH
         K/pQRWyPX5CnRV5aXR+3q5ngchHE17MJt1yhfcWqWQOZRYwBGcY0B27STcWUF8CAjzt6
         KHohR2ZXtjyahlG10dGRZJliPFLuy4DkTUbUbe3qZkIjvQ7cNEyd4om60gHqI8IVLPy+
         kZsPQ/07JCcPuLM3igMNKguoCbLon5EsFkXp7Df2t3zNUNG9OJKEak832Tae7i9FPNm2
         I/GA==
X-Gm-Message-State: APjAAAWv7o9fyTBQH/jsFjT9a7xItIKQHJsEWv7kX9bDu46xYTqM54v5
        fa/e0lvkV6WDAa4G/boZqAD7I186
X-Google-Smtp-Source: APXvYqxtzuJ/roniTZP8I35oCojKxTGjqb7Bgg8WaAksJkq4A/NsQRQxmTmYmK0fMX9yNVdwFAzOJQ==
X-Received: by 2002:aa7:9242:: with SMTP id 2mr42788012pfp.230.1557855502904;
        Tue, 14 May 2019 10:38:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a80sm46115717pfj.105.2019.05.14.10.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 10:38:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     joe@perches.com, Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org (open list:BROADCOM NVRAM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] firmware: bcm47xx_nvram: Allow COMPILE_TEST
Date:   Tue, 14 May 2019 10:38:15 -0700
Message-Id: <20190514173816.17030-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514173816.17030-1-f.fainelli@gmail.com>
References: <20190514173816.17030-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building building the BCM47xx NVRAM and SPROM drivers using
COMPILE_TEST.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/broadcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
index f77cdb3a041f..c041dcb7ea52 100644
--- a/drivers/firmware/broadcom/Kconfig
+++ b/drivers/firmware/broadcom/Kconfig
@@ -1,6 +1,6 @@
 config BCM47XX_NVRAM
 	bool "Broadcom NVRAM driver"
-	depends on BCM47XX || ARCH_BCM_5301X
+	depends on BCM47XX || ARCH_BCM_5301X || COMPILE_TEST
 	help
 	  Broadcom home routers contain flash partition called "nvram" with all
 	  important hardware configuration as well as some minor user setup.
-- 
2.17.1

