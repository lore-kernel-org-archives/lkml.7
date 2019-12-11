Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C237C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3721556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0P1tS1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfLKVCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:02:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44572 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:02:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so2389671pfd.11;
        Wed, 11 Dec 2019 13:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OhBkMI3t3DWSX3k7D+r5JxYn0BJD2ICRypnq2eXkR0=;
        b=P0P1tS1T3NzwhVl8ZF5LJwPyhvw9yGhEEvxjhk0lzERnuFw2U8FfN7Y8QBU98CS5FC
         /fuI/tXT0blh59eEfaBMhxgMfeCH6ThCLgzhzBKRZswCzx7ySCF3pT92C3hBksy4A5Ac
         ANqvwHTLzIpnJNTqN7up4PA8jjPzk+tD87UZtn3AGa1cjuFEjB7UB480e6a+AF20D+vb
         OFFkC/ocfj81d1eKNMy2CI7MS4WUGGVKj+/BXmJXR4n8oM6iUcHYZMROsDl+HbJeoLlr
         AUEi6chsM9yaZuJ9aZ26LjlHQi6gFmybFQphtrWpSEx0x/V0A5HWtXp4OFpIAIWhWL3f
         qtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OhBkMI3t3DWSX3k7D+r5JxYn0BJD2ICRypnq2eXkR0=;
        b=bU9SO6d0ot2xHecc2movB3eMabJdq8Bk6G1uDA02UfvKjC/Q3kHlfdMnTTSc5z9vv/
         cOktjoTRZvGJk6V1NyJTBUYB4OdwYPYn9f6zqTs1KuX5BKaEuo0aYd9kCi6MZfE2w6/n
         22ZZSVpqzBYI1/PJKRigPqAc7cbCeKNWTnAW67czrmVF24QN/bxvzHBVeuiFmeQsRBNS
         hK+Vre4BzSmCjEmfRWvH0Q7rKlZUTqWb3lE58u1Aj/Sbkgt5S7/bHfz3kPMyKFV12jL2
         4A4PnUUk2dMoeK4ZDFvBKaTGauAu7vYI4lfjkBSNUBJ/E59/EhXIOUcCtOTStc5JGp1L
         h9vw==
X-Gm-Message-State: APjAAAX4MsZz1LOdSYsdJkI9HUEHLDP0tMmLJnhOJc+oliiBmbdXLVrF
        IglNRYOH5tGZg2jVJihkwQrVFxbd
X-Google-Smtp-Source: APXvYqxF7uajY/k2sjYOpwbigBP1VPQ6hkyHaUQQRhNvPJVuVLBqSKNCYo4JdRr8VytSCzFajcg3Ag==
X-Received: by 2002:a63:30c:: with SMTP id 12mr6401250pgd.276.1576098130113;
        Wed, 11 Dec 2019 13:02:10 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g19sm4062137pfh.134.2019.12.11.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:02:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org, Paul Burton <paulburton@kernel.org>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 1/2] watchdog: mtx-1: Drop au1000.h header inclusion
Date:   Wed, 11 Dec 2019 13:02:03 -0800
Message-Id: <20191211210204.31579-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211210204.31579-1-f.fainelli@gmail.com>
References: <20191211210204.31579-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including au1000.h from the machine specific header directory prevents
this driver from being built on any other platforms (MIPS included).
Since we do not use any definitions, drop it.

Reported-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/watchdog/mtx-1_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 25a92857b217..aeca22f7450e 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -41,8 +41,6 @@
 #include <linux/uaccess.h>
 #include <linux/gpio/consumer.h>
 
-#include <asm/mach-au1x00/au1000.h>
-
 #define MTX1_WDT_INTERVAL	(5 * HZ)
 
 static int ticks = 100 * HZ;
-- 
2.17.1

