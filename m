Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2355CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB3320700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DVXp2CF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfCYSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:45:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33511 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfCYSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:45:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so7033884pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7a92O0IL4yxS6jfXWReaSz0adfdvNKb8+QWSFPrpew=;
        b=DVXp2CF918Ab6uG3uYX4oUjSXGUAkb/u8mG6DENiDwfo8aJehc0wmJKTirRgQS5Gm4
         pNHh9r9AF6k0YrZQY28+WJbLMVOGPtR5dq1AopR+pVAGPsjLa+L4+vU4/dYzg3LVHDXx
         sVABXtM9z1PlO7kbr7Dq2g9RmkbRBtKCE0Ot4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7a92O0IL4yxS6jfXWReaSz0adfdvNKb8+QWSFPrpew=;
        b=UvtMn+WV6mbOoa+hyPtUpgoACstBnW+8xsDT20SADbxV0aGF8J1smJv/ybB6Pi8BAR
         Wl0cFjTE5Y/HEo8+OXcxXGFxZOAcAVPW4vjdCxOO2y2Rfsd75fjdVzz+QjVyUczy6lA0
         n0KW+afyKULv7pHDIENJmGa0qrAZzpMJMRq+X/wb7qJ9smpfDaV5Y0AyAZktUOWnfPvv
         /6FXjBFmmuZoievU/NDGqGPQ7P1n+OIQ0nliixTSzWp/K1CIXG7kPB2cGo/cpizIQBkF
         pMQ38UjNnNMQi4jjXIyBLjVDi/wVVN4UM6GWFybH7AjMBXvuakGUup6ApFAh/vM/TAku
         6WNg==
X-Gm-Message-State: APjAAAXw04rzuWSmpr4AGj8mVa/W1Wc+GcC/KdSV9RPxBXsjnTC8J6yb
        zYeqbyjTHwXJUA2G7hSWRVvx1w==
X-Google-Smtp-Source: APXvYqyMXJPbynt3m5k1hLlGOkh5D1aL/KQi1wvoQteraUT7DDhAZzk6M7HeFhM0EbNtUpakBuy6OA==
X-Received: by 2002:a62:6c43:: with SMTP id h64mr25569222pfc.123.1553539525285;
        Mon, 25 Mar 2019 11:45:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm27505108pfb.31.2019.03.25.11.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:45:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 1/4] scripts/gdb: Find vmlinux where it was before
Date:   Mon, 25 Mar 2019 11:45:19 -0700
Message-Id: <20190325184522.260535-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325184522.260535-1-swboyd@chromium.org>
References: <20190325184522.260535-1-swboyd@chromium.org>
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

