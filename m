Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF294C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C532081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TSlntLE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCIFts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:49:48 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33444 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfCIFtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:49:47 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 2AC0ECF4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 05:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zUoukoAKWrgF for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 23:49:46 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id E9220C98
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 23:49:45 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id z131so13651625itb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 21:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O96fONrE+kQXwreD9x0PMCN0fUD5949Yh6FwwievkFM=;
        b=TSlntLE/+GUqK+WucPC+CEGjIJw/FRV60NjB80uJZBZyuPU+qDabWSs/iobJbxaLE/
         9uotZzWLaumFnS9WVTvFSKZ4BE+O2PoPXTYsy9yWveeo+1kS93jeqySCgyQS1YvDVCUf
         wNw6A1wUBPBPSu1u0/qzJhv+1bNRbcUITRjqSGZKey3emE3je85JuIUyclRPJpfLz/pN
         xWZIHdFfalxXKMv029KDtLytJSDGcsxwFpAGNUO1Ey6hCTT4bb56kIQdJ44HVjXPcUcB
         c9+6DZY/BvuI1TCaL/yPjhDopUcf2xuV/YiLpwnGcE7D3GR9sg8rw8Q/r4vE8fKHHFOA
         tKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O96fONrE+kQXwreD9x0PMCN0fUD5949Yh6FwwievkFM=;
        b=lpA4LVUk9oqRdtAQj1o7QTsm/P8VTYaM97HRMLrrbIk5zdfNldXMm0HvhuyBbgB8nW
         cqSTjM1pHYSt2D1CLvc29Nbw7BxkNIQVGVpT7K12UPdZlLN47FH22u105z4KqGO4dfw6
         JlCYobDO2EykcS07fxbsMNQcFYp2k4peGYXOMxFG+jyySguO42HENe5W+nPVBP3XMmUr
         0bXGz0wGovpymreb7/JXHguT/uToCpDmqzMO068WCuDvAYaBEuq4I37YhTBNm+xPzOuS
         ES6lwKbSdc71gDT3PHrPLcAGMXABjtOiOP6QgCAx2uTxrIObnsP5XPWqgKcSU93xlCPA
         Fr9w==
X-Gm-Message-State: APjAAAU+D3zj96ZXqwbGXDRnW5j+jUrJJRRb/p1FjMk5Xr8IGfBckASI
        rpyw4xEikgWUbgIcr0tJEY1l9ATG0++oY4gdWyMgjePL0DvInS4WYcEjScrF+5ojNG+SyeJLFK0
        l/E7lSv8za47wrNUYG22PrC6UwRfM
X-Received: by 2002:a6b:7112:: with SMTP id q18mr1360927iog.5.1552110585578;
        Fri, 08 Mar 2019 21:49:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0tMc8yAMoN0xHl9fs33DHGhKeXLxXJ8rCkhoSlFMxaDAOuU1YRnm1AYZD62hkc8X+ojlgsQ==
X-Received: by 2002:a6b:7112:: with SMTP id q18mr1360921iog.5.1552110585374;
        Fri, 08 Mar 2019 21:49:45 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id b20sm4068924ioj.12.2019.03.08.21.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:49:44 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] isdn: mISDNinfineon: fix potential NULL pointer dereference
Date:   Fri,  8 Mar 2019 23:49:34 -0600
Message-Id: <20190309054936.24784-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix returns -ENOMEM to avoid NULL
pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/isdn/hardware/mISDN/mISDNinfineon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/mISDNinfineon.c b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
index 3e01012be4ab..0fe6ddcb3fdc 100644
--- a/drivers/isdn/hardware/mISDN/mISDNinfineon.c
+++ b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
@@ -712,8 +712,11 @@ setup_io(struct inf_hw *hw)
 				(ulong)hw->addr.start, (ulong)hw->addr.size);
 			return err;
 		}
-		if (hw->ci->addr_mode == AM_MEMIO)
+		if (hw->ci->addr_mode == AM_MEMIO) {
 			hw->addr.p = ioremap(hw->addr.start, hw->addr.size);
+			if (unlikely(!hw->addr.p))
+				return -ENOMEM;
+		}
 		hw->addr.mode = hw->ci->addr_mode;
 		if (debug & DEBUG_HW)
 			pr_notice("%s: IO addr %lx (%lu bytes) mode%d\n",
-- 
2.17.1

