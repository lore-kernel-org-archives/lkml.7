Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B172AC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CE22064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7vu3ze9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfG3CQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:16:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37733 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfG3CQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:16:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so28972481pfa.4;
        Mon, 29 Jul 2019 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kK+9K230k9UmhXIlNoE4R+E3TALh2YKwntB3mvsn3JY=;
        b=h7vu3ze98CHC+g3s+U26XwrmG6mLVuk3ZVcnjTUqm4hdxP+S2iqPDZ4hcFGtszHP6p
         l20iDSIBd1ekBbNGA6yPU4gmmQs43wq3MQR3ejtriYG2WvA8oEVjw0df8KFtAG1w3egJ
         JWX/Ak+6oQh8GgVHJxrRqsrBYBcw2KUpEBDeKrgbr2xF9P1uGeHHYG6cpCryZ2pHuVuB
         VZOD6mrbuECNsvnCDwCnZKQlhIZB9Ki8gC9SrWUsaKC3hkNONqVRAoIy6UlNyITmF/1f
         bDcPmjBsqauWo31xkSgE7JS0CZzs569x9Tow3SiusO/DMwA9LoytiM0r/nIdvzLj7YZ0
         bwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kK+9K230k9UmhXIlNoE4R+E3TALh2YKwntB3mvsn3JY=;
        b=H9OmZ6/rdxyIIONHM+8P3L3vnXP42unS5Gf2i74epbtyyfbGJHvRXuctLwHC3awBmM
         44NAc+9tVrGTvpVSZN1wJGgeVrdyYZ6kBmA158kZYScv/pv0j/vKDuKYY7k/dxf0Zrmd
         UfaBmdn3Lom4aKRA5fNpuqrMjudmHLERo0BJKGkE7gcgENslyKXBj/ca6mHh+kQr1d53
         YpQlCq3UZ/ptV0vt3j2grBwjfZvvTi2E+O3FqWLkZupQaq5+xs1zG7vIkQbz0yvgaXr7
         tBJS16OkNK6wJ4+hrD2CkXDL+daJz62UxUmp89gvDohtKsJD+Fh/1+DJcWBnq9APZ0jN
         OyCw==
X-Gm-Message-State: APjAAAW6UdNh95fbOiToHBdlQmg26389o8W8v5zgvRr/zo2sO4w1Y3ny
        yRg4nzZgmQKB+DDoSe3okKg=
X-Google-Smtp-Source: APXvYqxz+/5jmcYgqPhXdoZoScMFO4V4MK6a+QEyGHcmsYDX0vk1W/pN8clbTXW6W1h3kRh4SUKR3g==
X-Received: by 2002:a63:5920:: with SMTP id n32mr103128393pgb.352.1564452959435;
        Mon, 29 Jul 2019 19:15:59 -0700 (PDT)
Received: from localhost.localdomain (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id x13sm66561133pfn.6.2019.07.29.19.15.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 19:15:59 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrianov@ispras.ru,
        Mark Balantzyan <mbalant3@gmail.com>
Subject: [PATCH 3/4] watchdog device drivers:pc87413_wdt: Tidying up conversion of pc87413_wdt driver to common watchdog interface, removal of some stray nowayout parameters
Date:   Mon, 29 Jul 2019 19:15:39 -0700
Message-Id: <20190730021540.66579-3-mbalant3@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730021540.66579-1-mbalant3@gmail.com>
References: <20190730021540.66579-1-mbalant3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential for the variable swc_base_addr in the call chain of the
driver initialization function (init) to be used before initialization. This
brought up the need for, by rewriting the driver to use the common watchdog
interface, ensuring to have all resources in place. This patch addresses this
need by rewriting into common watchdog interface utilization for the driver.

Signed-off-by: Mark Balantzyan <mbalant3@gmail.com>

---
 drivers/watchdog/pc87413_wdt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index a9070a22..bc6c4e19 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -392,9 +392,3 @@ module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 		"Watchdog timeout in minutes (default="
 				__MODULE_STRING(DEFAULT_TIMEOUT) ").");
-
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout,
-		"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-
-- 
2.17.1

