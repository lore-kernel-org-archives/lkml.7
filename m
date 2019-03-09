Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EDA2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 07:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="GW4DaVv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCIH71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 02:59:27 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:57346 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfCIH70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 02:59:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id EFD58D5F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 07:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id okxMA6o7qNlK for <linux-kernel@vger.kernel.org>;
        Sat,  9 Mar 2019 01:59:24 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id C46CFD5B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 01:59:24 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id l10so17200530iob.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YE4caVrt86ca20EnitrvlK6jc9Gx5N4MPbxejNccVNY=;
        b=GW4DaVv9PKTqcoUXrP/7WVEfWxDIpzn9jj0FcLYWAjiww/TsJcmzDfqEF6oHcNk0aJ
         PuLXRUtcoN8VYLdhtgeZO0xv4Z/9l2e62YPtF0utNROELR+Zngwm0LD73ohGI8l6BE5b
         imLiv/2XaEyID8tXy3mXldCi1POJ5z9zlvk996rxhGtElZsQRc39qQx7D+18J1DE78Mi
         I3GP9hRiXJNDAddXlAWhFruGboEFNbW6/mL49bRp0PavSYpZQnVjI9auKlZzAcR1VlG1
         U+4HkoeddVcMF/Dr44bLVIVOABX+x3iX3D+6IZYuFWmyi2fWsVKd/nSEDGrM67Ta9fyr
         +f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YE4caVrt86ca20EnitrvlK6jc9Gx5N4MPbxejNccVNY=;
        b=jgQQYmDUzmqn5K4pY+cyubPhm3VeVqmsh0GyK/2x4giEAF6u8cD0cbJtDf47TO3yED
         wkeM0dEHYyhd7YjZVC3HL21DBYdyZxp8n7cX4V7NR8xId4aRUlX+LOBoaFDNGv9Vt5zl
         SMsYxeEt2v90GqSn/i+BW7ns/AGGlmOkSPIDthOyAzJsj1OAKxxB9MgHeItOZj+guo9F
         52vTP9X0JabHTgbKSr+LbZmGxoOoZ9FNTR0Cni12aFQ3Q4FMLKLkzQdbJ/LJ0SNqj7SF
         FI3oN5F3l+HNMmiFJVdqRtpqu/FVNqE5pIbrx810Ie5S6xEVU+NJcPkxYJr6VnKVY+Ju
         8Ahw==
X-Gm-Message-State: APjAAAWOLK7veHeb/xDNrQ/XYTUeRlSxIYyGr+/VanhSIsmw7mJahV/3
        fBwFrZOQxvXk4/j8Kb4jxVg/Dyd7pE0bSq98JwnhBaR/VVJ1jbSXim+tkRsMFhluFI+EcP3NVsc
        FgHeJQjzvGu4rKmtqxY8NX+jd0rZ9
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr11063250itd.171.1552118364344;
        Fri, 08 Mar 2019 23:59:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvks7mhh7nY8/tI9VyhWMCQkHRdkBH+QBPtDOl/0AnFXRdITi0lcIY366rFTwDsKS05Gimog==
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr11063239itd.171.1552118364100;
        Fri, 08 Mar 2019 23:59:24 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i14sm5504363itc.34.2019.03.08.23.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 23:59:23 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Maxim Levitsky <maximlevitsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memstick: fix a potential NULL pointer dereference
Date:   Sat,  9 Mar 2019 01:59:17 -0600
Message-Id: <20190309075917.6791-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_ordered_workqueue fails, the fix returns ENOMEM to
avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/memstick/core/ms_block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 82daccc9ea62..8e00de414567 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2149,6 +2149,11 @@ static int msb_init_disk(struct memstick_dev *card)
 
 	msb->usage_count = 1;
 	msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
+	if (!msb->io_queue) {
+		rc = -ENOMEM;
+		goto out_put_disk;
+	}
+
 	INIT_WORK(&msb->io_work, msb_io_work);
 	sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
 
-- 
2.17.1

