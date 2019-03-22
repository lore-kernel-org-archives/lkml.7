Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43600C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077B520850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV6uTOZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCVPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:32:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33282 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfCVPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:32:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so1787842pgk.0;
        Fri, 22 Mar 2019 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hU9SIY+MKil7n6a/7OgtQUfY8N6iQMmd1/vHWhQNtDc=;
        b=jV6uTOZV8Ak0BEUkK+m93uWtsPa1p+vPYgBUvwsYgwEho5cm5DuH7JG9Ib8iDtHjza
         c+SSeuP2BX/A584egI02qJ9uUe15ppZaDhznjaqqsrAzOhch2bxFx4va1CBcf/RJ5Ygq
         a7TDOT/R883PN3APOKc44kXzcr0V0EFKA13rPV1tGSu/9RpI/RLgEYHQCZoI5Nfv2uwB
         GUeSIjnjfdDwWEmHceR3gOYlmvGz9d4/b79vTrzDmdZpLNbX3G9qxPkFpciRLMRpvMm/
         0inRn1/sy8yA6s02Y63yRNTY3V2JTywczcLZe9aARE5B4wV9NuiscMdD7N+TRlKRFBVq
         KQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hU9SIY+MKil7n6a/7OgtQUfY8N6iQMmd1/vHWhQNtDc=;
        b=ZdIlR402USUS/eYcs5CGJnuUNL8NeNTec822TAsZUpvlPokYlCbvuFZ1HCLnggmYys
         ZqLwtCl85ixW6K8tl7b9Wz0YVtOLbnrWihXq5E0F7K1cjdM/wGGzCFpqpxmA4/wNyT0i
         SCBnaJB90/MWFlg4AU8E2nMiJkJDMMoH7pOkpDu+X0liu8bilcxQUCbywM9DowFZcBU8
         HionSM8pthIuV3Uis0dQDzrG40xkjDHe0ysIfX1g6IEGYisYMu94DJleJBy6Xm0s8fPj
         +xclI0n24cgySHPrLx9fQUwKQL7q5O8OZmpcqw0e8Mbv01XXIB51rIwuuNBCK5SPOshM
         IcNw==
X-Gm-Message-State: APjAAAWbGcfd37/BIGA/Yq5pLBrAzI9MfcCFF9vK7Y/QBDSLZN6mctbZ
        ejHpYgeWkm9KLOSQ/QwJSV4=
X-Google-Smtp-Source: APXvYqyvqW7nV5hZNZcKgEvaU6ul53cA2neK/8Q9hu2RXVNpW2arzI3lytgKI8Td2Yl8Ra0vfdtAKw==
X-Received: by 2002:a63:b52:: with SMTP id a18mr9533020pgl.393.1553268747897;
        Fri, 22 Mar 2019 08:32:27 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id v82sm7701687pfa.170.2019.03.22.08.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:32:26 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        akpm@linux-foundation.org, horms+renesas@verge.net.au,
        kuninori.morimoto.gx@renesas.com
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] sh:mach-dreamcast/irq.c : Remove duplicate header
Date:   Sat, 23 Mar 2019 02:32:16 +0530
Message-Id: <1553288536-14470-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/sh/boards/mach-dreamcast/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index a929f76..cc06e4c 100644
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
1.8.3.1

