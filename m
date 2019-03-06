Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB98C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFF120675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgEyHQQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfCFWxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:53:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38822 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFWxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:53:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id t2so5590588lff.5;
        Wed, 06 Mar 2019 14:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuRVHuWMluoval6qWiJA7VxxUGn9vnQ2osYX8Us1zH4=;
        b=cgEyHQQg9jn3nOLRN7+5zu0raz/gXFlkoJohSEJHRlFia1UJzw/TAQCf1U0EXc9nre
         aPDPkYnBuNNVmu9SW8s16g/ZMd8KzsvKRJOaGpUDPLlQrt1WfR81WByF0KfdI5wAGKE6
         MGJ+C9kqzg3AtkeG4zEFrnU4Lxzzf3UL/oA4uWpaXfDDsVCyF6Hknzrw450FgLg/tnyd
         GOZ0r4/RrKCKe9PbD1XtfbrpESFCX7S4WTnfiVjTMxiU8eHVW6rOSozdv/AH90OUEvvq
         hsRH/jd8U1akPdrvndl3/GrWoGL9VzOAgiNz3To0hUtigSsMt0KoA18q5oDGMN4VGUhq
         xuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuRVHuWMluoval6qWiJA7VxxUGn9vnQ2osYX8Us1zH4=;
        b=fIh/wySh9yRgK7kyZR0ZgVXKUG9yPUd9+ZDZ3SY1Vef46+/bfGSy8z9tC+eu2S/9C6
         /vVYOM4vk2qv3+OQ5yKwZbAHzZ3wwYQf3vIBm6Ms4OGHyUvc5t7bMDkbF7K03MbrkYHU
         g4/L88zkITVKKpBhBsJ5Fiv6fe9tpyhn1ug6dLqqr/q6dm6fVE+rzMuXFS3Y5y4f1xpF
         7aowxlskDnNJk+lp3IQaeVd1Q+r5KlFBq3yXdrkgbifL0L4QiSZpX3QX38i9JeCJn5dk
         zr6TfhE7MxZUwdIAJ06xMvEV403g4s2gpY6WAMI6Lk+9W1TmEeeApx+7OqGE6FA4t4NG
         2b8g==
X-Gm-Message-State: APjAAAXxBG38fK64e/mZwCvM5u6RdD8BiTZbVy0Qv/+27BGZr7ziqFCx
        r9zkTB5qdgu9J7upv6HycmhaIWSN
X-Google-Smtp-Source: APXvYqxNfbJlFLa23SeawFZ3d6UHfmEOm9BEKg4xyafsenX8A9RrQrU06wiTZ4if4RNaDIxMWrfiiQ==
X-Received: by 2002:a19:c209:: with SMTP id l9mr5025349lfc.68.1551912785367;
        Wed, 06 Mar 2019 14:53:05 -0800 (PST)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id x18sm536961ljc.67.2019.03.06.14.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:53:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] IOMMU: Tegra SMMU fixes
Date:   Thu,  7 Mar 2019 01:50:06 +0300
Message-Id: <20190306225009.3391-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series primarily fixes a bug that affects Terga30 and
Terga114 platforms, it also carries two patches that improve SMMU
functionality and clean up code a tad.

Dmitry Osipenko (3):
  iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
  iommu/tegra-smmu: Properly release domain resources
  iommu/tegra-smmu: Respect IOMMU API read-write protections

 drivers/iommu/tegra-smmu.c | 41 ++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

-- 
2.20.1

