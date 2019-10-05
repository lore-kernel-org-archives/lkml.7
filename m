Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11729C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34CA222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfJEVE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfJEVE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:04:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A8868AC6F9;
        Sat,  5 Oct 2019 21:04:56 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-21.ams2.redhat.com [10.36.116.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD0815D70D;
        Sat,  5 Oct 2019 21:04:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: dwc3: Switch to platform_get_irq_byname_optional()
Date:   Sat,  5 Oct 2019 23:04:48 +0200
Message-Id: <20191005210449.3926-3-hdegoede@redhat.com>
In-Reply-To: <20191005210449.3926-1-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Sat, 05 Oct 2019 21:04:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc3 code to get the "peripheral" / "host" / "otg" IRQ first tries
platform_get_irq_byname() and then falls back to the IRQ at index 0 if
the platform_get_irq_byname().

In this case we do not want platform_get_irq_byname() to print an error
on failure, so switch to platform_get_irq_byname_optional() instead which
does not print an error.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205037
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/dwc3/drd.c    | 4 ++--
 drivers/usb/dwc3/gadget.c | 4 ++--
 drivers/usb/dwc3/host.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 726100d1ac0d..b1f76628b313 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -139,14 +139,14 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
 	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
 	int irq;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "otg");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "otg");
 	if (irq > 0)
 		goto out;
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
 	if (irq > 0)
 		goto out;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8adb59f8e4f1..13c97ff21dba 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3264,14 +3264,14 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
 	int irq;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
 	if (irq > 0)
 		goto out;
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
 	if (irq > 0)
 		goto out;
 
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 8deea8c91e03..534a49609779 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -16,14 +16,14 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
 	int irq;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "host");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "host");
 	if (irq > 0)
 		goto out;
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
 	if (irq > 0)
 		goto out;
 
-- 
2.23.0

