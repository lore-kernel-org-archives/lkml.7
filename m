Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B52721872
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="eGyEsGP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCPBuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:50:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44212 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCPBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 21:50:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so7500804pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 18:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=++NquuHJmycDpifqfNxom1OGjUF5fgqXGJLzV8X+ejs=;
        b=eGyEsGP8yy0Fv1QWas5AmNQOXRYJjnovegl8yePysplu9FEAUaIdZndScDN5V1u0MY
         ZwbrbPj44Nz1hIC6Pfnk9iTr4QBUocJh4CzfeSE91G3/LHnezCMQ87U+QHZFT7mw38YF
         9XrK3B12AW8fFOk6L5rtHgs6mnIkTL+3FcJy2S7PEOTldC3Z+nvWWDk00bETwyldwnMv
         pMP0kpPd0/Y7ZAKrUtqq1XruyXXojeyUPOLIEWmgUV6HIvDOzKuGV9d8P2uDnOnCVMk3
         ZyQEE0YmsPLXumm44AEaX6bzWj494OBJVsvC/umZk0u42Bmgq0HXdSFT/uT0Hb9oXH7f
         2m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=++NquuHJmycDpifqfNxom1OGjUF5fgqXGJLzV8X+ejs=;
        b=E3oU3q1bBxGgwxzyQ3jNQyuOeEaMdBiE8BYC+YlD+9e2pj9QM47DY6ItKEeNtOqt2W
         Lx6r4uL1PRAnTRSoAAMG1aGEYpj5QnZhGaFsZi5w4C8941IOsYaApYVdcvgoSDwW7Phv
         6RI0ik1AQz64mk0qlxadD0k19wDJA7LjJEpQYtXkQtU+zAgYXwYATbNMdWAuEarsqtw+
         efDPmYwSrLU8n9B6FsaAnU5Nsg+Y/TNeef0X0h7Ou/BgqTj1ji04eYrz7yoEL6kepd6k
         C1u3CcEeKZmAWBo0AkRsBIwvcxpYnqrZU0zitpRB50TeYrs4wcAW9pnG1Z234Kc8RRbD
         Wt+w==
X-Gm-Message-State: APjAAAWNd5bUlz2oo8qkNbD8IX+MH5vq1BzUhkFy6ezAGjBF+gAa9zrl
        TlTydrahvYGvdRyK9PuvzFw7oA==
X-Google-Smtp-Source: APXvYqw1oX4kA4wDASSp/m61GOWRK9RAfvj1WWB0jY9fqczD2luovBOc+9Rhh3VwzXkAkE9Bho5PSQ==
X-Received: by 2002:a17:902:d704:: with SMTP id w4mr7454823ply.236.1552701042624;
        Fri, 15 Mar 2019 18:50:42 -0700 (PDT)
Received: from localhost.localdomain (36-239-209-125.dynamic-ip.hinet.net. [36.239.209.125])
        by smtp.gmail.com with ESMTPSA id u11sm4019794pfh.23.2019.03.15.18.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 18:50:41 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: da9052: Include linux/of.h to fix build warning for of_match_ptr
Date:   Sat, 16 Mar 2019 09:50:30 +0800
Message-Id: <20190316015030.11522-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #ifdef CONFIG_OF guard so linux/of.h will be included when
!CONFIG_OF. This fixes build warnings when !CONFIG_OF.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9052-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index cefa3558236d..d272cd040f79 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -19,10 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#ifdef CONFIG_OF
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
-#endif
 
 #include <linux/mfd/da9052/da9052.h>
 #include <linux/mfd/da9052/reg.h>
-- 
2.17.1

