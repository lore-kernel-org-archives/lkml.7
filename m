Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 08:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB8B2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 08:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TNo0YNGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCIIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 03:05:06 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:52228 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfCIIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 03:05:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 33D37C2C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 08:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dlry2C1OSfJx for <linux-kernel@vger.kernel.org>;
        Sat,  9 Mar 2019 02:05:05 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 0AC06C26
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 02:05:05 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id m15so17287831ioc.16
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 00:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+8gxduFASunNMUV+FAvjnOOYJPZHPr1JxXnGqOOIECI=;
        b=TNo0YNGrGmaTIPL1KQCv3LTWBxhhwEZujhe9xdIgG7dajplKh4Ox01AJPWxLwigGR3
         Psi48jhiTHKABH9j15Iwh2ySTACJxEOr9PlVSE4SBpPzuV13aqVNLoE4B81hd7g7I3Dc
         GZz37d3iVCbooS5ZLhhhfZSdk43QSgmq6ScmRqiEys8+6UFvbaIp1+uXmHCDiRigaAW+
         pc8EDvM1FiLL6dvmt4Vz+0dCTWdJlEPTtSqHB/DrrnPQSXiWFCH+7F3g5KkzVSsGkoXy
         9E6QtUFLmycujaZMW+4I8rv+tgaKedaqJ9MTIEij/XdwIib9wP7u3hvAJmVHwujsMeNN
         15qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+8gxduFASunNMUV+FAvjnOOYJPZHPr1JxXnGqOOIECI=;
        b=c/R0ksNcHfCXQkIP81DhS5IE1AWsBFyOSJeR3aY2307m6jBj47fbQA69kvuXtxyILv
         MGVARUSIIyk+iFR0YKYjzpbAoHO1VbTTJAkjaA5LxGHehTSjnGnsK4GK69013vjsha8J
         6w9iZQsbF7Mk6j/aLHyHhhLtf8PY4AM6YEA0NsSMTrPADW6R1eAtb1ptctt/xggHYKyh
         zd98ctbkolqpq2bij93MhqYXOdmD23Ca1AAwJzIR5a/Mjma/C3XNQ1q3MYWFHi0K7SQ5
         qCVobVkny38/ymCloNW19fZq0mEHGvIdL/3BmBRzcDYfH6ketMWv+Ngwgdumauhsi20f
         6dXw==
X-Gm-Message-State: APjAAAUFpGi6yCz7IeAL4N+BbApPscIU0C21lDQOGuzt2hVqxP/K+m+6
        xxwvZzNldnW6CTq/mwRwGcMYJTIbxsxOtyU/pvh2hL1yR39ympoP7Kfvry4ibV9kYExaFof3IMF
        ex61FrVwx6cj9hOFeF1QtSqqt+v6U
X-Received: by 2002:a02:4902:: with SMTP id z2mr13146793jaa.9.1552118703901;
        Sat, 09 Mar 2019 00:05:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFFdutzuyle8pC2v/TShojHUmlb5WTWLVUCW06SNOpO/+bN8JLnRD1Mvsx45IkrYUgG6ShdQ==
X-Received: by 2002:a02:4902:: with SMTP id z2mr13146783jaa.9.1552118703606;
        Sat, 09 Mar 2019 00:05:03 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id f201sm5088509itf.13.2019.03.09.00.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 00:05:02 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: fix a potential NULL pointer dereference
Date:   Sat,  9 Mar 2019 02:04:56 -0600
Message-Id: <20190309080456.8579-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_kzalloc fails, the fix does NULL check and returns
-ENOMEM upon failure so as to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/mfd/sm501.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index a530972c5a7e..e0173bf4b0dc 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 	lookup = devm_kzalloc(&pdev->dev,
 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 			      GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
 	lookup->dev_id = "i2c-gpio";
 	if (iic->pin_sda < 32)
 		lookup->table[0].chip_label = "SM501-LOW";
-- 
2.17.1

