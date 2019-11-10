Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378D120842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 17:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVmU9oeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKJR43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 12:56:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35909 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfKJR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 12:56:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so7748245pgh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 09:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PtqYt1fGL7WFdKH+RvL3PePfXJx2mou2pQEcrG9jbZU=;
        b=eVmU9oeMjmQDjIG/u141aHB4siTpgnOngq2Vm7FyIX5/WuPm6g8wB7QIkf6tc8DFZe
         TaZN211+gXNsTlie89ha1k3T7BEvzB5lOtuOoyDyISrPE/wyOPU3vKxPZoq7QVVTcsQG
         bbvVZtDkfVGV5GI76doDZTkUyYZoXgkIzs6R/+nHgc1LxIuKuHHwnG+lnuNyQPV1YtqU
         fmt4wtEWVthRJYtyvnbxaGzBPTMl4QDwd7L0JuqVHKuN4zavs3K0ZmTUaXPMn8hV/rHB
         TFnWY5PtwWQZRD9ulOPkIKIOzylqEoDf7q+YDkbfHt3PZTU2oHZq5tIqu8oPiMnHePcy
         7F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PtqYt1fGL7WFdKH+RvL3PePfXJx2mou2pQEcrG9jbZU=;
        b=jXBGCaKUBfDz/S2RrUTQR+LPocNX8CtML70RjwbiHvFtBP9ZqQqf7xrD0UtS8GT7wI
         tjb47qsX9J9Jwn7mmXYr4XUz6pzFcPjh6Nd0h2k637R/Nbl2yPjVF7WOz07ScJxZjlI6
         xdokt9VI1ACrBqdBIyiSaef2Emy/xrgMUvAzaiwDT8VYCGIModsyV1DO4CdIBTr7yST6
         mvLbBvLuD7U4ssCRFJZ7pnY3yMLGX4DaRTo+A81tyWQC53+SkPZtAqAmy7o9Q+DaNNIk
         aY+CDMVUKWb+MmgNwqLtLmHcr7erADzY192Tr+wpMAdV0LIYj5VL/eoUW2/hMSFowUdh
         oAmw==
X-Gm-Message-State: APjAAAXjCUuO5q0imM8DtuGGHaeu+njqyg187SNgdStppnd7bnVeBSdh
        M6Dy/Er5FKhV8+vX09/A9uvRi0FV
X-Google-Smtp-Source: APXvYqxcsOvCIMeB2vwv7Hk4q37bewW4KNu4hwZ+1YEdJWYKPnUYyheC3m5dhgqu8IxOz6admeV8xw==
X-Received: by 2002:a63:5b1d:: with SMTP id p29mr24023814pgb.209.1573408588139;
        Sun, 10 Nov 2019 09:56:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z14sm15104414pfq.66.2019.11.10.09.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Nov 2019 09:56:27 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] staging/octeon: Fix test build on MIPS
Date:   Sun, 10 Nov 2019 09:56:20 -0800
Message-Id: <20191110175620.20290-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mips:allmodconfig fails to build.

drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_poll':
drivers/staging/octeon/ethernet-defines.h:30:38: error:
	'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared

Octeon defines are only available if CONFIG_CPU_CAVIUM_OCTEON
is enabled. Since the driver uses those defines, we have to use
the dummy defines if this flag is not enabled.

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 171a9bae68c7 ("staging/octeon: Allow test build on !MIPS")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/octeon/octeon-ethernet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/octeon/octeon-ethernet.h
index a8a864b40913..70848c6c86ec 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -14,7 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
 
-#ifdef CONFIG_MIPS
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
 
 #include <asm/octeon/octeon.h>
 
-- 
2.17.1

