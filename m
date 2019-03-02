Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EE1C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3AA20815
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LFCiJ2co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCBVU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:20:57 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40188 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCBVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 16:20:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 013BFDF9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 21:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LSFmaPjFR0ch for <linux-kernel@vger.kernel.org>;
        Sat,  2 Mar 2019 15:20:55 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id C4392DF4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 15:20:55 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id j127so1682548itj.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2AkkWeUTpbIx4CGi+oZ6cC64pedwOZubl56rdyCKQlw=;
        b=LFCiJ2coqjs/rOyP/vMCALYP8dLUhUfTe8W8ABXvGLwlcptFl4yd/4y/4Gt/1w5ILN
         w10c4hA/nC3zFcPDTU6zLmb28rHGEphl11L/s6hdYRVCCsrGVTFWbV0xFN4tG0VAv04w
         VIm0AFPFfJ43Za5VHDrSxVRzwD1aSbWHJoYdvmcXDefjNMJuW6Enl2HyyS8qxsFqnXT/
         vIDRIKvg38/f9gGoFTagoxjIt06+5DXRD0FyxDDr0u6loTvQSEIt+/2umiHp30idY1Ul
         Q2vEPELr7e0q/dMRapOSkixQnTbTPkyRxevZ3QBb1ida/X/Tyax5PT5M0Loy2jQn7KFd
         pNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2AkkWeUTpbIx4CGi+oZ6cC64pedwOZubl56rdyCKQlw=;
        b=HoToJ6S9u6FJaXvyrR5FVfB2o9B0HkhQWBIcBzAwlfxIjqkU07/dflNB5CgR0S/4QC
         rM4DKXHNPQspHbQrRvmGCYjIWJOPkgS7jGs91pYdEvYp65zVWuQTJyvFSYG5KvnLVxtY
         mz8N/C5+p4wYbgrPAufalJL12otZBZmDMphL5g+9YhKmJQH7mxFrAP3gytv1tdnwOAuM
         tgsn3KV4AoxnBmJVv5848f14UaG3TIW/RclI/5WRj9fpgwob/eugK+xncYxMPc2MYBu1
         zHyoD63uhBWZ6P18mG5bP8+USw0Z89pFF7OnV9DoAVJ1imZWnOY1ujTg0AqGSk/4j8tk
         AkfA==
X-Gm-Message-State: AHQUAuaZCJ6QvpXYVCSpElQ0cF3gbRk5uUAiE6msmM3L8zovP/szH8zt
        Sy1AkWq99m7NmUItlAHrvyPUao1bNECF/4fJV/G/HcwOcR0pQcJp7RvAVmmR2VEI6UG4LfaClem
        rrI5gwc49gAWwxYPBsM9NgtfPrpX+
X-Received: by 2002:a24:41e2:: with SMTP id b95mr7366391itd.115.1551561655425;
        Sat, 02 Mar 2019 13:20:55 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbrlqDSYpF304NXo5SygMFWy8MmsFqWt3vBqHupJ7oWGd1jLIOpSX2ZfhMfo9DaUZ6fWstTTg==
X-Received: by 2002:a24:41e2:: with SMTP id b95mr7366382itd.115.1551561655190;
        Sat, 02 Mar 2019 13:20:55 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z132sm930483itb.1.2019.03.02.13.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 13:20:54 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] isdn: mISDN: Fix potential NULL pointer dereference of kzalloc
Date:   Sat,  2 Mar 2019 15:20:43 -0600
Message-Id: <20190302212044.13638-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocating memory via kzalloc for phi may fail and causes a
NULL pointer dereference. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 124ff530da82..26e3182bbca8 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -263,6 +263,9 @@ hfcsusb_ph_info(struct hfcsusb *hw)
 	int i;
 
 	phi = kzalloc(struct_size(phi, bch, dch->dev.nrbchan), GFP_ATOMIC);
+	if (!phi)
+		return;
+
 	phi->dch.ch.protocol = hw->protocol;
 	phi->dch.ch.Flags = dch->Flags;
 	phi->dch.state = dch->state;
-- 
2.17.1

