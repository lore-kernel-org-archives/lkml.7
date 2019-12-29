Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FCB20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643431;
	bh=SgAo8MiCmRcNxda/Wx+4lX2jC223OfII5kBxqJHI8Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NtACbI97VE81R/6FT5t0hSVuUgL4FpEuRx2iwV5w9saKozVT1tMDH4SyiFDHvITvZ
	 jSrsGmQYjM+T7YaI0PdqFHGcbnqaTQNvp2wF+fKILdmhaLLvKIIpUHuT+qqfAvX4im
	 HrfhcjINHw97EtEY7oULjvQTjtcYFft+r+l5FlD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfL2SRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfL2RX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:23:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA8E21744;
        Sun, 29 Dec 2019 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640207;
        bh=SgAo8MiCmRcNxda/Wx+4lX2jC223OfII5kBxqJHI8Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=addqcoWN2GXvX4LlLtzDjOZUML+uIWE04+/JvVlr1GWBGRrNRsOOJjNyi696xC7tG
         QIYg/iew+ARfPHAKyh0QDyQrkPGDPR9q4WyaW46lP2oxak+VIfK/XKMQp8nXL9iOHr
         pfhn65+iNTbkSLUuoIi/VmtkSLRFFF1H6rSW/FP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Rohloff <ingo.rohloff@lauterbach.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 062/161] usb: usbfs: Suppress problematic bind and unbind uevents.
Date:   Sun, 29 Dec 2019 18:18:30 +0100
Message-Id: <20191229162418.082916254@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Rohloff <ingo.rohloff@lauterbach.com>

[ Upstream commit abb0b3d96a1f9407dd66831ae33985a386d4200d ]

commit 1455cf8dbfd0 ("driver core: emit uevents when device is bound
to a driver") added bind and unbind uevents when a driver is bound or
unbound to a physical device.

For USB devices which are handled via the generic usbfs layer (via
libusb for example), this is problematic:
Each time a user space program calls
   ioctl(usb_fd, USBDEVFS_CLAIMINTERFACE, &usb_intf_nr);
and then later
   ioctl(usb_fd, USBDEVFS_RELEASEINTERFACE, &usb_intf_nr);
The kernel will now produce a bind or unbind event, which does not
really contain any useful information.

This allows a user space program to run a DoS attack against programs
which listen to uevents (in particular systemd/eudev/upowerd):
A malicious user space program just has to call in a tight loop

   ioctl(usb_fd, USBDEVFS_CLAIMINTERFACE, &usb_intf_nr);
   ioctl(usb_fd, USBDEVFS_RELEASEINTERFACE, &usb_intf_nr);

With this loop the malicious user space program floods the kernel and
all programs listening to uevents with tons of bind and unbind
events.

This patch suppresses uevents for ioctls USBDEVFS_CLAIMINTERFACE and
USBDEVFS_RELEASEINTERFACE.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Link: https://lore.kernel.org/r/20191011115518.2801-1-ingo.rohloff@lauterbach.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/devio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 62b2a7105f02..4fb4cf8c2f14 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -755,8 +755,15 @@ static int claimintf(struct usb_dev_state *ps, unsigned int ifnum)
 	intf = usb_ifnum_to_if(dev, ifnum);
 	if (!intf)
 		err = -ENOENT;
-	else
+	else {
+		unsigned int old_suppress;
+
+		/* suppress uevents while claiming interface */
+		old_suppress = dev_get_uevent_suppress(&intf->dev);
+		dev_set_uevent_suppress(&intf->dev, 1);
 		err = usb_driver_claim_interface(&usbfs_driver, intf, ps);
+		dev_set_uevent_suppress(&intf->dev, old_suppress);
+	}
 	if (err == 0)
 		set_bit(ifnum, &ps->ifclaimed);
 	return err;
@@ -776,7 +783,13 @@ static int releaseintf(struct usb_dev_state *ps, unsigned int ifnum)
 	if (!intf)
 		err = -ENOENT;
 	else if (test_and_clear_bit(ifnum, &ps->ifclaimed)) {
+		unsigned int old_suppress;
+
+		/* suppress uevents while releasing interface */
+		old_suppress = dev_get_uevent_suppress(&intf->dev);
+		dev_set_uevent_suppress(&intf->dev, 1);
 		usb_driver_release_interface(&usbfs_driver, intf);
+		dev_set_uevent_suppress(&intf->dev, old_suppress);
 		err = 0;
 	}
 	return err;
-- 
2.20.1



