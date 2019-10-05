Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2944BC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F419B222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJEVFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:05:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfJEVFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:05:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EECE1C057E9F;
        Sat,  5 Oct 2019 21:04:59 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-21.ams2.redhat.com [10.36.116.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E22E5D772;
        Sat,  5 Oct 2019 21:04:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: dwc3: Remove dev_err() on platform_get_irq() failure
Date:   Sat,  5 Oct 2019 23:04:49 +0200
Message-Id: <20191005210449.3926-4-hdegoede@redhat.com>
In-Reply-To: <20191005210449.3926-1-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 05 Oct 2019 21:05:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
platform_get_irq*()"), platform_get_irq() will call dev_err() itself on
failure, so there is no need for the driver to also do this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/dwc3/drd.c    | 3 ---
 drivers/usb/dwc3/gadget.c | 3 ---
 drivers/usb/dwc3/host.c   | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index b1f76628b313..c946d64142ad 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -157,9 +157,6 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
 	if (irq > 0)
 		goto out;
 
-	if (irq != -EPROBE_DEFER)
-		dev_err(dwc->dev, "missing OTG IRQ\n");
-
 	if (!irq)
 		irq = -EINVAL;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 13c97ff21dba..86dc1db788a9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3282,9 +3282,6 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 	if (irq > 0)
 		goto out;
 
-	if (irq != -EPROBE_DEFER)
-		dev_err(dwc->dev, "missing peripheral IRQ\n");
-
 	if (!irq)
 		irq = -EINVAL;
 
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 534a49609779..5567ed2cddbe 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -34,9 +34,6 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 	if (irq > 0)
 		goto out;
 
-	if (irq != -EPROBE_DEFER)
-		dev_err(dwc->dev, "missing host IRQ\n");
-
 	if (!irq)
 		irq = -EINVAL;
 
-- 
2.23.0

