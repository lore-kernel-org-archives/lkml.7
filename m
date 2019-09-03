Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E408C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4F422DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfICGRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:17:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:30236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfICGRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:17:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 23:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="357638241"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2019 23:17:39 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 0/1] Add option to skip using RTC
Date:   Tue,  3 Sep 2019 14:17:36 +0800
Message-Id: <cover.1567484279.git.rahul.tanwar@linux.intel.com>
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

v3:
* Fix a build warning reported by kbuild test robot.

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

