Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC2C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF06221906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YgbVjsF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503953AbfJXSBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:01:13 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:28248 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389845AbfJXSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:01:13 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OHvB7M009551;
        Thu, 24 Oct 2019 18:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=Nd36wEoqHAG6QPKAc3M8Ts/MzRoQ2UKtTIaLD+uF+Y8=;
 b=YgbVjsF1MIz+7tq80n5NnCkqhj7v4D6QN6TWhcO90fkEbBgIjb+LMIhHvDpBFjB3+tfv
 wsBknJGmExoNMgjDsagV/eJ8igQBpn13FHur3e/9WvUbRqyW4A8dXDn4vsOIgIj0yn6q
 jn2zssWsKQzlZcpOoCxJPfM1XQgnIoJgFCbQFUQrwRfwSY1kj1Yx4hdL5RRe1RqnDaqr
 wpX6ULjDFoajjHO9LucE1oiJOW16aWMK2fJY57WI48Nhv8MGZPOha5M9z3B+vAj6Dui1
 K1sp5FFA6XGQuP139k/QwSo1UqTyoBqJTp3QKtvV+q60hBEJjzLpY9ppFJucbWpvaWZd Aw== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2vssv83859-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 18:59:56 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9OHlCxY002926;
        Thu, 24 Oct 2019 13:59:55 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.57])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2vqwtwqnq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 13:59:55 -0400
Received: from USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) by
 usma1ex-dag3mb4.msg.corp.akamai.com (172.27.123.56) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Thu, 24 Oct 2019 13:59:54 -0400
Received: from bos-lpii8.kendall.corp.akamai.com (172.29.171.127) by
 USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Thu, 24 Oct 2019 13:59:54 -0400
Received: by bos-lpii8.kendall.corp.akamai.com (Postfix, from userid 42339)
        id BDDB317F639; Thu, 24 Oct 2019 13:59:54 -0400 (EDT)
From:   Michael Zhivich <mzhivich@akamai.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <rafael.j.wysocki@intel.com>,
        Michael Zhivich <mzhivich@akamai.com>
Subject: [PATCH v2] clocksource: tsc: respect tsc bootparam for clocksource_tsc_early
Date:   Thu, 24 Oct 2019 13:59:45 -0400
Message-ID: <20191024175945.14338-1-mzhivich@akamai.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=866
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240167
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_10:2019-10-23,2019-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=1
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 mlxlogscore=852 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910240169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of clocksource_tsc_early broke functionality of "tsc=reliable"
and "tsc=nowatchdog" bootparams, since clocksource_tsc_early is *always*
registered with CLOCK_SOURCE_MUST_VERIFY and thus put on the watchdog list.

This frequently causes TSC to be declared unstable during boot:

  clocksource: timekeeping watchdog on CPU0: Marking clocksource
               'tsc-early' as unstable because the skew is too large:
  clocksource: 'refined-jiffies' wd_now: fffb7018 wd_last: fffb6e9d 
               mask: ffffffff
  clocksource: 'tsc-early' cs_now: 68a6a7070f6a0 cs_last: 68a69ab6f74d6 
               mask: ffffffffffffffff
  tsc: Marking TSC unstable due to clocksource watchdog

The corresponding elapsed times are cs_nsec=1224152026 and wd_nsec=378942392, so
watchdog differs from TSC by 0.84 seconds.  Since jiffies is not guaranteed
to provide reliable timekeeping due to possibility of missing timer
interrupts, this is a false positive.

This issue affects machines running with HPET disabled; otherwise, HPET would
be the watchdog for tsc-early clocksource, and this situation would be avoided. 

Restore previous behavior by respecting "tsc=reliable" and "tsc=nowatchdog"
boot params when registering clocksource_tsc_early.

Fixes: aa83c45762a24 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
---
 arch/x86/kernel/tsc.c | 3 +++
 1 file changed, 3 insertions(+)

 Changes from v1: updated commit message, added "Fixes" tag.

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c59454c382fd..7e322e2daaf5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1505,6 +1505,9 @@ void __init tsc_init(void)
 		return;
 	}
 
+	if (tsc_clocksource_reliable || no_tsc_watchdog)
+		clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
+
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
 }
-- 
2.17.1

