Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA2520657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 08:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gbWVThzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfCJIPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 04:15:14 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:35004 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfCJIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 04:15:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B8953BA8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 08:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cxTKBlgv7H-3 for <linux-kernel@vger.kernel.org>;
        Sun, 10 Mar 2019 03:15:12 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8467EB62
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:15:12 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id q184so2159875itd.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 00:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sR+0KRmiIOct8yRErYNoAixuC5XPvKpQ/5YDnFmMUgM=;
        b=gbWVThzw59QbPRiQ4grseBbz1WwJaZmS1q/VXYIgQCmMDC5py2zVQdLvD2A6P/uOU8
         2YlDaN0wmvblBJIG3q18kSYnSHVMChoak+xtlUYlvC6CB/htYYaXimP/vAmDl0rvKFBz
         uSYDVftkEWAAyepPHDNr2nmpwJFElvHesZkXT+/lfkZoOD+/RNvkt4LyJtiMUjznPVRq
         96cYH1+O5G3uec8SPqt0CjhyQbKn3YHKTJ7DjRDPevfjkk5nBs1g0Fz2X0cQCzXT+1F8
         zOOgFIBpa1+3S19a2AJcN2NPbAZE1eFekPxlbwv7mi7Lu/50Mtmp3ZR3xRv+NdhTKupU
         eN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sR+0KRmiIOct8yRErYNoAixuC5XPvKpQ/5YDnFmMUgM=;
        b=ZhK9R0lx8lSMgVcumTUlEPG4rkOBkkTuVPRm0snbkIkElJ3AwO7+Ca1Xao7seNWcjy
         obHMeRKu7RgYcYQFAqEZY+V8h8Wlt6G6W3/8Jy8Sp0tA/Tbm8Ys+i+xDmWoHBlkAFPau
         lH03mAyLNICOeHi7yBv+/52OPGLfuW4zFcSiQ+3JanfDwKiVrJutksjhEJSKjJFzF7f0
         QYYOXAyMUFZoIyPJKBvzmpxhNNG4zyeLSYI7KXE3C+diZukAIalzfwtSKq3b59UR4qOn
         /cUhoOSYie5IBbPVMAKSoE9I73SuJLGReL6Q3+B9z4stKRFRi9goovW4FM/+yYMfqU3B
         RnXQ==
X-Gm-Message-State: APjAAAUChvDmVs4ypQIe92MRPiQsRWKojoOAb5RAb9sW9WluC3xVwSpk
        1JFKh6y+WEwucTc7MFOFv36pp5pESenhNett+fAIIGheC6UhZFb+UDScAMNpttafirnH5LcEbyY
        Rih/KWJ+VnlwugtpQzfT7RW4w9KhM
X-Received: by 2002:a02:b901:: with SMTP id v1mr7072959jan.13.1552205711874;
        Sun, 10 Mar 2019 00:15:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfj0oTWA3dA5cVBJN2dWkNEchzkMM9FLo2/Gw3FtjaGFBJ2mnMBPp6quButsmqj7yIf7dtCw==
X-Received: by 2002:a02:b901:: with SMTP id v1mr7072951jan.13.1552205711610;
        Sun, 10 Mar 2019 00:15:11 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id o7sm938882ioh.87.2019.03.10.00.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 00:15:10 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: 8390: fix potential NULL pointer dereferences
Date:   Sun, 10 Mar 2019 03:14:53 -0500
Message-Id: <20190310081455.6097-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix returns to avoid NULL pointer
dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/8390/pcnet_cs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 61e43802b9a5..d82ecedf7366 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -289,6 +289,9 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
 
     virt = ioremap(link->resource[2]->start,
 	    resource_size(link->resource[2]));
+		if (unlikely(!virt))
+			return NULL;
+
     for (i = 0; i < NR_INFO; i++) {
 	pcmcia_map_mem_page(link, link->resource[2],
 		hw_info[i].offset & ~(resource_size(link->resource[2])-1));
@@ -1423,6 +1426,11 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     /* Try scribbling on the buffer */
     info->base = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
+		if (unlikely(!info->base)) {
+			ret = -ENOMEM;
+			goto failed;
+		}
+
     for (i = 0; i < (TX_PAGES<<8); i += 2)
 	__raw_writew((i>>1), info->base+offset+i);
     udelay(100);
-- 
2.17.1

