Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C104BC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93117206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uB8dffVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEFWfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:35:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44357 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:35:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so7503091pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MVtT3kQLs0YjL3YNGwUnTq2ZujgVqV6tZnKeBQ8kJfI=;
        b=uB8dffVJJW5NeI5rCGx3da6F4jQci4VTRz22kuwU4hi3unN6J9ULTlXATxqPum8Jpl
         bcbHoKGoYjsfClP5H6tLnMuRkPmQNUh+Yt4guhdrAvCRbzDMLT7ipAON5hWEBOwf7c5l
         T7c77DumktpTdf27dGyjUSwYN4jYakEhYUUV7I3kwQBXTv5DKcZRCvHR4BhQfxAzjLM3
         gR7nB8FZxHhp/YPbpfOBOcRfygWN1f55At0QE5FNWu/C4qcdcr3V/BE/4VkpxrTco01X
         4Zb+m1OyUCI1SLp+Cy+zJdnRRkDEY7fvi5diOXauqjqZCbSEw03lwMlTgupBKspsdMdh
         nXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MVtT3kQLs0YjL3YNGwUnTq2ZujgVqV6tZnKeBQ8kJfI=;
        b=arCUmdV+j5LYO93UMtlCT4jJdpUL5ecPJK2Q7kARWpWJCuEB4gI8jOm7zyRI/VRJuq
         vI99y/64Gl4BUDsA9ARozs1/IFIOQY51+g34jjQxU5VsiseiT8PegL1Us6UAl380jUVU
         dGbUy+ZFyxF1m6RS0h15fjt9FdoHsJz99+Jnii/b6fGmwKyMx35Jlxdbux1/OmAlWb3Y
         5UAgMtsoV4VyoVQsNMDSSwKDrmf16kyEfbKoP7GweZraB4NNhtkP8PrWBt+jn9aTg3Tx
         q8agIadF3+T5LfcHaMhOum/6lliBPqHJpP9letfdRQFxJlBwO+nl4rAbb+r5Jbp3inrN
         r77A==
X-Gm-Message-State: APjAAAUWOUQbCxQRnOS5g980ke/KW/aC4aqc8YnHOSqWKurm3azcZZz4
        /7TlPzzxRcxCGXkLEc90XeA=
X-Google-Smtp-Source: APXvYqzdcCq3Dtjv+AmVg2+uqx+O48/4UFPG2DQ1TKHu/jB/+4fF04UNjl+KcQMkCu4W3YsBF5BhbA==
X-Received: by 2002:a63:3dcf:: with SMTP id k198mr16016305pga.60.1557182114439;
        Mon, 06 May 2019 15:35:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c19sm14254976pgi.42.2019.05.06.15.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:35:13 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/2] Optimize dma_*_from_contiguous calls
Date:   Mon,  6 May 2019 15:33:32 -0700
Message-Id: <20190506223334.1834-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Per discussion at v1, we decide to add two new functions and start
  replacing callers one by one. For this series, it only touches the
  dma-direct part. And instead of merging two PATCHes, I still keep
  them separate so that we may easily revert PATCH-2 if anything bad
  happens as last time -- PATCH-1 is supposed to be a safe cleanup. ]

This series of patches try to optimize dma_*_from_contiguous calls:
PATCH-1 abstracts two new functions and applies to dma-direct.c file.
PATCH-2 saves single pages and reduce fragmentations from CMA area.

Please check their commit messages for detail changelog.

Nicolin Chen (2):
  dma-contiguous: Abstract dma_{alloc,free}_contiguous()
  dma-contiguous: Use fallback alloc_pages for single pages

 include/linux/dma-contiguous.h | 10 ++++++
 kernel/dma/contiguous.c        | 57 ++++++++++++++++++++++++++++++++++
 kernel/dma/direct.c            | 24 +++-----------
 3 files changed, 71 insertions(+), 20 deletions(-)

-- 
2.17.1

