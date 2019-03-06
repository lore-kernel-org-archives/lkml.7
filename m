Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD19DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A2A206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfCFWN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:13:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:53535 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFWN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:13:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 14:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="149937633"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2019 14:13:28 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 0/5] Fix PF/VF dependency issues
Date:   Wed,  6 Mar 2019 14:11:13 -0800
Message-Id: <cover.1551907663.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Current implementation of ATS, PASID, PRI does not handle the PF/VF dependencies
as defined in PCIe spec r4.0. Following patches addresses this issue.

Kuppuswamy Sathyanarayanan (5):
  PCI/IOV: Add support to verify PF/VF spec compliance
  PCI/ATS: Fix PRI PF/VF dependency issues
  PCI/ATS: Fix PASID PF/VF dependency issues
  PCI/ATS: For PF/VF skip ATS initalization if spec check failed
  PCI/ATS: Fix ATS PF/VF dependency issues

 .../admin-guide/kernel-parameters.txt         |   2 +
 drivers/pci/ats.c                             | 129 ++++-
 drivers/pci/iov.c                             | 468 ++++++++++++++++++
 drivers/pci/pci.c                             |   2 +
 drivers/pci/pci.h                             |   6 +
 include/linux/pci.h                           |  33 +-
 include/uapi/linux/pci_regs.h                 |  15 +-
 7 files changed, 639 insertions(+), 16 deletions(-)

-- 
2.20.1

