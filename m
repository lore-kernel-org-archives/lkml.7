Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44600C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A25324682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm8X15pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLTC7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:59:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33865 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTC7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:59:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so3469339pln.1;
        Thu, 19 Dec 2019 18:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=bNbW/BlTT6ZvgVAq0OoCTXIr6KiWB0s9gAQzENg8Kk0=;
        b=Jm8X15pBgp294rFAoMot2kk2lFXs8FjWlGnTYgSJcWFis5Wq8YlmiLguWXbZ3rKns1
         wD6P2dZSI2vtJNtunQpP6LfSTV0BLZMbNgdwFjWauGXNoUd3tFrM/8joVYgAVyhurwVR
         SoaJ0hiNlX8uSFhJM/1PH42+1TNFjWlRQRuE3yzzxiuzFK5hDi4HRqaFvbcgcI8eaJav
         fXQ0oXYvG9BDwnf46iFZIfu8JdGxDhZhhPVEfmwE8B7tT7nhZfq5a0BJdxcsOAc4yhaF
         D3oPFz5tYiDkJXME30lY7vB+rZayJuui6OhSXBynWW3xl+j70EKbt1zdosdjd3pOPLSD
         8IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=bNbW/BlTT6ZvgVAq0OoCTXIr6KiWB0s9gAQzENg8Kk0=;
        b=g6JGDdNJoUliXLHCei0dsA6HFP3pIOi7B2Rw1JAzc6fYFV6T/24kREL9CEKlZe7m+o
         yBHFkPG9VNmWYBqutNzzuuBsWqYhWRhbbxcAoEIeFtRYbXar0Bx8bV4THpXie7ca2oCB
         CKBR/z9VgRolWkTDVc5eck7FyCUHvjVTANapZ1PLaPsS+4JJpjzPY8pZ6wb4/20rRlEV
         yWalVOfdRb1zuoRmrqCrigriiDGw0aszuUXGRSVYuCwizB9D/RzZvxElMP9PAJySEdtj
         sBCQL+rtAlAXGBQo8kxNjjhi7hELpsXk5c+0pz1WNHRbkPPCIEZXCUu9cce4xo11nG+K
         tr7A==
X-Gm-Message-State: APjAAAVblhULLbg6IeMK8U+49OzALCXB39f4uFH4hy+DwaZquAO0gGrB
        OM8RDuGmyBIPrHfVo4Sz0xc=
X-Google-Smtp-Source: APXvYqzZaI2UIUUwxjuE13+vUXr3i6YIEHow4ey3Cb74NWqxud4RqjIiQrhbYKCgVd/X8xQaOv+gVA==
X-Received: by 2002:a17:90a:22e7:: with SMTP id s94mr13870029pjc.12.1576810760702;
        Thu, 19 Dec 2019 18:59:20 -0800 (PST)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id k16sm2624831pje.18.2019.12.19.18.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 18:59:19 -0800 (PST)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: hub: move resume delay at the head of all USB access functions
Date:   Fri, 20 Dec 2019 10:59:17 +0800
Message-Id: <20191220025917.11886-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_control_msg() function should be called after the resume delay, or
you'll encounter the below errors sometime.
After the issue happens, have to re-plug the USB cable to recover.

[ 837.483573] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
[ 837.490889] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
[ 837.506780] usb 2-3-port4: cannot disable (err = -71)

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f229ad6952c0..2fb2816b0d38 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3522,6 +3522,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		}
 	}
 
+	msleep(USB_RESUME_TIMEOUT);
 	usb_lock_port(port_dev);
 
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
@@ -3544,7 +3545,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		/* drive resume for USB_RESUME_TIMEOUT msec */
 		dev_dbg(&udev->dev, "usb %sresume\n",
 				(PMSG_IS_AUTO(msg) ? "auto-" : ""));
-		msleep(USB_RESUME_TIMEOUT);
 
 		/* Virtual root hubs can trigger on GET_PORT_STATUS to
 		 * stop resume signaling.  Then finish the resume
-- 
2.17.1

