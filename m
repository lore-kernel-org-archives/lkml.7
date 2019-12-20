Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08367C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E412465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVabQMVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLTAcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:32:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45436 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTAcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:32:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so3314676pls.12;
        Thu, 19 Dec 2019 16:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7/Hluy6r2VW8M5PHO8z1hcbWtjMcwj/79LYueYPEReY=;
        b=bVabQMVqnaD1wxYaqbc41uMz1hUBO6Y6CTs8bokHeGCAwwt5Zcp7i3fptcZFlK/iwB
         dbVyVoiXdVOH81rG1Uz/+dTwvngouWGqQqUrCu7VSbFH8BdyIXalmtC4kj8HvLNmjt3L
         VC+HLZkHFViqlmPjws24dF8llKxYYOHG1i5iyecaLfMm3mkFFdyFWLXhoLlIi0XtAOEN
         /GvheGWlmXZNKQNmx2m5CJVzdc8+YExe5DxcDxu4Tt0HxbAZFkPKoeLM0lIyslg2Xqr6
         k/8A4PzPhRUoUU3cR7C+WhgNNrTq2us95DbcrgyMSM/3c2Rf+mppm+pZ+lSMGuVoVson
         suOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/Hluy6r2VW8M5PHO8z1hcbWtjMcwj/79LYueYPEReY=;
        b=n4mHD9/r5Ft90ExG/oWVbaIFKj8rQCXgH2CZpb22ILvVzGKQB7g8sFDmH58naX212x
         QuSUm2O93bWauQ8NxSVlUyIqasPJEEhe38Ulcs+xg3pIKKMMS8MQRnhSccOMG7dQVBiE
         A6zaVg26uu1BPdPtthbhvXixZWnM8sZTzSa/i6OS2L+aNZyivbG5AXjN4DwA3ll7OgjK
         bJuZgcXGdJ3R3IQeFwKq/v7/qxp8FO3hRUKQZfL47pSwv+yBFlI8Tl9rwVH/OwSWvxN5
         MC4c4YRfK+1HsSDMedKmC3zEu35ns3wTtJU1lATcwXWO647TOrsGRlGyRbX3hkUY/rf8
         kQhA==
X-Gm-Message-State: APjAAAU/mzowXH6JXdZlViT8OCYZVsEg2T0RxIM9evbl6ImpmwGKT5S+
        SpN+93I2Bkw30tz1hQoOL3wkmDW1
X-Google-Smtp-Source: APXvYqyejX7YMmVp34ctzUEmdK5Wj6hSszdLT49vgsiUfowiWDd13bl0Ef/tISxORYtldA5F34R+bg==
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr2608420plr.340.1576801951886;
        Thu, 19 Dec 2019 16:32:31 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:32:31 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iommu/tegra-smmu: A set of small fixes
Date:   Thu, 19 Dec 2019 16:29:10 -0800
Message-Id: <20191220002914.19043-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series of patches are some small fixes for tegra-smmu, mainly
tested Tegra210 with downstream kernel. As we only enabled limited
clients for Tegra210 on mainline tree, I am not sure how critical
these fixes are, so not CCing stable tree.

Nicolin Chen (4):
  memory: tegra: Correct reset value of xusb_hostr
  iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
  iommu/tegra-smmu: Fix iova->phy translation
  iommu/tegra-smmu: Prevent race condition between map and unmap

 drivers/iommu/tegra-smmu.c      | 29 ++++++++++++++++++++++++-----
 drivers/memory/tegra/tegra210.c |  2 +-
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.17.1

