Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1DEC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCFB21A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570021984;
	bh=3e4qjCD59H59r+JQxF+7cnk3Ugzw2q1azgwC+2Vshl0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=f4IK8IinNIxp6AsKlcYcLPw+BS+gL1/egXsS4YaGE2f2FXz1vxiSM/wK0tRHp83yM
	 vRWEpuN5OsJ2T3k/sZbhBwlwjal8vI/31sbkwL7XR+uQDoC6U4mPTw8r5PIHnmn8zi
	 cUQD/ymVr7v1TOs93zbDDTUDqolqdy2aFQ0EORdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfJBNND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfJBNND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:13:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A5421920;
        Wed,  2 Oct 2019 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570021982;
        bh=3e4qjCD59H59r+JQxF+7cnk3Ugzw2q1azgwC+2Vshl0=;
        h=Date:From:To:Cc:Subject:From;
        b=a/Lp9Dn88fyyGRkxwEghkROxDPyppdGB9hjgASPc9EA9nzyvZnjCI4VZ3Dw8i5ybn
         c1Aw85yc4ay9Ncc/TLwJH0nbmFMH33z4g0BVMpMEpmB+AYUbgEO7nIWTcQcAH3vaNW
         lnGJgfDoF6qfGj8305AFPbSPAYwhHDZrpAiKKXFw=
Date:   Wed, 2 Oct 2019 14:12:59 +0100
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 5.4-rc2
Message-ID: <20191002131258.ne5r6clp7hq6lxmx@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please can you pull these three arm-smmu fixes for -rc2? They fix a
missing resource free on an error path and some page-table issues with
MALI GPUs including broken cacheability attributes and malformed tree
structure with smaller virtual address ranges.

Thanks,

Will

--->8

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 1be08f458d1602275b02f5357ef069957058f3fd:

  iommu/io-pgtable-arm: Support all Mali configurations (2019-10-01 12:16:47 +0100)

----------------------------------------------------------------
Liu Xiang (1):
      iommu/arm-smmu: Free context bitmap in the err path of arm_smmu_init_domain_context

Robin Murphy (2):
      iommu/io-pgtable-arm: Correct Mali attributes
      iommu/io-pgtable-arm: Support all Mali configurations

 drivers/iommu/arm-smmu.c       |  1 +
 drivers/iommu/io-pgtable-arm.c | 58 ++++++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 13 deletions(-)
