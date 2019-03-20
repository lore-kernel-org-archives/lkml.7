Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F2F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Jo2+Tufb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfCTQeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:34:14 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33278 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCTQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:34:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id B8F23C03
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 16:34:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wh5aPjf7FJ7p for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 11:34:12 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 7E2ECBB0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:34:12 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id f5so2008689ita.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q+EDH+6Mpk7eQdDDKdoqyLJUnDYxgp9LJfW7iLiBop4=;
        b=Jo2+TufbfbReQoiRUoZqJFNHA2n96MbDED/Hn4ItFSvb7g7SobN1CLZw3FELFp/1+N
         5yY1UKIFKopBqNgBRw7kBBBn3KkbHUqUcPsxj1cItZNYyK0z1zxUMdAPSvUVsMctblrQ
         Ko2kjRN2wylx8+rnC48OSKPwT2WCpdiVXeN7vPP0Ovtgb3Ic2tNvNe1NVaZg9eB+9+G9
         7o8nXC0IzbTT/NFzazGqP8+bLhGHxSotoOPmvQ5xZqCGA3/dw82qHqil6h2BUis40pca
         mRlSODc8NCqiZb1G+ZFQUzgJio1ylpkePzOGNaWszbddTVJdHGLy8V1uBaWosD2xtVdL
         4AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q+EDH+6Mpk7eQdDDKdoqyLJUnDYxgp9LJfW7iLiBop4=;
        b=oR8Tjnz0kntT5DFHGa856EaJk1fTwbu5y2EoygYUK5ygFkZgVYR8wJ31fhUJ3Koi4P
         dXHh/t7nWqTRcAlqBjhzVHAylSSxOvBAvTuDsidDGTLVrQ3bnCt90j7Z08vqgAYUG/Ae
         a16Gp3g/xvhHvjjzHZXJsuDBXFStcac+z7FvFNME6CzO+WYMcjKK8MiNX8sHf5LLjqCN
         Z0s0/girGyl9gl4ECk4ercSsEJmAjBnmFyzRcKtwRLygB75Pqj+ZQWW9iCWBdi5YQh0L
         taQiey3rijcFCtVDyrPYaEMY8Y51QbM9bn+/IxJP4W0ml6G9jdPlx9lzdrQRkHeJFSAG
         PJMQ==
X-Gm-Message-State: APjAAAUSFdE9O2CMQvkhxPaKA0GWxeYlrZ+BVhShRI1czyCMrvxa00/Z
        PHmoBP4WiIlN31l57mMmqeYOgs+01uhBAOJA+DQWb6pCCxZ7KKTPIR9WkdIHdsA4RJkgYi77Lv3
        PyK0p+aTk9Xe0goTzdEDBqXV1Ri3H
X-Received: by 2002:a6b:e418:: with SMTP id u24mr6034367iog.128.1553099652168;
        Wed, 20 Mar 2019 09:34:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxrY/1U5mkoGHQeZKC+qtMD7silrz0rUE8pAJQE0wsi4YjFssAsY4T7oDVattVSIjDMbl61Jw==
X-Received: by 2002:a6b:e418:: with SMTP id u24mr6034352iog.128.1553099652000;
        Wed, 20 Mar 2019 09:34:12 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 134sm1266177itx.29.2019.03.20.09.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:34:11 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] thunderbolt: Fix to check return value of ida_simple_get
Date:   Wed, 20 Mar 2019 11:34:09 -0500
Message-Id: <20190320163409.30746-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In enumerate_services, ida_simple_get on failure can return an error and
leaks memory. The patch ensures that the dev_set_name is set on non
failure cases, and releases memory during failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Remove kfree in device_register failure
v1: Missed cleanup of svc in case of allocation failure and
device_register failure.
---
 drivers/thunderbolt/xdomain.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..e0642dcb8b9b 100644
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
-- 
2.17.1

