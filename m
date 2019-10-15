Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6970C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4712084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fXSuKxc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbfJOS0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:26:25 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.24]:35526 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728245AbfJOS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:26:25 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C9ED11AE1F35
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:26:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id KRWKiOQxTHunhKRWKi1G7d; Tue, 15 Oct 2019 13:26:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h9r1/ws24FPcET1Unnl3HF3aff7NQ3NhjeVSLBi8B2k=; b=fXSuKxc70sbDsCkDiz+3QDL8Ry
        P7NHu7tBjChuYuJko5lOMl00gne5dzqcEeS8W3XAtClSWhNMlpb/QSzJW5/SXhL4Y8ralH28LFbZQ
        C98EViQiXclMd73BNfxlpWHAAVINgvox/JYHAbQzU97vgkon9b0hPxA/WtRr3JIkdaKzbchJ/V3HT
        TCpGU4WQehqYef9N+3J0gWZabFtkWaMUfO+qaHJHyW0m2UPE9oCyOizwabP629qZPDfj/kyLmnloE
        g3ZrwzcI2wR7WxzZbsgfdlYgI1p+MFAspJs18tD9z2e+BaaqLN6f8pi6hWiKaxSHPrep8vUNMhCCD
        KLv6dm8w==;
Received: from [187.192.22.73] (port=40792 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iKRWJ-001U0t-Ix; Tue, 15 Oct 2019 13:26:07 -0500
Date:   Tue, 15 Oct 2019 13:25:49 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] platform/x86: huawei-wmi: Fix misuse of strcmp() function
Message-ID: <20191015182549.GA13772@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.22.73
X-Source-L: No
X-Exim-ID: 1iKRWJ-001U0t-Ix
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.22.73]:40792
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing the result of strcmp directly with 1 may cause it to be
misinterpreted. Note that strcmp may return an integer besides -1,
0, or 1.

Fix this by returning -ENODEV only when strcmp() returns a value
other than 0.

Addresses-Coverity-ID: 1487035 ("Misuse of memcmp-style function")
Fixes: b7527d0f4502 ("platform/x86: huawei-wmi: Add battery charging thresholds")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/platform/x86/huawei-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 6720f78c60c2..b43f76acbfea 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -470,7 +470,7 @@ static DEVICE_ATTR_RW(charge_control_thresholds);
 static int huawei_wmi_battery_add(struct power_supply *battery)
 {
 	/* Huawei laptops come with one battery only */
-	if (strcmp(battery->desc->name, "BAT") != 1)
+	if (strcmp(battery->desc->name, "BAT"))
 		return -ENODEV;
 
 	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
-- 
2.23.0

