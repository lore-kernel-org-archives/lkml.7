Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72585C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B53021721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfFSTjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:39:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:43722 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfFSTjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:39:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 12:39:05 -0700
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="162306711"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 12:39:05 -0700
Subject: [PATCH v2] libnvdimm: Enable unit test infrastructure compile checks
From:   Dan Williams <dan.j.williams@intel.com>
To:     hch@lst.de
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 12:24:48 -0700
Message-ID: <156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com>
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
---
Changes since v1:
- 0day reports this fails to compile on !x86 which is not surprising.
  Just disable non-x86 builds.

 drivers/nvdimm/Kconfig  |   11 +++++++++++
 drivers/nvdimm/Makefile |    4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 54500798f23a..f6623e807fb2 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -118,4 +118,15 @@ config NVDIMM_KEYS
 	depends on ENCRYPTED_KEYS
 	depends on (LIBNVDIMM=ENCRYPTED_KEYS) || LIBNVDIMM=m
 
+config NVDIMM_TEST_BUILD
+	bool "Build the unit test core"
+	depends on COMPILE_TEST && X86_64
+	default COMPILE_TEST
+	help
+	  Build the core of the unit test infrastructure.  The result of
+	  this build is non-functional for unit test execution, but it
+	  otherwise helps catch build errors induced by changes to the
+	  core devm_memremap_pages() implementation and other
+	  infrastructure.
+
 endif
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 6f2a088afad6..40080c120363 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -28,3 +28,7 @@ libnvdimm-$(CONFIG_BTT) += btt_devs.o
 libnvdimm-$(CONFIG_NVDIMM_PFN) += pfn_devs.o
 libnvdimm-$(CONFIG_NVDIMM_DAX) += dax_devs.o
 libnvdimm-$(CONFIG_NVDIMM_KEYS) += security.o
+
+TOOLS := ../../tools
+TEST_SRC := $(TOOLS)/testing/nvdimm/test
+obj-$(CONFIG_NVDIMM_TEST_BUILD) := $(TEST_SRC)/iomap.o

