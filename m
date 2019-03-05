Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F8EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5B120684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYR0jpoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfCEPLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:11:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35672 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfCEPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:11:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so5839568pgd.2;
        Tue, 05 Mar 2019 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9iTifxXjGmAi8MDFxxgTGnJK9Mg5GDC/s7gXfuRQ2HY=;
        b=SYR0jpoS0AahXnovteEllkGqx4Mn3i7fcd1A5SFuPU1JwnZtzQIZCD8vl35J+DXKtc
         2f0k6JcvFvmpoI1j1fdo71l4hHrWfmfOSjJ1ZApY56zkHH+VgHG0J0KoHGP/fBqUNjcd
         c0HF44VjlY8KBJmBdCwY2rckx3lRF9YXAjyyy7iOQX6EjALzUEeVKcfYD9c2Dh1PJfBH
         fJYyCt/icX8wmeSXYgfekRAsodwDRWncs7O1raYo16WsPoglr+MpOB2OYcgsvYzOfLhQ
         r3Tjkam/ZF30HnmqaLrKWYNq1lIxYoAc2R7nAV4CUZAw2OV+WxA42fPAwvKSQA1HYbEC
         q4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9iTifxXjGmAi8MDFxxgTGnJK9Mg5GDC/s7gXfuRQ2HY=;
        b=p7qF7Oi1F/xuQOwF66RXuoCh0B1CiK3kpss4ykiEoaa6h2POzhW/WivnvQ59KARwGe
         yyYWLEkNZtVX5mJTnuH1C50jXRHL9V3BuPNfk9B0aJw6TygBDT93igIuXdI/eQ1zk0tb
         CeEEsqejCgMDIYnoWWK0GC8qDERaOyjNU/zyL9BZYsfBirzu8CFwUF5K9Hx4E0okEuO9
         aLHYQWv2KUUdEOU0TQ0zMKibJKw83YAZt0xo+Py2cGSCdUf9gQLt+2FkD2MV+7UKg1Dj
         BaAl5WaMFE6WFiwAUAmArzl1PoCO0Gu+Rqo2dYxUXknp/FZAhAVyDWsu3b+M/9kFZRe6
         aFUA==
X-Gm-Message-State: APjAAAVG4P4qq0br8AhHUC8THZNhkqbT2LYV4Uo7GHOqLb3kQnmhPrJj
        xJDLCdsOd871duabchjaTYM=
X-Google-Smtp-Source: APXvYqxt0b0tIOAOppdXosAH6vPJGDN/Ih/54jeLa5Y0SiwjE6/9vc5jnmjfLSKtnRgH45k8DG47Bg==
X-Received: by 2002:a63:9dc3:: with SMTP id i186mr1763159pgd.305.1551798706365;
        Tue, 05 Mar 2019 07:11:46 -0800 (PST)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id k8sm11906707pgg.75.2019.03.05.07.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 07:11:45 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH] usbip: Remove unnecessary null check
Date:   Wed,  6 Mar 2019 00:11:10 +0900
Message-Id: <20190305151110.4366-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"vdev" points to vhci_hcd->vdev[] array and vhci_hcd->vdev[] array
is not a pointer array but a structure array and it is already used
in vhci_urb_enqueue() and then passed to vhci_tx_urb() as an argument.
vhci_tx_urb() is not called except vhci_urb_enqueue(). So, "vdev"
can not be null pointer. This null check statement is meaningless.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index f46ee1fefe02..667d9c0ec905 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -654,15 +654,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
 {
 	struct vhci_priv *priv;
-	struct vhci_hcd *vhci_hcd;
+	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	unsigned long flags;
 
-	if (!vdev) {
-		pr_err("could not get virtual device");
-		return;
-	}
-	vhci_hcd = vdev_to_vhci_hcd(vdev);
-
 	priv = kzalloc(sizeof(struct vhci_priv), GFP_ATOMIC);
 	if (!priv) {
 		usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
-- 
2.20.1

