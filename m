Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97462C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B4420872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="S4ASl6WF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCRCy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:54:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36300 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfCRCy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:54:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id r124so10359016pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uxWlvWRp142ZO+FTsvYeQNdtkGjJnnW9XeB4oJyrR7o=;
        b=S4ASl6WF1UAP+fPmavbstvMdQfcHspGxwcTlV/UMsH80rBqxcWII7932i1JGfLQjH4
         yxrm+TVMTjeFXmxzRh6CQD8Q2QNtRfRumHjqU2kk4HfkNCMqj+xIgF1mcpYC7Eju1gIq
         SVG7Ni+KYaMa6eOi8ZP/9MK5w6SzwjOUrzOc951EAGzPpgT48XzfU/KZzW7JHbeU0bKq
         iopKYrHu6vp4oqN7BqSH5qBdAlANNrn4LKmwSA7f1keDiG0lEc9W60Oz6a1FriUKjjYc
         DLXqaW0rR0gQN8eK3DOQN0xuh9+HabQZ5K6xrgG17fXDd8YDvu7X71umvU3DZl/LPENU
         2Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uxWlvWRp142ZO+FTsvYeQNdtkGjJnnW9XeB4oJyrR7o=;
        b=IWD8fO5wpLGyC7NCwcU91E7PGdO7tKH5Q526yAhnTHP9wXzPdt5XES/zqtc5zHOvP8
         sgXp1dAO7iB4KxZ77vy+siTcX1acopBsu4nwnmcUtOfxVZ1j0rbSuLIBYIsuG/b7ka3/
         jmVDV6B4R5yt7Q63nsUXAf4awX4XcTv8V30o0d5cXTIy6CT2r08PXJAUe51/7fiP/xqi
         /vLnoPOl6W47GuhOWL0r9Pg9TpeQGWeawq9Ywb4KUP/dgpsmmi+UTGZNGgYRMOxQigv6
         YZHPzHlxfchuUfpo5SB53rCGvvj+Y4+ZeH1cBoqowQxBMs4Ih0HogAgwXdSMCUmgqOvK
         HKSQ==
X-Gm-Message-State: APjAAAWbkfwD5MNWsAX2Ezqi4a66rhANnj+MoP5AFZssiL0lA+8xKL3g
        WDqtIlsp3VbP9Y0HsPYpax7Oaw==
X-Google-Smtp-Source: APXvYqz55JkEnzzHCzVK5JIsmwVxAXDv2hcAnNpvxPoKO/etKT+pEMZuBoG3qXRJiZh09+Hhavw0/g==
X-Received: by 2002:a17:902:e784:: with SMTP id cp4mr17438684plb.135.1552877695882;
        Sun, 17 Mar 2019 19:54:55 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i126sm13672955pfc.101.2019.03.17.19.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 19:54:55 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        Tri Vo <trong@android.com>
Subject: [PATCH v4 3/3] gcov: docs: add a note on GCC vs Clang differences
Date:   Sun, 17 Mar 2019 19:54:11 -0700
Message-Id: <20190318025411.98014-4-trong@android.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190318025411.98014-1-trong@android.com>
References: <20190318025411.98014-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document some things of note to gcov users:
1. GCC gcov and Clang llvm-cov tools are not compatible.
2. The use of GCC vs Clang is transparent at build-time.

Also adjust the documentation to account for the removal of config
symbol CONFIG_GCOV_FORMAT_AUTODETECT by commit 6a61b70b43c9
("gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT").

Signed-off-by: Tri Vo <trong@android.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 Documentation/dev-tools/gcov.rst | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
index 69a7d90c320a..46aae52a41d0 100644
--- a/Documentation/dev-tools/gcov.rst
+++ b/Documentation/dev-tools/gcov.rst
@@ -34,10 +34,6 @@ Configure the kernel with::
         CONFIG_DEBUG_FS=y
         CONFIG_GCOV_KERNEL=y
 
-select the gcc's gcov format, default is autodetect based on gcc version::
-
-        CONFIG_GCOV_FORMAT_AUTODETECT=y
-
 and to get coverage data for the entire kernel::
 
         CONFIG_GCOV_PROFILE_ALL=y
@@ -169,6 +165,20 @@ b) gcov is run on the BUILD machine
       [user@build] gcov -o /tmp/coverage/tmp/out/init main.c
 
 
+Note on compilers
+-----------------
+
+GCC and LLVM gcov tools are not necessarily compatible. Use gcov_ to work with
+GCC-generated .gcno and .gcda files, and use llvm-cov_ for Clang.
+
+.. _gcov: http://gcc.gnu.org/onlinedocs/gcc/Gcov.html
+.. _llvm-cov: https://llvm.org/docs/CommandGuide/llvm-cov.html
+
+Build differences between GCC and Clang gcov are handled by Kconfig. It
+automatically selects the appropriate gcov format depending on the detected
+toolchain.
+
+
 Troubleshooting
 ---------------
 
-- 
2.21.0.225.g810b269d1ac-goog

