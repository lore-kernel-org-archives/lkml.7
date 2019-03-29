Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65410C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF0218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWEPphIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfC2WIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:08:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34345 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfC2WIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:08:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so1650183plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7a92O0IL4yxS6jfXWReaSz0adfdvNKb8+QWSFPrpew=;
        b=hWEPphIOrY6VqueDwhBpyie6hlHzff7u3fPEQnD4/pA02foSyT5OR6jYSF9SUT4+p8
         OmquzxdT6dwV5+l7tEerCYPnppf7rtOTxHi9g5BCRQns84Azxv1ApXR/2CGpHNuIae59
         FthXtgZ5MBSunbvgrFz/Dr4FmPdz5wA+MYFe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7a92O0IL4yxS6jfXWReaSz0adfdvNKb8+QWSFPrpew=;
        b=Iy17bI8y4X/jHBZspTC6M8cIFWqpQUSvj+k6wtxuREf8GsA0jTQvFF1iA9w+Q8MFCI
         /sXXm/jXOxfWkHofrIHDSQzrzvtJgotvAB8fWZQAmWI6xgmUhBPWPhRJp7r8W5ruroOR
         8NCbtYQumlkCHaH1pFA9aW6wQYvBj9qOo/r59d0fp50XlYumqaJw829V4YVY4pecHRQI
         nAfkoYAEsiSORt4rTNPkrYnbW1vEPw9OhB23Qi5mfknErRPYsbNAxXI66FeEaY0DD+QD
         8sqlObZxNkNh37P+9N/Et7cdnuTTECnmyD0IQow5lNwYtmhtey0jdpMtgwSvNjPUpShu
         RDRQ==
X-Gm-Message-State: APjAAAWWV4sIARm8YCbxGINoJRsWfKvUGnaSB05ToecyGMVg5QZnd5ec
        /qfhyHW9wTPJLMvK8RadNl1fyg==
X-Google-Smtp-Source: APXvYqyGWJYuaMh1z7n19OResYvE6vrM66SSxq4Re3ek/+WsmPpGGD1/tGickBg/YeKmap5vw5V+Gw==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr28245171plr.341.1553897327102;
        Fri, 29 Mar 2019 15:08:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b7sm8925514pfj.67.2019.03.29.15.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:08:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v2 1/5] scripts/gdb: Find vmlinux where it was before
Date:   Fri, 29 Mar 2019 15:08:40 -0700
Message-Id: <20190329220844.38234-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190329220844.38234-1-swboyd@chromium.org>
References: <20190329220844.38234-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I run 'gdb <path/to/vmlinux>' and there's the vmlinux-gdb.py file
there I can properly see symbols and use the lx commands provided by the
GDB scripts. But once I run 'lx-symbols' at the command prompt, gdb
reloads the vmlinux symbols assuming that this script was run from the
directory that has vmlinux at the root. That isn't always true, but we
could just look and see what symbols were already loaded and use that
instead. Let's do that so this can work by being invoked anywhere.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Nikolay Borisov <n.borisov.lkml@gmail.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/gdb/linux/symbols.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 004b0ac7fa72..2f5b95f09fa0 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -139,8 +139,12 @@ lx-symbols command."""
                 saved_states.append({'breakpoint': bp, 'enabled': bp.enabled})
 
         # drop all current symbols and reload vmlinux
+        orig_vmlinux = 'vmlinux'
+        for obj in gdb.objfiles():
+            if obj.filename.endswith('vmlinux'):
+                orig_vmlinux = obj.filename
         gdb.execute("symbol-file", to_string=True)
-        gdb.execute("symbol-file vmlinux")
+        gdb.execute("symbol-file {0}".format(orig_vmlinux))
 
         self.loaded_modules = []
         module_list = modules.module_list()
-- 
Sent by a computer through tubes

