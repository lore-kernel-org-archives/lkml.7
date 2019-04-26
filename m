Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B4F21537
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPYnAEac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDZFd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:33:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36509 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDZFd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:33:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id w20so342196plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lhmq6sDyW4Op0uIeZ/6txUUsABhojMCaVXeWoDhUbi4=;
        b=sPYnAEac4okgmXdwG3ee/Abmtawav4ZW2lYCAGkaqLo+h0MLQFnJcB35lkT0q9M5It
         THZCWfQW9SjEH17LSLRYY2DfDD8MapWyzLYO4+rrXYTiN6tS32UFx9lFdFToGyUZ3NUz
         xMlNMECOJxc85cfM7lQ6BMiRHYqmLyajBFLwcuzrBRhdWaYHt4B0nX+g4veeaA3ivHBY
         VEIZ2H/LqF7qb7b1USypc6sw1msWvMwS5DqwX3oUl5ei/wqpq0fKDapp3SSSd0Sm8UtW
         tUE6gk6QUtSeJICnBUNJ4CeVQQZlHWRsHf1Uct3zCDKe0E80z4dlqzCbWNNXsR8CbBiU
         YfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lhmq6sDyW4Op0uIeZ/6txUUsABhojMCaVXeWoDhUbi4=;
        b=oHR0xjLZOZ8tJBd0kcb3SPKUIqBbmHZ55whBPD2eb+uBT2WqoFiNwV1PrNcTvAf5Wh
         fS3czWkQdTHVTUN1at8oGhvJI0wTwMeAduGrZJg3Y57+TsQLlhde5/9ruMGK8CeZzDwR
         4j8BQczXvWRMDnYyKXqkrkFu4zmRH6T4SoIxX9FQPJZDu710QiwQJhLcClfV0HBB9lxz
         aL5THzeAcdoHrjrVEQf3NSE7rFtRs3XWlLKZTE8wS+0+AyaBLYC48105+XLK35W7FRMg
         RD4XQWtTGpq0//jLlpCJ2PUUqO4mFr4ZeZIaSkshYEDaQC/o70LojuddtBcLjQUyfTeL
         eqAg==
X-Gm-Message-State: APjAAAWO0zZkS5nyqQmlxBuEmIfeRVYhr9xIeMZR7BI5Ybt0zxQahLMh
        381qidotz0nK9p14pIl0myM=
X-Google-Smtp-Source: APXvYqwetBBCUiROvxjmneN7n59EIUyT3lFZhxD3NLMwMCX74TNSKK55n1bBuP8pghihP9XCAEdNTA==
X-Received: by 2002:a17:902:e285:: with SMTP id cf5mr7169990plb.77.1556256807812;
        Thu, 25 Apr 2019 22:33:27 -0700 (PDT)
Received: from localhost.localdomain ([110.70.55.171])
        by smtp.gmail.com with ESMTPSA id j5sm5256532pfg.186.2019.04.25.22.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 22:33:27 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv2 4/4] printk: make sure we always print console disabled message
Date:   Fri, 26 Apr 2019 14:33:02 +0900
Message-Id: <20190426053302.4332-5-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that we print 'console disabled' messages on all
the consoles, including the one we are about to unregister.
Otherwise, unregistered console will not have that message,
because pr_info() under console_sem doesn't print anything.

We do the same thing in __register_console() with the
'console enabled' message.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3b36e26d4a51..20c702b963a9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2613,6 +2613,12 @@ static int __unregister_console(struct console *console)
 	pr_info("%sconsole [%s%d] disabled\n",
 		(console->flags & CON_BOOT) ? "boot" : "",
 		console->name, console->index);
+	/*
+	 * Print 'console disabled' on all the consoles, including the
+	 * one we are about to unregister.
+	 */
+	console_unlock();
+	console_lock();
 
 	res = _braille_unregister_console(console);
 	if (res)
-- 
2.21.0

