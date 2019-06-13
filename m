Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63132C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B852173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThcDxsm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfFMQ1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:27:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35893 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbfFMQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:27:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so5229443pgi.3;
        Thu, 13 Jun 2019 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1vy7DnzNlW7BikrT1aYtCzomLZ4jnCb1JSwMR9zHaI=;
        b=ThcDxsm2Eo7zmQtLPSCGbD3aEVtad1mN6qL3VVuxd32Ezhy3h2gEuGJOB5igc6ejUi
         8Tw/ooqqLqbKROz4UOMjhfE+0MEUn+wzcvHJIUfQKqeT9ftOaehe0G+B+nbBVbIHDVCG
         f12Z0/tv+bh6ILWIY35miZeb0HaDAZhrhYF/bc3ZRdYs2e6NTxF2QUwK7R0IUa2m1k2z
         IjJPuVzLzzye9N56nP2N1bs1hGoe13ydtlOWdcuN3RsYcC/ZRq9v8wAUHczMA1ZUHWkr
         aqy9QPNtz/dhG54rl5XGKA+aoI52ct7cgtVQGs+5afZ70qj8buSJASglXjK2dYttNmKf
         ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1vy7DnzNlW7BikrT1aYtCzomLZ4jnCb1JSwMR9zHaI=;
        b=nWTsBJbAt1yYQSIDSfhpik2y6iPppSkmOCCn87DPOl0b50VF9/0Ewm5Ch68ABgyGhZ
         T1vS/XSegLAh6JZMay7KwId5HbBJ0lZzKM16yPoux/RZuchGUZaDlCnEgypzhk3v/2MJ
         Ju2KEguooGVaing0SaGq4hhnDmNfZ3gtaYOh47d+8TH4gOMpHHQAgnSKX59UST/t9bnM
         IzY8+fY9wOeK/r7Q+Dn3g9ooX89dy83cyUQa6+9ViXO4o3eUdyVY4Eu/9KvPaMzSb18q
         F+C9837ifWABZhCr52Db8+mzEjq76kJ3tQBdm5hSHeIUW/h6oa/sDsthrvfSx0FTLTU6
         pn/Q==
X-Gm-Message-State: APjAAAUdBRj6QLDCo7loO04wCT0ywdY7GuddjRg2oV8wNkL3aQBQSRv5
        rVUel9y7yVXX1iRguyqV4cw=
X-Google-Smtp-Source: APXvYqxALl3rWY5oZWGDTc9ogW7qCDR1OKax63JMlYMjuaLbW+O6IMlBZCCBpt/Bp4dU5/yrELe38g==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr6526915pjb.115.1560443233237;
        Thu, 13 Jun 2019 09:27:13 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v9sm169586pfm.34.2019.06.13.09.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 09:27:12 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     joro@8bytes.org, m.szyprowski@samsung.com, kgene@kernel.org,
        krzk@kernel.org, will.deacon@arm.com, robin.murphy@arm.com,
        agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
        heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 02/10] iommu/io-pgtable: convert to SPDX license tags
Date:   Thu, 13 Jun 2019 12:26:55 -0400
Message-Id: <20190613162703.986-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190613162703.986-1-tiny.windzz@gmail.com>
References: <20190613162703.986-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/io-pgtable.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 5227cfdbb65b..3c84ff1901ea 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic page table allocator for IOMMUs.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * Copyright (C) 2014 ARM Limited
  *
  * Author: Will Deacon <will.deacon@arm.com>
-- 
2.17.0

