Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E83C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB14020665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998442;
	bh=BVnjbpkfuB/oaGGhBtb/7SiLclWRQ+wZuWJ25TgPT5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U5WwgV40G4BIeIfnhv4yjrNGTQ/VIbA0voHKmDApTHLMULWpRYMt6xknVl5edo+Ye
	 6vRUCMPMLvB3GLE6EtlYyVv+8kKViRmo1oeewkcxTrHzBArJeZ8b/Yliqlt6frFrgZ
	 v+So6UaoihwDoGMuaBjxZ9UQaSSka2r2lW2JV1FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbfGXUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405259AbfGXUAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:00:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A96422ADA;
        Wed, 24 Jul 2019 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998432;
        bh=BVnjbpkfuB/oaGGhBtb/7SiLclWRQ+wZuWJ25TgPT5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZ9Pm4npbrAgBNMrxWjVRs/ZRzmBRW3IikxCqyzl+MTCnYYXd+Jd6ejX13PA/3eUu
         GSMgxVdErDcqGCWA0Kbg9htoD4+q0CcoWLyv4QrZ97ZZ3do5E/E/IAKCn8kyNFiZCq
         42brcNigo9UJ1f7b/ZZhodF95he2f4DHghZJiRmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Lee, Chiasheng" <chiasheng.lee@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lee@vger.kernel.org
Subject: [PATCH 5.1 363/371] usb: Handle USB3 remote wakeup for LPM enabled devices correctly
Date:   Wed, 24 Jul 2019 21:21:55 +0200
Message-Id: <20190724191751.483105382@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee, Chiasheng <chiasheng.lee@intel.com>

commit e244c4699f859cf7149b0781b1894c7996a8a1df upstream.

With Link Power Management (LPM) enabled USB3 links transition to low
power U1/U2 link states from U0 state automatically.

Current hub code detects USB3 remote wakeups by checking if the software
state still shows suspended, but the link has transitioned from suspended
U3 to enabled U0 state.

As it takes some time before the hub thread reads the port link state
after a USB3 wake notification, the link may have transitioned from U0
to U1/U2, and wake is not detected by hub code.

Fix this by handling U1/U2 states in the same way as U0 in USB3 wakeup
handling

This patch should be added to stable kernels since 4.13 where LPM was
kept enabled during suspend/resume

Cc: <stable@vger.kernel.org> # v4.13+
Signed-off-by: Lee, Chiasheng <chiasheng.lee@intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3616,6 +3616,7 @@ static int hub_handle_remote_wakeup(stru
 	struct usb_device *hdev;
 	struct usb_device *udev;
 	int connect_change = 0;
+	u16 link_state;
 	int ret;
 
 	hdev = hub->hdev;
@@ -3625,9 +3626,11 @@ static int hub_handle_remote_wakeup(stru
 			return 0;
 		usb_clear_port_feature(hdev, port, USB_PORT_FEAT_C_SUSPEND);
 	} else {
+		link_state = portstatus & USB_PORT_STAT_LINK_STATE;
 		if (!udev || udev->state != USB_STATE_SUSPENDED ||
-				 (portstatus & USB_PORT_STAT_LINK_STATE) !=
-				 USB_SS_PORT_LS_U0)
+				(link_state != USB_SS_PORT_LS_U0 &&
+				 link_state != USB_SS_PORT_LS_U1 &&
+				 link_state != USB_SS_PORT_LS_U2))
 			return 0;
 	}
 


