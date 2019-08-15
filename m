Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C4C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C32084F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 01:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfHOBec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 21:34:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:19739 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfHOBeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 21:34:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 18:34:30 -0700
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="352096850"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 18:34:30 -0700
Subject: [PATCH 0/3] libnvdimm/security: Enumerate the frozen state and
 other cleanups
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Aug 2019 18:20:13 -0700
Message-ID: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff reported a scenario where ndctl was failing to unlock DIMMs [1].
Through the course of debug it was discovered that the security
interface on the DIMMs was in the 'frozen' state disallowing unlock, or
any security operation.  Unfortunately the kernel only showed that the
DIMMs were 'locked', not 'locked' and 'frozen'.

Introduce a new sysfs 'frozen' attribute so that ndctl can reflect the
"security-operations-allowed" state independently of the lock status.
Then, followup with cleanups related to replacing a security-state-enum
with a set of flags.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/022856.html
---

Dan Williams (3):
      libnvdimm/security: Introduce a 'frozen' attribute
      libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
      libnvdimm/security: Consolidate 'security' operations


 drivers/acpi/nfit/intel.c        |   65 +++++++-----
 drivers/nvdimm/bus.c             |    2 
 drivers/nvdimm/dimm_devs.c       |  134 ++++++--------------------
 drivers/nvdimm/nd-core.h         |   51 ++++------
 drivers/nvdimm/security.c        |  199 +++++++++++++++++++++++++-------------
 include/linux/libnvdimm.h        |    9 +-
 tools/testing/nvdimm/dimm_devs.c |   19 +---
 7 files changed, 231 insertions(+), 248 deletions(-)
