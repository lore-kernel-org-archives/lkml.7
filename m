Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B564C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AF12175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4pWEaoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfEXEIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:08:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38741 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEXEID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:08:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so4278683pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s74YDk11h63m3BV7XOfnkCuG6v9uaJVVe9rNVON22hw=;
        b=d4pWEaoDp8VDALdkCMCsdpaApDEtbf5qlmNVmtFaBu1dLqdJeDQAeAOVmLHxFoOH2T
         0KPvaAWTEKyeMBhm+4UC/dQvOjY/nwyM/qO/nbiRmBo9pAvmEWRw/GbN6v2yEXKE6Uif
         1IVZz6BJJxpjuO+gvH0PYvuK5AFQh4McrEeM76gok5/33Q0ciesPflsroAVXZ5CsyzON
         H9/F8sXGiqPEYQIxTFKTAnibA8qNWGGUiMepgWhsAhmj72HmkGQ6ip5T7JMixrDb59Q5
         1AG8HJWjKIuoZaWZHwFRH4weX2//KEgT50ICzsbyxb+ZFJk+oWktK+KDA2/H+LGKg1UJ
         zN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s74YDk11h63m3BV7XOfnkCuG6v9uaJVVe9rNVON22hw=;
        b=b6OJbwa+VfYQ32XpSjJ+X3+rGT9bAF1wpff1IK0hN+65A3Wr6hqpF9LlAXJ3q96U54
         1uFcubNdcNcW6g/QqVwBPzbEEdGu9B/uYGkYvNTzuB2Vk8XNGPRuuI+ytxAsaZcLTVvX
         XAJ86Qu0eXuHOqEgMbClYbJ5xg5pM53Ie+gbYyFNJ429PokWBltjHDuWChC6kKNpW25v
         zcyaTPO8V+d3xrbzGB00FpbW8DMDBm/VWaQ5N1EZ9PoBxE/oxYpG6ZFaOoaNU97G50a5
         qDuPUWOSzJ/NTR6A01AEI6fOSeUbATrbl19KRGXucR/AvTa7kSHk0mZ75SwELjDSl1+1
         /1ug==
X-Gm-Message-State: APjAAAXGCDCN7mQ+Lq/vjMoM7YzrWFFZk56MVkXtUEf5SjVibxB6Eakv
        frUZiky+1kUhabX/+mA/nWI=
X-Google-Smtp-Source: APXvYqz7SgXlmeiaXSvQX7Xs4PBLb1OsSy441YSgpyHE/mSRMUQEJbvKztTfbmY/Z7v8FcGOYR8dGA==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr18456270pfi.135.1558670882701;
        Thu, 23 May 2019 21:08:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e123sm786412pgc.29.2019.05.23.21.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 21:08:02 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: [PATCH v3 0/2] Optimize dma_*_from_contiguous calls
Date:   Thu, 23 May 2019 21:06:31 -0700
Message-Id: <20190524040633.16854-1-nicoleotsuka@gmail.com>
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

 include/linux/dma-contiguous.h | 11 +++++++
 kernel/dma/contiguous.c        | 57 ++++++++++++++++++++++++++++++++++
 kernel/dma/direct.c            | 24 +++-----------
 3 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.17.1

