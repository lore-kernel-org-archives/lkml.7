Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F64AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207B42184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eEgsPEQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCNL6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:58:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32804 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:58:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id d12so4383554edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7a4WtKjBYJ8vP6Oi1dUaJoxtpCIMA+vqm6PwLZbZr3I=;
        b=eEgsPEQyf5kiOWxA530A/iDUAi+Ic27pi3boXDduVXTtl/eX8oN58JNUKvoqkFe7Du
         8ruapmQAs35DuMq4gwwzPBNpdcZlOV7N6T2CKotxU+KS7gqiUjd5P9XobyffowRZRarZ
         iuPAj3+06fSHPtpdaEyboAYMzkIvO/ch9ttJdqf/C6tQuZnD05jM7F9M+fCZPln6WYbv
         /hsoAye5vICoGFDWXbxtMFe+3gEvK1V9hcEhYo7zuAqhXQwewwR7C10XtsgCOyPlhO45
         uMXU8Vjk4LHod+KDkrIefU4u3/bffnDn36xrZ7gMdPAUNm6KlKcc/NjpLflMAVyTn2Yo
         SUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7a4WtKjBYJ8vP6Oi1dUaJoxtpCIMA+vqm6PwLZbZr3I=;
        b=OnHgGyQp1He4xV3CQrmT4fcl/YV2sLMODOLGchP7xRtMWZC1YSbEotLn7zClz/cXmD
         V5Ot0MNl1fDzQuL2bcaUU9chtcHNmzjXiBFjnDoDP6m+u/YRxRkG3c/2CympsJKM5CVS
         XQV0dhqLzYOXclRV5h1DFk0hJILKY4z0Qt+dDQfKqqGIzXlYzxwUnMepHh8iohMsamD/
         oaUeQGo9ZiMOxUtd5wCLvMGG+3qirhb/kIHzXsTWeeuUNa/wPPSvsDemVgQ8vFtDFsN1
         amA6B2NQehAuZbyDp/CM2tR+Rt5IB08LlaZ9fV73J/didZuUHWWPBlKVAiSwTTfATTIA
         fNwA==
X-Gm-Message-State: APjAAAXkq7dFtuyC7SfHf2rlTzQm9PUxL58msocV9Eeeb4BM1uDg00IS
        hH6GaU4DPetM8nqmFzuSPEbFPA==
X-Google-Smtp-Source: APXvYqwJFmxdM/HQce3QMWK0IryrUfO3i7NZndTXndD7/B4BYqRCsNG7TSQhguDu6JcY2Dz46Cw1NA==
X-Received: by 2002:a17:906:69c8:: with SMTP id g8mr32484171ejs.75.1552564684209;
        Thu, 14 Mar 2019 04:58:04 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.04.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:58:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Date:   Thu, 14 Mar 2019 11:56:54 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1 and 2 are the same as v1.

v1-v2:
  Refactored ISA direct mappings to be returned by iommu_get_resv_regions.
  Integrated patch by Lu to defer turning on DMAR until iommu.c has mapped 
reserved regions.
  Integrated patches by Lu to remove more unused code in cleanup.

Lu: I didn't integrate your patch to set the default domain type as it 
isn't directly related to the aim of this patchset. Instead patch 4 
addresses the issue of a device requiring an identity domain by ignoring 
the domain param in attach_device and printing a warning.

I booted some of our devices with this patchset and haven't seen any 
issues. It doesn't look like we have any devices with RMRR's though so 
those codepaths aren't tested.

James Sewart (7):
  iommu: Move iommu_group_create_direct_mappings to after device_attach
  iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
  iommu/vt-d: Expose ISA direct mapping region via
    iommu_get_resv_regions
  iommu/vt-d: Ignore domain parameter in attach_device if device
    requires identity map
  iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by iommu_ops
  iommu/vt-d: Remove lazy allocation of domains

Lu Baolu (1):
  iommu/vt-d: Enable DMA remapping after rmrr mapped

 drivers/iommu/intel-iommu.c | 444 +++++++++++-------------------------
 drivers/iommu/iommu.c       |   4 +-
 2 files changed, 131 insertions(+), 317 deletions(-)

-- 
2.17.1

