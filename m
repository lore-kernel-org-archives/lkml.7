Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F0FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2394F227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfLRUkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45235 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfLRUkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so3014603qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dH6KnRsKCyeD6IBXbwILG8yB9gp5H5I7proIDgAuGXI=;
        b=ZwzBIZEnFADyL5w3JJqTza4RBWnP+JzDvNn6bEN/tn0QNpfG+t2WLJ0BF/7Cppb8MZ
         iqtbyjznYvTDlmFNOVOkF9Vhbo8VLO4d4vZxAGu8MJd6LO+5lImuB+WcGhhBtldefzHo
         ZxC7+rkxff9bQcv8xfOYc1068woPriFi4cN2k7y1y3oZ2dC6IKG/YQk3Iiup2KDY+4pv
         c0dwWMfI5rU2sMYVqM/2LMtUP2nRPNe9tHnFsTbM7UidWEoeByfwGAEkmbHEB/+IW8qS
         XCC+fjBB/ht1Lzg5xN5u5GxU7nfeYOZirF5aFpcupe7EPCiibfb/sL0QWpUIeVwu+XRJ
         2itA==
X-Gm-Message-State: APjAAAXcKW/+SJ7i73CIECSiSz7mdmDzrmcgxeeGFvQ7z9yk6FXXUg7C
        TOwJqObz2qoxYezFI2kjMsYJZqDp
X-Google-Smtp-Source: APXvYqwBuvsY0X1Zsz13333rMkGyMNlCaggMQEdd6Dza05LMsCGEBZlN6ndAFn0nGzts6fJxVbmXGw==
X-Received: by 2002:ac8:4456:: with SMTP id m22mr3987892qtn.362.1576701619803;
        Wed, 18 Dec 2019 12:40:19 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 20/24] arch/setup: Drop dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:58 -0500
Message-Id: <20191218204002.30512-21-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218204002.30512-1-nivedita@alum.mit.edu>
References: <20191218204002.30512-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con_init in tty/vt.c will now set conswitchp to dummy_con if it's unset.
Drop it from arch setup code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/sh/kernel/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index d232cfa01877..67f5a3b44c2e 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -341,10 +341,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
-#endif
-
 	/* Perform the machine specific initialisation */
 	if (likely(sh_mv.mv_setup))
 		sh_mv.mv_setup(cmdline_p);
-- 
2.24.1

