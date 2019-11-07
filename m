Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A530CC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727121882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573137027;
	bh=nunLUUukjE7H+fygHiM0yHAgwOJt5cB9lKYVFnHbO2A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XG8ivdGCjxvNFMAAAfm5JbY85v7+mwIfR9W+LW6FkVcO0bifFpW4mBdVmYiwDDVZ0
	 XA8cILjpGjbzPDY2HoZrEYeRgYDHC0NqNGvlXUQ5kCFVSHp/+swFOqrwmxXKhqWjHc
	 XzFeliGcCEeXhOBvfwnOXz5kx6W/8kHdsICgu7Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfKGOa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKGOa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:30:26 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0FC2187F;
        Thu,  7 Nov 2019 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573137025;
        bh=nunLUUukjE7H+fygHiM0yHAgwOJt5cB9lKYVFnHbO2A=;
        h=Date:From:To:Cc:Subject:From;
        b=ygxopWXvNWBupUFfq+x0vV43LlTIWXYmOf1NY0ueGzxoPfIsBX5uSzD8OBMbcAVv3
         55D+6XneAw5b2ySi62WSvlZ1/lROxqh3btERAwqCJ8UssH2gavgbfoM4POfpcO52Cm
         oa1pCEDIYApB47JJ+9Xbqlt0YgfQBlGmPp0TqSOA=
Date:   Thu, 7 Nov 2019 14:30:20 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.5
Message-ID: <20191107143020.GA12988@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.5. The main changes are support
for the Qualcomm SMMUv2 implementation in the SDM845 SoC using the recently
introduced "implementation hook" code, a bunch of preparatory work to
expose TTBR1 via the io-pgtable code so that two (distinct) page tables
can be attached to a domain at the same time and performance improvements
relating to runtime power management on SMMUv2 during unmap() and general
dispatch of the new TLB invalidation callbacks.

The Qualcomm patches necessitated some changes to their firmware interface
code, but that has been Acked by Andy and Bjorn.

There were some conflicts with the fixes I sent you previously, so this
branch has those same commits merged in because I didn't want to rebase.

Cheers,

Will

--->8

The following changes since commit 1be08f458d1602275b02f5357ef069957058f3fd:

  iommu/io-pgtable-arm: Support all Mali configurations (2019-10-01 12:16:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to dd5ddd3c7a8c7ac382a82d15757f0ca3ab2b2dbc:

  iommu/io-pgtable-arm: Rename IOMMU_QCOM_SYS_CACHE and improve doc (2019-11-07 12:19:05 +0000)

----------------------------------------------------------------
Christophe JAILLET (2):
      iommu/io-pgtable: Move some initialization data to .init.rodata
      iommu/arm-smmu: Axe a useless test in 'arm_smmu_master_alloc_smes()'

Rob Clark (1):
      iommu/arm-smmu: Avoid pathological RPM behaviour for unmaps

Robin Murphy (12):
      iommu/arm-smmu: Remove .tlb_inv_range indirection
      iommu/arm-smmu: Remove "leaf" indirection
      iommu/arm-smmu: Move .tlb_sync method to implementation
      iommu/arm-smmu: Remove arm_smmu_flush_ops
      iommu/arm-smmu: Report USF more clearly
      iommu/io-pgtable: Make selftest gubbins consistently __init
      iommu/io-pgtable-arm: Rationalise size check
      iommu/io-pgtable-arm: Simplify bounds checks
      iommu/io-pgtable-arm: Simplify start level lookup
      iommu/io-pgtable-arm: Simplify PGD size handling
      iommu/io-pgtable-arm: Simplify level indexing
      iommu/io-pgtable-arm: Rationalise MAIR handling

Vivek Gautam (3):
      firmware: qcom_scm-64: Add atomic version of qcom_scm_call
      firmware/qcom_scm: Add scm call to handle smmu errata
      iommu: arm-smmu-impl: Add sdm845 implementation hook

Will Deacon (3):
      firmware: qcom: scm: Ensure 'a0' status code is treated as signed
      Merge branch 'for-joerg/arm-smmu/fixes' into for-joerg/arm-smmu/updates
      iommu/io-pgtable-arm: Rename IOMMU_QCOM_SYS_CACHE and improve doc

 drivers/firmware/qcom_scm-32.c     |   5 +
 drivers/firmware/qcom_scm-64.c     | 153 ++++++++++++++++++--------
 drivers/firmware/qcom_scm.c        |   6 +
 drivers/firmware/qcom_scm.h        |   5 +
 drivers/iommu/Makefile             |   2 +-
 drivers/iommu/arm-smmu-impl.c      |   5 +-
 drivers/iommu/arm-smmu-qcom.c      |  51 +++++++++
 drivers/iommu/arm-smmu-v3.c        |   2 +-
 drivers/iommu/arm-smmu.c           | 217 +++++++++++++++++++++----------------
 drivers/iommu/arm-smmu.h           |  16 +--
 drivers/iommu/io-pgtable-arm-v7s.c |  15 +--
 drivers/iommu/io-pgtable-arm.c     | 130 +++++++++++-----------
 drivers/iommu/ipmmu-vmsa.c         |   2 +-
 drivers/iommu/qcom_iommu.c         |   4 +-
 include/linux/io-pgtable.h         |   2 +-
 include/linux/iommu.h              |   8 +-
 include/linux/qcom_scm.h           |   2 +
 17 files changed, 397 insertions(+), 228 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-qcom.c
