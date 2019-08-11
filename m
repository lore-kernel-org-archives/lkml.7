Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6204EC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341BE2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 22:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="t0+nutC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfHKWLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 18:11:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42784 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfHKWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 18:11:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so48501789pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kegUaQhH1NdMe3t6o5OANPxzXkbHQxn9BuZ0TfmzAU=;
        b=t0+nutC8qLWyX4diz234fSW3j0q8DJ2Ojb/HLeuzs6/vjy/hNCFm1uuGD1gee/xvTY
         FO0sGQJn9LxIqqYmrx4XspDRTzNPyiug6M3xGM37LHQ6JzDiBibqGi6BHPVGg1edZqj1
         6wel7OcLXZlGKZIdQhNYXcNprjq27yOLrgFyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kegUaQhH1NdMe3t6o5OANPxzXkbHQxn9BuZ0TfmzAU=;
        b=rsYG3mU4bYvLiJ7CZ5bz5uIxQLcqkFFTGS/Pvk0Ba5+dh0B+yRMR2vlqr2wcSMQTlG
         UDZJfmEYwmF5K27WDwzJGQ1z53qVZRbb9PUsFoitpkL7wiP0WMJ28Wczhpxp5inOM65u
         3kNUJ5uxUR4wL+4PVGbCJ4cZQa+9zCkKhvXEFR+m/PpF0ZYOuY7fckOAb9BhP8+PMXpO
         9zCzOS5wqK9TTp8UZlEUpyglHW+QNNT9utjqnfGAe7AHDbVO4/kxvbGGIdsfQz9Y5F4y
         KgZrtnK4EEYko5JV1m59240zIz1uJtq39KDkF8pYiRevDvL5NjFED6ljsaGosTN1//jn
         0a6A==
X-Gm-Message-State: APjAAAUkgs0K/8JTpjmLn8M7Kvt98pRVtrJuesXzohztBTR2DWEw2ncR
        4jjqwd66wOj2uh9hJ7MjM4DXV0BDL3M=
X-Google-Smtp-Source: APXvYqzxOGU+kMZtej1bkrVYNiZUGwRmFwlMB28pTDrFdj62NfG83GLxpsdqNbhzSFv5Skcae4h3/w==
X-Received: by 2002:a65:6401:: with SMTP id a1mr27650830pgv.42.1565561493573;
        Sun, 11 Aug 2019 15:11:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n10sm31376428pgv.67.2019.08.11.15.11.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 15:11:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] driver/core: Fix build error when SRCU and lockdep disabled
Date:   Sun, 11 Aug 2019 18:11:11 -0400
Message-Id: <20190811221111.99401-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190811221111.99401-1-joel@joelfernandes.org>
References: <20190811221111.99401-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly check if lockdep lock checking is disabled at config time. If
so, then lock_is_held() is undefined so don't do any checking.

This fix is similar to the pattern used in srcu_read_lock_held().

Link: https://lore.kernel.org/lkml/201908080026.WSAFx14k%25lkp@intel.com/
Fixes: c9e4d3a2fee8 ("acpi: Use built-in RCU list checking for acpi_ioremaps list")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
This patch is based on the -rcu dev branch.

 drivers/base/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 32cf83d1c744..fe25cf690562 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -99,7 +99,11 @@ void device_links_read_unlock(int not_used)
 
 int device_links_read_lock_held(void)
 {
-	return lock_is_held(&device_links_lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	return lock_is_held(&(device_links_lock.dep_map));
+#else
+	return 1;
+#endif
 }
 #endif /* !CONFIG_SRCU */
 
-- 
2.23.0.rc1.153.gdeed80330f-goog
