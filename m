Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83882C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfDVQjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:39:37 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.222]:40499 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbfDVQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:39:36 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id EFAD68084F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 11:39:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Ibyhh5Lbx2qH7IbyhhQA9V; Mon, 22 Apr 2019 11:39:35 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=39364 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hIbyh-001iky-5S; Mon, 22 Apr 2019 11:39:35 -0500
Date:   Mon, 22 Apr 2019 11:39:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPI: event: replace strcpy() by strscpy()
Message-ID: <20190422163934.GA2636@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.103
X-Source-L: No
X-Exim-ID: 1hIbyh-001iky-5S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.103]:39364
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strcpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warnings:

"You might overrun the 15-character fixed-size string event->bus_id
by copying bus_id without checking the length."

"You might overrun the 20-character fixed-size string event->device_class
by copying device_class without checking the length."

Addresses-Coverity-ID: 139001 ("Copy into fixed size buffer")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/acpi/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 5a127f3f2d5c..47f21599f2ab 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -131,8 +131,8 @@ int acpi_bus_generate_netlink_event(const char *device_class,
 	event = nla_data(attr);
 	memset(event, 0, sizeof(struct acpi_genl_event));
 
-	strcpy(event->device_class, device_class);
-	strcpy(event->bus_id, bus_id);
+	strscpy(event->device_class, device_class, sizeof(event->device_class));
+	strscpy(event->bus_id, bus_id, sizeof(event->bus_id));
 	event->type = type;
 	event->data = data;
 
-- 
2.21.0

