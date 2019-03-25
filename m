Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF105C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNQS8J9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfCYOXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:23:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33738 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCYOXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:23:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so6703462pgk.0;
        Mon, 25 Mar 2019 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkpXqE/ZOYgwKeZQPUTLuy5KfNwE6CRFadSlE/QlqlM=;
        b=iNQS8J9Vo1YrFbc9yswALqZN0PeaAFqDABUnsgxQ6/mD04OTYVThl+E25Oki/pUpBC
         dVP8a0ynS62RPxkcvzhGjuZSmuwuzGeMRdtVPD21htzTPuRfiDT+vRJaYC5vx3f1n4/d
         YVUg2RXVFCoKD4KO3dbpmAvcfA31945R9Ql45YpJD5jeo1CoPx083chR8yg9Uf/DID6g
         71kW3s/YhGEtGrzLHGJ8CyFXwv+T+nuSs2mDngZ1H0+FP+KQBOnR0aVnBpEdlgApfZtb
         J8tLVAQv1xClbXDrosFcD67b6fkCj7SSKH6azoV69NqqutRKECnlssqdkOENzPLBb/BL
         s+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkpXqE/ZOYgwKeZQPUTLuy5KfNwE6CRFadSlE/QlqlM=;
        b=HwCK0sCsCG4kAe32QxZpdNFu6pBeopOIt6GnokwXNakNPLWxWBMHWdW2/z4pHDyWzu
         +bn7v3HAgokpeIBivVflkBw92HORNcnDqlTQZH0eNdTCFeDvKIGzCVVsvZW0MHQGJCt7
         PKZU/4b2zn3mCN9qU6lqnoI96T54WQfAxB1L7F8ipUPdPbO77zN/tGa3+OZGVcoh58Nw
         rFkZFO6yqVJdSpVrG2/0+ydJcrKu4kKWxPIcHnLjODYrQMEnCLFGJ11VI7KeJjnR5uIl
         Jcob5puVIlVlZG9yPBIN4z+Zi4o3Xrv9jBDMFoGLlgVEmbAGOq2xo2iOcfQjD3zA5+Ak
         YrxA==
X-Gm-Message-State: APjAAAVHZAZYJthxiiF1QGDyBkpZctYndrDws29nU85vHALWj6UFlQ5K
        h5BNINJeN27UW1bEA9usqpziBx4h
X-Google-Smtp-Source: APXvYqxLjR746QlSHJX47ydBjXG0aDgSKKvNdy89K3qysQQkCGyVXUL3w20jhPSfsx9JZwxTT1yBcA==
X-Received: by 2002:a63:e755:: with SMTP id j21mr20729512pgk.418.1553523829056;
        Mon, 25 Mar 2019 07:23:49 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id h3sm26803767pfb.31.2019.03.25.07.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 07:23:48 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH] usbip: Support error(event) detection in vhci_tx_loop() kernel thread
Date:   Mon, 25 Mar 2019 23:23:32 +0900
Message-Id: <20190325142332.3917-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of stub driver and vudc driver, tx threads have error
(event) detection logic that is usbip_event_happened() and checks
error condition and halts the tx thread if there is an error. However,
vhci_tx_loop() has no error detection logic and there is a possibility
that an error(event) may occur before vhci_tx_loop() is executed.

For example, assume that a driver uses multiple URBs. vhci_rx_loop()
receives a URB and gives the URB to the device driver calling URB
complete function. And URB complete function calls usb_submit_urb()
and vhci_urb_enqueue() which wakes up the tx thread (vhci_tx_loop()).
And there is possible situation that the first URB is successfully
received but receiving second URB fails and the tx thread is scheduled
but not yet executed. In this situation, the tx thread must detect an
error in rx path and terminate itself when it is executed.

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 9aed15a358b7..004c91aa75ed 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -195,6 +195,9 @@ int vhci_tx_loop(void *data)
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
 
 	while (!kthread_should_stop()) {
+		if (usbip_event_happened(ud))
+			break;
+
 		if (vhci_send_cmd_submit(vdev) < 0)
 			break;
 
-- 
2.20.1

