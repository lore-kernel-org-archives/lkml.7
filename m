Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659BCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F942089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ng85Gh/P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YKJ0erlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfJOHaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:30:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfJOHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:30:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C57B607EF; Tue, 15 Oct 2019 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571124613;
        bh=gWI5vS4LE2mM1KgFOZqFpR0hhNVS/xdT8FfifKIimMo=;
        h=From:To:Cc:Subject:Date:From;
        b=ng85Gh/PH2Amof+QeGPgy6g23SzlglLv12iiZwhPMS153MF9IKU6/M/ocUstx2kYh
         V12q6RCYKjqO+bv4sdPNUiH8JIZFtLFBooQlsyZaoUY1cFftvLGspAGwUMED8XfjcN
         PmMrFHo/2zo/8vX/W9s0crvCSK0tciAZe/9swwS4=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C326760A43;
        Tue, 15 Oct 2019 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571124612;
        bh=gWI5vS4LE2mM1KgFOZqFpR0hhNVS/xdT8FfifKIimMo=;
        h=From:To:Cc:Subject:Date:From;
        b=YKJ0erluDlold+ao0gXTJLwRHAygJPeCMBh40ytwx48uWpmjXIE2UZKE47tcSXFJz
         p8B7I1WImtXcHpIYwNVOesOA10eKhqQkuqRHBYMOusej6uOZg2KAc32pey0zChkglt
         GotwiPfpgTE02I62i+8w+bEyMhh2X2fiLCh/Kq/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C326760A43
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     john.stultz@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 1/3] time/jiffies: Fixes some typo
Date:   Tue, 15 Oct 2019 13:00:03 +0530
Message-Id: <1571124603-9334-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

accuratly => accurately

while at it change `clock source` to clocksource to make
it align with its usage at other places.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/time/jiffies.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d23b434..e7f08f2 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -39,12 +39,12 @@ static u64 jiffies_read(struct clocksource *cs)
 
 /*
  * The Jiffies based clocksource is the lowest common
- * denominator clock source which should function on
+ * denominator clocksource which should function on
  * all systems. It has the same coarse resolution as
  * the timer interrupt frequency HZ and it suffers
  * inaccuracies caused by missed or lost timer
  * interrupts and the inability for the timer
- * interrupt hardware to accuratly tick at the
+ * interrupt hardware to accurately tick at the
  * requested HZ value. It is also not recommended
  * for "tick-less" systems.
  */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

