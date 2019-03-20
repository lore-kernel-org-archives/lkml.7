Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E63C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B042146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AXBqmV/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCTQYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:24:53 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:40422 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbfCTQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:24:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D3D20A21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 16:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mGq871n9imAF for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 11:24:49 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B0158955
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:24:49 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id p143so2539176iod.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gXJyr66VYF5HPgYe3ZQ+bHnuI2b/hRoegcIK9K63PJI=;
        b=AXBqmV/mvlpr8rbTNuVjKyEu+1uYmQ0y5/mMYI7JmgVHUOMP2IOtj40mBem4U/WJcu
         xW9zqd8JkkH4/d962J5CS492GwW0c51q1v6IUrt8r8AsO20JQnWLTa9E905KLfT3VfD3
         f/bsU+zWeffHrC6Tv8XAg3DxNj933HiqDLM9luwPXN1MlKNcc6cdNwNIZjbL2kQRNXnl
         uktGheLcy8oZa/QgjsG85tOvUnLLI3UzLzVjFNugOWQRDCryI5Jk7MkAc0lZSJzQKkRC
         B8EHpFsS2RjtL6yFIctnUjAlUihZIXwRTnc92dIrOp2ZTirzGInW3IexNhVbyLNWdxcl
         DDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gXJyr66VYF5HPgYe3ZQ+bHnuI2b/hRoegcIK9K63PJI=;
        b=CW1m++73aVClWXPWYcWgbS9yqXf2SzAVPTIlY2r8zKH0BSeDNcd16dhmiIpnW15lqI
         hJeS0luD7HyHXg5ANUm2mnJ1gwFRndfs4bVev8LLevCAygJtkWqDcw8+hCs9Akr5BZoM
         Rf71LChd6vF26QeDTGBs/676omlHYLPekbh7u6j3X9EWXWfKWNffh6sH1QNM8J1SVy/7
         XyZeRWKAZQRs+FEbOc2p1jvVHWn9RurmyjgJWMUy3Onru/a6VKr8JL5mJjs01jRGTThO
         bUUJhsHkjRkxhsuD4zDuMcwmHb0d8S0Z4R5+riNYrGdlRTmj3RzZDIKuJrdLjfVZ1lv/
         +/VA==
X-Gm-Message-State: APjAAAUsXtYnItqWfUPffcy+uvj6h/V4YNYg3KyQdPRmqdkTYsPv5akF
        3wir5AOPEDt5MpadQiQlm6JG8RwI0/2IKAYQsnLx4HwCwO8XbGJ6piOEyFgpeZBAmRUQ/r6jKeO
        srRkvN7nQGIapSitMHBRbsH/DEYzg
X-Received: by 2002:a5e:8c0b:: with SMTP id n11mr5932220ioj.265.1553099089352;
        Wed, 20 Mar 2019 09:24:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyf2Bf+dRs5G9Q93BhzgU02pv4/K3cD6MwG6ZirhirkukYfs/oPw9l6uIgGfgK8a68kVB81qw==
X-Received: by 2002:a5e:8c0b:: with SMTP id n11mr5932204ioj.265.1553099089174;
        Wed, 20 Mar 2019 09:24:49 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id e10sm959523iok.85.2019.03.20.09.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:24:48 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] thunderbolt: Fix to check return value of ida_simple_get
Date:   Wed, 20 Mar 2019 11:24:45 -0500
Message-Id: <20190320162446.30500-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In enumerate_services, ida_simple_get on failure can return an error and
leaks memory during device_register failure. The patch ensures that
the dev_set_name is set on non failure cases, and releases memory in
case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Missed cleanup of svc in case of allocation failure and
device_register failure.
---
 drivers/thunderbolt/xdomain.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..eb08275185bf 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -740,6 +740,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 	struct tb_service *svc;
 	struct tb_property *p;
 	struct device *dev;
+	int id;
 
 	/*
 	 * First remove all services that are not available anymore in
@@ -768,7 +769,12 @@ static void enumerate_services(struct tb_xdomain *xd)
 			break;
 		}
 
-		svc->id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		if (id < 0) {
+			kfree(svc);
+			break;
+		}
+		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
 		svc->dev.parent = &xd->dev;
@@ -776,6 +782,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 
 		if (device_register(&svc->dev)) {
 			put_device(&svc->dev);
+			kfree(svc);
 			break;
 		}
 	}
-- 
2.17.1

