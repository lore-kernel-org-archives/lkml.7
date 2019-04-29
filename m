Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833652054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfD2IDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:03:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:59379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfD2IDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:03:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 01:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="139699412"
Received: from shbuild999.sh.intel.com ([10.239.146.112])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 01:03:28 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH 1/3] kernel/sysctl: add description for "latencytop"
Date:   Mon, 29 Apr 2019 16:03:29 +0800
Message-Id: <1556525011-28022-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The body of description is mostly copied from comments in
kernel/latencytop.c

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 Documentation/sysctl/kernel.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index c0527d8..080ef66 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -43,6 +43,7 @@ show up in /proc/sys/kernel:
 - hyperv_record_panic_msg
 - kexec_load_disabled
 - kptr_restrict
+- latencytop
 - l2cr                        [ PPC only ]
 - modprobe                    ==> Documentation/debugging-modules.txt
 - modules_disabled
@@ -437,6 +438,23 @@ When kptr_restrict is set to (2), kernel pointers printed using
 
 ==============================================================
 
+latencytop:
+
+This value controls whether to start collecting kernel latency
+data, it is off (0) by default, and could be switched on (1).
+The latency talked here is not the 'traditional' interrupt
+latency (which is primarily caused by something else consuming CPU),
+but instead, it is the latency an application encounters because
+the kernel sleeps on its behalf for various reasons.
+
+The info is exported via /proc/latency_stats and /proc/<pid>/latency.
+
+This file shows up only if CONFIG_LATENCYTOP is enabled, and please
+be noted that turning it on may bring notable sytstem overhead when
+there are massive scheduling in system.
+
+==============================================================
+
 l2cr: (PPC only)
 
 This flag controls the L2 cache of G3 processor boards. If
-- 
2.7.4

