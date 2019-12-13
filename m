Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DACC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C42469F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfLMU6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:58:41 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:58:41 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbS0X-1i8S0J3tFZ-00bs55; Fri, 13 Dec 2019 21:58:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Li RongQing <lirongqing@baidu.com>,
        Zhang Yu <zhangyu31@baidu.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        zhengbin <zhengbin13@huawei.com>
Subject: [PATCH v2 22/24] y2038: remove obsolete jiffies conversion functions
Date:   Fri, 13 Dec 2019 21:53:50 +0100
Message-Id: <20191213205417.3871055-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+a7egnHYu/Vs4tGonIvWpddWPqQ3G3Wrw3UoOy1c8w4nWtkSLIH
 WP2j0kouEaxCIxmbWZSzvBL11f1KKh3/hew5IawQz0XOCrQ+gKizADA7n/VPFRd7zTV1smC
 k00875l342HVLxFmg7rrE6XRu7CNsuFPtLzP6FrKoEmYKUCt98BHJerR6wFhBdm7/cPzyKx
 byCtsDXIHe1CvT7R5U5vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FkIUgD1sr+w=:QqhdATVnkuEIRaTgHU5R3C
 8JX3YcqaA/s08qA+8JMS+qQUnItFmEfkGxSPHCUTLLwlAFupj8E84/HhYAcw8v2t4HyfFW5Hd
 3MQhV20eSbXQAxcfAPTC8qCnnKKpPsfTgaKA1o6VKvx4zIqiYJCpraES3tZY3r3jYQk9D5P1e
 Pw5F4LryugGgsLY+8wn9lcLRyXcOqmVfEdtTYAIka/HiEqUfRxwWGYRN1tR4cBh58PE22EGGO
 MoC0SnGtmSJydlAb+2F3upmMAqC8icW9HCNWn2Fu5HsfWSsaCV8tfqPC1X5Ou5PnZbGbwPt2S
 kNt3uw2hJwJbQjF+xOiS7FAudO8qj6K3FPIe0DtpNCjm0mJdDthrwXL5MqER2m51d5iDP4s1y
 DN6gi1U/9Xvti3wjsFcU+W2aqGphQCWaYOCYcAvDFyx8frrzOIh80iKwTXQZpwvJ19JuknobV
 b8Z7RxIVIZPLkjRrsfUEp93zrnvScXj9cz6Gj2flRSdG9/uM1pit9V8J9Wlu7S+aHjSeSm+6I
 ssX7OgleqxE6weQytJyWjN/XI0YdIIiUn4ZXTiwbgzlN3Nhxv60A9HwXolMdjcelo4NyiOX7e
 nr2rLrzpVYPKUq1x/DDEuzRVDx5iw4qs2ogq+agjVaNn91aQ4L2CnyjRqVo4a7CGb7DttqDNB
 e8RiLkP3xvV7+6JOviizoG2Lc8hj7X4EpV2eRd0ScYnkabXCr+yAQLdjTIEaGLDJN09rrXqQC
 Os5oW+oYwNs+NXa9Gn2wZ41I2Kwnp595vJTbaUDToapua3e8BDV0XLhtBYkS1+8yyVoawOsBr
 T36Sij30o6PfQUh0rKwnv1syW3iJpBhEGLw8OZMlwACYH4Af1QP7/+TUhOzqJNfQSOFsbGdCq
 pfrnDEOrRLxjz0wuNXYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the last user of timespec_to_jiffies() is gone, these
can just be removed, everything else is using ktime_t or timespec64
already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/jiffies.h | 20 --------------
 kernel/time/time.c      | 58 ++++-------------------------------------
 2 files changed, 5 insertions(+), 73 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1b6d31da7cbc..e3279ef24d28 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -422,26 +422,6 @@ static __always_inline unsigned long usecs_to_jiffies(const unsigned int u)
 extern unsigned long timespec64_to_jiffies(const struct timespec64 *value);
 extern void jiffies_to_timespec64(const unsigned long jiffies,
 				  struct timespec64 *value);
-static inline unsigned long timespec_to_jiffies(const struct timespec *value)
-{
-	struct timespec64 ts = timespec_to_timespec64(*value);
-
-	return timespec64_to_jiffies(&ts);
-}
-
-static inline void jiffies_to_timespec(const unsigned long jiffies,
-				       struct timespec *value)
-{
-	struct timespec64 ts;
-
-	jiffies_to_timespec64(jiffies, &ts);
-	*value = timespec64_to_timespec(ts);
-}
-
-extern unsigned long timeval_to_jiffies(const struct timeval *value);
-extern void jiffies_to_timeval(const unsigned long jiffies,
-			       struct timeval *value);
-
 extern clock_t jiffies_to_clock_t(unsigned long x);
 static inline clock_t jiffies_delta_to_clock_t(long delta)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 704ccd9451b0..cdd7386115ff 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -626,10 +626,12 @@ EXPORT_SYMBOL(__usecs_to_jiffies);
  * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
  * value to a scaled second value.
  */
-static unsigned long
-__timespec64_to_jiffies(u64 sec, long nsec)
+
+unsigned long
+timespec64_to_jiffies(const struct timespec64 *value)
 {
-	nsec = nsec + TICK_NSEC - 1;
+	u64 sec = value->tv_sec;
+	long nsec = value->tv_nsec + TICK_NSEC - 1;
 
 	if (sec >= MAX_SEC_IN_JIFFIES){
 		sec = MAX_SEC_IN_JIFFIES;
@@ -640,18 +642,6 @@ __timespec64_to_jiffies(u64 sec, long nsec)
 		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 
 }
-
-static unsigned long
-__timespec_to_jiffies(unsigned long sec, long nsec)
-{
-	return __timespec64_to_jiffies((u64)sec, nsec);
-}
-
-unsigned long
-timespec64_to_jiffies(const struct timespec64 *value)
-{
-	return __timespec64_to_jiffies(value->tv_sec, value->tv_nsec);
-}
 EXPORT_SYMBOL(timespec64_to_jiffies);
 
 void
@@ -668,44 +658,6 @@ jiffies_to_timespec64(const unsigned long jiffies, struct timespec64 *value)
 }
 EXPORT_SYMBOL(jiffies_to_timespec64);
 
-/*
- * We could use a similar algorithm to timespec_to_jiffies (with a
- * different multiplier for usec instead of nsec). But this has a
- * problem with rounding: we can't exactly add TICK_NSEC - 1 to the
- * usec value, since it's not necessarily integral.
- *
- * We could instead round in the intermediate scaled representation
- * (i.e. in units of 1/2^(large scale) jiffies) but that's also
- * perilous: the scaling introduces a small positive error, which
- * combined with a division-rounding-upward (i.e. adding 2^(scale) - 1
- * units to the intermediate before shifting) leads to accidental
- * overflow and overestimates.
- *
- * At the cost of one additional multiplication by a constant, just
- * use the timespec implementation.
- */
-unsigned long
-timeval_to_jiffies(const struct timeval *value)
-{
-	return __timespec_to_jiffies(value->tv_sec,
-				     value->tv_usec * NSEC_PER_USEC);
-}
-EXPORT_SYMBOL(timeval_to_jiffies);
-
-void jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u32 rem;
-
-	value->tv_sec = div_u64_rem((u64)jiffies * TICK_NSEC,
-				    NSEC_PER_SEC, &rem);
-	value->tv_usec = rem / NSEC_PER_USEC;
-}
-EXPORT_SYMBOL(jiffies_to_timeval);
-
 /*
  * Convert jiffies/jiffies_64 to clock_t and back.
  */
-- 
2.20.0

