Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674C3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0920726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575977598;
	bh=4annv4BCWN8Ss8AD2TSC7cKl1pVZ+zcs+cJH7zUHP9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u4iXIG76eIBpTV43Ne498+WoaiWZfzpGPq8JOE8q4G2ObigzmWFkHUdwHr/9bBToI
	 qZUc3eprcyweQBGhqw/qSNQ8xE88wiBSv0La67gjGgSVYCmCJdKQoWMnwyiezRhUZ5
	 ePbF+V3/Qaq3kJ1vvMJvGee+YbcVt/lMeaBnoxls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfLJLdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:33:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfLJLdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:33:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so19513288ljr.0;
        Tue, 10 Dec 2019 03:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Blqzm8+uJKvQuA0CbBCrZIVx4YR1ZVnP2Lq7em2cyqU=;
        b=uIsFRSpXYpbsB3qwKImibSBrF+IbCHbbPYNWQtRgjLODgQxa655ByJ9ezyf2/j/ePL
         sjmvkt6xMrhPZla7N3ceaPPA7OdaxogjLsFaH6rj5azn6TqPiYWpt1JbkE39GuLCscp4
         F6ME7wD4sKmEyIj4wDaPpTBKTNT3naSvx9leKdDmhVll46Uu3Pwg6XjNyPkXbX/Ba4IP
         XwpfN4Jh3Dzw0zZQvXB3YOKMAHyqjQ27fV4ayNDXegz6v2G9VEXj8Bt42wHjbqH685MZ
         0tVPetmJGl72xiI/XJDoiwH/IuzLdl5VlkF0OshrmhB80WT2X0d49iYo0AZjttu+Q81X
         GMbA==
X-Gm-Message-State: APjAAAVjq8/iaM9dL03hCJLpo9s4QaXLpcBkIURWt8j0pC/v36X53eug
        pdvNwA35mn9G9UGdlHrrzoc=
X-Google-Smtp-Source: APXvYqyIW5IfmyQIRr8p5hkGBqsmCvU2d723wr+Rta8PDZbIsTTmqLcYTIyuETrZVRpDC52t7Wr7qg==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr9586456ljl.134.1575977591464;
        Tue, 10 Dec 2019 03:33:11 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id i16sm1387353lfo.87.2019.12.10.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:33:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iedlQ-00010S-4r; Tue, 10 Dec 2019 12:33:12 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] can: gs_usb: use descriptors of current altsetting
Date:   Tue, 10 Dec 2019 12:32:31 +0100
Message-Id: <20191210113231.3797-3-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210113231.3797-1-johan@kernel.org>
References: <20191210113231.3797-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 2f74f6704c12..a4b4b742c80c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -918,7 +918,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			     GS_USB_BREQ_HOST_FORMAT,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     hconf,
 			     sizeof(*hconf),
 			     1000);
@@ -941,7 +941,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			     GS_USB_BREQ_DEVICE_CONFIG,
 			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     dconf,
 			     sizeof(*dconf),
 			     1000);
-- 
2.24.0

