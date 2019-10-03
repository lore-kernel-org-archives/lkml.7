Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2AAC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2055F20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfJCLY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:24:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:11552 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbfJCLY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:24:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 04:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="205595674"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.161])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2019 04:24:26 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-stable@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
Date:   Thu,  3 Oct 2019 14:24:21 +0300
Message-Id: <20191003112424.9036-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream

This backport is for v4.14 and v4.19 The backport requires non-racy
behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
are included.

NOTE: 1/3 is only needed for v4.14.

v2:
* Something happened when merging 3/3 that write lock was taken
  twice. Fixed in this version. Did also sanity check test with
  TPM2:
  echo devices > /sys/power/pm_test && echo mem > /sys/power/state

Jarkko Sakkinen (2):
  tpm: migrate pubek_show to struct tpm_buf
  tpm: use tpm_try_get_ops() in tpm-sysfs.c.

Vadim Sukhomlinov (1):
  tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations

 drivers/char/tpm/tpm-chip.c  |   5 +-
 drivers/char/tpm/tpm-sysfs.c | 201 +++++++++++++++++++++--------------
 drivers/char/tpm/tpm.h       |  13 ---
 3 files changed, 124 insertions(+), 95 deletions(-)

-- 
2.20.1

