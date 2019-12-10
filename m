Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8BC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B6420828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beROCNSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLJXfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:35:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37651 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLJXfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:35:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so22109720wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Dv/VxzJDAfTaBtCuFb7lBqg7ta9q337rpC3njmbd/0=;
        b=beROCNSlii7j5050AxrP1Q2nfBxc3FIFYjfL2AH8TEvtc03rVX3d8i7AjhVesNsrLk
         VGmTr4XknzlhVENJRdf4oSMLCEaRVOZ+XY4NUqsd6hSnP6H4HGv/vQat7yu9Ii1ROz35
         H+iFJue+sH9WDOTA0EBWMWJEegPa8maS+DNizsyvU3rstzki0QTRnEpyPYipRUbaD6Os
         biN+pyuvEn9w2hXXD0vvfTqDtbPiiuUfdJPVU3GHks53jSO4JLws5wd3CHK0cCcOZt4p
         jQSRb/pSz13CJQzbYYpvLP5U+Fi1jYtJKnpPI1798/OcX5Rx+2uCRdYp3FU3Dag8wjYP
         li8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Dv/VxzJDAfTaBtCuFb7lBqg7ta9q337rpC3njmbd/0=;
        b=hIaFpejGoxSA9K2unzg6b/DRrpChgMl298jVV4j4lBaeU31VAqTSsZaqaK/M0CfgSG
         RmUOBzhFdWVXdtrEOCkaANl/VDQO9iQuY/xunuv+q11mKPD5ctS9XjVCABZSdBaXBVgO
         q1o4mQOxj4MU5Gn5qnbZVngmXQBrhrIUhjMzLpYvpVsXCSgiaEh+SVsefUjgyIiA61E3
         Xz+Tn9fiJa+8pU8Piht1d7g3kCsxFzRAznlqvUW63SHtYpDWkkVn38N5+4/dcc3lZyhG
         4CZYf+qHkHxKzBzScTllnkmdBI7Scqs7agiE38RAymVQ+7w/LERGH2hMIdEDdIezTi5B
         PX5w==
X-Gm-Message-State: APjAAAVkG8tHi39lnJRyJfG4P9FfVh2zvnrDEpokYVg6UHfITythQmpa
        ItXU4j0rgqpfds85JBFQBz8=
X-Google-Smtp-Source: APXvYqzx9eQj+2joJ3ncGUAmrw2khMoxtWHR+p6R4TEP8jiUfptCIy5QwN4obIUYtRQ13Pas/q/dJA==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr96621wrs.247.1576020921488;
        Tue, 10 Dec 2019 15:35:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm59478wro.88.2019.12.10.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:35:21 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] soc: bcm: brcmstb: biuctrl: Tune interface for 7255 and 7216
Date:   Tue, 10 Dec 2019 15:30:41 -0800
Message-Id: <20191210233043.15193-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210233043.15193-1-f.fainelli@gmail.com>
References: <20191210233043.15193-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7255 and 7216 are some of the latest chips that were produced and
support the full register range configuration for the BIU, add the two
entries to get the expected programming.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 6be975392590..978cf52be664 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -102,6 +102,8 @@ static int __init mcp_write_pairing_set(void)
 }
 
 static const u32 b53_mach_compat[] = {
+	0x7216,
+	0x7255,
 	0x7260,
 	0x7268,
 	0x7271,
-- 
2.17.1

