Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCED2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqe9YIte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfCZLe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:34:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfCZLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:34:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1823376pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 04:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W5keWG+8K9pttGbYqwXZCypQPjjw0jSk0AFl/SzzcYw=;
        b=Sqe9YItea5PtBB7UuyLeBfak/0y7o3/RT4Lzj7sZHxBPzzbzEMgm9/hELBw0Hjjn2V
         lWLqiJ9IcWeIbz9zlkhh2g1e3xF+TfN159YB5tD1nAWNIah1sEs7GLW9y595VFr4esTJ
         G2H7HTuV3Wi273ioj7Tc51ZMmjLulW2qk14Lp0OEqNs8xH0uQrT9iJwgXyOI8TxgNROb
         iGPYRyBevPXITgm/c232LLeReSEhS2WvEJdL3ij02U4B6lu1zGVcl4wDxcrSM7p19J85
         YJSNc63p5fx5IqlMTlJ8ZYklR5y64fBbz1OET6lg5gBYcW69D8KTPxiL2oFqANmxLmEF
         HZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W5keWG+8K9pttGbYqwXZCypQPjjw0jSk0AFl/SzzcYw=;
        b=TF0bmx+oEasHLWgkr0jXcwLvgY9xlJP8bUpawZk3WtUsmXBxOJr+sjjWDK7xAINDKr
         6AR3P7WEW3JIdsbwH6uRlTGsdPu2o5vfzbKo7OZIrm7M6iCbBf6NnbblSsiSZO0GPVj6
         zf6QU6SN3g/xskl3gvx5qdHhZMCgEebTJDVjLmQPxkqH5z5C9Vhl+UEPFIqWjH+/Y8E2
         qFAuWJoZAH7HKn8Jo//JH2y3kxMH5cCNJ5BkdFBIxOVfIq+Cw8h3lUdiATdVyAUeiF1+
         dUrKxniy95ejbGOSVg90DjQlVj0oO2Wg+L0nmCovVg29cIrhuRB3QZ1uXG9ksSzdprrp
         R1dQ==
X-Gm-Message-State: APjAAAXX/hU5bODb5LLt7SOYImshM9JyMZcEaKi3h+RbjfGcmMjkWkT3
        fqgyB1pa+fogOJ3ZC+7PEVw=
X-Google-Smtp-Source: APXvYqweiTwgX9ZgW1WC/LW8XRsOajO51AoliMqLI4a65EF6ilmmTyB6WTEmEoHpUNnqUSSdAC7ixg==
X-Received: by 2002:a62:7049:: with SMTP id l70mr29352963pfc.78.1553600095800;
        Tue, 26 Mar 2019 04:34:55 -0700 (PDT)
Received: from VM_67_44_centos.localdomain ([150.109.46.178])
        by smtp.gmail.com with ESMTPSA id v18sm23139858pfm.165.2019.03.26.04.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 04:34:55 -0700 (PDT)
From:   Yongkai Wu <nic.wuyk@gmail.com>
X-Google-Original-From: Yongkai Wu <nic_w@163.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        nic_w@163.com
Subject: [PATCH] clocksource: Make clocksource insert entry more efficient
Date:   Tue, 26 Mar 2019 19:34:19 +0800
Message-Id: <1553600059-13193-1-git-send-email-nic_w@163.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clocksource_enqueue(), it is unnecessary to do
entry = &tmp->list
in every loop,do it once in the last loop is enough.

Signed-off-by: Yongkai Wu <nic_w@163.com>
---
 kernel/time/clocksource.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19c..da4829b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -829,11 +829,12 @@ static void clocksource_enqueue(struct clocksource *cs)
 
 	list_for_each_entry(tmp, &clocksource_list, list) {
 		/* Keep track of the place, where to insert */
-		if (tmp->rating < cs->rating)
+		if (tmp->rating < cs->rating) {
+			entry = &tmp->list;
 			break;
-		entry = &tmp->list;
+		}
 	}
-	list_add(&cs->list, entry);
+	list_add_tail(&cs->list, entry);
 }
 
 /**
-- 
1.8.3.1

