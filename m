Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8BB2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC+XuLNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfE1MQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:16:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33339 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1MQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:16:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so10907494pgv.0;
        Tue, 28 May 2019 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0bzN1Wwi4oBE37qwWfqH/W0xzz6B21Rsi/lku4rA1HU=;
        b=GC+XuLNhgsspcdTlIzr9n9G1yCrMcPERolCYmerBEd3mW//yh8vCHhUwuijq01NzXK
         ULXudmEVabpd/U7dZ9bftHqQo3DZoZpeOPwQxjgVjj0Lu8ht2iUpXWg4WI/GbfU5zYEV
         c5YJ1z+9EBSdjuwEz+fgNhBTR5IagqjWFOiosspvYm3unOaWKqqEjexFj/4iepLAzpPv
         yVfYDum+z58EDwjaPfpC0Q/frTMABE5f7vltdFqOceMWp41r0NNIM6YI14xBHfbDrbxe
         mtB8GMNfxh/bXXmYiJm0VFeZEddlzF/Wgna28+TJ0hmVVYv/kmmGqSN6DV3r5fPgDn8/
         q99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0bzN1Wwi4oBE37qwWfqH/W0xzz6B21Rsi/lku4rA1HU=;
        b=ttHoRe3QIjpHkAbqfvsruDbJrN1OOgTOw1/NG4FglppVaEGI6whbSe7/pmDO/qe7Yq
         dOvXRRW8y5MWOx+dDnEu829wT5RRtejTzIvKGsOPCa7qINweIuamoNglLJO8b8fbKUIM
         rgjBIQ71yxh/dXFQeiZqEua0hMdqJHzKUlIITkI92/Q8KcHR4CSlyA+wcKQxXzpRgWEW
         k8hMQNwYW/d7P4Ww/OKNOs54dLGSzCKhmAWfJvgCSnUKJtEfsas2MB2C+xQ4ptkb368q
         1mS82MZ0ZY7JzHTT3jYlnwKyrNXL1GC8tYKzy7+KK3y3Vh3PEVqVa6zO15HCCqAZwAcB
         XcVQ==
X-Gm-Message-State: APjAAAW2OWYLnIp/bDne/peuPjyKi0iDAQ0kfDWfGORCgsaX1yoFxofB
        vZJvqHE9ip0NSWxksdUXBYU=
X-Google-Smtp-Source: APXvYqx2htZ5c7BUme8PJ4mYq+Ub94y0VjLyCWZp/yxZHUt0R+QXXZHwINt/m08IKYwIDUYYtSWoeA==
X-Received: by 2002:a62:2cc2:: with SMTP id s185mr102870467pfs.106.1559045805596;
        Tue, 28 May 2019 05:16:45 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id j22sm7448173pfh.71.2019.05.28.05.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 05:16:45 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] usb: gadget: fusb300_udc: Fix memory leak of fusb300->ep[i]
Date:   Tue, 28 May 2019 20:17:54 +0800
Message-Id: <1559045874-23818-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no deallocation of fusb300->ep[i] elements, allocated at
fusb300_probe.

The patch adds deallocation of fusb300->ep array elements.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/usb/gadget/udc/fusb300_udc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 263804d..00e3f66 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1342,12 +1342,15 @@ static const struct usb_gadget_ops fusb300_gadget_ops = {
 static int fusb300_remove(struct platform_device *pdev)
 {
 	struct fusb300 *fusb300 = platform_get_drvdata(pdev);
+	int i;
 
 	usb_del_gadget_udc(&fusb300->gadget);
 	iounmap(fusb300->reg);
 	free_irq(platform_get_irq(pdev, 0), fusb300);
 
 	fusb300_free_request(&fusb300->ep[0]->ep, fusb300->ep0_req);
+	for (i = 0; i < FUSB300_MAX_NUM_EP; i++)
+		kfree(fusb300->ep[i]);
 	kfree(fusb300);
 
 	return 0;
@@ -1491,6 +1494,8 @@ static int fusb300_probe(struct platform_device *pdev)
 		if (fusb300->ep0_req)
 			fusb300_free_request(&fusb300->ep[0]->ep,
 				fusb300->ep0_req);
+		for (i = 0; i < FUSB300_MAX_NUM_EP; i++)
+			kfree(fusb300->ep[i]);
 		kfree(fusb300);
 	}
 	if (reg)
-- 
2.7.4

