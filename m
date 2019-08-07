Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5ADC31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357DC21743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="YXMcBrs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfHGBo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:44:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34342 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfHGBo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:44:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so36332964pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=us4X2/Ffv/gh+Z95c5AMld/oLf6kFtURt8EKlK9JFC4=;
        b=YXMcBrs65W/67DvADyGdD0BcIpES1T7tmdE80pZMunwXHKlXQZPyLniERqZmDFvptR
         /XkCUV/WdSbLAn0r/3UPoO7v7FXSG0bAcVYJJ48Q2Kl4NJ5tNIj23hdhVMen9f8PS56X
         RBtJdw0Eflk9Qu/H9tsSBicyJAmoBL8wXgA6OZLsY/5Tl5LleUWins6lWfTT7IKPRzbn
         DAqIru1R8Bv4CUVQpGPE9cP0IeUVolmQH0sFg5muytlHEpihRgIQGudbL5IE2n+5f8uk
         APpAgoBaeLKxbnx7FxOMjVJ0Gh61K0lE5CLqbzd3Y2kUllbBU7tlIa4HjOjTSioDfInA
         XCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=us4X2/Ffv/gh+Z95c5AMld/oLf6kFtURt8EKlK9JFC4=;
        b=M6ZnC2YX9EP7LQqspG8y5BWNwA4rOcsdJpp/CTd+6+bu9REf84OMR/SG5PIkjlv58v
         S1tvLfZzmokNnW60AhtwjlHpMkPYxWVhBAdVN6GZsRWFfXOUuQt2UImuAx6cOjr3pwEu
         7OovVU1SlrNp7IO8ezEUo8zr8yJxioAuLJCEVY+OIDORoi2Ce3U1Rcc7AIjD+wxMPe88
         tdmgeTAgkGWqQCw0UYpYWz/GLfAgYTLGpfzlfIXqUPhle4wNvXQOcPclWdRyYU6jVtSj
         IuJMm2cLdLR73WG6iG0/ehJjWzP6nHOESN6BMbKvj/2MCIavhauzQ0rivxUnTqQCKwPa
         pMFg==
X-Gm-Message-State: APjAAAXo5g3hN5fKTZvK/ayyUBu04O00O3CflZS/2g/UZVVHTw/Tzgv4
        CmztLnN3loO91LWf5KACCmi/pxetIS0=
X-Google-Smtp-Source: APXvYqyTqK3CX7JCzPdYO9xHwOeBv2HStnsRF27qO8fV3Ejg9Apmtxy0Edsq+4OLDdVaztpOgwh4ng==
X-Received: by 2002:a62:ce8e:: with SMTP id y136mr6867296pfg.29.1565142265801;
        Tue, 06 Aug 2019 18:44:25 -0700 (PDT)
Received: from santosiv.in.ibm.com ([49.205.216.78])
        by smtp.gmail.com with ESMTPSA id i9sm19321610pjj.2.2019.08.06.18.44.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:44:25 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] kernel/watchdog: Fix watchdog_allowed_mask not used warning
Date:   Wed,  7 Aug 2019 07:14:17 +0530
Message-Id: <20190807014417.9418-1-santosh@fossix.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define watchdog_allowed_mask only when SOFTLOCKUP_DETECTOR is enabled.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 kernel/watchdog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..d365616f9ed3 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -44,8 +44,6 @@ int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 static int __read_mostly nmi_watchdog_available;
 
-static struct cpumask watchdog_allowed_mask __read_mostly;
-
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
@@ -160,6 +158,7 @@ static void lockup_detector_update_enable(void)
 }
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
+static struct cpumask watchdog_allowed_mask __read_mostly;
 
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
-- 
2.20.1

