Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2582133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqSC7fnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDDAKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:10:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39834 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDDAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:10:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so276998pga.6;
        Wed, 03 Apr 2019 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=cEcd4nQiHml6NCBdnxmgLwBQ7PBsq1602z/DS3b3fXk=;
        b=iqSC7fnULlyXXvMw7twz0+vr2TrBzmW9h9UyCrhjxzjjnknYXsEQ0X+k2bhI4GiuEz
         IpMVXazDVDSgXjbqAzmRveRBwdtsNN5MpWdffDt2gyEUZJWNB8K5XigtUVzCdUd9Dwsn
         lMVotGNfP409ZjBkmdWPKVRvRAbOg1onLbYqznKB7thmNxjMWPVCdMDQ810sqMsIwuof
         3A8kPUHNuFet+p8eRliYqq4gdePljeq7P0MDNXuUA3x4l+xbR09sfgJDyLuU+YFFB2/C
         SoTC8ZIrpDgXJdXr62T8rO035YOnMjMRdIPVaZicOH+yoGz3Rg8cII2rl5Sb+cXgo7zl
         4TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=cEcd4nQiHml6NCBdnxmgLwBQ7PBsq1602z/DS3b3fXk=;
        b=QwQ6t2nPNvhJEyG9+/siiJjVPv9HVRzoAoSdee86IPZECMF9MMeIuFo2d2x8nenPSg
         tdWUlvjOxLIUC2gDRxfexsMfCRNowHbbYxnuwJdcfk88EUdXPUj225n6evKMuyYgR6/T
         PhY3fEl8TLoBdaqRe0rRAsyDNWAHQbLMfN+HQUN4gtISbz5ufMlrcoEt+8i8pzZr4sGo
         D8LeZPwX7fRaGzFVr55f60bpWvmaHnzwjnZYI4IwBP+zDtRt+aKhBjdpg2rzbFWAxhvf
         MY+l+uIHr2Hx7RLzwEm/uf9+zGYttGdG9nG3EAOL+xHmoKO5ew6hsrUecBvGrKkc1pUd
         98lw==
X-Gm-Message-State: APjAAAXkcLbdCXtbmspC00WdIYCL1Qgf+9UJ586JNSswg4XW6kVmDxUN
        YltbujbUAezmhMJofu0+zxfeBdzy+52zBn7x
X-Google-Smtp-Source: APXvYqzLlLG43E+5qZJYNlrGCHodRHPPCpnYq8LWrMAyh/Um8LFRDsCrZh/7DPHnkBavyUMcY4wg0A==
X-Received: by 2002:a63:5466:: with SMTP id e38mr2521075pgm.340.1554336609186;
        Wed, 03 Apr 2019 17:10:09 -0700 (PDT)
Received: from siddaraj-MOBL.gar.corp.intel.com (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id h19sm28176114pfd.130.2019.04.03.17.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 17:10:08 -0700 (PDT)
From:   Siddaraju D H <siddarajudh@gmail.com>
To:     siddarajudh@gmail.com, john.stultz@linaro.org,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ptp/ptp_clock.c: Correct input parameter range check
Date:   Thu,  4 Apr 2019 05:39:58 +0530
Message-Id: <20190404000958.15236-1-siddarajudh@gmail.com>
X-Mailer: git-send-email 2.12.2.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddaraju DH <siddarajudh@gmail.com>

The ealier implementaion used to return EINVAL for -ve adjustments
in the range -1ns to -999999999ns as these -ve numbers will fail the
unsigned comaparison against NSEC_PER_SEC. Since the tv_sec field
will be ZERO in this range, the user will not be able to specify
the signedness of adjustment through the tv_sec field. So, the user
must be allowed to specify the signedness through tv_usec/nsec
field also. All variables that holds usec/nsec in this function
are signed numbers and there is no need for that type cast.

Signed-off-by: Siddaraju DH <siddarajudh@gmail.com>
---
 drivers/ptp/ptp_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 79bd102..ee2b35b 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -143,7 +143,7 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		if (!(tx->modes & ADJ_NANO))
 			ts.tv_nsec *= 1000;
 
-		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
+		if (ts.tv_nsec >= NSEC_PER_SEC)
 			return -EINVAL;
 
 		kt = timespec64_to_ktime(ts);
-- 
2.7.4

