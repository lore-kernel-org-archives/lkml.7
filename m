Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C82B2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+PUEsP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfDAOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:16:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfDAOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:16:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so1621116ply.4;
        Mon, 01 Apr 2019 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GBtnr2uifv1rgyZVj+RwOSUrZwnVglgOBD2QtelHA8g=;
        b=C+PUEsP+oDsyOub8aY7acbpw7Nj8RrKt+1kmm+dFlYJPOS5eajTsdPhUb8l9XA/8Py
         xadPWVrT1IBAA7/YWJ2iLjD2gBMkmnhw3oP/d4NsWn/m9yXGHT/dkiPNrT8s/v8/WDYW
         WiLxaJKyE73LaoZtSzBIfG2BmMnacbljufoIFhWhh+yWf5vajWWk1+ue4wUPb7lAM6uC
         SWWIc6ELbmW1JqbdL3ygpWWuWdF4dNXqJu9VVO+5kdzgYd4cD6o6PpfeTa81H66+bE+f
         8xxy4lg6wvBqNptH+jkENLKC2SuXvmFeH6Vh7ofdlNKHe4S9IvhXSjILr6Qpt+6cL1Gk
         yVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GBtnr2uifv1rgyZVj+RwOSUrZwnVglgOBD2QtelHA8g=;
        b=D3qa6q2BRs1J/do1f7z+e6YErwOX+US/qW/BSvmpByFYT0qBUxSFzDLMlKhRCsW6KF
         mOHgR5r0S88mpCV7jLyAYAcmRzJVSi16PbbK0MqKlmdcTrX221Y1rwbLmJEEi71NwDle
         FUAIe4yFkd8hT8K7jetwGI8uJBDNt+IPf9UHByE9ils/YQhmFsCP/uP8bKDJoOMm6I27
         tQPl9KnhqT2ud4gkD6mAXmhku2YHv6r0Td0N76+qOuiP+TGPjoZJk4EmR2v9gj00GV9E
         Jb6UI1cmW2cTnH3sABsInXjhJ9WD6MO2SXTUvoHfiCU3a46Dc7J5UjyRz/hqtry+80+g
         wxmw==
X-Gm-Message-State: APjAAAVKaabApmkclfDm90remonFnUTKASF+CVsyTC2svcgsOaxZ52Y0
        vmbeXcdQx6ePvnc+xuLWNDo=
X-Google-Smtp-Source: APXvYqztZmQt62XacoVo9cFIR5QCuEjBdOhmqPIsVjgV7cOTKPUEnfJzjFzWnjExJ0El0wZiUMdJdA==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr44907063pls.311.1554128193744;
        Mon, 01 Apr 2019 07:16:33 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id y10sm17618384pfm.27.2019.04.01.07.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 07:16:33 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mathias.nyman@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2] usb: host: xhci: Support running urb giveback in tasklet context
Date:   Mon,  1 Apr 2019 23:16:11 +0900
Message-Id: <20190401141611.10087-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch "USB: HCD: support giveback of URB in tasklet context"[1]
introduced giveback of urb in tasklet context. [1] This patch was
applied to ehci but not xhci. [2] This patch significantly reduces
the hard irq time of xhci. Especially for uvc driver, the hard irq
including the uvc completion function runs quite long but applying
this patch reduces the hard irq time of xhci.

I have tested four SS devices to check if performance degradation
occurs when urb completion functions run in the tasklet context.

As a result of the test, all devices works well and shows very
similar performance with the upstream kernel. Moreover, usb ethernet
adapter show better performance than the upstream kernel about 5% for
RX and 2% for TX. Four SS devices is as follows.

SS devices for test

1. WD My Passport 2TB (external hard drive)
2. Sandisk Ultra Flair USB 3.0 32GB
3. Logitech Brio webcam
4. Iptime 1gigabit ethernet adapter (Mediatek RTL8153)

Test description

1. Mass storage (hard drive) performance test
- run below command 10 times and compute the average performance

    dd if=/dev/sdN iflag=direct of=/dev/null bs=1G count=1

2. Mass storage (flash memory) performance test
- run below command 10 times and compute the average performance

    dd if=/dev/sdN iflag=direct of=/dev/null bs=1G count=1

3. Webcam streaming performance test
- run simple capture program and get the average frame rate per second
- capture 1500 frames
- program link

    https://github.com/asfaca/Webcam-performance-analyzing-tool

- video resolution : 4096 X 2160 (4K) at 30 or 24 fps
- device (Logitech Brio) spec url for the highest resolution and fps

    https://support.logitech.com/en_gb/product/brio-stream/specs

4. USB Ethernet adapter performance test
- directly connect two linux machines with ethernet cable
- run pktgen of linux kernel and send 1500 bytes packets
- run vnstat to measure the network bandwidth for 180 seconds

Test machine

- CPU : Intel i5-7600 @ 3.5GHz

Test results

1. Mass storage (hard drive) performance test

            WD My Passport 2TB (external hard drive)
--------------------------------------------------------------------
    xhci without tasklet        |          xhci with tasklet
--------------------------------------------------------------------
         103.667MB/s            |            103.692MB/s
--------------------------------------------------------------------

2. Mass storage (flash memory) performance test

               Sandisk Ultra Flair USB 3.0 32GB
--------------------------------------------------------------------
    xhci without tasklet        |          xhci with tasklet
--------------------------------------------------------------------
         129.727MB/s            |            130.2MB/s
--------------------------------------------------------------------

3. Webcam streaming performance test

                     Logitech Brio webcam
--------------------------------------------------------------------
    xhci without tasklet        |          xhci with tasklet
--------------------------------------------------------------------
          26.4451 fps           |            26.3949 fps
--------------------------------------------------------------------

4. USB Ethernet adapter performance test

      Iptime 1gigabit ethernet adapter (Mediatek RTL8153)
--------------------------------------------------------------------
    xhci without tasklet        |          xhci with tasklet
--------------------------------------------------------------------
RX      933.86 Mbit/s           |            983.86 Mbit/s
--------------------------------------------------------------------
TX      830.18 Mbit/s           |            882.75 Mbit/s
--------------------------------------------------------------------

[1], https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=94dfd7edfd5c9b605caf7b562de7a813d216e011
[2], https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=428aac8a81058e2303677a8fbf26670229e51d3a

Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>

---
v2 change:
        - Add SS device test results and rewrite the description
---
 drivers/usb/host/xhci-ring.c | 2 --
 drivers/usb/host/xhci.c      | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c4d041..0ede5265e6e2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -644,10 +644,8 @@ static void xhci_giveback_urb_in_irq(struct xhci_hcd *xhci,
 	}
 	xhci_urb_free_priv(urb_priv);
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
-	spin_unlock(&xhci->lock);
 	trace_xhci_urb_giveback(urb);
 	usb_hcd_giveback_urb(hcd, urb, status);
-	spin_lock(&xhci->lock);
 }
 
 static void xhci_unmap_td_bounce_buffer(struct xhci_hcd *xhci,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7fa58c99f126..bb212b4669cf 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5141,7 +5141,7 @@ static const struct hc_driver xhci_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			xhci_irq,
-	.flags =		HCD_MEMORY | HCD_USB3 | HCD_SHARED,
+	.flags =		HCD_MEMORY | HCD_USB3 | HCD_SHARED | HCD_BH,
 
 	/*
 	 * basic lifecycle operations
-- 
2.20.1

