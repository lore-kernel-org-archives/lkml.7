Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D59C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C5C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aS2nSWkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJJW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:28:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37863 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJJW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:28:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so4561408pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ik/kSfKAQ4ZckUQirkRuCGEWrJxiH/kxb4IaqRf84E=;
        b=aS2nSWkBo2EM7xurh9e4KD3J/oEH5CMiR6qi6pemFdHozgo2Z1c7TRj96V/PkiHjw5
         FH6oKRaTNJzzH6k22JYKIFTE4RYwim+fu31Qx8OPm3DvD1SWi/W3PN1N9EnLTNV8O95r
         DXzrAuTvAi+zfUbmq8Hja0TWbbmGpPw9eXOoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ik/kSfKAQ4ZckUQirkRuCGEWrJxiH/kxb4IaqRf84E=;
        b=GoRR8Zl4NcQBdLO4TWfCCDilP9pkeA6/9u5yj9o/rhs909B4qR09weU5lMstcYviBQ
         6nzUeUbWxD1urBaGjJNx/GK5p6TcAnxAHNa0GlwboC+BhmSRZIyJ6952nCmyrMcfUErJ
         trLb9lqSBhTnN2LnDCbT1hG6bfR6YhJ4ruxkrXIOo5SHiInVv3dW79wbpQNnwUyc9EK6
         rKRVQFTrciBWvUKIqayUZj1a/ZtYZwQSSIKLNwQfh/4UG5CBTNmW4ZHm8N4iKc74TgVP
         oQEoG1pr4B3VPb4EIyZo6AnW2uLaVGnQAXIcPqKsRJACFnsVGsO1+aesttUkbhjmMbEO
         buvA==
X-Gm-Message-State: APjAAAVLnlM1dVNliil3QMw1rildDg3xT3dHGbe11FLYUQrUQQvYARv5
        /WJwSuRFUm2afRvilOGCFuieqA==
X-Google-Smtp-Source: APXvYqwiSLikkNRk0PtrKKYtoloMR4gcGK6Rx79wulZ5k/6xZ+dNXHBqNJrJBq6aMzrzeheKM691Vw==
X-Received: by 2002:a63:287:: with SMTP id 129mr13610227pgc.190.1570746518937;
        Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm7203427pfo.49.2019.10.10.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:28:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] dma-mapping: Add vmap checks to dma_map_single()
Date:   Thu, 10 Oct 2019 15:28:27 -0700
Message-Id: <20191010222829.21940-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicating patch 1 commit log:

As we've seen from USB and other areas[1], we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
adds vmap checks (similar to those already in USB but missing in other
places) into dma_map_single() so all callers benefit from the checking.

[1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb

-Kees

v3:
 - switch to dev_warn() (gregkh, hch)
 - split USB cleanup into a separate patch
v2: https://lore.kernel.org/lkml/201910041420.F6E55D29A@keescook
v1: https://lore.kernel.org/lkml/201910021341.7819A660@keescook

Kees Cook (2):
  dma-mapping: Add vmap checks to dma_map_single()
  usb: core: Remove redundant vmap checks

 drivers/usb/core/hcd.c      | 8 +-------
 include/linux/dma-mapping.h | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1
