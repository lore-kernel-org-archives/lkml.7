Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E24C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCA221872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/ugr/WM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfCOIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:41:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:41:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8XnFv196341;
        Fri, 15 Mar 2019 08:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Dw9O8I0mbLzOg3P3StcznEayWoZXR2LVAOinKFeWrdw=;
 b=d/ugr/WMbuwh9izeynCKt6XeHyaz+p+o7SqjSxTwQqSGQFMLn74vaToI0/RwY7oUBros
 4dtWZ6G2vSeTaRRH4Z0PiTVzUt2tDPVqTcpC/WzlrsmVfPFzR0cO1s0fwx5XUra+hojP
 VQi7j3S7C2bDHwuwNeJ8aXneWhUyvbPjFKrPRhcAekJobkC9z400lAb/vVWw0WgEhH/6
 hwZ+Pa2u8VoIxWaaQCRi/d0+qBI195nwqLCHU4L8Vaislf9rXal+htPuuLqTC9meAgoO
 u0ddn0xurxxiC0bqqZkpW5g20jtotQdDejv92ExCQDpKTZ0fVZSjaxE9JzTEegNn5Vfm 3Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r464rwbf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 08:41:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2F8fNIM022859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 08:41:24 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2F8fNmn001336;
        Fri, 15 Mar 2019 08:41:23 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 08:41:22 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 1/2] acpi_pm: Fix bootup softlockup due to PMTMR counter read contention
Date:   Thu, 14 Mar 2019 16:42:11 +0800
Message-Id: <1552552932-21821-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=1 spamscore=0 clxscore=1011
 lowpriorityscore=1 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup stage of a large system with many CPUs, with nohpet, PMTMR
is temporarily selected as the clock source which can lead to a softlockup
because of the following reasons:
 1) There is a single PMTMR counter shared by all the CPUs.
 2) PMTMR counter reading is a very slow operation.

At bootup stage tick device is firstly initialized in periodic mode and
then switch to one-shot mode when a high resolution clocksource is
initialized. Between clocksoure initialization and switching to one-shot
mode, there is small window where timer interrupt triggers.

Due to PMTMR read contention, the 1ms(HZ=1000) interval isn't enough
for all the CPUs to process timer interrupt in periodic mode.
Then CPUs are busy processing interrupt one by one without a break,
tick_clock_notify() have no chance to be called and we never switch
to one-shot mode. Finally the system may crash because of a NMI
watchdog soft lockup, logs:

[   20.181521] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
[   44.273786] BUG: soft lockup - CPU#48 stuck for 23s! [swapper/48:0]
[   44.279992] BUG: soft lockup - CPU#49 stuck for 23s! [migration/49:307]
[   44.285169] BUG: soft lockup - CPU#50 stuck for 23s! [migration/50:313]

In one-shot mode, the contention is still there but next event is always
set with a future value. We may missed some ticks, but the timer code is
smart enough to pick up those missed ticks.

By moving tick_clock_notify() into stop_machine, kernel changes to one-shot
mode early before the contention accumulate and lockup system.

This patch also address the same issue of commit f99fd22e4d4b ("x86/hpet:
Reduce HPET counter read contention") in a simple way, so that commit could
be reverted.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Tested-by: Kin Cho <kin.cho@oracle.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Srinivas Eeda <srinivas.eeda@oracle.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f986e19..815c92d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1378,6 +1378,7 @@ static int change_clocksource(void *data)
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	tick_clock_notify();
 
 	return 0;
 }
@@ -1396,7 +1397,6 @@ int timekeeping_notify(struct clocksource *clock)
 	if (tk->tkr_mono.clock == clock)
 		return 0;
 	stop_machine(change_clocksource, clock, NULL);
-	tick_clock_notify();
 	return tk->tkr_mono.clock == clock ? 0 : -1;
 }
 
-- 
1.8.3.1

