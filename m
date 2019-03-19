Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4D62070D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="owdfHLZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfCSReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:34:17 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58418 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfCSReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:34:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id B1ED71AF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ihylXwzIJMSV for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 12:34:14 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 6D878C94
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:34:14 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id j127so18004320itj.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHtAHbP+J9rk/HCsvQZ/OREEVmI9PQysYpbFZPNW7oc=;
        b=owdfHLZkR5fCbENNseTAksuJ6rsIBmDo8LZJtse/SdgML+YcmrTZytcwZt0aKCy83o
         rWFRmlMPOaEBLNRVYaIUErRxOuwgsGTJzwV1epTJapMhjOv1c1R3rhJY9dZTOPnC/9Xk
         o9qwgMDRlE4rZB84MJ9z5ZJw/oVpA/EUoZ0JuUZvuzIikVdNomP/VQclaLWyOu2H5OGC
         RI4XX0RQyFfn+a2weBPJeEcLBQ421OfYDgxIn9S4DA6+OalH3GGrfkHq2FDAReT3dj7H
         xyHLz8BYJPbmIPWsrx/9Jov0SlGdHVXwRxTPyZIxcz+AHBoDmm5u/x9sytLkAYH+U1xs
         9S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHtAHbP+J9rk/HCsvQZ/OREEVmI9PQysYpbFZPNW7oc=;
        b=k8vC4CxWVYosochFwPTfRzoGkyS772LOdhECTWA83wl70WlOlrXjzu4kH8IaTcbyeL
         CQlb32bsiM2NQrfEVkQNDVVTLEVzIPVypHY7GD1xmhbSVDQCE9cMVWkA08rTEGACpcMw
         LHkH4oRoB593LbzWzzD9hERXgm9kgYslu9FSyAX4imd3kojyhh8iOdSGtUNg5S06wqYJ
         8aux2STBGrHq7fwbP1gzdr9r4U5pNMBr6jFjpl4Vloi3LZM/OyviEK25xr2zyrlyjdIt
         sj71aBbv4YjyAA7vQxO8aiCGmOpp4wsK4nN6wyI+x28+onEdT4w+9PRNg6RzN1hLAv53
         6kGw==
X-Gm-Message-State: APjAAAWvSSWTOhcsYTx9ra59pRm5oyvlRI7Nk1hNtKWFzrOEADknuk3L
        WyZlcdxEqM5mZbEGtX41vvYERn0bnM6YT0bJhtPz8c8o1I1pHmgV+U7vybM13a6dNDXn0jOHWvX
        jXkzIzVKa5+pBcemfWL6/1kBmUGZw
X-Received: by 2002:a24:c301:: with SMTP id s1mr1989828itg.112.1553016853987;
        Tue, 19 Mar 2019 10:34:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykk2EesaIbzRo8XM+d/y+gYsI0TBfxSAtf9FwIDBmN5wRjS1MX0brQ3WnJUh8lU1/ieIaiNA==
X-Received: by 2002:a24:c301:: with SMTP id s1mr1989807itg.112.1553016853656;
        Tue, 19 Mar 2019 10:34:13 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id p11sm5777562ios.15.2019.03.19.10.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:34:12 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: u132-hcd: fix potential NULL pointer dereference
Date:   Tue, 19 Mar 2019 12:34:06 -0500
Message-Id: <20190319173407.7279-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190319135609.GA16254@kroah.com>
References: <20190319135609.GA16254@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_singlethread_workqueue fails, the fix notifies
callers the error to avoid potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
removed "unlikely"
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
+	if (!workqueue)
+		return -ENOMEM;
 	retval = platform_driver_register(&u132_platform_driver);
 	return retval;
 }
-- 
2.17.1

