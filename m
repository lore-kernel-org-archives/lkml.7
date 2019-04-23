Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EECEC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48BF2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syeatBby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfDWCZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:25:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbfDWCZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:25:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so6638564pfn.3;
        Mon, 22 Apr 2019 19:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H2eJWSVgxaR7EpJMRRyJAy9ntWuk045RN3qbYmEWde8=;
        b=syeatBbySkPuxXDhwcOOyJKun8pQwBRa3BgeGcDIGIyin8D24KiEgB+w/hPjW1rPWq
         N653OMSI213JRXZHG+y3NVpHr7NuwbemvEjg7sB5iNT+UOY6sgOurkij/FXutvJfi+x3
         HagqfgDbUO4Di/WfPJLrGvRxpl7bbHOgDF9Cq1h4d+wDZtMJdmwogOCmw42MxKrr6wz2
         OI9vP9Nsp/njgNtNJRCk6pzyMih8GoGVjVB75vPU51615aN1pzbTemO2Fy+YzvEFNw3q
         nuSh8i9mqlhzfSn3LknORG+z5i9wBCCDPFqnEEmszsL42fu9U74twv9m/XJHtDd9EfSa
         S6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H2eJWSVgxaR7EpJMRRyJAy9ntWuk045RN3qbYmEWde8=;
        b=eLxfF0WjiOpZOWPYMYm0hVr47I7gRqAV6QYvcKCfk+6DgqQ1xv2KnCdhpUFmOD/XAa
         at/Bgmo06HTE79+fjBsHhRCDCh81upcCGv0vFQUxInxBDlY//ITaRF8yMvV+Rw8+yxDM
         SgcCT3s2ch0ZfqlFtGt01td/a2NhHjo+niYadP5sj8qnpwL5IC6D1hk/sxpgQh/8euq5
         d5vd4fa6QjF5t3Y1z8zmTSg7S7qx3EiBxMy3i45rRwDBcroffwgw/at+AQRbkFzYIwfT
         O+SDANjv8LWiuHsvXQDftLriK4Gi9PTGoBBSjREhBf3VDq2xq/4CI+HTPNwuOEaRbMts
         cxmQ==
X-Gm-Message-State: APjAAAVKOU/M53V2BqRuZv0LstLyOHImo3cLFZVVCzKQ3kPbz1yiiPhY
        JnzHRZWj+cgjiaiggCRYA+89S3Xd0Vc=
X-Google-Smtp-Source: APXvYqyvxbxpBKuX0xvZWL8CeHx/0Flnf8aBiGM5raYXJ9JFVSHJS74b5oPXPaW/MjbC35TrV37G/g==
X-Received: by 2002:a62:1b8a:: with SMTP id b132mr23819833pfb.19.1555986346737;
        Mon, 22 Apr 2019 19:25:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k1sm24439630pfc.83.2019.04.22.19.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 19:25:46 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] isdn: hisax: Fix misuse of %x in config.c
Date:   Tue, 23 Apr 2019 10:25:28 +0800
Message-Id: <20190423022528.3595-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than
cast to (u_long) type and printed with %lX.
As the function seems to be for debug purpose.
Change %lX to %px to print the pointer value.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/isdn/hisax/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index b12e6ca..de96511 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -1294,9 +1294,9 @@ void HiSax_reportcard(int cardnr, int sel)
 	printk(KERN_DEBUG "HiSax: reportcard No %d\n", cardnr + 1);
 	printk(KERN_DEBUG "HiSax: Type %s\n", CardType[cs->typ]);
 	printk(KERN_DEBUG "HiSax: debuglevel %x\n", cs->debug);
-	printk(KERN_DEBUG "HiSax: HiSax_reportcard address 0x%lX\n",
-	       (ulong) & HiSax_reportcard);
-	printk(KERN_DEBUG "HiSax: cs 0x%lX\n", (ulong) cs);
+	printk(KERN_DEBUG "HiSax: HiSax_reportcard address 0x%px\n",
+		HiSax_reportcard);
+	printk(KERN_DEBUG "HiSax: cs 0x%px\n", cs);
 	printk(KERN_DEBUG "HiSax: HW_Flags %lx bc0 flg %lx bc1 flg %lx\n",
 	       cs->HW_Flags, cs->bcs[0].Flag, cs->bcs[1].Flag);
 	printk(KERN_DEBUG "HiSax: bcs 0 mode %d ch%d\n",
-- 
2.11.0

