Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A1A21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfCOPuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:50:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:34804 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfCOPuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:50:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 08:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="125769204"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2019 08:50:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h4p6A-0008UY-GN; Fri, 15 Mar 2019 23:50:18 +0800
Date:   Fri, 15 Mar 2019 23:49:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/dwc/pcie-designware.c:309:52: sparse: cast
 truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)
Message-ID: <201903152355.U5zD497n%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f261c4e529dac5608a604d3dd3ae1cd2adf23c89
commit: 0e11faa48b07a063289d65363015a3d51ca4c337 PCI: dwc: Make use of BIT() in constant definitions
date:   2 weeks ago
reproduce:
        # apt-get install sparse
        git checkout 0e11faa48b07a063289d65363015a3d51ca4c337
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/controller/dwc/pcie-designware.c:309:52: sparse: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)

vim +309 drivers/pci/controller/dwc/pcie-designware.c

   291	
   292	void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
   293				 enum dw_pcie_region_type type)
   294	{
   295		int region;
   296	
   297		switch (type) {
   298		case DW_PCIE_REGION_INBOUND:
   299			region = PCIE_ATU_REGION_INBOUND;
   300			break;
   301		case DW_PCIE_REGION_OUTBOUND:
   302			region = PCIE_ATU_REGION_OUTBOUND;
   303			break;
   304		default:
   305			return;
   306		}
   307	
   308		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
 > 309		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
   310	}
   311	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
