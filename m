Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D5CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B55217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swKu7CCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfKEGuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:50:09 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35725 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfKEGuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:50:08 -0500
Received: by mail-pf1-f201.google.com with SMTP id x3so15475804pfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 22:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5TtiPZ8JG3IZB9IHfZXJzJVA9bfv9F4xuxgcwBO6hmE=;
        b=swKu7CCOFsKCOAmFIWpmsKIU7pduBcL1SqT3rmb98vb6Dxl/uwlwROMOqGkwUNtk+m
         8Ej14ROYhooPiRond/JSp9GzM+cvW8btlVUnzypeL/CXta0LoH6St5ltAxsj8GK3fuFF
         moz+FFZXw0aqqeppnltv0t80+cWywykpG+tHir/JF15kbXnHGlxFJAF3wViJmx81JnIq
         NZX/5oWwR69XfrUdtGAuLr+FHOXwgNXmBrRIpppiwiNSgbArFtp4yLJ675clsmEAdqMA
         kNRyIR9nIh5ebxV2sPo5OcVDVcp+ME7Z28IxFagQY3oDbYdD4UzOrAQQ84s3GOcWrkyz
         vsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5TtiPZ8JG3IZB9IHfZXJzJVA9bfv9F4xuxgcwBO6hmE=;
        b=E+072UrFZ9/ghe3qcuqAoPCWdYD0Vjy6xxsNUQuj7ityMsdhCmRSZhkOVutI4jPr79
         wYTh1p0MGsXFnWWX6rTG+xjRwFzyn4a2PxeONdK0rmhYSQlyG1U78jCKMeKDShGuVHku
         gxjRVRIRR+5olR2EgpRo3D0I2CHPFxgcSshGtK8HGgDpX1fGEN74pNt7lpsYR+PI6z8I
         1k5CVxfs6DrWMuoe8HbYVjoZ1RFv7vncPqxI/rM8xmQNFhQa+6mI2gof8UkOgbOSJORa
         hlgMWfXldrgoe5a39Rzz0QW8LQcnNPdxkry1JJTmxIKLCIE6vbRIZizb1l3m2KKuvC4h
         hOaQ==
X-Gm-Message-State: APjAAAWq2VoNZKsFIMsYLC/q5cgg9xSy2m7qqErJRohJrw3bKcKgPnge
        8yq7+ca0A+pqmVdOYd0tUHEUcZk34rL6x4g=
X-Google-Smtp-Source: APXvYqwGRo54xKLFvAWpMkEuE+JgzaNYYlCcpLlRiqwkuvcW3Tcs2e3YTm4OBkeH9oUA2q79g2EH8wSrcCPAuQM=
X-Received: by 2002:a65:654e:: with SMTP id a14mr10978626pgw.170.1572936607242;
 Mon, 04 Nov 2019 22:50:07 -0800 (PST)
Date:   Mon,  4 Nov 2019 22:49:58 -0800
In-Reply-To: <20191105065000.50407-1-saravanak@google.com>
Message-Id: <20191105065000.50407-2-saravanak@google.com>
Mime-Version: 1.0
References: <20191105065000.50407-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v1 1/3] of: property: Minor style clean up of of_link_to_phandle()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a debug log instead of silently ignoring a phandle for an early
device. Also, return the right error code instead of 0 even though the
actual execution flow won't change.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index e225ab17f598..fbc201330ba0 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1051,8 +1051,14 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
 	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
 	of_node_put(sup_np);
-	if (!sup_dev)
-		return is_populated ? 0 : -EAGAIN;
+	if (!sup_dev && is_populated) {
+		/* Early device without struct device. */
+		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
+			sup_np);
+		return -ENODEV;
+	} else if (!sup_dev) {
+		return -EAGAIN;
+	}
 	if (!device_link_add(dev, sup_dev, dl_flags))
 		ret = -EAGAIN;
 	put_device(sup_dev);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

