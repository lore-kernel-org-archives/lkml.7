Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36971C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089BC206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCcZByq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfHOGBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:01:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36185 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:01:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so724775plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 23:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bmSCdnIPB1eNwZ60Q3PEiT3kdrTU05F9OKohp8Lrv6U=;
        b=hCcZByq+TgABNzIBu34g4/VXnusd7y6Lpex5x9X3JLLg9YwFvEcxQKfqyvtgujFnj+
         Qv0D1C0prHGL9PlxtUd0KEdb+ztLmtKpBsCIa2SwKAViuHT/UmguvquOEWkfNR+lNAd/
         XenD4goEDRlVjR1d3W5h6sgMAFCECZsjN9MLKBjoiLGthopOz22VUhsf9DRF2jPyQ145
         z2RJVnPGhblkHpAi35BT7H6Od8imPwnt0W8yOV46oZ30N/EoBvRB9ZWkHfHYkiZsQ46E
         /bA6QTImf/4F7WxaUZ3fSsWaxEVup8JNYSHOt7qSJOc++Vy0l6ThfBoMnxjZVryHQt1Z
         Domg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bmSCdnIPB1eNwZ60Q3PEiT3kdrTU05F9OKohp8Lrv6U=;
        b=FC2qVAOLC2t0+G3ywRCWuRckg2u4IogYjALJqwj4lntArpvlAwfLt9pOn+phbre+OT
         vm91ux5H+7ljmObtEY0yLdc/oCvCmeUszMcYmaraurr9mr1cp4/qExODrsy6uGq4GjGW
         bKH2H77HiqNBq9FoaJNd/vt0Sb/wkfiCPOawfVBYCGX8BXshOeULZxlV2xYVBXoc9UpA
         jkM3Vft3yELQMirisrx5H+j7n7eset7MBhAZjUOG+tqGKv7d8Q9G9ojDFrLv9DeUuqtj
         UBtTMaWPf6agxLovGxWrPU1kt0pCHdvbunJVvy7bygWXm30BULV1KWk1Dwl3vB2v6VjT
         znDQ==
X-Gm-Message-State: APjAAAVNSNyeGsqvRt1k/67duSu7JO+PYsxhJa9bmEyos5r462k30UE1
        lnBTYIF9clCoGFSgt6PzPeniZ8/s
X-Google-Smtp-Source: APXvYqwAGBnQSTTsWVzmoID/FtxQAy2pcPv6Z5k7uAYf/Ea5AMqq1nCrJIFpL4N/Go8xxyzFnUGMSg==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr2964869plb.144.1565848898432;
        Wed, 14 Aug 2019 23:01:38 -0700 (PDT)
Received: from localhost.localdomain ([110.225.3.176])
        by smtp.gmail.com with ESMTPSA id e6sm1860879pfl.37.2019.08.14.23.01.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 23:01:38 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] bus: arm-cci: Add of_node_put() before break
Date:   Thu, 15 Aug 2019 11:31:27 +0530
Message-Id: <20190815060127.2400-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_child_of_node puts the previous node, but
in the case of a break from the middle of the loop, there is no put,
thus causing a memory leak. Add an of_node_put before the break.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..1f84a5528073 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.19.1

