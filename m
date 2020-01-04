Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2337121734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 13:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn6Z9PCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgADN1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 08:27:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39070 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgADN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 08:27:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so24789063pfs.6;
        Sat, 04 Jan 2020 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nayi2zwyuGuajOdSqQur7LRfUBI2pbtvn9hMLF8U2/A=;
        b=hn6Z9PCv8qkHhhaCdQ6Qo9ChKK9LiQgBunNfUmXzesxAl8CLOZUfevoftvqtHYUt+F
         sujKXgvxTkjFbLv9b036aBYQM0IEgpIXrhZpKRrQWkpdupYvOew0vvIfVktI3vr6SLDU
         f/0X8bO3exUEbmuuJYuUT4MGYAozcFHA52H3Jbl65+tZmcgfNKv8FAtoB64hKqKpP3Lz
         IUcR6CTrw+wCok0eLrUH0gTlotm+jDY+F9Kgwth4sHR8pHf2dKJGtIwndE5oD46ZDn7e
         IBYxuAzkpp714cAJgVRDr/zBlDGQm+FV9m5jXKUqqmg8nkONPmVUs5EtSCfOVQ9fQW+5
         mVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nayi2zwyuGuajOdSqQur7LRfUBI2pbtvn9hMLF8U2/A=;
        b=aUrmo3yEjImzoF0eUQWXgBafMnqztHRCVmfPTIGoxLg+K+UgG7LUdTNcTlsRVvNW55
         Zutv6/4T/WSc9XNVBp3ztnX6Q2w8mLzY+zKE2DrHJGrSuX+l+ZS1aV4b80mqp9kprjte
         dCY2SqhFNXRCLX4bkFO4TvbVRk32skaZADcSD8qeWpNNltFOvHClSwjx9K/9lQjFBElV
         Re9PKX/1NwV1JjHaykECs32B5w3i4uH1pGC2yNsGOcCW0Mz4wJIWsEHBsQ28C+nsE+9l
         DkXYZkX8jS2NYOraSfvRoLWTl1j4aLgCeXJp2zJPIrgG2eCeEr+KCB+whTjb4lPqVJVe
         WP+A==
X-Gm-Message-State: APjAAAVR4gQeqtrgWEvBuvO86A9jqS5fQO0YHyQlqmq0CXnrtUi/cXu3
        Xwkh0/Oal5ioBC9u1DK6orY=
X-Google-Smtp-Source: APXvYqytyzuvGruYQeK2rj/n9YTvbIw6fvDWNN66VAwuB8ylmB7OCVlCJeJY0bUoUt78dRUiozl+xg==
X-Received: by 2002:aa7:9f47:: with SMTP id h7mr96845272pfr.13.1578144472194;
        Sat, 04 Jan 2020 05:27:52 -0800 (PST)
Received: from localhost (199.168.140.36.16clouds.com. [199.168.140.36])
        by smtp.gmail.com with ESMTPSA id z13sm18525146pjz.15.2020.01.04.05.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 05:27:51 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2] usb: gadget: udc: core: Warn about failed to find udc
Date:   Sat,  4 Jan 2020 21:27:40 +0800
Message-Id: <20200104132740.29055-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not warn here, the user may not know failed to
find udc device by a gadget driver with the same name
because it silently fails. Let's print a warning in that
case so developers find these problems faster.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---

V2: fix some mistake in comments.

 drivers/usb/gadget/udc/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 51fa614b4079..9b11046480fe 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1414,6 +1414,8 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 	}
 
 	mutex_unlock(&udc_lock);
+	if (ret)
+		pr_warn("udc-core: couldn't find an available UDC or it's busy\n");
 	return ret;
 found:
 	ret = udc_bind_to_driver(udc, driver);
-- 
2.17.1

