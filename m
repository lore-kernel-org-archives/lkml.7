Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE589216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX9UmhsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfGZI1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:27:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44147 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:27:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so24124529pfe.11;
        Fri, 26 Jul 2019 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p4Px+/RWZA6I9d5yNI1VqxqhPCr3ngVGjSAsIYaY3SU=;
        b=BX9UmhsVaWqyOnwAoxQfJt8JV/q6tyF/jJtjuRZOC6V9eIpnfoXyB0pbjjSPV6zS6x
         FhMBwXASqWl0ImHXD9MOiT8UV+Gwf9aLwO6I4R/JkRc0lHgtOxAh6oQ+owy7xjHud9Jm
         MmjExFqt1MPo3jhJQ4y8kADD6EJWv2KcCxtCRTkr3GQtKunJJ72FpdQn5BH2uApKWcq9
         P2H0T7/Dt6a/5UoxT9nJAdy6ElesUxvINdBRwmSDIdGCreb7ZJALcXH8Yl5inRXm1kv/
         eFkT+bWgaSD2P2DVGoigaLBMKpqMY9ExXlkiGZQPaJmVfuS+LxTi2SWsaj+P4Hccn/Oh
         oqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p4Px+/RWZA6I9d5yNI1VqxqhPCr3ngVGjSAsIYaY3SU=;
        b=eyxQLg5hTTFBSP2Z0Bivzem50V1Xp/uV5cQYt8yyd9lnBvUfIKm1jurfvNNq0DyNWo
         WslF2o825YqboxvuxjW2DBWcuXzmJU0J3oC31645e33UhWrIkV9WzftkwxwGNlf0xPSk
         vTRvBx8N967HdXGVcPtMizur3AwGZNr9jqXoyJvuErtGk3et0RmnzplvqJbqh6lxK6Q6
         Hg2JlXtZnMVyBtJ6/vd7PIKcJhtVImckHpAfqwQTxJtCPShwnHOF+pXF+uDCQDnVcone
         WZ9zvayDYchHNeHkSFrbZ2dHsMMCyIsrI4Lm9XOuZKPjIxl7X8spaQcmD90BFBq2XEje
         8eqQ==
X-Gm-Message-State: APjAAAWbHwB1HoLkgfDDUqSmICkWYMp4gr3lZwjwmwh/ZJJ0ux3itYNa
        hoqEqF2IqHHYi+aKLXLm24E=
X-Google-Smtp-Source: APXvYqy7SmHTipWTx6MmfcknThtAmAsEp7j807Yd3EbZrCXLMmY8DoghydN+v38ny2QX8stnighb2Q==
X-Received: by 2002:a62:3895:: with SMTP id f143mr20775849pfa.116.1564129672394;
        Fri, 26 Jul 2019 01:27:52 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id o24sm8237244pgn.93.2019.07.26.01.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:27:51 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de, davem@davemloft.net, pakki001@umn.edu,
        tranmanphong@gmail.com, gregkh@linuxfoundation.org,
        rfontana@redhat.com, gustavo@embeddedor.com, tglx@linutronix.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: mISDN: hfcsusb: Fix possible null-pointer dereferences in start_isoc_chain()
Date:   Fri, 26 Jul 2019 16:27:36 +0800
Message-Id: <20190726082736.8195-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In start_isoc_chain(), usb_alloc_urb() on line 1392 may fail 
and return NULL. At this time, fifo->iso[i].urb is assigned to NULL.

Then, fifo->iso[i].urb is used at some places, such as:
LINE 1405:    fill_isoc_urb(fifo->iso[i].urb, ...)
                  urb->number_of_packets = num_packets;
                  urb->transfer_flags = URB_ISO_ASAP;
                  urb->actual_length = 0;
                  urb->interval = interval;
LINE 1416:    fifo->iso[i].urb->...
LINE 1419:    fifo->iso[i].urb->...

Thus, possible null-pointer dereferences may occur.

To fix these bugs, "continue" is added to avoid using fifo->iso[i].urb
when it is NULL.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 0e224232f746..8fb7c5dea07f 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1394,6 +1394,7 @@ start_isoc_chain(struct usb_fifo *fifo, int num_packets_per_urb,
 				printk(KERN_DEBUG
 				       "%s: %s: alloc urb for fifo %i failed",
 				       hw->name, __func__, fifo->fifonum);
+				continue;
 			}
 			fifo->iso[i].owner_fifo = (struct usb_fifo *) fifo;
 			fifo->iso[i].indx = i;
-- 
2.17.0

