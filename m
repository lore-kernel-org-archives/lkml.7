Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39DAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E00521582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KBmfJyYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfLQVGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:06:25 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34940 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfLQVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:06:25 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47crKX2v95z9vbXw
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 21:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IWvmopA0X948 for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 15:06:24 -0600 (CST)
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47crKX1k2Hz9vbY8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 15:06:24 -0600 (CST)
Received: by mail-yw1-f72.google.com with SMTP id 199so8742954ywe.20
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVnukGaiui+du4+M3rktd/RcuLA80ABz3WVIbi2xHtI=;
        b=KBmfJyYowdx1h9k2Ktvy/CuZa7KBLKl+kv2WSWq4E1LLh/iGH1BZ2uKtukY/W2uzVo
         TpOpE0M/TjXJBydFNILe7JcWTtYgiVQq2UeznWuReLZCjbu5K78i6Cls+VL3XtsWT2fQ
         XqEb708qgSlCd/b2D+Rd3w2WrFn4lkITSTNECAMlkziteLnFv3NCZJMSGRpMZxt7LFwz
         qrHA64qCQ192u2heFfyU9uhQM/LWbb68NUezxaKZnEDdVrKoyC2KtmnmQWcdvb07iARW
         PMlTvvt7+lbf30tRWppvhTekxCkugnWrCjXMRCIrRGISPvcs/vncRp/4eZWU732GnxE0
         U0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVnukGaiui+du4+M3rktd/RcuLA80ABz3WVIbi2xHtI=;
        b=q9HYqJafwG1JemueSNhiFNxATNZSDONNZ6ayhlZPDRha5mt2lvMC5+isKUvU60G25G
         yvQd6eeuSJivP+IPJ5sVRZEioOn24Xa/iYzX42qGKeOVqeFJ4NMBcp5V5xG58jFrk4KW
         Zg+ndPCxuH4dasNTkC0vtDubV8zPHHFV6oJih43+pRmbtlOCoB+CfeYafeLIu9eYeCS3
         655+rD8UlYlE/p5L0Rr3aTLSTEKpGMSLLIZfBYFzoV9x2m4d8yuFT+Xr82DpnIw2Ivpe
         V/R135rxWyW3ZSaBLGROVLyfgWd1FWbcQUs8SfCgjCVHG62+q2eBOPq2BO+GBkMI3I4U
         g42A==
X-Gm-Message-State: APjAAAU/TwiRT4LQ3e8zhHvRUnpR8uZwgKQxSwXJKbjZZfncnNCyum3Y
        FD4gIFmVojUwMsFtbPyS99bNacju7M4rMxD8s/qk2N58r7Yd1c0BoD3ftjcsipUwORFbTEhdjZH
        2+jABXwrtkBMCov6kV2/7WXU0aguK
X-Received: by 2002:a0d:dbd5:: with SMTP id d204mr640591ywe.22.1576616783709;
        Tue, 17 Dec 2019 13:06:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxobVgJolFCbVUp/qKSoQ1G1fQbOomuh913hWdYuOGTVfl6p/BvJ6GamqZF59q/3T4hYM6AfA==
X-Received: by 2002:a0d:dbd5:: with SMTP id d204mr640571ywe.22.1576616783505;
        Tue, 17 Dec 2019 13:06:23 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id w138sm6913670ywd.89.2019.12.17.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 13:06:23 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hdlcdrv: replace unnecessary assertion in hdlcdrv_register
Date:   Tue, 17 Dec 2019 15:06:19 -0600
Message-Id: <20191217210620.29775-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hdlcdrv_register, failure to register the driver causes a crash.
The three callers of hdlcdrv_register all pass valid pointers and
do not fail. The patch eliminates the unnecessary BUG_ON assertion.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Changed from returning -EINVAL to deleting BUG_ON as identified
by Stephen Hemminger.
---
 drivers/net/hamradio/hdlcdrv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
index df495b5595f5..e7413a643929 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -687,8 +687,6 @@ struct net_device *hdlcdrv_register(const struct hdlcdrv_ops *ops,
 	struct hdlcdrv_state *s;
 	int err;
 
-	BUG_ON(ops == NULL);
-
 	if (privsize < sizeof(struct hdlcdrv_state))
 		privsize = sizeof(struct hdlcdrv_state);
 
-- 
2.20.1

