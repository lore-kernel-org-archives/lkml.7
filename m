Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FAAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085AB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfJJJ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:29:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:21633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfJJJ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:29:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 02:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="197189672"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2019 02:29:19 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 0/1] x86/init: Add option to skip using RTC
Date:   Thu, 10 Oct 2019 17:28:55 +0800
Message-Id: <cover.1570693058.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a new Atom Airmont core based product which does not support
RTC as persistent clock source.

Presently, platform ops get/set wallclock always use MC146818 RTC/CMOS
device to read & set time. This causes boot failure on our SOC with no
RTC. More specifically, it hangs in RTC driver's mach_get_cmos_time() 
when it polls RTC_FRQ_SELECT register and loops until Update-In-Progress
(UIP) flag gets cleared i.e. below code snippet.

 	while ((CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
		cpu_relax();

After few rounds of review cycles/feedback, we concluded that we should
control it from Motorola MC146818 compatible RTC devicetree node.
Please see [1].

Make RTC read/write optional by detecting platforms which does not
support RTC/CMOS device through the corresponding DT node status
property. If status says disabled, then noop the get/set wallclock
ops.

For non DT enabled platforms or for DT enabled platforms which does
not define optional status property, proceed same as before.

Patch is baselined upon Linux 5.4-rc2 at below Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core

[1] Documentation/devicetree/bindings/rtc/rtc-cmos.txt

v3:
* Rebase to latest 5.4-rc2 kernel.
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

