Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F374C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C612465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7ru/9dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:01:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41984 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRXBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:01:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so2051396pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=NEpfgOKYvxq3wOmBxYjpKpGazLvSdoYv1dP6PtRXd7k=;
        b=e7ru/9dQnqvP3pSCHG45xsVPmUQYvkLHucLJ8N6IqbIiYdnUmlBnWzd+UXrqChuYJB
         z3XZuFr1+C2cI+3YwVYh+pSNy6QF99n7wCkVp+p9phodQ99Hh56WbM+gp3rLD09WDVZ/
         Y0v017XJsMnQNsB18M2DwjPF4pIrwbT/n+ijU8K59UbjKfu1CzCaILlnQmTghfQ2wmJz
         4r9Erzhq8B75AURlzqT83AJhTAyQ+W31vn6hTxtZvbl06twU1dF/3C2fPwTtWg8rlse+
         FoL3gwoN/T/Se/SLdCvaSSYqxl1CZNX7J4XeNrQtUQgT3eZJGFVcff/lbgWyS5/5izQ5
         TOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=NEpfgOKYvxq3wOmBxYjpKpGazLvSdoYv1dP6PtRXd7k=;
        b=DySQllaKPo74SSac911DHOqy3qAgq2GXT3xCP/YEOBJcRm647LmBdnQT9GPf4h1+hW
         k4FngPJ3909oSTsKUvIPCq9j16ix5+SUOljzGLOmnTT+rSOF4lYxkGnge+wFC6OVVel1
         7BSApI43w4GykulhMy0ywAGzvrv3GSR0qhENP90AgXHUjJG0bB3XTIqgt4M9upc6KZkd
         U5YUxKBts8o2BHrSuAP9W4+2uoRIH1Pnuqt3qW8xVImRegTefOSpF6DPHQhX0sQY3YR9
         tj2833hJ4s/IJOEyAVbYF5v+25o5KfnD4wzSoa1WwiKnettCCMj292cfe6o5uQ/C8ybe
         18Mw==
X-Gm-Message-State: APjAAAWRMT3O3ZARheGg8ziV0c8hvxEgM1xXxXy40gyyEUhRqWwgi9jm
        KQdVfTtVgAeFAemH3Dxxiwi2jui9
X-Google-Smtp-Source: APXvYqz00c9UfuoymuIver1t9PgP1dmv0RzTAcFFrtlfBMaxHO+jN2E8Q1KfC56pxub0rlmxQEldxA==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr5811175pfq.138.1576710112842;
        Wed, 18 Dec 2019 15:01:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l9sm4382560pgh.34.2019.12.18.15.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 15:01:51 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] init: Fix crash observed if there is no initial console
Date:   Wed, 18 Dec 2019 15:01:49 -0800
Message-Id: <20191218230149.23299-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems with no initial console crash in f_dupfd(). This happens because
console_on_rootfs() was changed to call filp_open(). Its return value
(a file pointer) is checked against NULL, but returns an ERR_PTR after
errors. This ERR_PTR is then passed as file parameter to f_dupfd(),
which experiences a severe case of indigestion.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 8243186f0cc7 ("fs: remove ksys_dup()"),
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index ec3a1463ac69..1ecfd43ed464 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1163,7 +1163,7 @@ void console_on_rootfs(void)
 
 	/* Open /dev/console in kernelspace, this should never fail */
 	file = filp_open("/dev/console", O_RDWR, 0);
-	if (!file)
+	if (IS_ERR(file))
 		goto err_out;
 
 	/* create stdin/stdout/stderr, this should never fail */
-- 
2.17.1

