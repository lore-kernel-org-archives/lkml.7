Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F432071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbeEtoMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLIVhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:37:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50605 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:37:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so963279wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMJA3Di2ivxRbsSzXza7HsfMjXgBB0+KSpDg3SPUVLQ=;
        b=fbeEtoMzrLwHuNHnyz+UGn1uIq/g+CCc1Vu86q1v5Y4P/Ybr/MCajyIR5+R5yVpZVb
         m+j3G2l6qbjJ69H3hu8o6ZXNc6SMFxMfQ6YLAxAwNeGvUJez38zK0yRa+gFf6+IeDTHk
         X+CdKDHe+vLzB+uUNXfuWrvkP8BWbNAwzUDbwhjcmog1nh/FkCVmTjtAiLFJuRkUP2TV
         8xR4laFN7pI25TkJ0M8Vk4ATu0qzO0Dy/SyoILHA1J9t0ZRHLN8NYKnwnZJKu8ZM0rl+
         S3cL8FpaGea5mEPvlSfQ5km/1EFdvbraDBWPTL8EwyVee4kkYNCwN+c//TFKMEooXcne
         W4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMJA3Di2ivxRbsSzXza7HsfMjXgBB0+KSpDg3SPUVLQ=;
        b=Sl7ogIcSihgw5S+utvoaoVUsGs8TMG+rkJ9xXztIbonlgnXHfssajrdOPqRk7/aFkw
         iFyOlZYfFljDln1IXPMdsXBSfliRAmm+kfLPYdFkbWVJSeQNLHXJxYCyasT8gwxUCGa1
         6O+5MG2tz0VfTFC1qDYnVHyCPh9/9tUsJjpTiZwKA72DxwERdc7cia8SIQ12ri8ixUID
         54t5OAw10eLKtpnyEu1hehB4SQ0i23V3ULd0eOY22ZaQAM8Wii/yeoa97XSYmmaYQLkI
         q8twvnN4k0suIAOeEyEuHhhb7+w9GywsJxatekRWRP+elVMENSbhVUoCjS4/n0Lcs1IM
         C/AA==
X-Gm-Message-State: APjAAAWvlyPoKFgapM2Kto2C5TO2tgY2bXP3hyxmoa3/XnPcFxEL99x4
        gBqI9LCZa3NqbxDoBIwP2BY=
X-Google-Smtp-Source: APXvYqwXM97IR9th+kenNyJrOC96LNA0sb6otipYNvRNIp2l2DLLT8pGqubHjKwnSLLSr7fNt92ohQ==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr1244266wmj.58.1575927423069;
        Mon, 09 Dec 2019 13:37:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40f6:4600:a51f:44c:fbfb:c44])
        by smtp.gmail.com with ESMTPSA id i16sm731578wmb.36.2019.12.09.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:37:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Subject: [PATCH v2] misc: xilinx_sdfec: fix xsdfec_poll()'s return type
Date:   Mon,  9 Dec 2019 22:36:55 +0100
Message-Id: <20191209213655.57985-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xsdfec_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Derek Kiernan <derek.kiernan@xilinx.com>
CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---

Greg,

Can you take this in your tree?
Thanks.

Change since v1:
- add Dragan's ack.

 drivers/misc/xilinx_sdfec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 11835969e982..48ba7e02bed7 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1025,25 +1025,25 @@ static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
 }
 #endif
 
-static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
+static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 {
-	unsigned int mask = 0;
+	__poll_t mask = 0;
 	struct xsdfec_dev *xsdfec;
 
 	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
 
 	if (!xsdfec)
-		return POLLNVAL | POLLHUP;
+		return EPOLLNVAL | EPOLLHUP;
 
 	poll_wait(file, &xsdfec->waitq, wait);
 
 	/* XSDFEC ISR detected an error */
 	spin_lock_irqsave(&xsdfec->error_data_lock, xsdfec->flags);
 	if (xsdfec->state_updated)
-		mask |= POLLIN | POLLPRI;
+		mask |= EPOLLIN | EPOLLPRI;
 
 	if (xsdfec->stats_updated)
-		mask |= POLLIN | POLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	spin_unlock_irqrestore(&xsdfec->error_data_lock, xsdfec->flags);
 
 	return mask;
-- 
2.24.0

