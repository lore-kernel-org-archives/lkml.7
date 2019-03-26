Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00590C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC98820830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b9wro4BM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U5NbNTea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfCZIMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:12:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCZIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:12:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 511FB609CD; Tue, 26 Mar 2019 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553587952;
        bh=LpuCn0nrIOxod4WpgS2Jk2Nq1TE0TBmK90h3pB7FzzU=;
        h=From:To:Cc:Subject:Date:From;
        b=b9wro4BMnneHOUWwXC/pE6aReK4Tj5w16xmjZ/9JDF6AM/FxjTd+TGD1aefwtFOTR
         x6BWAebqrBoQEiYI3sWnUetPWrerZOuWvkLqTZtrtEqTFOQ7iRR53CjDXZgic7FKgT
         9ew5Q9zvvB/PmI7gFuX86wi/GZSpPqF0noQdWP7Y=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EBB760A60;
        Tue, 26 Mar 2019 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553587951;
        bh=LpuCn0nrIOxod4WpgS2Jk2Nq1TE0TBmK90h3pB7FzzU=;
        h=From:To:Cc:Subject:Date:From;
        b=U5NbNTeaodr/yJBpjBmIuFaheWMAWMXTcrCGeYVkdm4ssW/5k38ga9h5V6ULS+rAl
         oIzFDwpDM6OrYepWdobI59Vjz/H1+4vrLk5bMZtiItEHdRt0RuZYu5STLv125HC35v
         0SeSAjfT7QoMzllJbCQbT8dHULXRz+zBXI3QVRL8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EBB760A60
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     kjlu@umn.edu, pakki001@umn.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        colin.king@canonical.com
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] usb: u132-hcd: fix resource leak
Date:   Tue, 26 Mar 2019 13:42:22 +0530
Message-Id: <1553587942-14037-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if platform_driver_register fails, cleanup the allocated resource
gracefully.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
This patch is dependent on "usb: u132-hcd: fix potential NULL pointer dereference"
by Kangjie Lu, otherwise it may give merge conflict.

 drivers/usb/host/u132-hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 934584f..1d8d578 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3204,6 +3204,9 @@ static int __init u132_hcd_init(void)
 	printk(KERN_INFO "driver %s\n", hcd_name);
 	workqueue = create_singlethread_workqueue("u132");
 	retval = platform_driver_register(&u132_platform_driver);
+	if (retval)
+		destroy_workqueue(workqueue);
+
 	return retval;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

