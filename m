Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA360C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782A8217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwRcv4V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFNRhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:37:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38072 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:37:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so1868185pfa.5;
        Fri, 14 Jun 2019 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=UDa/dMlErc/w/xnjMIjE+h9jNB7ar19zHZIA0ksyjuQ=;
        b=lwRcv4V7KPR49dGmmNMzJadXBBNBJbWDACSzpM5ITWo4q8F2R9DAmGU5kQV33qTHEV
         nO1+/EhMbDxFhS+kTW2BRm/6P3fvAja9kKy/Pb2dVbyexfuUggi617DntHBnSZ5JtYKH
         4pm3Ghppni3qMK5g90jl00FMHW7EpsRIn0xbpOQyCMm9itN7NfwuBgkVuXlEmvO2KOgL
         ebaXumwVVG81HR8cM0xfPEB/u7SytmRWE45iHdHGUBZ7zS6jpoo7winz01PvFgm+l7wv
         HAPCSOPSYFmB4a21g1OuxeoX/XHHGkhPtSDCAH2uQUXNI4Tl31kBt68Z2xB3kt/v6RBl
         Zo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=UDa/dMlErc/w/xnjMIjE+h9jNB7ar19zHZIA0ksyjuQ=;
        b=t/DlmRXIrHwUPWRWvaFv26eqQjVgpq9CAiez8G9jqrvKKUUubYqMLDFhdMn0UzD3b2
         CXeY8dDiC6kqlGGYt2ntWo1gnzhGs0iEia8GI22iIOMPhRS3AznjbAjCz8Np7GdhkIZw
         WyHXFFFrDOME2LJ30IRO2Wb2u/7awN+qSf1tW0RsJQPLu5re2BGsb66/mZDvjZTEXjpy
         PDje8jAl8Pn0tMDQaYw3DewtwRElt2Fcm4X1jKcUm2eJDVPbh4QsvJRaDbIPGIdQM6jO
         3hrg3/tjqY7xcZOR/x7siZCimDucRyxh1y6P77tVQklGz1qIFFfO1rmeMkV0ScvriPzH
         0dUQ==
X-Gm-Message-State: APjAAAVtJ4rgwyF7r3wwd1P3jVwLEcO8xLkpuchQCGemYgtoiNWoc3RS
        dQutt1P6gdJenuF3viZOKTQ=
X-Google-Smtp-Source: APXvYqzSBQgH12dJfzAFGro+Q/GPrj/3PqGvjqwKB5y6MFgdWJrGw8eg9hOQZPo3rsj+kjhh+kS+NQ==
X-Received: by 2002:a63:490d:: with SMTP id w13mr27886324pga.355.1560533857692;
        Fri, 14 Jun 2019 10:37:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 24sm3332905pgn.32.2019.06.14.10.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 10:37:36 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Chen <Peter.Chen@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH] usb: chipidea: host: Only disable regulator if it was enabled
Date:   Fri, 14 Jun 2019 10:37:33 -0700
Message-Id: <1560533853-32574-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems, the regulator is never enabled if power is controlled by
ehci. This can happen since there is no explicit call to ehci_port_power()
from ehci_run(), but there is one from ehci_stop().

This results in tracebacks on shutdown.

WARNING: CPU: 0 PID: 182 at drivers/regulator/core.c:2597 _regulator_disable+0x190/0x1f8
unbalanced disables for usb_otg2_vbus
Modules linked in:
CPU: 0 PID: 182 Comm: init Not tainted 5.2.0-rc4-00045-gc11fb13a117e-dirty #6
Hardware name: Freescale i.MX7 Dual (Device Tree)
[<c0312f58>] (unwind_backtrace) from [<c030d70c>] (show_stack+0x10/0x14)
[<c030d70c>] (show_stack) from [<c114e4ec>] (dump_stack+0xd4/0x100)
[<c114e4ec>] (dump_stack) from [<c0347918>] (__warn+0xf4/0x10c)
[<c0347918>] (__warn) from [<c034797c>] (warn_slowpath_fmt+0x4c/0x70)
[<c034797c>] (warn_slowpath_fmt) from [<c09d0b10>] (_regulator_disable+0x190/0x1f8)
[<c09d0b10>] (_regulator_disable) from [<c09d0be0>] (regulator_disable+0x68/0xa8)
[<c09d0be0>] (regulator_disable) from [<c0e34f0c>] (ehci_ci_portpower+0x58/0x104)
[<c0e34f0c>] (ehci_ci_portpower) from [<c0df37e0>] (ehci_port_power+0x84/0xc8)
[<c0df37e0>] (ehci_port_power) from [<c0df3998>] (ehci_silence_controller+0x5c/0xc4)
[<c0df3998>] (ehci_silence_controller) from [<c0df5904>] (ehci_stop+0x3c/0xcc)
[<c0df5904>] (ehci_stop) from [<c0d9c4bc>] (usb_remove_hcd+0xf4/0x1b0)
[<c0d9c4bc>] (usb_remove_hcd) from [<c0e34978>] (host_stop+0x38/0xa8)
[<c0e34978>] (host_stop) from [<c0e2fdb8>] (ci_hdrc_remove+0x40/0xe4)
[<c0e2fdb8>] (ci_hdrc_remove) from [<c0b6a388>] (platform_drv_remove+0x20/0x40)
[<c0b6a388>] (platform_drv_remove) from [<c0b68894>] (device_release_driver_internal+0xdc/0x1ac)
[<c0b68894>] (device_release_driver_internal) from [<c0b6739c>] (bus_remove_device+0xd0/0xfc)
[<c0b6739c>] (bus_remove_device) from [<c0b63884>] (device_del+0x148/0x36c)
[<c0b63884>] (device_del) from [<c0b6a8a4>] (platform_device_del.part.3+0x10/0x74)
[<c0b6a8a4>] (platform_device_del.part.3) from [<c0b6a938>] (platform_device_unregister+0x1c/0x28)
[<c0b6a938>] (platform_device_unregister) from [<c0e2f394>] (ci_hdrc_remove_device+0xc/0x20)
[<c0e2f394>] (ci_hdrc_remove_device) from [<c0e36980>] (ci_hdrc_imx_remove+0x20/0xc4)
[<c0e36980>] (ci_hdrc_imx_remove) from [<c0b659d0>] (device_shutdown+0x17c/0x220)
[<c0b659d0>] (device_shutdown) from [<c03730d4>] (kernel_restart+0xc/0x50)
[<c03730d4>] (kernel_restart) from [<c03733c0>] (sys_reboot+0x15c/0x1ec)
[<c03733c0>] (sys_reboot) from [<c0301000>] (ret_fast_syscall+0x0/0x28)

The problem only affects imx7d systems, since all others set
CI_HDRC_TURN_VBUS_EARLY_ON. The regulator on those systems is controlled
by the chipidea driver and not by ehci.

Only disable the regulator if it was previously enabled.

Fixes: c8679a2fb8de ("usb: chipidea: host: add portpower override")
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Li Jun <jun.li@nxp.com>
Cc: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
It might be better to implement a solution in ehci, but I have no idea how
that would look like. Overall it seems odd that imx7d systems work in the
first place, even though the regulator is never enabled. It may also be
that the problem is somehow related to the mcimx7d-sabre emulation in qemu
(which is where I see it), but I have no idea how that would affect
behavior such that ehci_ci_portpower() is never called with enable=true.

Yet another possibility might be to set CI_HDRC_TURN_VBUS_EARLY_ON for
imx7d, but that would effectively just hide the problem.

 drivers/usb/chipidea/host.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index b45ceb91c735..3d63bf0e7c4b 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -26,6 +26,7 @@ static int (*orig_bus_suspend)(struct usb_hcd *hcd);
 
 struct ehci_ci_priv {
 	struct regulator *reg_vbus;
+	bool enabled;
 };
 
 static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
@@ -43,16 +44,20 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
 				"Not support multi-port regulator control\n");
 			return 0;
 		}
-		if (enable)
-			ret = regulator_enable(priv->reg_vbus);
-		else
-			ret = regulator_disable(priv->reg_vbus);
+		if (enable) {
+			if (!priv->enabled)
+				ret = regulator_enable(priv->reg_vbus);
+		} else {
+			if (priv->enabled)
+				ret = regulator_disable(priv->reg_vbus);
+		}
 		if (ret) {
 			dev_err(dev,
 				"Failed to %s vbus regulator, ret=%d\n",
 				enable ? "enable" : "disable", ret);
 			return ret;
 		}
+		priv->enabled = enable;
 	}
 
 	if (enable && (ci->platdata->phy_mode == USBPHY_INTERFACE_MODE_HSIC)) {
-- 
2.7.4

