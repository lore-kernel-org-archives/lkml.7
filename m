Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEDF21744
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918378;
	bh=QhPBN9gNOBG7ibVJkM//F+zbpk+4MmzzhuRo3CiDcPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8NgYG+u23dQxQOGZKhZbewruv65UBJhgC2F4YfIVYNcXnLXyZN56/rVLztQz9Sz6
	 yzfSFvXtb1xFrJG7dZywgNeRvvFSOqKuAeCvwi7+B8gx1wcHptW3JhFOzRWUdMknEs
	 beB4BDxE6FZ7aC8434RVIYU2Do3EbWKBIPIPM4j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfEOLGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfEOLGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:06:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7327421734;
        Wed, 15 May 2019 11:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918371;
        bh=QhPBN9gNOBG7ibVJkM//F+zbpk+4MmzzhuRo3CiDcPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLF5OhwKGsbHM1Pm+Mpx9bTuBues0tkSNoeubQbqmBujFpvI0fdYbn2l9yPdZwdxw
         nk4S6TbfhR/8j5+i61vLoyEve3PXMf8UW/MWrUGqyX7rM0vA4nJDWLkxbbXB306KvI
         i9WVCHD3uUai4oRGB0qPPL417OoCez8LuQ6diJnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.4 104/266] usb: u132-hcd: fix resource leak
Date:   Wed, 15 May 2019 12:53:31 +0200
Message-Id: <20190515090725.970626912@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d5434e7a3b2e..86f9944f337d 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3214,6 +3214,9 @@ static int __init u132_hcd_init(void)
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



