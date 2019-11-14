Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE9B20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNGmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:42:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:58046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNGmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:42:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 22:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="216645415"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2019 22:42:06 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>, stable@vger.kernel.org
Subject: [GIT PULL 1/2] stm class: Lose the protocol driver when dropping its reference
Date:   Thu, 14 Nov 2019 08:42:00 +0200
Message-Id: <20191114064201.43089-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
References: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c7fd62bc69d02 ("stm class: Introduce framing protocol drivers")
forgot to tear down the link between an stm device and its protocol
driver when policy is removed. This leads to an invalid pointer reference
if one tries to write to an stm device after the policy has been removed
and the protocol driver module unloaded, leading to the below splat:

> BUG: unable to handle page fault for address: ffffffffc0737068
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 3d780f067 P4D 3d780f067 PUD 3d7811067 PMD 492781067 PTE 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 1 PID: 26122 Comm: cat Not tainted 5.4.0-rc5+ #1
> RIP: 0010:stm_output_free+0x40/0xc0 [stm_core]
> Call Trace:
>  stm_char_release+0x3e/0x70 [stm_core]
>  __fput+0xc6/0x260
>  ____fput+0xe/0x10
>  task_work_run+0x9d/0xc0
>  exit_to_usermode_loop+0x103/0x110
>  do_syscall_64+0x19d/0x1e0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by tearing down the link from an stm device to its protocol
driver when the policy involving that driver is removed.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: c7fd62bc69d02 ("stm class: Introduce framing protocol drivers")
Reported-by: Ammy Yi <ammy.yi@intel.com>
Tested-by: Ammy Yi <ammy.yi@intel.com>
CC: stable@vger.kernel.org # v4.20+
---
 drivers/hwtracing/stm/policy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 4b9e44b227d8..4f932a419752 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -345,7 +345,11 @@ void stp_policy_unbind(struct stp_policy *policy)
 	stm->policy = NULL;
 	policy->stm = NULL;
 
+	/*
+	 * Drop the reference on the protocol driver and lose the link.
+	 */
 	stm_put_protocol(stm->pdrv);
+	stm->pdrv = NULL;
 	stm_put_device(stm);
 }
 
-- 
2.24.0

