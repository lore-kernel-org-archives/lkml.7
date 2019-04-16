Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DABDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2511C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WafkOIoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfDPRKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:10:31 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:46250 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:10:31 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5181024E0F60;
        Tue, 16 Apr 2019 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555434631; bh=JdXfGPr2sCTuPyMbyMXnxhO+/WvPG/lSXHGegYPnxXM=;
        h=From:To:Cc:Subject:Date:From;
        b=WafkOIoZIaEy9kHrvIGXMvsHiNTVrhcavw6Bs8Ox09J/YOVOMS+rJBSoroimGLc6n
         wO2xXDImePKPwUUuNFdmVhWT7ZPc/kA7V1YEPF/vGK8B5xZsuTXDEtSRgyY6h1nz6b
         Lp5M07519+kC1AYMaya8CxJ7XBAD73Z/XxXCIPfE9VnIYlVhiUV92NmOZqyyYNJGZm
         lWc+oY37EygfHRM4+swc0sFp4LattwSx/+XzRqMRAFcCYRiJzjEWZEc0vvL7cdVY8m
         PZ97E/pX0OWt2p4AXP5sNv3+LRdXvHlLdctaspqMhHvvOTH4Jsjo8+FkUBFMFLbe8l
         jX9SiLEtzQC6A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id E2C2CA023C;
        Tue, 16 Apr 2019 17:10:24 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 0/3] ARC: cache: allow to autodetect L1 cache line size
Date:   Tue, 16 Apr 2019 20:10:18 +0300
Message-Id: <20190416171021.20049-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to autodetect L1 I/D caches line size in runtime instead of
relying on value provided via kconfig.

This patch series is inspired by https://gitsnps.internal.synopsys.com/
arc_oss/linux/commit/c229c6e2e7a62269e2929943ccda2b04149e5b27
however has the following improvements:
 * we don't touch any generic code, so it's easier to upstream it.
 * autodetection can be disabled via kconfig.
 * changes are rebased on latest kernel version.

Eugeniy Paltsev (3):
  ARC: cache: declare cache-related defines via ARC_MAX_CACHE_SHIFT
  ARC: cache: check cache configuration on each CPU
  ARC: cache: allow to autodetect L1 cache line size

 arch/arc/Kconfig             |  10 +++
 arch/arc/include/asm/cache.h |  20 ++++--
 arch/arc/lib/memset-archs.S  |   8 ++-
 arch/arc/mm/cache.c          | 147 ++++++++++++++++++++++++++++++++-----------
 4 files changed, 141 insertions(+), 44 deletions(-)

-- 
2.14.5

