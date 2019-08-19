Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1CAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298962085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfHSNXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:23:00 -0400
Received: from 8bytes.org ([81.169.241.247]:50272 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSNXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:23:00 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D15E3309; Mon, 19 Aug 2019 15:22:58 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 00/11 v3] Cleanup IOMMU passthrough setting (and disable IOMMU Passthrough when SME is active)
Date:   Mon, 19 Aug 2019 15:22:45 +0200
Message-Id: <20190819132256.14436-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

This patch-set started out small to overwrite the default passthrough
setting (through CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y) when SME is active.

But on the way to that Tom reminded me that the current ways to
configure passthrough/no-passthrough modes for IOMMU on x86 is a mess.
So I added a few more patches to clean that up a bit, getting rid of the
iommu_pass_through variable on the way.This information is now kept only
in iommu code, with helpers to change that setting from architecture
code.

And of course this patch-set still disables IOMMU Passthrough mode when
SME is active even when CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y is set.

The reason for that change is that SME with passthrough mode turned out
to be fragile with devices requiring SWIOTLB, mainly because SWIOTLB has
a maximum allocation size of 256kb and a limit overall size of the
bounce buffer.

Therefore having IOMMU in translation mode by default is better when SME
is active on a system.

Please review.

Thanks,

	Joerg

Changes since v2:

	- Added 'bool cmd_line' parameter to iommu_set_default_*()
	  functions, so that we correctly recognize iommu=pt/nopt
	  command line parameters

Changes since v1:

	- Cleaned up the kernel command line parameters to
	  configure passthrough/translated mode, getting rid
	  of the global iommu_pass_through variable

Joerg Roedel (11):
  iommu: Remember when default domain type was set on kernel command line
  iommu: Add helpers to set/get default domain type
  iommu: Use Functions to set default domain type in iommu_set_def_domain_type()
  iommu/amd: Request passthrough mode from IOMMU core
  iommu/vt-d: Request passthrough mode from IOMMU core
  x86/dma: Get rid of iommu_pass_through
  ia64: Get rid of iommu_pass_through
  iommu: Print default domain type on boot
  iommu: Set default domain type at runtime
  iommu: Disable passthrough mode when SME is active
  Documentation: Update Documentation for iommu.passthrough

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/ia64/include/asm/iommu.h                   |  2 -
 arch/ia64/kernel/pci-dma.c                      |  2 -
 arch/x86/include/asm/iommu.h                    |  1 -
 arch/x86/kernel/pci-dma.c                       | 20 +-----
 drivers/iommu/amd_iommu.c                       |  6 +-
 drivers/iommu/intel-iommu.c                     |  2 +-
 drivers/iommu/iommu.c                           | 93 +++++++++++++++++++++++--
 include/linux/iommu.h                           | 16 +++++
 9 files changed, 110 insertions(+), 34 deletions(-)

-- 
2.16.4

