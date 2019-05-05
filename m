Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC97C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BC7206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO0185am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfEENSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:18:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40651 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEENSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:18:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so5081923pgl.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/nwncARJEE19W+SwxCr4yhfXabdWKcWPT1319XAhwgI=;
        b=YO0185amDDkouf7GkxgJcauWqHzczdutOU7rgLkAXXPB34r9scPO+P0ZSs5766FTUx
         csjnEjMK0H0SMbHc6fo2aV/7q9Ziv/V4fbpFU1qBPQ0LEnb9wGnR+RJEctT48RsZZzgX
         TJXWGJhsj5JbfL2SExn8O0DIyAWEojN4rV9cX/Rs+/dbhP8cqDPKIJ7K8JZMo1+89v+D
         kCm8Cdg/D5nPAVqocvE8ltx7eGNVGmhkMMtRqsFjanZmazetiWxKkss/641mB4pOvBm8
         lYnxGCDh8o1lhPWWhP2ctdmp51+gLyRnk/IDrt4t3pCfoKgE8JkcnaZ5hK0dQdQ+IfGH
         Qk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/nwncARJEE19W+SwxCr4yhfXabdWKcWPT1319XAhwgI=;
        b=moh9qjNLoeTjPrgKgR27u4XWX2B1XMISdC36Fa9mTZjV/siON/2J7mDLn68eGkknus
         UWmJSCuibINADOpWiCGoQwRqpC2uwo0Zr2bmdk13DrXlpZqF6ZNV54qO+b0135xlpN7M
         1+O+fEAsZYExS4T4hxY3wVrNeWkWy2avtr59kMnG4rLUUqlaxcRrk0PBmPdE4pMd6UtV
         wkYsVBZ2/J8DwXHU4Bin9WWdfBUiwqbSvWju6//B4xDLdHpij4QDYmX01e5NGc5OZE7u
         ZuPrHsc7pAyYWD6MRoXjgxbqdDpZfH9PgctFg9y6RnTXJGGLLmZYCMGzzwFBi9xQN/eL
         8z3A==
X-Gm-Message-State: APjAAAUgLovmtQ7sqeg1FvemjAzy4XKtxW3HFBmH8AJiMuu+5dmSCAfb
        IuijOAbGQkAfTaCuoyOflIYmPZ9W
X-Google-Smtp-Source: APXvYqylr0vki0C89HqYRYVMQD6gzOE8pdrYiz98igigvgZzwJ2uuaAaXkzWVhbac0+ACGsqvSgaow==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr25686207pfu.4.1557062331978;
        Sun, 05 May 2019 06:18:51 -0700 (PDT)
Received: from localhost.localdomain ([103.87.56.229])
        by smtp.gmail.com with ESMTPSA id k14sm23556582pfj.171.2019.05.05.06.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 06:18:51 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 0/6] staging: rtl8723bs: core: Fix checkpatch warnings.
Date:   Sun,  5 May 2019 18:48:34 +0530
Message-Id: <20190505131834.4166-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix the following warnings:
-Remove multiple blank lines.
-Replace NULL comparison.
-Remove unncessary parentheses.
-Remove braces from single if statement.
-Fix variable constant comparison.
-Move logical operator to previous line.

Changes in v2:
-Dropped one patch from the series as it had some compilatin error.

Vatsala Narang (6):
  staging: rtl8723bs: core: Remove blank line.
  staging: rtl8723bs: core: Replace NULL comparisons.
  staging: rtl8723bs: core: Remove unnecessary parentheses.
  staging: rtl8723bs: core: Remove braces from single if statement.
  staging: rtl8723bs: core: Fix variable constant comparisons.
  staging: rtl8723bs: core: Move logical operator to previous line.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 69 ++++++++-----------
 1 file changed, 30 insertions(+), 39 deletions(-)

-- 
2.17.1

