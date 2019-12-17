Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AB5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B703620716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXJVfZN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLQJvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:51:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40480 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfLQJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:51:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so5852013plp.7;
        Tue, 17 Dec 2019 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mz0FL23L69c1tpx2ygN4sLzZLSZmhkV7Slvkay3hNvM=;
        b=OXJVfZN+wUzAkeOonP0tbHHRoCC1wA9zG+K/NvBDVmyq6YoF7MEnzBb0uAo9I5EZzc
         Ma536Rf5ruYIo6KVaCZH8ngdN7d154xwdmg4d3PW5RjsrRCBoMpXdUuWtyjEwrHSPznQ
         q8AhTeh2DeF35+ktY/HqskjW8pGcN3xeA0IUUMpHsaM53Ady2jFouhOkpWq1hGOSWRVV
         f34VatGJo+/Hyj2Q9dS1R9PhRT6Wbz+Zk3mzlMjR37C5XoT/K03GVScny8bV82BxxoI1
         R3PpKQQuuDJaPG2Bq1dxwUXpryT3eZJG4OQsjd52aTHet7gb28DfCQx/0wm8D91lQLXU
         HYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mz0FL23L69c1tpx2ygN4sLzZLSZmhkV7Slvkay3hNvM=;
        b=gZA8cETVwB79QQCwld2Zu5SJnBbCK2ud8XDtyf+mJ9iqKiyXkyhqC5oC7K5cD+7uFC
         IJBV/x6N22coVmxh1PbiZ9ZAZS+R3yjQl9pnBEPl5/ixiujxg3vgg0oJ5t58g5OBBLCy
         AV33gHet+0tdZISS0l4M6wz7geeUFbAu5iemWVgfCOB/x3Ts1U1DuGVqAeOGbBBEvjPu
         O+CpsLDoFzslzK85fzH2hMzMKhDItx4IhbrikBfuz7d6DBJ+JwzfC3ZL6KZz1n9Hx/xz
         nvmlrO6T45vt+ci5+FUSaK3T2X9Um9wK/ZxyQhkETSc9hwtaPvtmQZzjgGMCCwoZq1fl
         uu0A==
X-Gm-Message-State: APjAAAW6cHdGusUUjSpfeKnKDiD2sAcTEPl0nL1HWcfYRjak8Uc+DA68
        XXcMymlWPtEBPLD4oIx2MjI=
X-Google-Smtp-Source: APXvYqxiGW9b3uK9c/V8DXYYYSApcBCsYHNjFlrQSwcb0IsPmWuT+FGHKzu7ThC7N6Q5wtdC5+JeuA==
X-Received: by 2002:a17:902:be02:: with SMTP id r2mr20684990pls.76.1576576291674;
        Tue, 17 Dec 2019 01:51:31 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id l1sm26291310pgs.47.2019.12.17.01.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 01:51:31 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: musb: Remove unnecessary check of musb->hcd in musb_handle_intr_connect()
Date:   Tue, 17 Dec 2019 17:50:23 +0800
Message-Id: <20191217095023.6878-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In musb_handle_intr_connect(), musb->hcd should be non-null, 
so the check of musb->hcd on line 783 could be dropped.

Thank Greg for good advice.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/musb/musb_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 15cca912c53e..ce57f253a8e1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -780,8 +780,7 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
 		musb_dbg(musb, "HNP: CONNECT, now b_host");
 b_host:
 		musb->xceiv->otg->state = OTG_STATE_B_HOST;
-		if (musb->hcd)
-			musb->hcd->self.is_b_host = 1;
+		musb->hcd->self.is_b_host = 1;
 		del_timer(&musb->otg_timer);
 		break;
 	default:
-- 
2.17.1

