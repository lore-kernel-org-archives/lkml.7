Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACD4C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FEB20815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="PAYUewPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfJBOQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:16:19 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:10948 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfJBOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:16:18 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92E2TfJ018383;
        Wed, 2 Oct 2019 15:15:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=/ZlqzeeYJxZ37rXBIMYZlJVPrpFIy//tFlZEdwpSGYc=;
 b=PAYUewPicYiC3naj7PZoR9Uq0tOK3bJyIWpG7P72D8ynfH3UD5T8ON+U3jtCod87sLsv
 2DndM30hQj7DZtQi4fbl6FbMUEy12S1ggt124/BNSZqF8OpKyS0my5qoVlWIHJottDP0
 lpg9xxgRNpOn8uaay2s2C/TVGqlAmdEucMQbpHb+BefAp1NENi+Shq7qM+6MdRM1S71P
 QZYk+FKNp6P1Ae8eivCKyGpr0o36SCgwYNs6Houmsk1961RARgySLp3r2T92VbPlQ/Iy
 Hw/Gk6fPBt3roPNyEtQYIKGolaalbPemxVPuqNdaGxFP2z1ex9XGMafjNvKomdaEgmNW aQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2v9xs8dt3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 15:15:57 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x92E1u5f024199;
        Wed, 2 Oct 2019 10:15:56 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.34])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2va2uwbwdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 10:15:56 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag3mb4.msg.corp.akamai.com (172.27.123.56) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Wed, 2 Oct 2019 10:15:56 -0400
Received: from bos-lpii8.kendall.corp.akamai.com (172.29.171.127) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Wed, 2 Oct 2019 07:15:55 -0700
Received: by bos-lpii8.kendall.corp.akamai.com (Postfix, from userid 42339)
        id EFE5317F639; Wed,  2 Oct 2019 10:15:55 -0400 (EDT)
From:   Michael Zhivich <mzhivich@akamai.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <rafael.j.wysocki@intel.com>,
        Michael Zhivich <mzhivich@akamai.com>
Subject: [PATCH] clocksource: tsc: respect tsc bootparam for clocksource_tsc_early
Date:   Wed, 2 Oct 2019 10:15:53 -0400
Message-ID: <20191002141553.7682-1-mzhivich@akamai.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=816
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020135
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_06:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1
 mlxlogscore=798 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of clocksource_tsc_early broke functionality of "tsc=reliable"
and "tsc=nowatchdog" boot params, since clocksource_tsc_early is *always*
registered with CLOCK_SOURCE_MUST_VERIFY and thus put on the watchdog list.

If CPU is very busy during boot, the watchdog clocksource may not be
read frequently enough, resulting in a large difference that is treated as
"negative" by clocksource_delta() and incorrectly truncated to 0.

This false alarm causes TSC to be declared unstable:

  clocksource: timekeeping watchdog on CPU1: Marking clocksource
               'tsc-early' as unstable because the skew is too large:
  clocksource: 'refined-jiffies' wd_now: fffb7019 wd_last: fffb6e28
                mask: ffffffff
  clocksource: 'tsc-early' cs_now: 52c3918b89d6 cs_last: 52c31d736d2e
                mask: ffffffffffffffff
  tsc: Marking TSC unstable due to clocksource watchdog

Work around this issue by respecting "tsc=reliable" or "tsc=nowatchdog"
boot params when registering clocksource_tsc_early.

Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
---
 arch/x86/kernel/tsc.c | 3 +++
 1 file changed, 3 insertions(+)

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

