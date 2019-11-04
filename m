Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E5CA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F5C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906475;
	bh=R9g+S9y+c2VGUfwHWA0l4yuNP1TCqOTSUlsLSVpOWSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y1JuFgXxu5JL7yD8gmSM9T0eiWI1/aN0DgN3Nz8sDCifvrhV9LVwfRSDwA4lWmYd4
	 4Gp7cKSV6UZEMy9gqS9OoPMOcfR1gr3byDKRHOlM+HJISH9LHDVYxU5/tBFLYshvsN
	 71GHc1k9OUb4vuxEGoga5PKOL97hx4LmgAV0z9Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfKDW1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:27:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbfKDVtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:49:43 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9534A214D8;
        Mon,  4 Nov 2019 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904183;
        bh=R9g+S9y+c2VGUfwHWA0l4yuNP1TCqOTSUlsLSVpOWSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XhR2A+9iZWIyXFgTh+CgEHGIhHNaUIbKocht1RGQRDatTlqZ3GYp603hQXRVluwu
         KNmtbIlUDB6BU3CzjGqICEr/Im07KtNRADkFObDK5Al8+ATQWVAgDLOh9+FhS6+qga
         0HjY5r4TxYfoMgERWx4S/jPcYAPYZ3DkJ/1qIdqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan-Marek Glogowski <glogow@fbihome.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 10/62] usb: handle warm-reset port requests on hub resume
Date:   Mon,  4 Nov 2019 22:44:32 +0100
Message-Id: <20191104211911.807197912@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211901.387893698@linuxfoundation.org>
References: <20191104211901.387893698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan-Marek Glogowski <glogow@fbihome.de>

[ Upstream commit 4fdc1790e6a9ef22399c6bc6e63b80f4609f3b7e ]

On plug-in of my USB-C device, its USB_SS_PORT_LS_SS_INACTIVE
link state bit is set. Greping all the kernel for this bit shows
that the port status requests a warm-reset this way.

This just happens, if its the only device on the root hub, the hub
therefore resumes and the HCDs status_urb isn't yet available.
If a warm-reset request is detected, this sets the hubs event_bits,
which will prevent any auto-suspend and allows the hubs workqueue
to warm-reset the port later in port_event.

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 63646dc3ca27d..4a87cc4783404 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -102,6 +102,8 @@ EXPORT_SYMBOL_GPL(ehci_cf_port_reset_rwsem);
 static void hub_release(struct kref *kref);
 static int usb_reset_and_verify_device(struct usb_device *udev);
 static int hub_port_disable(struct usb_hub *hub, int port1, int set_state);
+static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
+		u16 portstatus);
 
 static inline char *portspeed(struct usb_hub *hub, int portstatus)
 {
@@ -1108,6 +1110,11 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 						   USB_PORT_FEAT_ENABLE);
 		}
 
+		/* Make sure a warm-reset request is handled by port_event */
+		if (type == HUB_RESUME &&
+		    hub_port_warm_reset_required(hub, port1, portstatus))
+			set_bit(port1, hub->event_bits);
+
 		/*
 		 * Add debounce if USB3 link is in polling/link training state.
 		 * Link will automatically transition to Enabled state after
-- 
2.20.1



