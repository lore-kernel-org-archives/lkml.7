Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E30C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2F82086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkl4LWlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfFEONG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:13:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41228 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfFEOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:12:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so9592965plr.8;
        Wed, 05 Jun 2019 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rQ5cAV9JVUsLAwdrrM1O5TPRMwz73JZqLRqBbZ7vdx0=;
        b=mkl4LWlmnvt2DDHqNVDTjN982AZdka7KylbeLHsPRlFPb8Ko91eXw2vN/MbTCFK4K6
         V/0KfvD/l/DRVJ6PVKgElDaBROM2zzQn7hWGT4EWBUnzj4h4pOm0WlJKhCWr+tUG2k9Y
         uN2J3NmkoFeUUwV2pekjnutk6BNiwrzUN8P0xjuH7U2xVUgKiaGS7hZWSuUHZx+TSNq5
         /zZp/3vkShW4LmMUeqFyHeJJ5kp2HSrT0onJq+zEirrztCwDfzeUZimYS1yJkZFWwbAb
         ZXKvZatNxonsOZJVjfJw/QOJzJLLx89QFfpCds8hKAI0mFiF7i16GKxc1mUoE24UFqVf
         YKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rQ5cAV9JVUsLAwdrrM1O5TPRMwz73JZqLRqBbZ7vdx0=;
        b=OLhSvwFIiQlzsgJEwoc2RUk1TVrIZkXd7QpVY1HAtW58u9QBjfeIzCIL9Je+visdM3
         GpROekHXoiTTbDk0xmZ5IgwQo0JCIPec3tIODJkdnBdslKmKVGr599PPzMG/yboSHcHJ
         wpZ0mHfSTlNy/lhYQJVywmai+4wgGSfxz/PJXpPqUmQjobcYcMNOYoyyUuTfRIRPOem0
         DeoyAGtSA1pvY1Yykk/2PF2EN86MPNKUEauTBb5jlQbDZQNjKursrUub7Hea1btCltuJ
         sV3XuA+TzUXEh4ongCc3UYZbQEkcy6zHOVYkVTz0goJAVm4iH58mH1qD8Anjw/VFhkQ+
         6kbA==
X-Gm-Message-State: APjAAAXdBFbi8XohmR+vBLZDUhWVq43R0L4j2/TdwIfIJHr75F2P9cAi
        Q+zLjY3lRaFOKnYRTGWK8K0=
X-Google-Smtp-Source: APXvYqwt9vBba0fghkxA1R42UwPabG57Vw1OB94e8KD9RMo/nfBcesglEHOs/XxsrQ0RyMkSZGGI0Q==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr44511012plr.128.1559743979222;
        Wed, 05 Jun 2019 07:12:59 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id c6sm41458010pfm.163.2019.06.05.07.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:12:58 -0700 (PDT)
Date:   Wed, 5 Jun 2019 19:42:53 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: at91_udc: Remove unneeded variable
Message-ID: <20190605141253.GA7052@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at91_wakeup is always returning -EINVAL.

But usb_gadget_wakeup expects 0 on success and negative number on
failure. As per current implementation this function wont fail.

This patch removes unneeded variable and returns 0.

Issue identified by coccicheck

drivers/usb/gadget/udc/at91_udc.c:802:6-12:
Unneeded variable: "status". Return "- EINVAL" on line 821

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 03959dc..194ffb1 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -799,7 +799,6 @@ static int at91_wakeup(struct usb_gadget *gadget)
 {
 	struct at91_udc	*udc = to_udc(gadget);
 	u32		glbstate;
-	int		status = -EINVAL;
 	unsigned long	flags;
 
 	DBG("%s\n", __func__ );
@@ -818,7 +817,7 @@ static int at91_wakeup(struct usb_gadget *gadget)
 
 done:
 	spin_unlock_irqrestore(&udc->lock, flags);
-	return status;
+	return 0;
 }
 
 /* reinit == restore initial software state */
-- 
2.7.4

