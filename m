Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5013C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F4C21670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfIDW5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:57:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:16403 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDW5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:57:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 15:57:49 -0700
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="177109951"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 15:57:48 -0700
Subject: [PATCH v4] libnvdimm: Enable unit test infrastructure compile checks
From:   Dan Williams <dan.j.williams@intel.com>
To:     jgg@ziepe.ca
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 15:43:31 -0700
Message-ID: <156763690875.2556198.15786177395425033830.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infrastructure to mock core libnvdimm routines for unit testing
purposes is prone to bitrot relative to refactoring of that core.
Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
This does not result in a functional unit test environment, it is only a
helper for 0day to catch unit test build regressions.

Note that there are a few x86isms in the implementation, so this does
not bother compile testing this architectures other than 64-bit x86.

Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com
---
Changes since v3:

- Switch the Makefile operator from := to += to make sure the unit test
  infrastructure is incrementally included.

Jason, lets try this again. This seems to resolve the build error for
me. I believe ":=" would have intermittent results in a parallel build
and sometimes result in other targets in drivers/nvdimm/Makefile being
bypassed. This has been exposed to the 0day robot for a day with no
reports.


 drivers/nvdimm/Kconfig  |   12 ++++++++++++
 drivers/nvdimm/Makefile |    4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index a5fde15e91d3..36af7af6b7cf 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -118,4 +118,16 @@ config NVDIMM_KEYS
 	depends on ENCRYPTED_KEYS
 	depends on (LIBNVDIMM=ENCRYPTED_KEYS) || LIBNVDIMM=m
 
+config NVDIMM_TEST_BUILD
+	tristate "Build the unit test core"
+	depends on m
+	depends on COMPILE_TEST && X86_64
+	default m if COMPILE_TEST
+	help
+	  Build the core of the unit test infrastructure. The result of
+	  this build is non-functional for unit test execution, but it
+	  otherwise helps catch build errors induced by changes to the
+	  core devm_memremap_pages() implementation and other
+	  infrastructure.
+
 endif
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index cefe233e0b52..29203f3d3069 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -29,3 +29,7 @@ libnvdimm-$(CONFIG_BTT) += btt_devs.o
 libnvdimm-$(CONFIG_NVDIMM_PFN) += pfn_devs.o
 libnvdimm-$(CONFIG_NVDIMM_DAX) += dax_devs.o
 libnvdimm-$(CONFIG_NVDIMM_KEYS) += security.o
+
+TOOLS := ../../tools
+TEST_SRC := $(TOOLS)/testing/nvdimm/test
+obj-$(CONFIG_NVDIMM_TEST_BUILD) += $(TEST_SRC)/iomap.o

