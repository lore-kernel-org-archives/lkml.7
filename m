Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0460DC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DAB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWXSJOL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF0Rdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:33:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41589 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0Rdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:33:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id c70so1205099pga.8;
        Thu, 27 Jun 2019 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=19iGsB+gEzyIr57/DpIGaBLmn8xqXumBOeEKleUog6g=;
        b=VWXSJOL/XQJ6XCDQCsBk0dmxzaahEp9pmrVM0g18Mq/CJv0Y5yF1uV4yfAU/1lIYuO
         wUKxsrJ1vQkeHo3Ssin9WpV9patwudTbZ6Lh9DG0VMs2rq85i5CEbQ+x6lId/JxrKgBC
         p+0/6Age1KNMbk+zf4bmqUnoJmGopWLBto8Vt58eSNRyv5Nyviq2YUN7i/x0l0UfOlOA
         6gzLZ+dzWQ+yM2JHrXtdlzOm2sLps0+uq3d0mj/ecS1BZuzBQP6wFxuIJOGb+cBiDItB
         +J6Px8IYhc5bIkkkn+uqzGs56NFI4mniSJe3vlVN63PCJy2wrPD3crJ2cTJSkCE3sK+E
         vm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=19iGsB+gEzyIr57/DpIGaBLmn8xqXumBOeEKleUog6g=;
        b=Cn6aD+l9vMxjCwMcoqSQVwIfg3m3gbzNcpY173qD3eOjlKmMPVQjtCefE26EHcFEwP
         u+wl6ltUY2uTir4ONo/8pUppja+FqWtMV0gRTvv8B3nq78wGJJDwdtbt23OA4ELOBbbI
         Q/3QXX4oEp5mMLIcrbtQTOA7NpEDztjUoCWWyEAmACfa8e6VPCda/KXDpR7fleOy3qcU
         PlLJmjs/BgRaYmEupAZPN3gjy8MlBrLrVXbAwrNddl64WDoWKYSwcG0Tkbprjz6An3Qm
         Kbs/2/RklZuUl320usSZAfMx6hjeRn0O/TeML3rEqup6RZEfCgXKQc7C52qgI0aHhysk
         Xq0A==
X-Gm-Message-State: APjAAAVGVLvPnYb2IhCkRj4wOfUV+A77FVlkPe+UWPzgRGJzLCFWwAVI
        /jy6+XkjLfUgXd865ONZ2Lg=
X-Google-Smtp-Source: APXvYqzwq6aLPmIprFHDeK9/db3iLLruH7les8HE0ELbvixRrz6wmetv4rmeRN3+GdGENzYpA5hXjg==
X-Received: by 2002:a17:90a:2244:: with SMTP id c62mr7583309pje.29.1561656824516;
        Thu, 27 Jun 2019 10:33:44 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u65sm10301043pjb.1.2019.06.27.10.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:33:43 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/87] sh: mm: Remove call to memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:33:31 +0800
Message-Id: <20190627173332.1879-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..b09510adfae9 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -58,8 +58,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.11.0

