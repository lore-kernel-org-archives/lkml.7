Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6736820833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ar7li2mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfEPTNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 15:13:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40194 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEPTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 15:13:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id d15so4109062ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytXoT9QXH0tp0KH5HbLhQkSNcdNnbs3zOQzOwCDi3zs=;
        b=ar7li2mZrRTWtLvb94yAyN1fLq6AQ7wHOhT6rhcq3Y6sFlqVVbSTBhtFvrDEdNJTSR
         DD6ZnSUKYcrHyCjREqAnq0Z92/xK6qLsUR2FrU9jiSIVcPNcthQdVN0XEKvMJgI8Eh4K
         cB7av9Wqq2aI7vtLyjwWkATaL3JxfGfj9KTDA5rt4n26GTYyKd7lEnfpDHkX0huaNnOf
         swceiRVXFm3UWn7Tu3RVzRW4JXnFC+DanwqabxO5r80v5lpVu7vjoMveifKq0qd2a75R
         60Lprr8wecYXUZecSBfHLuc4cmRGchfM87vLvQscAZJ+h9u0NAUyu9Wv6Uyt7OO3tF/k
         Y47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytXoT9QXH0tp0KH5HbLhQkSNcdNnbs3zOQzOwCDi3zs=;
        b=aVcSmeN7/kaPBjaqWSATdwTFP8Q0141N4b5yu3rE9ZyA4GNJzjcIxUO6v6FpH/t8M+
         ROY9Xx43FrWCBp6jkFYTlez4dNjJd+RXT+X/eghGDZnymRBz3RmzTY5fDJHTxrZJQr7k
         kBXwZPjNMkf/SQKpGIWwPLuu+kcMcJVv8Z5fP0u47fKd/HPEVTBOk99u7SsiGq+JAaEu
         57hXxEZPJMlZOwS+HewzrYWDLpn/dfjwCnuxGb4NDCqA5PMtzc9Jz7clE+78b1sCxk76
         wV7bovr26txSQm+sdzGtvKUgFgeViQKvNAVT0AGPFCNcCMVrAQJyixDqxhgHbno8hmKW
         xEuQ==
X-Gm-Message-State: APjAAAUa0LTE2KCdoIF/n1FDkikEG6n5EOkKb+j5i4MrX8E05+5mWOJg
        w/2+cI5ings2F8jbI1//TByvfgAWzq+OSw==
X-Google-Smtp-Source: APXvYqxdpr+G53xx9iV/kHu+BbZ86/ltydlarTcj0ZYl0S0nUa2zojbztohkiOM1/rGtOgyufIsfXw==
X-Received: by 2002:a2e:95c1:: with SMTP id y1mr23480187ljh.127.1558034012181;
        Thu, 16 May 2019 12:13:32 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id p5sm251560ljg.55.2019.05.16.12.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 12:13:31 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] locking/lockdep: remove print_lock_trace function
Date:   Thu, 16 May 2019 21:13:26 +0200
Message-Id: <20190516191326.27003-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns that function print_lock_trace() is unused if
CONFIG_PROVE_LOCKING isn't set.

../kernel/locking/lockdep.c:2820:13: warning: ‘print_lock_trace’ defined
   but not used [-Wunused-function]
 static void print_lock_trace(struct lock_trace *trace, unsigned int
   spaces)

Rework so we remove the function if CONFIG_PROVE_LOCKING isn't set.

Fixes: c120bce78065 ("lockdep: Simplify stack trace handling")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/locking/lockdep.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d06190fa5082..df1bd3ba56bc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2816,10 +2816,6 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
-
-static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
-{
-}
 #endif
 
 /*
-- 
2.20.1

