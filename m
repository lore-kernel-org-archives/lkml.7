Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E09EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C50F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHTtXiSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfHHHky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:40:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33340 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:40:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so43087003plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S1vYkeYnIxIk+ekzL7HnbTBc0znZIC9jl5tqToA9XB4=;
        b=ZHTtXiSKFKHjb5U1lPeJeduG1GXr7+0yr3xUr7c5TBXVYfgBChZzX6xDyX4ohsQTe5
         t3j6jxkCMTrTy+DdX+9Ry2wvIWlPoiM1plDSuuVXGpjFE1sQCOMCGpv6xmFbOG5DRk4M
         Us8Ko7x0k9Wr306BVVDrOUn4bam2DpEr6dww2ObMXIk+iOE3Ry2hZVN7uJs+snXgPGdI
         M2KxwpfqK9UQaCzZrl30fvjv6QuzkJEmk0O6N0G07J5FLgaVqLgVCyc4Neyfqki2Q7ZI
         35DdB26ApzVrhOwV7zXxgMpHGXGK/3hsKURH+GiPzv8Jn91FvGBn5rUTyQMsFaodjFaL
         IfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S1vYkeYnIxIk+ekzL7HnbTBc0znZIC9jl5tqToA9XB4=;
        b=YSG1+Bw+Z9xwz/faX/WUt2mQ3Nv2tAh6lWQNwakoPOIbfM/jpiy+PFRR0mXtWFVSKG
         8/YE0/qiBlw+OIfb1gPtLIrIZDSISoD+S5bX6gkWnMsU60/Y0WdLZzSbz/0/qh/Yo0sS
         paEx4nDN0NZMz13JvnpOeVJs6UasM3T/GgKxkx7Hv07u7qFIQ+RGqBx2v5a2FWHbYNv8
         51LQ1gJ7bRRpgdR0Zodeg6OPpt6uheB/oMJGzEdMIFnrmthVqdA34UEl1ZEsOqusws2B
         Fn5Krva4imjuMBtd//QrAXb4f8o1exEaWPSTqDm2fsp67oA6fEmyc4WEMSat298jAnox
         0avA==
X-Gm-Message-State: APjAAAVxnm9duJZkXlw9/1h2PedOP1gtRxZ+wWo8yDW0s/9SXTYd5vtC
        bfHa4/SKqN12MBR3sl0iM5Cjet2h5z0=
X-Google-Smtp-Source: APXvYqzw+NZOVyoNLgRtX7zi8xwFsnDOAlQbn8ElgyujZ+S+W8KmPz03bKCyYbV0s394Kb2IW3K3Tw==
X-Received: by 2002:a17:902:4501:: with SMTP id m1mr793642pld.111.1565250053962;
        Thu, 08 Aug 2019 00:40:53 -0700 (PDT)
Received: from localhost.localdomain ([122.163.44.6])
        by smtp.gmail.com with ESMTPSA id b6sm81736833pgq.26.2019.08.08.00.40.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:40:53 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     tony@atomide.com, rogerq@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] bus: ti-sysc: Remove if-block in sysc_check_children()
Date:   Thu,  8 Aug 2019 13:10:42 +0530
Message-Id: <20190808074042.15403-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sysc_check_children, there is an if-statement checking
whether the value returned by function sysc_check_one_child is non-zero.
However, sysc_check_one_child always returns 0, and hence this check is
not needed. Hence remove this if-block.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/bus/ti-sysc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd8305d..bc8082ae7cb5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -637,8 +637,6 @@ static int sysc_check_children(struct sysc *ddata)
 
 	for_each_child_of_node(ddata->dev->of_node, child) {
 		error = sysc_check_one_child(ddata, child);
-		if (error)
-			return error;
 	}
 
 	return 0;
-- 
2.19.1

