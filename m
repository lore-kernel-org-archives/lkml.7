Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ECD2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eSNoAB45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfCXWtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:49:25 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:51206 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCXWtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:49:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 3B6DBB20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SIqpN3bAj5AL for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 17:49:23 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 12E23939
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:49:23 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id i1so6555487ioq.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LANmRa7KJszDSWBvJL10LMMY9zi5I+m67De+DHavWrQ=;
        b=eSNoAB45jVFfKnzij5+B6nfU55qugsZVlGbuck5hhjOhcygw9RpBbshVZzVZapZqYS
         ZcujFhHqb68GtdtTk1LfBfPOzJKnDW1euDmjSsgZ2ZAJD4w2aUHjtiASIZs6/Px881vx
         6q27C7FVx9YzbrWOZpcn+VBRkfbnEqOGl8TZkRpHdvT5ymX3HSR42y2N5td4BgUZxStj
         gf6DOPEzDtigbkSsKGuBaI6VScb2nyrVLmEXiS4PjxD9CRttUo/nkLvml97CrAty6jcT
         pMAh8Yk9yMqKIJkAw9h5GEJj7a2yb26CjZk23W616WxiWo2uWE0WNRGtqIiex9daoVhc
         oddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LANmRa7KJszDSWBvJL10LMMY9zi5I+m67De+DHavWrQ=;
        b=GW5hCfnwbWzY/UFUm6+lE8zuqpIa9V7obPZRALL3B+g0AzuMM8e2nr2k6Frj2o3Yhp
         +gHTZYIcPGXI2QP0PsOW/xuIWmRNuNjO5SeqBXmygFUl3uPIjvTNvERl+MDJrCr9q0Cx
         NkkpevFF5Jz2n2Ee2jQCFc/OIrSgpClkKjxBkNpWlZPxi/ZRkJZIJvUI/WtfRZqiJ+1p
         PcBW0B5YpaU7FU/H/0d0peOL6yvfMgUP8K2CBYL8ZHKjQEnw/kxcPKfzZ089zCkE2E1C
         gkXX3mQ2SK5T/iz/OtZAm55osBCSMhR/2HclPtwvaeWM88RytUwOWXvuh0k7gjcFFfcv
         GQDA==
X-Gm-Message-State: APjAAAWfVAmADW+4Nz1yYi89yKFKrH1iC2eNDp2J8pn0DFlgjCwGgP2t
        h1xObaWQA8o+XDx8Bm1JxGd7tKLM8IS46W1J4Z5zos6uXaAzw6UUooIzfDCETgiaFgLzRMwRvK4
        d4uTZwnEtgRMXWt+w79qo7HARjZ0W
X-Received: by 2002:a24:7d84:: with SMTP id b126mr6192529itc.58.1553467762706;
        Sun, 24 Mar 2019 15:49:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLT+BJSAp1mo0Mu2/0YoiFKic7Z/VA6u1nQzLz7mGh8hjJkRgendz6UA6VSrCuKOyuQ89INA==
X-Received: by 2002:a24:7d84:: with SMTP id b126mr6192519itc.58.1553467762504;
        Sun, 24 Mar 2019 15:49:22 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e18sm5032726itc.20.2019.03.24.15.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:49:21 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: property: fix a buffer overflow and a missing check
Date:   Sun, 24 Mar 2019 17:49:16 -0500
Message-Id: <20190324224916.1389-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, no memory is allocated for "property->value.text"; the
following strcpy will lead to a buffer overflow.

Second, no check is enforced for the return value of kzalloc,
which may lead to NULL-pointer dereference.

The patch fixes the two issues.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/thunderbolt/property.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 841314deb446..d5b0cdb8f0b1 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -587,7 +587,12 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
 		return -ENOMEM;
 
 	property->length = size / 4;
-	property->value.data = kzalloc(size, GFP_KERNEL);
+	property->value.text = kzalloc(size, GFP_KERNEL);
+	if (!property->value.text) {
+		kfree(property);
+		return -ENOMEM;
+	}
+
 	strcpy(property->value.text, text);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.17.1

