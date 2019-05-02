Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E80C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C337204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556812168;
	bh=Y4+DkkEm6qw6MrPYv/QXTPbREB3iYOpAviwK5X3+YB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vby1jP5lE9NKWG2LJqTkbj453DqhB3qsfTkQfhzZ5OQGcmneqpjm2/nJGSM+IghEJ
	 wWa7rD8iJKTu2ibs8XGFhN8VohnVSH5ByCZeNnrCobJ409BBzqawbJVQS+xE9Vz65c
	 cRfXkK1axt9FcPRj/awPKKr9rQenYdTkwcRwlvs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfEBPt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfEBPWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:22:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B88F216FD;
        Thu,  2 May 2019 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810556;
        bh=Y4+DkkEm6qw6MrPYv/QXTPbREB3iYOpAviwK5X3+YB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGjyQzAqzXJQL/vK1F3Uo90ma5OUoQVKxosQ7lyvn/H7rRrSkbMjHxJTzWzPml/fa
         Qe5Bt1FofkORud+h4LCRXkY2nH1T6DdBlbWq3kbabanYZ5SGDFzqLJaFGcODyb0PUW
         atPy2LfTgpOVFAtpact5cwyqJ7VeFZ64r2oyxZ/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mukesh Ojha <mojha@codeaurora.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.9 25/32] usb: u132-hcd: fix resource leak
Date:   Thu,  2 May 2019 17:21:11 +0200
Message-Id: <20190502143321.788945171@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143314.649935114@linuxfoundation.org>
References: <20190502143314.649935114@linuxfoundation.org>
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
index 43618976d68a..3efb7b0e8269 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3208,6 +3208,9 @@ static int __init u132_hcd_init(void)
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



