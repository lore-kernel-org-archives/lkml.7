Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D4EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF1F21883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BoDvk+mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfH0QoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:44:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36597 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfH0QoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:44:18 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so47823896iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zN9rQTT26l9zAK3NchO2FMSVvMPQG95vDmCrQfg85Y=;
        b=BoDvk+mpCBPBdM5/8HNZtsZKICxZ8+kgAaMMC14OhLRuliNSLp0rigwTM0e3y5CCfG
         5adEmJz3HqsZsf30CD3Dqi71shA/AXMLbMTn5HhmU3uRAXsy17rZCS7wObfr82pxYJ2p
         KS7XhEiw1u8+tNhC3Z66BJjs+g4FM6uh9ZiM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zN9rQTT26l9zAK3NchO2FMSVvMPQG95vDmCrQfg85Y=;
        b=j8Zm1Q2bRqTVRRpJ2qq3731H/Ow1ojRWKp/SU5zzvXoA3/3AbuQEctlj/sQv8ytxY5
         fKJYD3ezvINTGJ2o3+z8c+91mkBJV2BIR0z3eLnmR4R8baO+dDXhKRNyKw+SxZp9cmLv
         K1B2B3/EuDU2p5XR5T189BaMIn2vFt1N4GIqKmNsRveGlFRNVmKafb8iLz7UTUcgY7ue
         116upsPyajjnzJdsJ4jwfrHAWJT6rTzodKGOMuA/BW6KCKTocdvbN/gO4knasadg3wi7
         Nn1PFGMiYJDsGG8IDCxOGaSF9HcHmbdWhjLYL1SksEIPa2jXfkjEEKz4/VDAebJmt2Vg
         USpg==
X-Gm-Message-State: APjAAAXYUa/iDEYYmG8Ah+gnU2Xy7euyNFYW+eJVVr1AOUq9vqA0aaOE
        OxblYbbNmlwO64gJHWpH6X8WQw==
X-Google-Smtp-Source: APXvYqyWLe5uVzPTlWq6B0m97PM88WV6eUmw7fuLY7t8WP6UPDZAQh/nsmusX5QnbuqdqcO+mT9FdQ==
X-Received: by 2002:a5d:8a10:: with SMTP id w16mr3915448iod.175.1566924258018;
        Tue, 27 Aug 2019 09:44:18 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id i10sm9871840ioq.51.2019.08.27.09.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:44:17 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     keescook@chromium.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm/bugs: fix build error in lkdtm_EXHAUST_STACK
Date:   Tue, 27 Aug 2019 10:44:13 -0600
Message-Id: <20190827164414.122478-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building an x86 64 bit kernel:

lkdtm/bugs.c:94:2: error: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Werror=format=]
  pr_info("Calling function with %d frame size to depth %d ...\n",
  ^

Fixes: 24cccab42c419 ("lkdtm/bugs: Adjust recursion test to avoid elision")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 1606658b9b7e..bf945704f21a 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -91,7 +91,7 @@ void lkdtm_LOOP(void)
 
 void lkdtm_EXHAUST_STACK(void)
 {
-	pr_info("Calling function with %d frame size to depth %d ...\n",
+	pr_info("Calling function with %lu frame size to depth %d ...\n",
 		REC_STACK_SIZE, recur_count);
 	recursive_loop(recur_count);
 	pr_info("FAIL: survived without exhausting stack?!\n");
-- 
2.23.0.187.g17f5b7556c-goog

