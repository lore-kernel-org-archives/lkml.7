Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D8BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB0727403
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQvIjLr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFCSZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:25:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37589 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:25:38 -0400
Received: by mail-it1-f193.google.com with SMTP id s16so28182199ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fcglEOvOUqs4y0358IN0qMWFLPY/6sl/Md2xEDoCqa4=;
        b=CQvIjLr8T9/jg1IjqK0hZQeQAAsbULRZUUf55FykUKXZa+hg9hfcqHIXTAQQ9Fo4GO
         RMZ2tSf+qI8W7uWoCtKnftpy33TZ6Das9A6LHHdXO+qGlRIlOoCkIcqp804N8ZcQBPcH
         3Q5Z2B6OM/XjJIsJIhE6eO5hYlJ6QMnJ2pVnRB3K2hDrnP5CnzyCl6Fvsn0NU+H0dG6N
         Ka376uJQ00FbOBAbFgp+BkZnRHf7BWcc5PDMbr8arRxX0UpRYL5O8nLdOkS6SZUlNqLx
         45rhx2P/Tz3kDykys+eaNzWQhti9GoL37DaBA3O7B/9lJMPc7VfhsccOS3a+F34gukcD
         rRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fcglEOvOUqs4y0358IN0qMWFLPY/6sl/Md2xEDoCqa4=;
        b=AN+mvGKNNNkhgdvFu664I45rox68NP21SJMguTyo+WjWpH5Qn9Lhynn1vP5RHlHxcS
         gtm+Yr+OZWtaLxnCjNhu3Kkfqh61f7D2JMy4kW5VgXTG+xv/tvnxXhayznIFspX4ZizP
         rC31izZjQ7rFipJxrUIM58H3l8HbcSbl5m7fnptfInUfQNica7sPGdPTFJ9j88f98yvd
         IpS7ph1z7p+lIWApeHfZzMcnBqhAXu5K3pqFPizVTCCFhr3pjax63rh2LNwSLpvR3Nt2
         zFkfYPV+wX3SPr/YqUwCXBHuQRwsMe54m82YTk2cGl9R0AAIZdHwKRe2K6MJMUlF2D+N
         kxwA==
X-Gm-Message-State: APjAAAWDhObZkvFM8CHJolNCrR2RtYL4c4g2EFPL8Gk5gXj5vFsEjTDH
        RiISXFwT34QipDb+tuhu738jD6uFwu1ic+dn
X-Google-Smtp-Source: APXvYqzxFW218WT6cUSi00y3LSVxut302sZ/E0rICR+OUO2T4hbwBdDwKcYqRN/HG3qWgYgmYnJIQw==
X-Received: by 2002:a02:3c07:: with SMTP id m7mr19017068jaa.64.1559586337185;
        Mon, 03 Jun 2019 11:25:37 -0700 (PDT)
Received: from instance-1.us-central1-a.c.lasterhub-me.internal (174.52.202.35.bc.googleusercontent.com. [35.202.52.174])
        by smtp.gmail.com with ESMTPSA id u133sm5065420itf.13.2019.06.03.11.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:25:36 -0700 (PDT)
From:   "Laster K. (lazerl0rd)" <officiallazerl0rd@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Laster K. (lazerl0rd)" <officiallazerl0rd@gmail.com>
Subject: [PATCH] ACPICA: Fix compilation with bare-metal toolchian
Date:   Mon,  3 Jun 2019 18:25:28 +0000
Message-Id: <20190603182528.12039-1-officiallazerl0rd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ifdef expects to be compiled with full-fledged Linux toolchain,
but it's common to compile kernel with just bare-metal toolchain
which doesn't define __linux__. So, also add __KERNEL__ check.

Signed-off-by: Laster K. (lazerl0rd) <officiallazerl0rd@gmail.com>
---
 include/acpi/platform/acenv.h   | 2 +-
 include/acpi/platform/acenvex.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 35ab3f87cc29..b69319198cb8 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -148,7 +148,7 @@
 
 #endif
 
-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
 #include <acpi/platform/aclinux.h>
 
 #elif defined(_APPLE) || defined(__APPLE__)
diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 2e36c8344897..c7697a47e33f 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -19,7 +19,7 @@
  *
  *****************************************************************************/
 
-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__KERNEL__) || defined(__linux__)
 #include <acpi/platform/aclinuxex.h>
 
 #elif defined(__DragonFly__)
-- 
2.17.1

