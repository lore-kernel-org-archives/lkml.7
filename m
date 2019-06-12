Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F6C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B5B208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="TvHkcos3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438352AbfFLLPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:15:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37505 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438323AbfFLLPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:15:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so6101370wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N7TfMirow0WLkJ8Qk5sTGDNuiXjkVvo5PhKfS+WN4/0=;
        b=TvHkcos3aVvBmtDnRVLiF8pREYuprtIOehZYrLYdAyjZP7EdbPz6anRT6UL2bn+1lt
         iRSNcVbOmYQ+kkQ3JbVs1+N1QXgzSkLX7YOg4L2t2XY70f8q+rjIVRsJ4twJwhJN5UVZ
         5vJXv8Lim0Z9xob8xQk0ZvGfB+Z70kXkXVtj9Vo9sPNZX6nj6jRDgEYn1CZRGWviaBdS
         8d2kZlRPWm/+iACF30dR/3uZm/5FVD9NxZ0mvNShAZQiO33Rxhr5EDslpWhYAWS2n20q
         sZ86aP63QHnIW66uQRUQxsSNaaLrpUhja+T3uqyEQLfK6EbRGrP9SJ6Yvc6TpIiuxChN
         7asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=N7TfMirow0WLkJ8Qk5sTGDNuiXjkVvo5PhKfS+WN4/0=;
        b=lbx66+IBF18MNXv+HO546yLPF3O9R4MJ5W8WP1w4FLoXK6SUE2M5mXTFQ4sS5fGUa4
         ZXa+Arr6VyQqFdjUzhVy+y3ppa4mKlo1lbjpBrAWO88J4i75EYzSpKJX2VMrS19Anjwp
         6PAFb/z2WU1donvZnQ3YqKia1nkhZqou0aoh3xqznJY5HJsYcShqdtyWbO932F2ERbqw
         onWvbiqbWTobQonh9UGR2I+q8fdZZl19Vb1HjIHKDWYNCurfx6Ika4IUVs+pMFtxiJRF
         675WXlB95CY/Yz+rEGsCzAm2CH/mSBGJzNlYL3EhFDR04pGyCrc2pBTCDFET4wnkczZL
         Yj8g==
X-Gm-Message-State: APjAAAWIpLHL9WSsBaY6eGFa8dSemZCvkOJAbluOzdfSRg5RSG4a7Nba
        /Edl4eVv8YYupdmdA8nVoOiCEQ==
X-Google-Smtp-Source: APXvYqxDqteBduXIGovJOsGxQCU7BEXqUQmBQgzI25tvhIXaofsgXxbwQoEvBU7rTYV1bD0qZFpatw==
X-Received: by 2002:a1c:1b81:: with SMTP id b123mr21041986wmb.144.1560338098580;
        Wed, 12 Jun 2019 04:14:58 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g19sm6514083wmg.10.2019.06.12.04.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:58 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/6] serial: uartps: Remove useless return from cdns_uart_poll_put_char
Date:   Wed, 12 Jun 2019 13:14:43 +0200
Message-Id: <19a9f67770e1896dde57d94b093273b503610eef.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

There is no reason to call return at the end of function which should
return void.

The patch is also remove one checkpatch warning:
WARNING: void function return statements are not generally useful
+	return;
+}

Fixes: 6ee04c6c5488 ("tty: xuartps: Add polled mode support for xuartps")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d4c1ae2ffca6..bcef254fa03c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1074,8 +1074,6 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 		cpu_relax();
 
 	spin_unlock_irqrestore(&port->lock, flags);
-
-	return;
 }
 #endif
 
-- 
2.17.1

