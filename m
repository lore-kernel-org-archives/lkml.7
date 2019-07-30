Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFB9C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B116320693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyvBSq7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfG3CQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:16:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39556 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfG3CQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:16:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so24984019pfn.6;
        Mon, 29 Jul 2019 19:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FzaH7PVhh1ba0vgranyXQGmQCp6gwkLqstIglv23EsQ=;
        b=LyvBSq7Lw08tXQ633RjUqWZpZn43VQW8t+28eD9ymlKdYMU1xpv9DXKYvHhHZXvEwI
         rxCMCp8aJCZBKhNHg1e0MvPgSxV574CcOl0jpNPjeN8TOeeacpIbJzdZkt5TMU0UWL34
         k50ZjFj1jHUtn7lp3ww5c5jIj1KN9oEATWqr+AtuI7Y47AwUhihOMZ/Srs63HDwhgK2G
         xuZz47MLrSVuse0C3dhTNlCOjI3v06nvrEMr73mhiQDtimhsO8T7OGcLXk/LyviJI4UW
         Cy7qo8az3HqWjxcGAOqB8b1tSp0HOTe/m7IGwsRRa4PDmXgo2eLRsPDSaQYXvLF1YwZ5
         cjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FzaH7PVhh1ba0vgranyXQGmQCp6gwkLqstIglv23EsQ=;
        b=bWAMIo0u071Cv9poiQdTwfjSrFsKD59snYMWW19EEznrwSHIO3lpwHFj1m8DeR6pz9
         LQlxnHakDNnG5LI4UBgdYHcnNr1hzS6q3tEctErf+MFywy7Srj9cQdUemjv6bzzvl8pQ
         MrcNJ6R/qWk8iiK3q8K2o0wU1uTjUCe1cPb7XxGXBOaUpPytI7u96mLyW/+qM5/gAAsZ
         xcS9cyUUx5AHLKq/9eJgfXMo6OJWrK1MUgkUIsLbhv+1bsIqCt2n+ZDGHzrJc5Acs+UH
         QsZHQV/a7k97eXewFBtY5H4hdawrUQc6efbvPEofVtnMjUFXq7wmYzTqeb2AXYx2/s+x
         4Dww==
X-Gm-Message-State: APjAAAWWSwAZzRUq4RB14xyZHx34tb2GWLGlmY8TRZrqOaE++psZWDKw
        n6hL8Gfi1BpA1+XsnwjgA/g=
X-Google-Smtp-Source: APXvYqyzqZjq9jxdFiLhWHSSW5Eg5iWQpzGeoNGFJopdLmyoTZfK/duGMg9X4ELFvax+xWwR0HFxWQ==
X-Received: by 2002:a17:90a:29c5:: with SMTP id h63mr110083713pjd.83.1564452961866;
        Mon, 29 Jul 2019 19:16:01 -0700 (PDT)
Received: from localhost.localdomain (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id x13sm66561133pfn.6.2019.07.29.19.16.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 19:16:01 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrianov@ispras.ru,
        Mark Balantzyan <mbalant3@gmail.com>
Subject: [PATCH 4/4] watchdog device drivers:pc87413_wdt: Continuing revision of conversion of pc87413_wdt to use common watchdog interface, removed undeclared identifiers
Date:   Mon, 29 Jul 2019 19:15:40 -0700
Message-Id: <20190730021540.66579-4-mbalant3@gmail.com>
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
 drivers/watchdog/pc87413_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index bc6c4e19..6863145a 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -370,7 +370,6 @@ reboot_unreg:
 static void __exit pc87413_exit(void)
 {
 	watchdog_unregister_device(&pc87413wdt_wdd);
-	unregister_reboot_notifier(&pc87413_notifier);
 	release_region(swc_base_addr, 0x20);
 
 	pr_info("watchdog component driver removed\n");
-- 
2.17.1

