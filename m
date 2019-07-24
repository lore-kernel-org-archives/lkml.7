Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE268C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C069721734
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999988;
	bh=Hq7xfIPpMVKYh/xEQ7Nzp1ydd1HyY/Vs4u0I5IFpz+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z70zEqLL27wJR00d6oSJFdZe0CqTIPhgIOYFXwVfKdSXseOJwlpH+WCeq82EdHGdW
	 f7QsDOlL/GsW0vW8xOGdiVI4ozaYs+wOb9QFCK8lepd4ENmK3A+CBomQHbz6GjM1JL
	 A8rlyGh/Wdpcd8MrJZ7dpHeXYI9t7mxyBk0LYV5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbfGXTh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389452AbfGXThX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:37:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A556D214AF;
        Wed, 24 Jul 2019 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997043;
        bh=Hq7xfIPpMVKYh/xEQ7Nzp1ydd1HyY/Vs4u0I5IFpz+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zseMg3fB4jGFyyNt7PdamEncoVsqRx5+24NqSe1WB1m6qR9iuocbZscQ/IHVpeZR3
         5MR/EtlEFCXyf9OTho8iFaaJDeBnTk6AClAm0qjK06+orC0JnC8P15N7gWu5m4P+Um
         KZS30HezkBAeBbN9VNxdM9CU+t/3b2dhPFdcyZes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.2 252/413] xen: let alloc_xenballooned_pages() fail if not enough memory free
Date:   Wed, 24 Jul 2019 21:19:03 +0200
Message-Id: <20190724191753.800324248@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit a1078e821b605813b63bf6bca414a85f804d5c66 upstream.

Instead of trying to allocate pages with GFP_USER in
add_ballooned_pages() check the available free memory via
si_mem_available(). GFP_USER is far less limiting memory exhaustion
than the test via si_mem_available().

This will avoid dom0 running out of memory due to excessive foreign
page mappings especially on ARM and on x86 in PVH mode, as those don't
have a pre-ballooned area which can be used for foreign mappings.

As the normal ballooning suffers from the same problem don't balloon
down more than si_mem_available() pages in one iteration. At the same
time limit the default maximum number of retries.

This is part of XSA-300.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/balloon.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -538,8 +538,15 @@ static void balloon_process(struct work_
 				state = reserve_additional_memory();
 		}
 
-		if (credit < 0)
-			state = decrease_reservation(-credit, GFP_BALLOON);
+		if (credit < 0) {
+			long n_pages;
+
+			n_pages = min(-credit, si_mem_available());
+			state = decrease_reservation(n_pages, GFP_BALLOON);
+			if (state == BP_DONE && n_pages != -credit &&
+			    n_pages < totalreserve_pages)
+				state = BP_EAGAIN;
+		}
 
 		state = update_schedule(state);
 
@@ -578,6 +585,9 @@ static int add_ballooned_pages(int nr_pa
 		}
 	}
 
+	if (si_mem_available() < nr_pages)
+		return -ENOMEM;
+
 	st = decrease_reservation(nr_pages, GFP_USER);
 	if (st != BP_DONE)
 		return -ENOMEM;
@@ -710,7 +720,7 @@ static int __init balloon_init(void)
 	balloon_stats.schedule_delay = 1;
 	balloon_stats.max_schedule_delay = 32;
 	balloon_stats.retry_count = 1;
-	balloon_stats.max_retry_count = RETRY_UNLIMITED;
+	balloon_stats.max_retry_count = 4;
 
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 	set_online_page_callback(&xen_online_page);


