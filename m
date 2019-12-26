Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8469C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D73C20740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vy0udCBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfLZWRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:17:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39240 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:17:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so8004405plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7ESk9eQMRZr+kEQuMK0Z8FaJecR+BKoIpQxePhdF6o=;
        b=Vy0udCBfVuzARF9m0mc/Z7ONkkt6IwY8DJpXMCucBLV7TsxIK5bJ8eO+LLIwhAcreh
         CkGkrzG9pykpqkkC/iNQkJrXOTJJzLxzLV2Af/tFrnzxwp0qxTioh5LFMW+8Qa/ptf8o
         GvOs519X10lPwvXPESozI0QrNaX466/0LxX4ZzyLb2JEiPJbe/6z0MBezOrlDr7xPNgR
         2jQYAUfXVZDB8eexJKD56ciO+LezslNbzyWDQHcJi4/bSTbbK05iRhwJT63FtAgIJDnn
         nza9W86KONxRz8DtZsKb3Yj3k2PFTrn5o2z/X3XQmu3ZvTxV3fi4qyFLvI72CP4p/Uzr
         wXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7ESk9eQMRZr+kEQuMK0Z8FaJecR+BKoIpQxePhdF6o=;
        b=aJxNIBzee/MTLNpT9dwD5LuwRp5sJR99IVzFKw5MXKy/M1xmBpTVA5AnpGYxCi89DH
         6gv7Oe9UTuhEQdCZtLp1m5uWo0HukCDb2KY5/Bx+sgjaMZLtjP+Stdt8013+tn9nOzWc
         VoU/5iOPuHaENYp87WBC0TXx8DWzKj3EUwJmnRMTD48d/BppS3463lo0frXsSBVP57L4
         cMdiut7nD80v2AIMZxC+Rp4RKhiwizTK00VxopdClE2CmzXCw5ZVaE1gfa6sAl2MGb5o
         vp8a45eAhKsZFULFW/pbyS5o5N6tIWCFha/vl63PEY7Tf1saVCzpjrjqEEeI1CWGO1pS
         ODNA==
X-Gm-Message-State: APjAAAVWnZEPZWg/XFplmqHGVHyVsbiWhrvHJvs7h7BVmv4h/0/uW/LJ
        no9Hzd79hx+xfSwapZJM0gmBxA==
X-Google-Smtp-Source: APXvYqzeKxoKEB96j5hPs7KlRto6hP0WKGq35P+5NZsItv40vaoBcyhUle3i4Zaj9vYVjTLZejXkWA==
X-Received: by 2002:a17:90a:1a0d:: with SMTP id 13mr22096750pjk.129.1577398664714;
        Thu, 26 Dec 2019 14:17:44 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 2sm11779409pjh.19.2019.12.26.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:17:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Patrick Daly <pdaly@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
Date:   Thu, 26 Dec 2019 14:17:06 -0800
Message-Id: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches implements the stream mapping inheritance that's necessary in
order to not hit a security violation as the display hardware looses its stream
mapping during initialization of arm-smmu in various Qualcomm platforms.

This was previously posted as an RFC [1], changes since then involves the
rebase and migration of the read-back code to the Qualcomm specific
implementation, the mapping is maintained indefinitely - to handle probe
deferring clients - and rewritten commit messages.

[1] https://lore.kernel.org/linux-arm-msm/20190605210856.20677-1-bjorn.andersson@linaro.org/

Bjorn Andersson (3):
  iommu/arm-smmu: Don't blindly use first SMR to calculate mask
  iommu/arm-smmu: Expose s2cr and smr structs to impl
  iommu/arm-smmu: Allow inherting stream mapping from bootloader

 drivers/iommu/arm-smmu-qcom.c | 35 ++++++++++++++++++
 drivers/iommu/arm-smmu.c      | 70 +++++++++++++++++++++++------------
 drivers/iommu/arm-smmu.h      | 15 ++++++++
 3 files changed, 96 insertions(+), 24 deletions(-)

-- 
2.24.0

