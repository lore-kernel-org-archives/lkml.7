Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B732184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Sz8QIu6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfCNH1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:27:22 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56258 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCNH1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:27:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id E5E93B67
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1vNlstJjASGd for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:27:20 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id B2442C4F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:27:20 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id i4so3915023itb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=djLP/qUyS3huRIWZoxZzkniDQRI72bSE9Cei/axWzzE=;
        b=Sz8QIu6HXqnsW9UCYVt09gM9pKDkVKhutg8q6tOtGVH6UcZ6Jce43GocCAuR4RbxXr
         sH304frP/+DthfT5AYLxCB6+NxJxmL6VDntkY1Qf4ubrBl/i2XYYPi8cOXSkMKm5VxDJ
         BCdlIzW7XAVcsfYfebRjR1uQ8TSABetMTwvYayBeN25yPjtHj0avspntgUSBo6e1gTii
         dvtmvIQXvlOl2FYb/VEfvqn5QK4Ys1t73ghPzLgt8FF4DaqaDkomvnmAOxaYIxT6RYiP
         +G0XYJL4jMg9LrQJrlEy7VTFWeqBrIWGHRwuNUv2ft5IKncwIgKiCdU4MKjm2WcobjAj
         m9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=djLP/qUyS3huRIWZoxZzkniDQRI72bSE9Cei/axWzzE=;
        b=j+0upmhx9xzQFiqY+zVMTt4uIhKrcfs5sSi38OSTYe5DBaPbyCuEDV8HLlLszW2JY9
         3ZCWZBhl8B+xEtCFz+FIJvZRVxcqBmxGv36lWbhjTgx0AdkCXFIY00LTZVYLmHnHv9YR
         CbU335i0jK5QKqu6oH8C7zA5LnWy1qZZ/kr4P7xb+/L5JgAFIdJJNCezKEvqJQMyBuNr
         0jfyg0vi0sqOzTXk3ExuPvq5O6xjVGW4kDAygtwvx9VfixQP1LdefttNXSEmiop+bceu
         9U+JyZptF3t2pi43QCeabyo7m5RSvCakUsSCOdoLSGz2EA/5K2Mqb/+qtEllZqOeysrp
         S0rA==
X-Gm-Message-State: APjAAAWxM1R28tNjhJHST4h0ruPmchWyW8Cd+dCmTUMwKVl0h0fq9BMo
        JCryqXyoxE1ICFGReKqJITL7xrtMynGL9IUH2tNVHX1zN1hWkr3dzQnU4+JzuIMbiHVqP+ARRRW
        B/v9oupxwZnUGJKqPqKhXYytaaPTI
X-Received: by 2002:a02:568a:: with SMTP id u10mr26969555jad.130.1552548440321;
        Thu, 14 Mar 2019 00:27:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYcTR0fi44fVKoNPOSbal03VlGI8u4mdLJJZm7omm1LFJaYn/eHgk/xg3ImdD41Ho286JVzg==
X-Received: by 2002:a02:568a:: with SMTP id u10mr26969544jad.130.1552548440071;
        Thu, 14 Mar 2019 00:27:20 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id n4sm5815711ioa.26.2019.03.14.00.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:27:19 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: u132-hcd: fix potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 02:27:11 -0500
Message-Id: <20190314072713.20666-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_singlethread_workqueue fails, the fix notifies
callers the error to avoid potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/usb/host/u132-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 934584f0a20a..6d5b532b03f8 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3203,6 +3203,8 @@ static int __init u132_hcd_init(void)
 		return -ENODEV;
 	printk(KERN_INFO "driver %s\n", hcd_name);
 	workqueue = create_singlethread_workqueue("u132");
+	if (unlikely(!workqueue))
+		return -ENOMEM;
 	retval = platform_driver_register(&u132_platform_driver);
 	return retval;
 }
-- 
2.17.1

