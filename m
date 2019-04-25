Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629EDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3772E206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Gv8abTzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfDYUbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:31:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43947 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfDYUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:31:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id j20so1107917edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glQPnL4sW8XWVHXeXK/MLZZpZFsTphMoxIctEosK2tc=;
        b=Gv8abTzqyEqzsx5HSyGWB4F138/aW4b1L5C9HK1fBVoeUE+2hffUyiyueOH3f/Ij6v
         oxN1Ii2Dc8jG4WHXWT7sYcWH8N+JeKoTJc9PJNrP8EdKfFZJz12ZEidUfT6IcrHxEx3a
         T/QLIe6oES4SyLPMhZq6bOMjaEo5kFeB4W4Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glQPnL4sW8XWVHXeXK/MLZZpZFsTphMoxIctEosK2tc=;
        b=L/2Zd0Ol9Vm6rjQBuwjDDjWUvQKp19YoyiAvNHeyDP/t83Fp3zN5nHVsth/wih5Nd6
         7GLHCM3/srwd8FYxfhYGa4jW0DbHNJn6tpWa1JqCDqIZHsXgGzn+TPKJCjLzS6vzi9rC
         vBgMJIOClzX7fLWgjSeRFpHbP5ALTFOugk/PNwGh3XhU5cSABkB+0gtYrwfXYMjl1nRk
         UgQgWEJ5iwjuiJ9uP2xo++1IOLNFPI9zGqTjDHXNYVx2LmrKlbBnXdQ43KCYdzIh2Res
         qM6LbJF2DCoewmzPaNcYju9EKRdLxrzcpjdXsNgPHDQKs0KBDnQe60NhsblBzuRmR2De
         sNIw==
X-Gm-Message-State: APjAAAVkWTFSBAEhOKXZbSg1F0pVqijw7gYZeUL/Azas1TDL+Rct94CP
        dBS6J3g5fvxDa/LJFefm/W1dxq4FzgwXtxju
X-Google-Smtp-Source: APXvYqzxc1GBAvX4pAcNSXGdonuVZmtIHGHo3vJGI2k1wymEZrttua1TgJEXUIkS+1lT2km3amZOIw==
X-Received: by 2002:a17:906:11d2:: with SMTP id o18mr20208570eja.123.1556224265071;
        Thu, 25 Apr 2019 13:31:05 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id 10sm4159585ejn.37.2019.04.25.13.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 13:31:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by 80 bytes
Date:   Thu, 25 Apr 2019 22:31:01 +0200
Message-Id: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A typical kernel image has hundreds of static struct of_device_id
instances (a lot of which are sentinel all-zeroes), each occupying
~200 bytes. Nobody initializes the .compatible member with strings
anywhere near 128 bytes, so a lot of that memory is simply wasted.

To verify, I first had the 0day bot chew on a patch adding a dummy
extremely long .compatible string, and I did get an email saying that
the patch resulted in lots of new
"warning:initializer-string-for-array-of-chars-is-too-long"
warnings. Then I had it chew on a version of this patch reducing to 46
(because gcc unfortunately does not warn when the literal sans the
terminating nul just fits), and got a SUCCESS mail listing 107
config/arch combinations.

For an arm imx_v6_v7_defconfig kernel, .rodata becomes 70K smaller;
.init.data shrinks by another ~13K, making the whole kernel image
about 83K, or 0.3%, smaller.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/mod_devicetable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c32e4d..502629bdac2e 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -241,7 +241,7 @@ struct sdw_device_id {
 struct of_device_id {
 	char	name[32];
 	char	type[32];
-	char	compatible[128];
+	char	compatible[48];
 	const void *data;
 };
 
-- 
2.20.1

