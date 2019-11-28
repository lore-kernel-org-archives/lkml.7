Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC521771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MsBrXnDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfK1O62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35533 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfK1O6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so19827390lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0ILJLPvMSycr+N5z1WBGPbbOOzMeVGs3+El1NFG5gM=;
        b=MsBrXnDd/G1Zjj210ATgY6vuErblELNtwtEokGCaoA1MxxkLkU5DMXWZ/DqI4rkd5Z
         gETgTkCKjtmJ/BL1I8x41SvinDsW0tjkR9cfyiTi9zOlB2m8FMv18BEU617l2rIZlRYm
         JgqrkOdeLh5F0tEM8F/+7LQYmLCxUlP6KBeO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0ILJLPvMSycr+N5z1WBGPbbOOzMeVGs3+El1NFG5gM=;
        b=la89XoLNWrOg0G9jUu5EmQMLvFz4O6WmTpWeQyW6RFg89q8XxAu8gRqestvrMCe7jg
         duORayNZeBBKT9EciOX9Lm188J1n5aR9yXB70Z998aJgvdYVEKomRvfQEHu/gtd9L2Dr
         gEGgnF3D04vgoPpU6o3XnrqF0zHbjLPknPKGBdcM0BZJ5u6sHgje8NiHrrldDE3eRYjR
         jD5IaaboIBcJUsGLBC42YMnyF/4y0U5g+ahY9KE/HPh9+1aw7eIN8c74aJd8P08HDYTF
         Nd6YFZQvWfWRMr37a8lEz1O/UXjb2QFvoAI3Q1/DZlYT6VsgneMd9TYG/Gq2JXMYaigP
         +GRg==
X-Gm-Message-State: APjAAAXtxg6qhUHYiGQhlxPgRzLL8L1veoiLhmOLpOmLyo8uvBaK0zMl
        ZcJXHO/FyOaZVPe280wv4/Sn4Q==
X-Google-Smtp-Source: APXvYqzc2fQxY6lskiW/Z09onmsQDrBOExaD6v9SX5/irAT7oq304NVrn38+PRfo+mxcFltlRIIozA==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr35084645ljk.78.1574953086759;
        Thu, 28 Nov 2019 06:58:06 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v6 48/49] soc: fsl: qe: remove unused #include of asm/irq.h from ucc.c
Date:   Thu, 28 Nov 2019 15:55:53 +0100
Message-Id: <20191128145554.1297-49-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allowing this driver to be built for ARM, the build fails (for
CONFIG_SMP=y) since ARM's asm/irq.h header is not self-contained:

  In file included from drivers/soc/fsl/qe/ucc.c:18:0:
>> arch/arm/include/asm/irq.h:34:50: error: unknown type name 'cpumask_t'
    extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,

But nothing in this file actually uses anything from asm/irq.h -
removing this #include generates identical object code, both on PPC32
and on ARM (the latter with a patch added to asm/irq.h to make the
build work in the first place).

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/ucc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index da3d7e2dd837..90157acc5ba6 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -15,7 +15,6 @@
 #include <linux/spinlock.h>
 #include <linux/export.h>
 
-#include <asm/irq.h>
 #include <asm/io.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <soc/fsl/qe/qe.h>
-- 
2.23.0

