Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF282C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A50206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GaCue3oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfG2Wtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:49:36 -0400
Received: from gateway20.websitewelcome.com ([192.185.64.36]:46524 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727576AbfG2Wtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:49:36 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id B4E2D400C81CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 16:46:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sESVh1uJZ2qH7sESVh4GOK; Mon, 29 Jul 2019 17:49:35 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RsCF2vuzTm3iwzaX6PiskbgBBNm8IovFMRJ8CCI/Gmg=; b=GaCue3ojx2KA5yk8vKLnHWpkW2
        7DexMxtvyZkfRcB/kCwqzsGtBSXxqfmdiVHfceSNJXIJnnG3zEyI1RCxltTrS4Zmc/27ICiwT45XX
        ojrNiRulP3299WA31HPphgswkUBxkg9pbhIJzbGAr8hHxepn+xbS942SAUq8Wkfo8OSsyhwtXe911
        Xg3Rkk0Sp5Ue4s/vvgQdlb0GFdL2IHrbxr5OfTfwHc/NIDMsQrYYFHDY/2wJiOsOf6FDJpC6XnZRa
        raoymwXO6PMiGYSKmo7n0pCIndftZNEtASHi/bmch+Wov8gzCVlvIKPKpWutNrTznz1PSKJkHlzyH
        rJoEih4g==;
Received: from [187.192.11.120] (port=60902 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsESU-002FpJ-FR; Mon, 29 Jul 2019 17:49:34 -0500
Date:   Mon, 29 Jul 2019 17:49:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] cpufreq: ti-cpufreq: Mark expected switch fall-through
Message-ID: <20190729224933.GA23686@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsESU-002FpJ-FR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60902
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 43
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/cpufreq/ti-cpufreq.c: In function ‘dra7_efuse_xlate’:
drivers/cpufreq/ti-cpufreq.c:79:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
   calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
drivers/cpufreq/ti-cpufreq.c:80:2: note: here
  case DRA7_EFUSE_HAS_OD_MPU_OPP:
  ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/cpufreq/ti-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 2ad1ae17932d..aeaa883a8c9d 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -77,6 +77,7 @@ static unsigned long dra7_efuse_xlate(struct ti_cpufreq_data *opp_data,
 	case DRA7_EFUSE_HAS_ALL_MPU_OPP:
 	case DRA7_EFUSE_HAS_HIGH_MPU_OPP:
 		calculated_efuse |= DRA7_EFUSE_HIGH_MPU_OPP;
+		/* Fall through */
 	case DRA7_EFUSE_HAS_OD_MPU_OPP:
 		calculated_efuse |= DRA7_EFUSE_OD_MPU_OPP;
 	}
-- 
2.22.0

