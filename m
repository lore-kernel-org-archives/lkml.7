Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76436C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4623D2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="E6/bkMrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfG2B7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:59:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46961 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2B7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 21:59:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id k189so8340277pgk.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg3UqXF6q2ogG0aws2NzF1jHYSyhZVe/vA7oA+neKFA=;
        b=E6/bkMrkPKDrDhcmXH2s3oDHTlyow2A+S6Eo/ZAYntqGDtmLdprQl7L6igoOiQ8HaV
         aVNLr7mjK3fi/Xh87ZwuozIOVc62pW9TZp0DpwyMJCo51ZL0sk0b8znOuZhFzmE7ksgG
         qESYqoGpHc8H7SlT1HoWzBGGnR5ilqgDvlGII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg3UqXF6q2ogG0aws2NzF1jHYSyhZVe/vA7oA+neKFA=;
        b=cBBJn+hdlKGuR7xm1j+5qa7HSaOJR4YIWo1/TJp7lB0rbBOoWiO3kpZMjJQs6/DpaS
         Qi1S2lMrjtjjBZgAisK9FeCeR9csyKt5Y6fz3s8jk7e4acOFm1eeoi8R0Yv7hoXuIIwO
         okNI8EU14mYtKYNmdrNCxLmHZAj4loAGIAhzLd6rqcf3JGw6HwCcv3MzbcgBouPn6Sjh
         rV6eLjWk0pmehUw7HfvhfQxRJ8WhDtaF1wrsMd2u/p6d0xG7YTAAZK9jKkniAvUB9aia
         frqb6z8siV91oJDm6MpJEg/w2q5P87OPOL8+xATsKkwkXWtpOiorF68Xi9BbGXgKlfMU
         RJcQ==
X-Gm-Message-State: APjAAAW+TVFMccgI+hNBqsvi8ck8EWKem9MqjLG74I9wDwi/f3XxTleP
        OYGbP+xgHPLCWVrUXbTHsV8=
X-Google-Smtp-Source: APXvYqz0yOUtkTmn9MkcOM02Oohy9zHEE8h3X0JJqqeFB1c4XJQqek5kkBolceHk7MK8oL/DMNpKsA==
X-Received: by 2002:a63:4041:: with SMTP id n62mr30789182pga.312.1564365580822;
        Sun, 28 Jul 2019 18:59:40 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id q1sm81000964pfn.178.2019.07.28.18.59.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 18:59:39 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Axtens <dja@axtens.net>, Marco Elver <elver@google.com>
Subject: [PATCH] x86: panic when a kernel stack overflow is detected
Date:   Mon, 29 Jul 2019 11:59:33 +1000
Message-Id: <20190729015933.18049-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when a kernel stack overflow is detected via VMAP_STACK,
the task is killed with die().

This isn't safe, because we don't know how that process has affected
kernel state. In particular, we don't know what locks have been taken.
For example, we can hit a case with lkdtm where a thread takes a
stack overflow in printk() after taking the logbuf_lock. In that case,
we deadlock when the kernel next does a printk.

Do not attempt to kill the process when a kernel stack overflow is
detected. The system state is unknown, the only safe thing to do is
panic(). (panic() also prints without taking locks so a useful debug
splat is printed even when logbuf_lock is held.)

Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/x86/kernel/traps.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f8447112..bfb0ec667c09 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -301,13 +301,14 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
 						unsigned long fault_address)
 {
-	printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
-		 (void *)fault_address, current->stack,
-		 (char *)current->stack + THREAD_SIZE - 1);
-	die(message, regs, 0);
+	/*
+	 * It's not safe to kill the task, as it's in kernel space and
+	 * might be holding important locks. Just panic.
+	 */
 
-	/* Be absolutely certain we don't return. */
-	panic("%s", message);
+	panic("%s - stack guard page was hit at %p (stack is %p..%p)",
+	      message, (void *)fault_address, current->stack,
+	      (char *)current->stack + THREAD_SIZE - 1);
 }
 #endif
 
-- 
2.20.1

