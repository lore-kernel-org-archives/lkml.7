Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE552C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9429E2184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qukTmJ3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfGBH6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37061 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfGBH6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so7863712pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=64U+xwNq15ns4s/MqPHBxHaqqHD2yARwWyQRIBtqHAE=;
        b=qukTmJ3ytuKf2m1zcZDERh5w6HKuKBUj22BgMGYq5wqebcT/e6JJg8palBrk64kPPp
         PpSOepmUHwkeD4sXHBq9HU4facE1zcQznnPp4vFqEepqTZNFCUu53OeG69qFvXtf7O6d
         cUfqOr+DkPZKU5RGo+cGUNA9K1/DWWk9T9JhUY7xFOxcPJzftKJ34GMoCCc2cTIkzJgt
         FGe6ot+11LUSXZtXM9f/EWQD/4YQT4NAPkcjEAqT81xP1mgmjHBOLgoqzZnc6/clW9R4
         RcJzUX1PUW543a6hqGApkheAe6P40KL8Tc71f7BYO/tbGNr+8l8aVOm1SZdGGMt7y2ap
         6l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=64U+xwNq15ns4s/MqPHBxHaqqHD2yARwWyQRIBtqHAE=;
        b=pkBODALCI/CmIKc1laEPulYCxS07bIiUVMlC4qnk8utRAKLRdRaVo73a0o7+DpakkA
         hmCVpErvGGvnLXkyQ01WVMkZydr2garQHLYFswHCencqEcpVXxWpf0pQmR1cp8VZt+pW
         uD9z2+2asJ3+Y0VlNcRTPaZoYycDSb693V3gHpxQ2J3G0lH4/nGYq23SfUytPqusQbR0
         wL3GK2o3RY9RXm5uHve7yUzR6PQXUDs2kBkl++s32bqBJ4VFZARrrUxFh+YeccX5M5VP
         8WuA72vio7uhzQUJ6G9x2WqQftXvsEv5sT/5hVeSa936djdKbf0apm3gDNp76JBGbIwi
         3gjA==
X-Gm-Message-State: APjAAAVJTf080BmEtZijqsOfEEaetPz5hAtTrlmF0CnJmFPeiud2IA00
        OihRNPcMpL3QO3w6DDBGbRpVKTa6iX8=
X-Google-Smtp-Source: APXvYqwx4R8yd0ux710GWMV+Xz05bA8MYtOoVvL78ihZyPVGQCmORbi6RHUa5/D3KNA9/IZ+q2By/g==
X-Received: by 2002:a17:90a:26ef:: with SMTP id m102mr4030910pje.50.1562054313567;
        Tue, 02 Jul 2019 00:58:33 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q4sm1674582pjq.27.2019.07.02.00.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:58:33 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 13/27] message: fusion: remove memset after pci_alloc_consistent
Date:   Tue,  2 Jul 2019 15:58:27 +0800
Message-Id: <20190702075827.24119-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/message/fusion/mptbase.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index d8882b0a1338..845d1ef8abdf 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -4507,7 +4507,6 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "Total alloc @ %p[%p], sz=%d[%x] bytes\n",
 			 	ioc->name, mem, (void *)(ulong)alloc_dma, total_size, total_size));
 
-		memset(mem, 0, total_size);
 		ioc->alloc_total += total_size;
 		ioc->alloc = mem;
 		ioc->alloc_dma = alloc_dma;
-- 
2.11.0

