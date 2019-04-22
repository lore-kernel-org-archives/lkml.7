Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E075C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A6021906
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962430;
	bh=okBKAVgy5/JgWzgyhzkFghh0wqimS1gM5WiB6aBHrIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HkP/kjQU8QdvBEVucWNVG6RGxqd8iuQg/LWx/+PxjaY8AdEhvJPrCxa6B1BLpAAji
	 4G0fREbBRXAnR6P0N80i9EN25RHFBQnGCQAZIRM28osj0WrNX4nCvMHK6ORVsmoZK/
	 b2SD1JPr8zXnmBcdON8L7TXBbAmIsUT6tKzCcopc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfDVTrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfDVTrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39AF721908;
        Mon, 22 Apr 2019 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962425;
        bh=okBKAVgy5/JgWzgyhzkFghh0wqimS1gM5WiB6aBHrIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzDN3AWm+qo3JstQ38BmtziSbZInzvj7wNz3NyBUC9vcDZJn9+/HywJeTVmjFQ6QW
         +g/Ul1ox38xjcgvjwOjAD+ldgFsIzo1CR9XzyB+TX8xaInha4aNnWpvAZR6Ce2cBJX
         gBYET+LVggJ0DGMTZ+ppmYRYVVjn9tjjqJLtMfj4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/68] usb: u132-hcd: fix resource leak
Date:   Mon, 22 Apr 2019 15:45:03 -0400
Message-Id: <20190422194516.11634-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Ojha <mojha@codeaurora.org>

[ Upstream commit f276e002793cdb820862e8ea8f76769d56bba575 ]

if platform_driver_register fails, cleanup the allocated resource
gracefully.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/host/u132-hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 5b8a3d9530c4..5cac83aaeac3 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3202,6 +3202,9 @@ static int __init u132_hcd_init(void)
 	printk(KERN_INFO "driver %s\n", hcd_name);
 	workqueue = create_singlethread_workqueue("u132");
 	retval = platform_driver_register(&u132_platform_driver);
+	if (retval)
+		destroy_workqueue(workqueue);
+
 	return retval;
 }
 
-- 
2.19.1

