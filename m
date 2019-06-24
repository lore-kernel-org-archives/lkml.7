Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26ADC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82A522CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cB3nYOt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFXBkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:40:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfFXBkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5O03xuD2861908
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 17:03:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5O03xuD2861908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334640;
        bh=G6Rcj19LN8Eah6UVwz0SmpTcT/imHv19chiL/vGryN4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cB3nYOt3O/B8xn7hNsmxgh0+SBb79HHSsWJodsImWN7k7ubkZhbd7ejEF0EEcIvQP
         Du10KdSg+1tK9w1abh8uU6WF9FN8ydgpvhhMmdJvWYSVBfxuocxPsvR3vMdVnA2HL6
         blI0Z9XgQU1ijW7eoa7jod1Vx0HOcdQdzOKif5wotwKERAWxVvlXoN9ZayOqmTbv8I
         B8yZOa94mLSkxeDRlWK4tmvUagOzBxx9C6rzFx7Hc7U4z8yqT967jmEaTmFi8GchqM
         58G4qFVYx0ncUwY1h35IvC4giRHlcA7sGG2EijMmb811VkW8nJo3IIul9mIYM/GSpe
         b2b15W8JS0MIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5O03wC72861905;
        Sun, 23 Jun 2019 17:03:58 -0700
Date:   Sun, 23 Jun 2019 17:03:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-203dffacf592317e54480704f569a09f8b7ca380@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, bp@alien8.de,
        peterz@infradead.org, ravi.v.shankar@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, tglx@linutronix.de,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org, luto@kernel.org
Reply-To: peterz@infradead.org, tony.luck@intel.com, tglx@linutronix.de,
          ashok.raj@intel.com, ravi.v.shankar@intel.com, mingo@kernel.org,
          hpa@zytor.com, bp@alien8.de, luto@kernel.org,
          linux-kernel@vger.kernel.org, fenghua.yu@intel.com
In-Reply-To: <1560994438-235698-6-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-6-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] Documentation/ABI: Document umwait control sysfs
 interfaces
Git-Commit-ID: 203dffacf592317e54480704f569a09f8b7ca380
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

Commit-ID:  203dffacf592317e54480704f569a09f8b7ca380
Gitweb:     https://git.kernel.org/tip/203dffacf592317e54480704f569a09f8b7ca380
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 19 Jun 2019 18:33:58 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 24 Jun 2019 01:44:35 +0200

Documentation/ABI: Document umwait control sysfs interfaces

Since two new sysfs interface files are created for umwait control, add
an ABI document entry for the files:

   /sys/devices/system/cpu/umwait_control/enable_c02
   /sys/devices/system/cpu/umwait_control/max_time

[ tglx: Made the write value instructions readable ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: "Borislav Petkov" <bp@alien8.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Andy Lutomirski" <luto@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/1560994438-235698-6-git-send-email-fenghua.yu@intel.com
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1528239f69b2..923fe2001472 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -538,3 +538,26 @@ Description:	Intel Energy and Performance Bias Hint (EPB)
 
 		This attribute is present for all online CPUs supporting the
 		Intel EPB feature.
+
+What:		/sys/devices/system/cpu/umwait_control
+		/sys/devices/system/cpu/umwait_control/enable_c02
+		/sys/devices/system/cpu/umwait_control/max_time
+Date:		May 2019
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Umwait control
+
+		enable_c02: Read/write interface to control umwait C0.2 state
+			Read returns C0.2 state status:
+				0: C0.2 is disabled
+				1: C0.2 is enabled
+
+			Write 'y' or '1'  or 'on' to enable C0.2 state.
+			Write 'n' or '0'  or 'off' to disable C0.2 state.
+
+			The interface is case insensitive.
+
+		max_time: Read/write interface to control umwait maximum time
+			  in TSC-quanta that the CPU can reside in either C0.1
+			  or C0.2 state. The time is an unsigned 32-bit number.
+			  Note that a value of zero means there is no limit.
+			  Low order two bits must be zero.
