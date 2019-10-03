Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39831C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A14E207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfJCOIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:08:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:64806 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbfJCOIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:08:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 07:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="191275044"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 03 Oct 2019 07:08:29 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 03 Oct 2019 17:08:28 +0300
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH] cpufreq: Fix RCU reboot regression on x86 PIC machines
Date:   Thu,  3 Oct 2019 17:08:28 +0300
Message-Id: <20191003140828.14801-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Since 4.20-rc1 my PIC machines no longer reboot/shutdown.
I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
API in terms of RCU for Tree RCU PREEMPT builds").

I traced the hang into
-> cpufreq_suspend()
 -> cpufreq_stop_governor()
  -> cpufreq_dbs_governor_stop()
   -> gov_clear_update_util()
    -> synchronize_sched()
     -> synchronize_rcu()

Only PREEMPT=y is affected for obvious reasons. The problem
is limited to PIC machines since they mask off interrupts
in i8259A_shutdown() (syscore_ops.shutdown() registered
from device_initcall()).

I reported this long ago but no better fix has surfaced,
hence sending out my initial workaround which I've been
carrying around ever since. I just move cpufreq_core_init()
to late_initcall() so the syscore_ops get registered in the
oppsite order and thus the .shutdown() hooks get executed
in the opposite order as well. Not 100% convinced this is
safe (especially moving the cpufreq_global_kobject creation
to late_initcall()) but I've not had any problems with it
at least.

Here's the resulting change in initcall_debug:
+ PM: Calling cpufreq_suspend+0x0/0x100
  PM: Calling mce_syscore_shutdown+0x0/0x10
  PM: Calling i8259A_shutdown+0x0/0x10
- PM: Calling cpufreq_suspend+0x0/0x100
+ reboot: Restarting system
+ reboot: machine restart

Cc: stable@vger.kernel.org
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Fixes: 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c52d6fa32aac..6a8fb9b08e33 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2761,4 +2761,4 @@ static int __init cpufreq_core_init(void)
 	return 0;
 }
 module_param(off, int, 0444);
-core_initcall(cpufreq_core_init);
+late_initcall(cpufreq_core_init);
-- 
2.21.0

