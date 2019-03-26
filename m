Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8732075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMSJTXlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbfCZUQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:16:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51572 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732073AbfCZUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:16:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so14027445wmf.1;
        Tue, 26 Mar 2019 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5zMrbv4HXLs7N/jpV0cgVroc3dOnsgGLlkvfpNHIpc=;
        b=JMSJTXlHyb3jBKAw6tqBAykxqAANUMzeENoPXFppgja9eQRXIWUl50QH2/lGQsCSxl
         L8OjvAacsFJVed4xsg8fjjClmCWrLbaJ1d+ABpTFTegi3Mv7F066ni+D1VyKzF7qW5lk
         j4oDfaC33yQf1pvhJb/eQxvJE/z/dyGSmKVykxFXtPSzm32dRcVjKxs5Pzk0EtvaSokF
         VPZn1tspRyBKcXQW1Hcm9WY6FhVlBcuV9Cj7HrrTjhYYdqrnNQtW6cUvsMCIamZa9AmT
         wBEHh5SwHc9HlygfBH14ymA/HrKmjDBt/WyyPWjGLteeXtccEJ0cnmfeyYhySYk3dkIU
         kP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=b5zMrbv4HXLs7N/jpV0cgVroc3dOnsgGLlkvfpNHIpc=;
        b=FRiqhbdlMzMwQ2DlnPPPyCdeyRh6keHjf/4wPsH1NhwVZxRn96ZAOkMHwRAcLnquir
         OYfT88IaPCA2feOMgfNi4uLimrLZJnr5+J6vRPnfaSmAN5CoCLnc9XRkXOnAOZ8iv9zJ
         k00kcy5xRe7zkM64LfjY8ynNufgp8K9WlEzFbQCY/f2/rxZhCZ+DHvGsARrIp2KGC5K+
         F2r29zuOkgRkwT1MG7LQkSvVjtXJLFLk08KlRivDELMB7TotDOO7L79cRcIWA2BJA33C
         kHBNL9LZOH2OoEgCHXu7+38bN3feonyAMFsb4NFiUtygbLr/CKNoIDCqIb2ZB2UHdhBd
         E+dw==
X-Gm-Message-State: APjAAAWp6wJB9ZjisDuV19v1uBQS6IXAockeUBxFspmoul9u5vLKvYIb
        /6tHEEZn9rwxfdjqgM+X2V4=
X-Google-Smtp-Source: APXvYqwT87oGi03VC4IjmKvAkWT7YBc+4rP8vQ3TZ+ni18h7fejbjVJSPRVV3HuY0SSxgwbvDsIoXA==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr16902969wmk.136.1553631368470;
        Tue, 26 Mar 2019 13:16:08 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id i17sm6890023wrs.44.2019.03.26.13.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:16:07 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 37F9C1142374; Tue, 26 Mar 2019 21:16:06 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     trivial@kernel.org, Mathieu Malaterre <malat@debian.org>,
        Sarah Sharp <sarah.a.sharp@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB/xHCI: Remove returned value 'status' since never used
Date:   Tue, 26 Mar 2019 21:15:57 +0100
Message-Id: <20190326201557.20388-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The returned value in status has never been used since
commit 4296c70a5ec3 ("USB/xHCI: Enable USB 3.0 hub remote wakeup.")
So remove 'status' completely.

Remove warning (W=1):

  drivers/usb/core/hub.c:3671:8: warning: variable 'status' set but not used [-Wunused-but-set-variable]

Cc: Sarah Sharp <sarah.a.sharp@intel.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/usb/core/hub.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 8d4631c81b9f..15a2934dc29d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3668,7 +3668,6 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	struct usb_hub		*hub = usb_get_intfdata(intf);
 	struct usb_device	*hdev = hub->hdev;
 	unsigned		port1;
-	int			status;
 
 	/*
 	 * Warn if children aren't already suspended.
@@ -3702,12 +3701,12 @@ static int hub_suspend(struct usb_interface *intf, pm_message_t msg)
 	if (hub_is_superspeed(hdev) && hdev->do_remote_wakeup) {
 		/* Enable hub to send remote wakeup for all ports. */
 		for (port1 = 1; port1 <= hdev->maxchild; port1++) {
-			status = set_port_feature(hdev,
-					port1 |
-					USB_PORT_FEAT_REMOTE_WAKE_CONNECT |
-					USB_PORT_FEAT_REMOTE_WAKE_DISCONNECT |
-					USB_PORT_FEAT_REMOTE_WAKE_OVER_CURRENT,
-					USB_PORT_FEAT_REMOTE_WAKE_MASK);
+			set_port_feature(hdev,
+					 port1 |
+					 USB_PORT_FEAT_REMOTE_WAKE_CONNECT |
+					 USB_PORT_FEAT_REMOTE_WAKE_DISCONNECT |
+					 USB_PORT_FEAT_REMOTE_WAKE_OVER_CURRENT,
+					 USB_PORT_FEAT_REMOTE_WAKE_MASK);
 		}
 	}
 
-- 
2.20.1

