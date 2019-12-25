Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED12AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E9720730
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 06:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="IKWFxoZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLYG0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 01:26:35 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37620 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYG0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:26:34 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so2063503pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 22:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0hfOFdpppNhfx4JZoVAcogfBULm51LLYT9TT+3UyFc=;
        b=IKWFxoZD+dOqu5/O4YmTKkIIcrMFegYbTrWZ85TsffnrcT/oRZFoVeTz6dCtGwHKEu
         IZfGZqNQ/gknjhEOqkrUZl4AFtfr/tNxAz6fj9/5FevohzI1+nYfAEZ7BZKkhZKpc+ih
         3/mF/x6nL5CDLuUK4kC7mBGUmG/mXZwzp/HayKiqR4Rt2BZ7MG/zg8fFSjOdVGTLnMEQ
         IHdTRg3P6vcf3foc64LZdXCbkafpoABxqZDoJKBy0dpDbTbsArGWwzqYfA8iJ1JUAFlO
         vCrcPl9zZvoF/hbc5WwnzcnnbZ+dXTTbyjFRViyvSSUNkd+eFtiLuOHJKalzgaRcwdsl
         ZKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0hfOFdpppNhfx4JZoVAcogfBULm51LLYT9TT+3UyFc=;
        b=lguVsBvwiMTD+D0I6cetJTtP7jqg86v2OpOB5RztB9zAr3RlwT0JEde9VE7StM824T
         fPpR60agdAd54zOid9xdFcxB6nTHXblit1CSsgeVG6JoOhnxkK9HEsvbD23fU58dW0Ap
         RWLBDZzjsLoKioQpk/FXFYTA6HWIMwMJwd12pfGcdwUs9u2eFCLgcQcinl8mwJPZcB7n
         iu04KWvXSJvmBfgFNsMrqrnWjX+qPaR/ksYqOl4kb6+WizMKxfmiCPYdjGUVG2/YLMWf
         mCnRbXlMuGMynu7a3bvhUnaGWY0i/EAhZfaR/1V44V+WOcoYLGM2bczLA3ddn9P3rvB3
         lbaw==
X-Gm-Message-State: APjAAAW6DwbS0NKDFmMI1K+cplpsTxbQlukWOpq9YdV9mSQcQXNsq9cj
        b076ixWMgFQunVRwr+rkq/tS9g==
X-Google-Smtp-Source: APXvYqwzqavlyiYyx9EoEqGXqZFwYwG+aF++DGYxCfQAyvIIJbxQwOTzLpWXewtHml5Ho+ETNluQsA==
X-Received: by 2002:a17:90a:a88f:: with SMTP id h15mr11396906pjq.32.1577255193466;
        Tue, 24 Dec 2019 22:26:33 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id j7sm30875474pgn.0.2019.12.24.22.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 22:26:33 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, pizhenwei@bytedance.com
Subject: [PATCH v2 2/2] misc: pvpanic: add crash loaded event
Date:   Wed, 25 Dec 2019 14:26:22 +0800
Message-Id: <20191225062622.60453-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191225062622.60453-1-pizhenwei@bytedance.com>
References: <20191225062622.60453-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users prefer kdump tools to generate guest kernel dumpfile,
at the same time, need a out-of-band kernel panic event.

Currently if booting guest kernel with 'crash_kexec_post_notifiers',
QEMU will receive PVPANIC_PANICKED event and stop VM. If booting
guest kernel without 'crash_kexec_post_notifiers', guest will not
call notifier chain.

Add PVPANIC_CRASH_LOADED bit for pvpanic event, it means that guest
kernel actually hit a kernel panic, but the guest kernel wants to
handle by itself.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c      | 9 ++++++++-
 include/uapi/misc/pvpanic.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 3f0de3be0a19..a6e1a8983e1f 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -33,7 +34,13 @@ static int
 pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
 		     void *unused)
 {
-	pvpanic_send_event(PVPANIC_PANICKED);
+	unsigned int event = PVPANIC_PANICKED;
+
+	if (kexec_crash_loaded())
+		event = PVPANIC_CRASH_LOADED;
+
+	pvpanic_send_event(event);
+
 	return NOTIFY_DONE;
 }
 
diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
index cae69a822b25..54b7485390d3 100644
--- a/include/uapi/misc/pvpanic.h
+++ b/include/uapi/misc/pvpanic.h
@@ -4,5 +4,6 @@
 #define __PVPANIC_H__
 
 #define PVPANIC_PANICKED	(1 << 0)
+#define PVPANIC_CRASH_LOADED	(1 << 1)
 
 #endif /* __PVPANIC_H__ */
-- 
2.11.0

