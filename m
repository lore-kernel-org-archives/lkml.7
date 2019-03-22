Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE41C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59E42190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfCVQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfCVQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:18:40 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mw9Hm-1gosZt2rSu-00s8H8; Fri, 22 Mar 2019 17:18:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jules Maselbas <jules.maselbas@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Dietmar Eggermann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Stephen Kyle <stephen.kyle@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, nd@arm.com,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [BACKPORT 4.14.y 6/8] sched/cpufreq/schedutil: Fix error path mutex unlock
Date:   Fri, 22 Mar 2019 17:17:21 +0100
Message-Id: <20190322161727.1153278-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MXmycvD1CtaPZk6JuDv4SojVbiweK06JIhz6y2x882YX36mi0DM
 jbWkydyoobkg+9z0Zc9Gy3DjX9YKXIHqqoPZh5mg508pXHXhGfsnl3ltLgbRic/ddfYZX6T
 LCEQSKTRZKaiZfLjsDhFWC59O0Xt5EFTZ0cjXan43UPZsQ2whGuvO/Z49yQCqoMeNcP4EfV
 CveReTpzT4oshyzdGPZmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Lwf+QVPKuE=:4vgzKyqxEq7hRMJ9UyPWm5
 UCq/pC1jputQqbYgzbaDOa9ZBx7vDAH2eakVJcA2UdyqqRWV1gjVWtH8eK/HlNWXs/TW1cfjH
 xdvbN2nnTjTSbsWebK+Vy5BCLdARp5Z9G6nnz2wmt7r6dGTu/OXfHyXj7XxLbzskOAhd+34X3
 DdA/oIQKiIVZdZv/Ak0I1xT6p0xmto5j3uxxffY/PA5gsy3elESlSRV0T6fzJsdUIHQQoa8zl
 +X5O2K5nvfSgVd+49idZug+2ymzi+5G1UVi8Q8bWCiwpuExhxwQph41LaHzMEMv/NZ3+usVHJ
 4du+7RbuwxwhZlaGH94I+ZYD+Eyph0kxGGyJeX+wcaIMfcSptbnRjHHnTrtzhCa73wZKswjS4
 CvchHpxk5xoldgSY8LRO81x8iS3kg63YliIH9WXDQhAaiPVUHz0oYR3toID5UKLFfm/eAG8EC
 /oFFux0WZENd+i/rM3xOV2JZ26lHZ51sHr9RZCogRrV+ZI4kYKb56pIYEUQ5pS+sbcBrb/nTV
 yY3FW4VV+/NWSA/srg/+vCEyRBUyicSmfMn8G1vO6GgNRlNDZYyNuWFXX70stvDG4w6Jib8b0
 5S4Wn6AzS8BMsloz5idKtSXTROc9A4KGgUXonqF1w/t3lwMFs0HSUhAgNByUv5Rh8I2up2X2+
 1xQ15PnASE92P7DbJEwNj7bg/bgwFDzcjXhJfeMkYGVf15ks4BeihBhyjheuTeqB0219oETBi
 rpTb9t1YE8OsRkk41JGR8TPWBB4X1jbnmBs9ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Maselbas <jules.maselbas@arm.com>

This patch prevents the 'global_tunables_lock' mutex from being
unlocked before being locked.  This mutex is not locked if the
sugov_kthread_create() function fails.

Signed-off-by: Jules Maselbas <jules.maselbas@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Dietmar Eggermann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Stephen Kyle <stephen.kyle@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: nd@arm.com
Link: http://lkml.kernel.org/r/20180329144301.38419-1-jules.maselbas@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit 1b5d43cfb69759d8ef8d30469cea31d0c037aed5)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 81eb7899c7c8..b314c9eaa71d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -605,10 +605,9 @@ static int sugov_init(struct cpufreq_policy *policy)
 
 stop_kthread:
 	sugov_kthread_stop(sg_policy);
-
-free_sg_policy:
 	mutex_unlock(&global_tunables_lock);
 
+free_sg_policy:
 	sugov_policy_free(sg_policy);
 
 disable_fast_switch:
-- 
2.20.0

