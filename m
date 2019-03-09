Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E4FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE9520866
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TnxHbrAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfCIF17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:27:59 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50128 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfCIF17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:27:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 61C8ED24
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 05:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tcr_jn_u82fg for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 23:27:57 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 3034BD1A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 23:27:57 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id y70so13627677itc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 21:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8V5mykk5+M/vqjEv8YFcfZki90BeEu3bJb4Xis1EIYY=;
        b=TnxHbrAVnfyQpkFaRMRzaaJYKvl+30kdMpgqoJsManXu40sLsgW/ZINdDE3ogQVXYv
         X20cAvTZjQ4EEQCR35s839GiZFNcua6PR5PuNkMdd0ogVPnAwn/ZxtHpXT4bsq5lTXuS
         3zspFDCz4lJmtdRfiEdh+MmGyxeOtfv05CVD5t5YNwj0n3l3j46LmWM9qKjN/LrLFBVO
         ZqvBh4wpgkyYfA/hiGk5alfE/TuOivlyZ68R3+i5oN4vY6kLyH9gQQUZfO67Llenjim/
         GR06v3HlKvkWKZK36ZSGLATP3HO+QLsj1BWksc/V7UJpZiGMloHkCg57bnpUpIGUpfaZ
         /yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8V5mykk5+M/vqjEv8YFcfZki90BeEu3bJb4Xis1EIYY=;
        b=suSbtM2WDd8myeefAA/5nqf5l27w2DV/w6M//Q70g4KEAZPltijG+az59cyK3hbGNp
         2omiJLTahywQpTKxzSAlVJdlVX8vuAqgCah+YO+WZUEQJixtmeQWsZAVCeB9h5LWWFBW
         +k9L6yErDpql0LzQzKKHRTgeK81tUoIJsK8jEm8U4mSZiSZix4hz8ObLacS/2aL3ePYH
         0pSFME7vKG7LlAcXBVXQ5SKfz09RL/dRD/qKGnBWShdGumoU8lKrROyk+kmSNsUw4zC4
         QMuW8F5WoxYXDqOOyfNUw/ZmfXpfkCMTHgfZbPuSvmehFI4uzTG9+ZkT4gdwir9t6A+P
         Lf8w==
X-Gm-Message-State: APjAAAXSN31uPxC/2OA5cdM9SZj7ODp+Am1zYlUdYhkeLDJFprMydwxV
        JIbhhJQv+x1119EOZTZmlHLBSn2cWNxweLsyk2SQ3CBH7cT2la31eAA++0/Di1ymEFUk6xqqO4y
        dq+trdVhP0uiisF6CLr4xMO3H+Gjb
X-Received: by 2002:a5e:cb01:: with SMTP id p1mr816959iom.100.1552109276749;
        Fri, 08 Mar 2019 21:27:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4ouVxHrPFz9Wf/O0KMZpZm6eJ3ypst4GQbQZT4uT2oYt7asN0uRv7leTzfhq0+DSB9etWYg==
X-Received: by 2002:a5e:cb01:: with SMTP id p1mr816949iom.100.1552109276536;
        Fri, 08 Mar 2019 21:27:56 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e73sm4802512itc.39.2019.03.08.21.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:27:55 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: i40iw: fix potential NULL pointer dereferences
Date:   Fri,  8 Mar 2019 23:27:50 -0600
Message-Id: <20190309052750.16139-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_ordered_workqueue may fail and return NULL. Let's check
its return value to ensure it is not NULL so as to avoid
potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 206cfb0016f8..ad9b4f235e30 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -3256,9 +3256,21 @@ void i40iw_setup_cm_core(struct i40iw_device *iwdev)
 
 	cm_core->event_wq = alloc_ordered_workqueue("iwewq",
 						    WQ_MEM_RECLAIM);
+	if (!cm_core->event_wq) {
+		i40iw_debug(cm_core->dev,
+				I40IW_DEBUG_CM,
+				"%s allocate event work queue failed\n",
+				__func__);
+	}
 
 	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
 						      WQ_MEM_RECLAIM);
+	if (!cm_core->disconn_wq) {
+		i40iw_debug(cm_core->dev,
+				I40IW_DEBUG_CM,
+				"%s allocate disconnect work queue failed\n",
+				__func__);
+	}
 }
 
 /**
-- 
2.17.1

