Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83874C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530C420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="koGQ4EWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF0Xsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:48:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0Xsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:48:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNmHVm503360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:48:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNmHVm503360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679298;
        bh=r4TIRP/RJYPjwamCMfyx60Lm6LGclzml/cVv1FYCkdc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=koGQ4EWElXr82CNezO6RrQYCNEty5tocqmcXclAu+mNS8J7WQmtupmCkxxYav/0p9
         iNr5rcppUrAK7RNIpvwek6jH4aGVV4xpIhWw2XREDflzQbe223G4lz2GWbmqn7N05S
         zTLBXLjEowuYYeaKUSCD3brMV0bAnAFpGk2tIBhmfBNeNsLsL4e41WOyQHO7UAeYMr
         4DcggE/o6CPx17Th0LCaPWEfNoQiRddg9YsuTFikuDZAjqB/UWoIl5azWle3HcLaz5
         xxU3tt0r66AEVtnTeO0qOky3qwdvmFmcoMJo/HyYWfEGcF5rPsaAEYPeWjeyA73QZt
         W5ZoaNFos3ZWw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNmHk4503357;
        Thu, 27 Jun 2019 16:48:17 -0700
Date:   Thu, 27 Jun 2019 16:48:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-af5a1dadf3fcf673906af1a1129b2b7528494ee5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        Suravee.Suthikulpanit@amd.com, tglx@linutronix.de,
        ashok.raj@intel.com, mingo@kernel.org, ravi.v.shankar@intel.com,
        peterz@infradead.org, hpa@zytor.com, andi.kleen@intel.com,
        ricardo.neri-calderon@linux.intel.com
Reply-To: hpa@zytor.com, ricardo.neri-calderon@linux.intel.com,
          ashok.raj@intel.com, andi.kleen@intel.com, mingo@kernel.org,
          ravi.v.shankar@intel.com, eranian@google.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          Suravee.Suthikulpanit@amd.com, tglx@linutronix.de
In-Reply-To: <20190623132436.002758910@linutronix.de>
References: <20190623132436.002758910@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Add function to select a /dev/hpet
 channel
Git-Commit-ID: af5a1dadf3fcf673906af1a1129b2b7528494ee5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af5a1dadf3fcf673906af1a1129b2b7528494ee5
Gitweb:     https://git.kernel.org/tip/af5a1dadf3fcf673906af1a1129b2b7528494ee5
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:23 +0200

x86/hpet: Add function to select a /dev/hpet channel

If CONFIG_HPET=y is enabled the x86 specific HPET code should reserve at
least one channel for the /dev/hpet character device, so that not all
channels are absorbed for per CPU clockevent devices.

Create a function to assign HPET_MODE_DEVICE so the rework of the
clockevents allocation code can utilize the mode information instead of
reducing the number of evaluated channels by #ifdef hackery.

The function is not yet used, but provided as a separate patch for ease of
review. It will be used when the rework of the clockevent selection takes
place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.002758910@linutronix.de

---
 arch/x86/kernel/hpet.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3a8ec363d569..640ff75cc523 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -228,8 +228,25 @@ static void __init hpet_reserve_platform_timers(void)
 	hpet_alloc(&hd);
 
 }
+
+static void __init hpet_select_device_channel(void)
+{
+	int i;
+
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
+
+		/* Associate the first unused channel to /dev/hpet */
+		if (hc->mode == HPET_MODE_UNUSED) {
+			hc->mode = HPET_MODE_DEVICE;
+			return;
+		}
+	}
+}
+
 #else
 static inline void hpet_reserve_platform_timers(void) { }
+static inline void hpet_select_device_channel(void) {}
 #endif
 
 /* Common HPET functions */
