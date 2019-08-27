Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B1C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1FC206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfH0BJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:09:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:5417 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfH0BJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:09:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 18:09:07 -0700
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="174388482"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 18:09:06 -0700
Subject: [PATCH v2 0/3] libnvdimm/security: Enumerate the frozen state and
 other cleanups
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Aug 2019 17:54:49 -0700
Message-ID: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
- Cleanup patch1, simplify flags return in the overwrite case and
  consolidate frozen-state cases (Jeff)
- Clarify the motivation for patch2 (Jeff)
- Collect Dave's Reviewed-by

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/023133.html

---

Jeff reported a scenario where ndctl was failing to unlock DIMMs [2].
Through the course of debug it was discovered that the security
interface on the DIMMs was in the 'frozen' state disallowing unlock, or
any security operation.  Unfortunately the kernel only showed that the
DIMMs were 'locked', not 'locked' and 'frozen'.

Introduce a new sysfs 'frozen' attribute so that ndctl can reflect the
"security-operations-allowed" state independently of the lock status.
Then, followup with cleanups related to replacing a security-state-enum
with a set of flags.
 
[2]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/022856.html

---

Dan Williams (3):
      libnvdimm/security: Introduce a 'frozen' attribute
      libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
      libnvdimm/security: Consolidate 'security' operations


 drivers/acpi/nfit/intel.c        |   59 ++++++-----
 drivers/nvdimm/bus.c             |    2 
 drivers/nvdimm/dimm_devs.c       |  134 ++++++--------------------
 drivers/nvdimm/nd-core.h         |   51 ++++------
 drivers/nvdimm/security.c        |  199 +++++++++++++++++++++++++-------------
 include/linux/libnvdimm.h        |    9 +-
 tools/testing/nvdimm/dimm_devs.c |   19 +---
 7 files changed, 226 insertions(+), 247 deletions(-)
