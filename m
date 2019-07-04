Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27419C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F085D218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8/08T8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGDCgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:36:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37927 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfGDCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so2155724pgz.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3tmiZiCH2XBVN5DuJQwuRPNtjxIcwvAWUQCPl8nlFS8=;
        b=j8/08T8J4krcY8oeDaG8iVVGo9lDUlLhT7nM08zXXc+dclnwsab6iqduH7tHilXg1g
         iSLsCS3QNXdkfi1FhjmW4M+qjeb6irGtZkh2B23TfRkOwhSRUjIrxy49y5Jortjk3bqM
         F4tnycg+yEFACC1trpDUiej9M3IDJ8sncAwMfoeeVJlMNr+FfVENXns0vMOLK09IAINS
         mJAG107H+F/holFUJnJS+bcpCZXn+xtxxC9qXA20WHYLRo/ss977B1Hi8tqclnGhOH/D
         0UGxKsT3xi1+00z5+8m9DpbHsWYLYfvacof4ISc52xEy3N6v3wwpAlomqt3mtmo/Ey+n
         Q6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3tmiZiCH2XBVN5DuJQwuRPNtjxIcwvAWUQCPl8nlFS8=;
        b=Sk51K3rn56FjRa6t55zaRZ9LPTGdkUHGEsaZUWdnPZTHtOOOWtkXI2IoQzYrdtVFy1
         6UvQIvWhOMVPLfUCDj1VbT+RYhyPQ/WZAtlb3Pzw8nPg/edp68VHowtgUCKEwd1MUE79
         nL509aQpqr80fHxoMjG8+f+ULJW2hbFhSmMxWMeI8rGUv+4p5RV7DtiopWR5fQ4nMKy8
         kEz1PWCJstIMcgqSE0R9AA+8BSfTnDdJGVNWogWvx3+Bt4WdPvPAVhwf/4ofhibG+H7H
         dPA+i6/SB/RcDLRakt6euYZcwCYMJie+GpPF6Iwyw1ldam87SGSiNm1lbc93Et8Z8vsz
         7a6A==
X-Gm-Message-State: APjAAAVgd4xXeipMgSZHJJ92DOxKFi5lDX/SCxAkL2qS1snqkMn8CTFJ
        /fjl3BSeGTPAvEjaR6+wfclug+V7iVg=
X-Google-Smtp-Source: APXvYqyk5Nfr9mkfmlo0wPAAUjVe5OCh9aS4oDX9RYtz0TWt4Psr0aPBzYiylWf+ahi1WXDd32HvNA==
X-Received: by 2002:a63:d512:: with SMTP id c18mr42063797pgg.239.1562207786341;
        Wed, 03 Jul 2019 19:36:26 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t96sm3105193pjb.1.2019.07.03.19.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:25 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 06/10] iommu: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:36:20 +0800
Message-Id: <20190704023620.4689-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 62f9c61338a5..c638f7795735 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -36,7 +36,7 @@
 static const struct iommu_ops omap_iommu_ops;
 
 #define to_iommu(dev)							\
-	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
+	((struct omap_iommu *)dev_get_drvdata(dev))
 
 /* bitmap of the page sizes currently supported */
 #define OMAP_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
-- 
2.11.0

