Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8173F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bxcTuoVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCOEQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:16:05 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45422 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfCOEQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:16:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id CDC3CD32
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SBaN57QajshL for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 23:16:02 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id A4153D43
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:16:02 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id a7so3199945ioq.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O9UyWyQp5ZFQQj168ip+/BDAKMS0Io1aVPQm8I6ncn4=;
        b=bxcTuoVGLvc40tebzxLqbuuy9d15YMncTZydXxsNsaISlMv4BfhrOGvCKkUjAklhAK
         N2RshOb3NEdS/rcvz3GMwY8NHirW/SbhdUt93G9Nbb1d+GsPsMYWp3wmHU9cMQKO2v9u
         FOFuF5dnxn30SAR2wVlK92RuZO6z5a6yiBmhT6Z7FjtZz56yEHcki48cqz/PXrb95OM+
         xQSn2o4ANM2o/nMTeL1vubkud3hlJhzZyqd1FGQpD6cUqZJkOmV4Aqq1Lxn8wytK4oH4
         HjTFW5D4IhePfVBkcCZiD9LGfVIX1a6j8O1I3z+RO1T7d2yffrwA8yH/qI2+B/Kkk/2n
         JBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O9UyWyQp5ZFQQj168ip+/BDAKMS0Io1aVPQm8I6ncn4=;
        b=V/swg2dbaqxPa0D80GzDWccxmwcNyOp4E14R31zTKokfHR4qmmvkk7Z4xN0ft2dRuB
         c+9tCp3uXHUtPLTfprtxcgfuE488D/pOtJ56oFcmuz8xg8ISKi5COC7lKIeLz/NKwfz6
         ja3QEcgh5Nj8Ju7MTHR+KSi7oD48EZyg5aoBt5xrN0IOu9GwknENRcmLg7s4Ti8vOxz6
         8sSCjQRWJQKd0wDUvGI1l0HOm67wUSLUjD435n0DH+qy9BLibceAbiMoWRxHsStv+t8Q
         93dCxSxNtw8t6PmdVVylCSe+i6WZORq6jyiBW5GnRtgV8Gv7Evuqixha6hdURUhs9WF0
         aMTg==
X-Gm-Message-State: APjAAAV5kBxAT+LnBaGv7Q92xymYDhUnWU1rCnsXQe0+D+0H3n1Hhe76
        enwj0wY6fXJeevn/JB46HtFP7ozrrg3qxZxLiv/b10UWYMQuyxscn3TVBR7hA9R4m6YIDZx5tRR
        4dwEPqc+72IijgAChSLs5zZL8EVGo
X-Received: by 2002:a24:7c46:: with SMTP id a67mr699919itd.171.1552623362268;
        Thu, 14 Mar 2019 21:16:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUwxyHButHiVuP3c8WYmb5KO9bs4gCPt4oqjJjwC6SZY1E6I4sg8UlH6XEWP21V6ItOOnqjw==
X-Received: by 2002:a24:7c46:: with SMTP id a67mr699908itd.171.1552623362035;
        Thu, 14 Mar 2019 21:16:02 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e73sm505244itc.39.2019.03.14.21.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:16:01 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: smc: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 23:15:55 -0500
Message-Id: <20190315041555.1801-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case alloc_ordered_workqueue fails, the fix returns NULL
to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/smc/smc_ism.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 2fff79db1a59..e89e918b88e0 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -289,6 +289,11 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	INIT_LIST_HEAD(&smcd->vlan);
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
+	if (!smcd->event_wq) {
+		kfree(smcd->conn);
+		kfree(smcd);
+		return NULL;
+	}
 	return smcd;
 }
 EXPORT_SYMBOL_GPL(smcd_alloc_dev);
-- 
2.17.1

