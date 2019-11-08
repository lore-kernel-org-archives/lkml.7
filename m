Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B8FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBCF20674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfKHUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:36:18 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKHUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:36:18 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7yuz-1hpfJe1Cz5-014yOw; Fri, 08 Nov 2019 21:35:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Corey Minyard <minyard@acm.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net
Subject: [PATCH 4/8] ipmi: kill off 'timespec' usage again
Date:   Fri,  8 Nov 2019 21:34:27 +0100
Message-Id: <20191108203435.112759-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108203435.112759-1-arnd@arndb.de>
References: <20191108203435.112759-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5h5zjTJTFS7NU7dR3OxD3RGZD81MiMNfiSZHg3//WQd5cEspSJc
 LIApSfiSz9Te28wkEE3ctR6BIBgRSUZv+L8WoFHniGGNul2rk23RWvU9J1joypQooUlQ9/Y
 DGmmNTguceLb02Y1evbVHD9ZTU8F11CtM7iKaUrqM2+zVzRGt7fUWskVkjFrWQxFHRWNCDP
 Wk8+4Q6wKeQ6K8pK07LrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TcWOuYfgQ1c=:5rJazEAWe8fZzBgGo5S7kS
 vEWFdfZBBTUpkp+pnxRlr2kLO4coolsU4UPvtSI/uWs6ncs2JIzQNkPtmpnxkSNYqY4aluw1Q
 +WUFzBe0iTFJFKK3OGgLW//tPpefDApoosfIVPfo6ZqSCOyaCypL59y8vqDdr/WVrpBtdN37d
 odZGiMdY5BAPDC5mMpXRE3MShieMhVrCIMBrJ+1qfeGSLSNZp3v2Wpm73FJeTVztusApsgWh1
 uVoMimJy7Hy3SiRv1FRWJrpeZ03G/WVodq3+zpnppq47d2x8WwuKbyAsOm9Lj/kKsIoLjUzF6
 +E3JzqvTv/oEMEK3MMvyHK8dnFvwAgm3RBGKlDRVJw63T+HnP33YXm1rs5oo1o+7rrLAqJlep
 NfRtxeJ3aShvYjGwpd3WB5Q92YPyB1Dqu81MtAgh0pAOlDImOXcdSVSuuVzqP7MqqiYE++mue
 CWV6DkqUrt5stJvHGqX9unK2mFM8Ga2ukfxYgB2YE4KqpS9LBpCw0RvWlI6CRLyZEiBIqiJbn
 A0bs+MvnRh37jz1HsGtAXmFM01joN1dktLIurvpV9iBgaeusR6eSNg9ixohYBwRVtUEs/pBnk
 BdD8VFtif50YujggMHE6LqfQIqaBEBn8XIVhFhgolWqn4nZOyjx4m0cmTF7vv2R+8MeVGQ1yI
 fQ7g5IH0MGfIK2GnlcSeTTSo88dcMo83TyzJmhrXvQoHTYIdOsX1S5RK+nHQWsXzdNF/LILJq
 GqeI0NScCQSLY1bZhOGnhhafLyEiMv65GDYeYBdU2+lsuX8kew1uHY61pmcRpmKVwydWkjvuZ
 IMn9bi1scc/juK2D5DpZRKZTlm8qjQ1TxO3kLdowUbQAO0ufELXvrEh50YL25ros262CVd7Pt
 97v5Wkz54JcwT1EXeUGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct timespec' is getting removed from the kernel. The usage in ipmi
was fixed before in commit 48862ea2ce86 ("ipmi: Update timespec usage
to timespec64"), but unfortunately it crept back in.

The busy looping code can better use ktime_t anyway, so use that
there to simplify the implementation.

Fixes: cbb19cb1eef0 ("ipmi_si: Convert timespec64 to timespec")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ipmi/ipmi_si_intf.c | 40 +++++++++++---------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 6b9a0593d2eb..c7cc8538b84a 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -265,10 +265,10 @@ static void cleanup_ipmi_si(void);
 #ifdef DEBUG_TIMING
 void debug_timestamp(char *msg)
 {
-	struct timespec t;
+	struct timespec64 t;
 
-	ktime_get_ts(&t);
-	pr_debug("**%s: %ld.%9.9ld\n", msg, (long) t.tv_sec, t.tv_nsec);
+	ktime_get_ts64(&t);
+	pr_debug("**%s: %lld.%9.9ld\n", msg, t.tv_sec, t.tv_nsec);
 }
 #else
 #define debug_timestamp(x)
@@ -935,38 +935,25 @@ static void set_run_to_completion(void *send_info, bool i_run_to_completion)
 }
 
 /*
- * Use -1 in the nsec value of the busy waiting timespec to tell that
- * we are spinning in kipmid looking for something and not delaying
- * between checks
+ * Use -1 as a special constant to tell that we are spinning in kipmid
+ * looking for something and not delaying between checks
  */
-static inline void ipmi_si_set_not_busy(struct timespec *ts)
-{
-	ts->tv_nsec = -1;
-}
-static inline int ipmi_si_is_busy(struct timespec *ts)
-{
-	return ts->tv_nsec != -1;
-}
-
+#define IPMI_TIME_NOT_BUSY ns_to_ktime(-1ull)
 static inline bool ipmi_thread_busy_wait(enum si_sm_result smi_result,
 					 const struct smi_info *smi_info,
-					 struct timespec *busy_until)
+					 ktime_t *busy_until)
 {
 	unsigned int max_busy_us = 0;
 
 	if (smi_info->si_num < num_max_busy_us)
 		max_busy_us = kipmid_max_busy_us[smi_info->si_num];
 	if (max_busy_us == 0 || smi_result != SI_SM_CALL_WITH_DELAY)
-		ipmi_si_set_not_busy(busy_until);
-	else if (!ipmi_si_is_busy(busy_until)) {
-		ktime_get_ts(busy_until);
-		timespec_add_ns(busy_until, max_busy_us * NSEC_PER_USEC);
+		*busy_until = IPMI_TIME_NOT_BUSY;
+	else if (*busy_until == IPMI_TIME_NOT_BUSY) {
+		*busy_until = ktime_get() + max_busy_us * NSEC_PER_USEC;
 	} else {
-		struct timespec now;
-
-		ktime_get_ts(&now);
-		if (unlikely(timespec_compare(&now, busy_until) > 0)) {
-			ipmi_si_set_not_busy(busy_until);
+		if (unlikely(ktime_get() > *busy_until)) {
+			*busy_until = IPMI_TIME_NOT_BUSY;
 			return false;
 		}
 	}
@@ -988,9 +975,8 @@ static int ipmi_thread(void *data)
 	struct smi_info *smi_info = data;
 	unsigned long flags;
 	enum si_sm_result smi_result;
-	struct timespec busy_until = { 0, 0 };
+	ktime_t busy_until = IPMI_TIME_NOT_BUSY;
 
-	ipmi_si_set_not_busy(&busy_until);
 	set_user_nice(current, MAX_NICE);
 	while (!kthread_should_stop()) {
 		int busy_wait;
-- 
2.20.0

