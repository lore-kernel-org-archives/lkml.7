Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF67C341C7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D39F2469B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLMUxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:53:33 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55983 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLMUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:53:32 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNwXA-1iLyXr40AC-00OKO3; Fri, 13 Dec 2019 21:53:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>
Subject: [PATCH v2 07/24] tsacct: add 64-bit btime field
Date:   Fri, 13 Dec 2019 21:52:12 +0100
Message-Id: <20191213205221.3787308-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m6zEFmAIGteUTAMEdgs5prJfD/t974ZJHKfzjd8SuVlLVyFh89i
 pvk7yilTWbmNQeMsJ/AlHqqLtide7TxY7hZG6X9HBcpWwfIX0yPr/Drv3EvsHl7n+Ml6j1d
 0tOFRa0UPRlTwNTtR5mokYRAhW18Uz1TBCButDDeBDX9U8H7nv//rgGg3Nym7/5yfm1OSLO
 m6dEvLkEgCjTO+uvaQQuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wVYUFpoDrxs=:RY9/vsc3D1VxscEnAiUjml
 r0KGyz2oGh43qf6yyRErfNzcXG7W5xEASsxVzHdgjutQQj0BXyWsru5UoBMgVsN2syAWj46kC
 LsGnxVyODBZoFq5D78OZmppOUNowPq2YnUB9NsuGeAKwyFqsyp7ruvHJl8GrnV82dC7o1DAJK
 csMhiVhkyRpeHfYWvTpdpsqMjiAnJ4G0iW2O76y/rST1OmxNaQErWizbTTsWnAPQ+rCDUNFYc
 zwcUFx3zSylWCIy0UztN1cozDHepsL1MltTnJIb/QSOdXHGm69gbReBhRbnVhMG528q2PeQ2E
 VVOzhkk7c1tKILcnfKYfjAXd/em5NjgdKrs2Tbq30EBdAl6G4uSJ/NrrAPmQXIMQ7I/pKdrJj
 VaUTzaCMZcUF5Xx6AGKfp1aafz891WMvLD5KSUWWq5BnSjYIuvAtxSm5/DzrKXBmQSyyHTGyX
 b7IKA+z2tSj619vxwcEZ9Z102Qak/ufaiqu4y/3pi1eyLLMW7nQuJX5VQB3GzpYccO3NJDup8
 i45sVCFKrftpu4Xb5shNAcgsZB9Ne2VUOic3nmJmea9A7NQsCoPg4kRW/7dMO/SKZkhsbXH/v
 kwEtCz27McMrJsoswg4BWMZml6pWFE2v53bTVbdc3Kfx6EpuEHndvFJ3ClXKXOsPSXrLsA6HF
 3Zpb25Cs571FdJfN2WBbajDvC/F3X58/54uE+4+EaEtQ5ve+CHOeyedjRyZ0H8znillRbOn80
 gUKaHvzdCS3hZ6kLNcdGaNX88Auct2TyW8oT+DMyw+BQPe+J4f7aThFCMMukmc01+KNPUoLTq
 OhMDWmoWzoAoMdlvSPaD/HakQGGxTfttI7bG4VDtDOlBiGp5CBEvlbFtpm0A5xuNwtaLs58uJ
 jVlHaEdEr1biLGL6AN6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is only a 32-bit ac_btime field in taskstat and
we should handle dates after the overflow, add a new field
with the same information but 64-bit width that can hold
a full time64_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/taskstats.h | 5 ++++-
 kernel/tsacct.c                | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index 7d3ea366e93b..ccbd08709321 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	9
+#define TASKSTATS_VERSION	10
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -169,6 +169,9 @@ struct taskstats {
 	/* Delay waiting for thrashing page */
 	__u64	thrashing_count;
 	__u64	thrashing_delay_total;
+
+	/* v10: 64-bit btime to avoid overflow */
+	__u64	ac_btime64;		/* 64-bit begin time */
 };
 
 
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index ab12616ee6fb..257ffb993ea2 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -36,6 +36,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	/* Convert to seconds for btime (note y2106 limit) */
 	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
 	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
+	stats->ac_btime64 = btime;
 
 	if (thread_group_leader(tsk)) {
 		stats->ac_exitcode = tsk->exit_code;
-- 
2.20.0

