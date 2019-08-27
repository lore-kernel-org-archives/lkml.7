Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F5AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042A62189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfH0J01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:26:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:20370 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfH0J01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:26:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="182724428"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2019 02:26:23 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 0/1] Add option to skip using RTC
Date:   Tue, 27 Aug 2019 17:26:20 +0800
Message-Id: <cover.1566895445.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a new product which does not support RTC as persistent clock source.

Platform ops get/set wallclock are used to get/set timespec through kernel 
timekeeping read/update_persistent_clock64() routines. Presently, get/set
wallclock ops always use MC146818A RTC/CMOS device to read & set time.
This causes boot failure on our new SOC with no RTC.

Make RTC read/write optional by detecting platforms which does not support
RTC/CMOS device through the corresponding DT node status property. If status
says disabled, then noop the get/set wallclock ops.

For non DT enabled machines or for DT enabled machines which does not define
optional status property, proceed same as before.

These patches are baselined upon Linux 5.3-rc6 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core

v2:
* As per review feedback, do not hack RTC read/write functions directly. 
  Instead, override get/set wallclock ops during setup_arch init sequence.

v1:
* Detect platforms with no RTC in RTC read/write functions and skip RTC
  read/write if not applicable.

Rahul Tanwar (1):
  x86/init: Noop get/set wallclock when platform doesn't support RTC

 arch/x86/kernel/x86_init.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.11.0

