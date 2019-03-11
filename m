Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E643C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035D620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ty92g9pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfCKPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:46:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:46:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id m2so4336107pgl.5;
        Mon, 11 Mar 2019 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=+9UZa4gubbzy5gZyM/W6ZF4dGbmRy5L5BvhJE4XaD/E=;
        b=ty92g9pHGOKuF+ZeMj17hTGQzy15RR0OoLT1C5j0MfTgC25KbQzIsGOGMgc4jMIEwi
         mb0XqJkrNFYn79Gyb2WkF/2JdvHjzGQBI2zREudaFqXs2fojZEXNWi5Wp3PUh1Yk7ebj
         inlaWhkuJ2LZDIcP76aKeLHLZuKRlrF+1ET1WbTIgwIgFAfeqBmv6S4n/XQ1RMzDb2FP
         B9gmcIIG+sYlpYppLhhE0JNj6RQibqQ4jC8NWZiDzrC6D8VLnEb0CL/sfoZ1pAZvzI/R
         bX8PMz0vpbOAl5QFym+RF5lr3j9faa9tZOqHQXPZPZZY1tPSWFK0WS8agdZcuxIP9oxo
         Y6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=+9UZa4gubbzy5gZyM/W6ZF4dGbmRy5L5BvhJE4XaD/E=;
        b=t8BxULQiUs1vkYhsryuYobl4M46ZKstahyrp2N6KKZFZxHiG/qvfpr02NFQFlkrIkb
         0ffR2BKnf1WIl06h7wDs2I7EVakJ+vL0JxhbKY8WtSSngN5f+k6p6JLnSK4d1TE6g2a3
         it2vlUp7IvzhlA6srR7gD6xJ3mbJ5Dn3IO/9KmumuYDDroZY8y9uiTUkV8KPqEEW5d7K
         jhKfhTWP8x8QXFTTR6aF1cNVAIqHr5nhYYeUrsGXmlSEX601ymF2Dl+VbcLAdDQWgJTk
         FwZOh2gCyTuLBbw3GF/ZgujWAgD0QEnSWDVIXBc6QeM0ZGSLAfnk1JcWjDcRlb2HxbDo
         6YJg==
X-Gm-Message-State: APjAAAVj+//BG5UxL8LSWH8SS9xLP2ybPEUumNPdYAzdJ+/3KM4pNSWN
        Cutp+jvbj+a0vaV6Y+jODlLLxASkIHI=
X-Google-Smtp-Source: APXvYqxFBSyBbmoDAJBOXWg4z8sJ1E8lBFrLOIggDrIJJN3iOGGJhvz7Mor/drz8m3nS0L/Do1lDDA==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr35391502plo.265.1552319216133;
        Mon, 11 Mar 2019 08:46:56 -0700 (PDT)
Received: from sabyasachi ([2405:205:6194:e788:a4f9:f674:88cd:e152])
        by smtp.gmail.com with ESMTPSA id c18sm8355820pfo.44.2019.03.11.08.46.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 08:46:55 -0700 (PDT)
Message-ID: <5c8682ef.1c69fb81.5a1ea.2e7f@mx.google.com>
X-Google-Original-Message-ID: <20190311154649.GA8946@sabyasachi.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:16:49 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        jrdr.linux@gmail.com
Subject: [PATCH] arch/sh/boards/mach-dreamcast/irq.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove  linux/irq.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/sh/boards/mach-dreamcast/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index 2789647..69fa91c 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -10,7 +10,6 @@
  */
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/err.h>
 #include <mach/sysasic.h>
-- 
2.7.4

