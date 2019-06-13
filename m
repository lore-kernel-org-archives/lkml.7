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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61599C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B1B21744
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ18UcaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392425AbfFMQ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:27:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47061 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392410AbfFMQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:27:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so12147347pfy.13;
        Thu, 13 Jun 2019 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IszorbYpZ8EP1Tp+nYz4SokI6QENBhp1O9rNXrNQTYg=;
        b=CQ18UcaJLPYS/u6Oo5otSFFQ7Ecriq4cKTb+yUFrnQ8mDlkdVFjdraR/sG7mwrbfzt
         w8430KSMbyef/tMS+IkO5hME1L9flVDQFWFPD8neeaCMQkgB6f4nEziS8Xg9752KnHa0
         36/X+0NI440Psui6njrXRDPWczTwak5kRpJmMazWysWKXZLfiJ+UiHLYDBEh6y4h3kZQ
         9PpUKF/2rjgq+5r1CeBnwisBRwrOUdvCztqfJxXrLoPHuyh2U5A/ah80mky6jnOWXDtg
         ev/u/kfEiqAyPZd9EOCcPyI8E4hYpcmIACwxYluSmBqoDA3N8UebR87b38ShqeI7uV1e
         9G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IszorbYpZ8EP1Tp+nYz4SokI6QENBhp1O9rNXrNQTYg=;
        b=i/J1r81816OVMowpmE0KUh5elxNChCSu125oy4CwqPHzSRGYlDZvkP3geqopjf6PBk
         vPGHO+Q8FSz6vQBQkL0dl6I7ZyrKZ/dhP0Abg6SocDJyeM34JzWMCvCN1H7y/yu08kDL
         scvS5WCpAbaiz0kPXWXfOLGqW9/9he60hzmTli1Gfc4rFwoVd2WttJR80iUOpZDucCFL
         1f8dwWVTKrpASJfYg81/TuUxh27D2P3ZaTNdPR7D9U7QX3gji5PnaDuqR6oCC+4hK1JE
         jhqviUyvXnY282OmmsJXCloqs6oXc8nKRv8jm1mypf9PvTsovAm9MXKOgZF2QFi5FMG5
         W50g==
X-Gm-Message-State: APjAAAWjK3R7ipqAtJEqzSPBRTuZ2Y53IMWZF3yjdGrfcVH0K9qupjbK
        bGezIE84H3/DqPqPO9tGUh8=
X-Google-Smtp-Source: APXvYqxufy0T2XKD0lth4cHLWERwXJoOmg14CS0iBJUyYk6CLpJnRVrFofyyxkm03jlk+bd+w9w2OA==
X-Received: by 2002:a63:1516:: with SMTP id v22mr32253463pgl.204.1560443251259;
        Thu, 13 Jun 2019 09:27:31 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t26sm289990pgu.43.2019.06.13.09.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 09:27:30 -0700 (PDT)
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
Subject: [PATCH 07/10] iommu/io-pgtable-arm: convert to SPDX license tags
Date:   Thu, 13 Jun 2019 12:27:00 -0400
Message-Id: <20190613162703.986-7-tiny.windzz@gmail.com>
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
 drivers/iommu/io-pgtable-arm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e21efbc4459..6282c45eefaa 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPU-agnostic ARM page table allocator.
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

