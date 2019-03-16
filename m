Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2280C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCC2206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+V31o50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCPDh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:37:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42366 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCPDh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:37:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id b2so7704729pgl.9;
        Fri, 15 Mar 2019 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u6CRvQfZpKD/LZe1IqtqRPm6EaOEDluBBG5Jl9SDETo=;
        b=P+V31o50nKMO34cVyeTmN0TZk2vO9X3qQl1iEdnWMGcCQySAFOnRoVmhycS8mKLMJw
         KBzCeWVN1BzSwhFYiFEm82S4MOyIxoHvQD2jXlbe/8RxViBqerzso9QocJC8oO37KKuG
         JLwynfhcMm1DqsZ8H5nvCdd5RDAOC9r06C8/W32fnXrv0yO1FVxHA73Rt0lxL9/0iSs0
         m6x9JEzSfSbOGsFWD/kpcTc/0YkiOgEIH4EzRXJ/y6wrhfai2uRoZ8YB+L/McVEjJkdA
         0EAR5qA9o03alChFzy7s2kY6+PKlqWn4PH1bpsqP/6ynW6SLH5YMFfNARPk1ZQJd1Ta3
         A6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u6CRvQfZpKD/LZe1IqtqRPm6EaOEDluBBG5Jl9SDETo=;
        b=lGwCzqwRHogUsWJBUrFQi1FKIxfvzHwyqL5HRPmalFOI+hyNsD3D9ueIXJWAzHBYjJ
         2iHwhbpaAezG4nY6Els6PhHn2WdLUd+aajTnKhJjwsjOXSF8fyZYLzUpGv8wgJ2xoW18
         WRdnA5eb6wKpnf5egvU0xXdy1OcizWGNOmdPzXwm/gseW8IWQQUme68lAGcjGD2Gt64j
         qMXeNNwtIkQaePDfluGkXBeghPKqvPWi4npzMNubZDPDNpGYUwKCtv5pyhMhnTdakeIK
         kM5ZtNpm0pGBvzJ+N1Jr3CI0gVSrs9Y0AGIK0sgnuKMgGNOcHofN7ADcszlG3dPrZQEn
         cf0A==
X-Gm-Message-State: APjAAAW0s76xKY3/XMwl2ivGOPfQFltC/Ela7wZerOoVvxlntuqyBHkB
        PdU6bxUUBMyVHDY3pbbxeKk=
X-Google-Smtp-Source: APXvYqzHq73XjJliOQDF8rIRlxlppJ6IfQKW7w4nNefeB9D0GtwUqOQ6ERL3z9mHX3ASJ2SK+Mzasg==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr7862590plp.38.1552707475804;
        Fri, 15 Mar 2019 20:37:55 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p6sm5235540pfn.63.2019.03.15.20.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 20:37:54 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / core: fix kerneldoc comment for dpm_watchdog_handler()
Date:   Fri, 15 Mar 2019 23:37:51 -0400
Message-Id: <20190316033751.31323-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index f80d298de3fa..0cff68bd7b4b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -478,7 +478,7 @@ struct dpm_watchdog {
 
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
- * @data: Watchdog object address.
+ * @t: The timer that pm watchdog depends on.
  *
  * Called when a driver has timed out suspending or resuming.
  * There's not much we can do here to recover so panic() to
-- 
2.17.0

