Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1B5C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA920675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfCFLFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:05:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:3696 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfCFLFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:05:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 03:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,447,1544515200"; 
   d="scan'208";a="304839004"
Received: from elena-thinkpad-x1-carbon-6th.fi.intel.com ([10.237.66.140])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2019 03:05:45 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     ebiederm@xmission.com
Cc:     serue@us.ibm.com, keescook@chromium.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 0/3] creds/cgroups/ns_proxy refcount_t conversions
Date:   Wed,  6 Mar 2019 13:05:46 +0200
Message-Id: <20190306110549.7628-1-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to reopen ages-old discussion on these conversions now.
Eric had objections against them in past, namely on not providing enough
security for reference counters (but we still argue it is better
than overflowing atomic_t and resulting use-after-free).
However now, refcount_t has been successfully used in kernel in many places,
helped to detect bugs and mistakes in logic of refcounters.
We have converted most of core kernel reference counters by now and these
3 are pretty core ones, so it would be really great to have them covered
also.

The patches are fully independent and can be cherry-picked and
discussed separately. More information about each conversion in each patch
separately.

Elena Reshetova (3):
  nsproxy: convert nsproxy.count to refcount_t
  groups: convert group_info.usage to refcount_t
  creds: convert cred.usage to refcount_t

 include/linux/cred.h    | 15 +++++++-------
 include/linux/nsproxy.h |  6 +++---
 kernel/cred.c           | 44 ++++++++++++++++++++---------------------
 kernel/groups.c         |  2 +-
 kernel/nsproxy.c        |  6 +++---
 net/sunrpc/auth.c       |  2 +-
 6 files changed, 38 insertions(+), 37 deletions(-)

-- 
2.17.1

