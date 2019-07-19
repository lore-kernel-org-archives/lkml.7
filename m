Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2FDC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EA52173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in+MPhQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfGSBc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:32:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36705 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:32:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so14796834plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+WrorOfGfVMn+EPTDunKndruhB1A70dpJYU7D8HhjI=;
        b=in+MPhQQJrz8zMcoMjNaSmIfGzYsuCUMH2V5W913MXsyCZvH0sEDOWy3Z2CI5RsAef
         78E2KyUu7xzy37ZFlPIY0Enj/CpzapB9228mVLOxaouvtgjRXwKzbXqypJdVYbiESDcU
         FNXKc7ni3Cc32pQ3a90864Zu7DRFCmnb4i4Hf/21nmOJoP698l25BVZ6DlPjLzc82ta/
         dHVabGJJOayDSxkBrpEkvUD9Raze4jorP/ei56WnO1Ae5MUPSkn/sOaSgHMCgQ1RPBgR
         1a1nzzHlL5OgOBFRia96vDTh8KvZqHpmDE0fwgszQBv4dedZh/M60Vic9Jy3mgT2gayH
         ChVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+WrorOfGfVMn+EPTDunKndruhB1A70dpJYU7D8HhjI=;
        b=gjoi+CbWFu3+XV6haOWHNdFrdkxKF+BiARGbaLy6NIB/RsRaGmw0B6d3hpRSJMyavf
         7Ky9EbbAnY73mKF+buIsX3BhHuf9hJqc712VvqDu/lkzs20qepcF+7vmf3jOtL/cXBn0
         8a+dxcewTMAiVFLcvHEVPlKH5H6hcD36sCfSApKcwuWiPxUKL4y1CgIrOXpwgjTLfuLY
         T2FCuqAd3SgF5NvghoNuYzM4CibGpmi+Gyc0O+IWjSOiWbg9YpCDuhkr5zSrxPTvVU5C
         pj4eJgHrNkblGFPHUzEHZ94WVeQRGibpxIf43DkLi/MLuPWKgqZvbwNSiym2cUdItRSe
         f09g==
X-Gm-Message-State: APjAAAXYasicA0ZBijqgeeQoeTfwuchB9pmNNeiPjpP7xpYbj/zX1/ja
        gbkyUTeGcPnv0ZnUX4Ax82U=
X-Google-Smtp-Source: APXvYqwOy+/rlRV+P6zztL/pjPFB4PZ7sFhSOtDuj2Ut4HRafwajNrgF2hCkV6hi5EAvwkk6rb1vxA==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr51975599plb.183.1563499977244;
        Thu, 18 Jul 2019 18:32:57 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v184sm28887711pfb.82.2019.07.18.18.32.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:32:56 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     pavel@ucw.cz
Cc:     SCheung@nvidia.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        bsingharora@gmail.com, dan.j.williams@intel.com,
        dnellans@nvidia.com, ebaskakov@nvidia.com, hannes@cmpxchg.org,
        jglisse@redhat.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        liubo95@huawei.com, mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Date:   Thu, 18 Jul 2019 18:32:53 -0700
Message-Id: <20190719013253.17642-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717074124.GA21617@amd>
References: <20190717074124.GA21617@amd>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

The HMM_MIRROR option in Kconfig is a little underdocumented and
mysterious, and leaves people wondering whether to enable it.

Add text explaining just a little bit more about HMM, and also
mention which hardware would benefit from having HMM_MIRROR
enabled.

Suggested-by: Pavel Machek <pavel@ucw.cz>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi Pavel and all, does this help? I've tried to capture the key missing bits
of documentation, but still keep it small, for Kconfig.

thanks,
John Hubbard
NVIDIA

 mm/Kconfig | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 56cec636a1fc..2fcb92e7f696 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -681,11 +681,18 @@ config HMM_MIRROR
 	depends on MMU && 64BIT
 	select MMU_NOTIFIER
 	help
-	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
-	  process into a device page table. Here, mirror means "keep synchronized".
-	  Prerequisites: the device must provide the ability to write-protect its
-	  page tables (at PAGE_SIZE granularity), and must be able to recover from
-	  the resulting potential page faults.
+	  This is Heterogeneous Memory Management (HMM) process address space
+	  mirroring.
+
+	  HMM_MIRROR provides a way to mirror ranges of the CPU page tables
+	  of a process into a device page table. Here, mirror means "keep
+	  synchronized". Prerequisites: the device must provide the ability
+	  to write-protect its page tables (at PAGE_SIZE granularity), and
+	  must be able to recover from the resulting potential page faults.
+
+	  Select HMM_MIRROR if you have hardware that meets the above
+	  description. An early, partial list of such hardware is:
+	  an NVIDIA GPU >= Pascal, Mellanox IB >= mlx5, or an AMD GPU.
 
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
-- 
2.22.0

