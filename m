Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60260C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC0F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dfTUXLhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCLIUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:20:42 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:34246 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:20:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E2CDE692
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CMu_h7yREA6H for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 03:20:40 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id AF38F624
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:20:40 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id j127so1542856itj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6pXfUIxIQnph85qeigpOHBJdfRlD+BkO94R1xL/k3ys=;
        b=dfTUXLhYInVeRrm8NTfldheTVidbCXTfOANSZv3ZHLWY01F48xge8vVvOV2Tm6chBR
         qxJJ7nMdCpr/YpBMsrygKDRre2y1p9IAiJ/v4ohVKY75Fuq/mdwbr6sSAstbqUSFngxS
         G+QtYCVo7S85Gasz5q4Pr5oTM/jQ21sDIZ1ycDlJkykJJhA162AHhy7V064OqvIDplhN
         rHojbPHo33zxgqKQslN5ypHfDwv+Uu26puRebIf1PB6sVaoA/HeZhcKWC6DSj2tgs/st
         BzSPN94QUcBjkAcg2r+M6uzqeEpFR7PS6egeeQUdYbiOiPgpgN4hmgtMGi9/oaIRu3Qv
         4puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6pXfUIxIQnph85qeigpOHBJdfRlD+BkO94R1xL/k3ys=;
        b=ClHRVCOkQoMs0zPR65sk+dn5zs2bksa+Pd+fqjdczF+VleYxZEIqkwiHQvR0xpLyzx
         w+FHZDLLQLfQjFfnkPCo/o2gJvRT/rvDn8mOwMwH4K9+7qVYn+38dqVLYF3QwO/mCJJo
         6RpMnkQI4RrE6JSFM1zfY71qumNskpebDBKhyHcZZTxoT5ClwTwKTD3hA7UZNBl/Q5XL
         y4Tn2jGVuVKXvt5k13hrBEpLhrvnp3PhbpBSGCfc9oFjR6icsSRih/CalJa6+RLFjo7B
         jX3c7mat6cUbb8BgiH8zO+IoNhDiHU/9dB6VezhjNPkalgHCAk0IAswTgaMgTyc+Jp2A
         1UnA==
X-Gm-Message-State: APjAAAWcDE9nzr5tIfTC/3vVYgE2korg9IHtCLabObs5vnGJhL4iDyAg
        LeLVOP96ViwQP1xf5avxlQ7e35GF8x4ORBig9MPNiFV/BinW0H0KoUWFMuaurJGE8tb3zUS8Glz
        LEi0L2SYanNU093d5lkkYXnvCEmkl
X-Received: by 2002:a02:c914:: with SMTP id t20mr1311306jao.29.1552378840337;
        Tue, 12 Mar 2019 01:20:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxx7OyI740fzNpPsmdmOzldE83zpRp6vLwBJdEcDlRn+RDQ3Ss8kYrATO8AMmjDSyvz8d9luQ==
X-Received: by 2002:a02:c914:: with SMTP id t20mr1311295jao.29.1552378840114;
        Tue, 12 Mar 2019 01:20:40 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id d135sm998676itd.43.2019.03.12.01.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 01:20:39 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvdimm: namespace_devs: fix a potential NULL pointer dereference
Date:   Tue, 12 Mar 2019 03:20:34 -0500
Message-Id: <20190312082034.5846-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix goes to blk_err to avoid NULL
pointer dereference

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/nvdimm/namespace_devs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 4b077555ac70..6f65261e151f 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2245,9 +2245,12 @@ static struct device *create_namespace_blk(struct nd_region *nd_region,
 	if (!nsblk->uuid)
 		goto blk_err;
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
-	if (name[0])
+	if (name[0]) {
 		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
 				GFP_KERNEL);
+		if (!nsblk->alt_name)
+			goto blk_err;
+	}
 	res = nsblk_add_resource(nd_region, ndd, nsblk,
 			__le64_to_cpu(nd_label->dpa));
 	if (!res)
-- 
2.17.1

