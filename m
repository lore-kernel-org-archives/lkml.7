Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6609C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814072171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rasZdmYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfDSCpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:45:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSCpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:45:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so2055769pgf.2;
        Thu, 18 Apr 2019 19:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gDQf3PA01qvbrGfvHZT0g5UE97POJa7dkmHX5dqDnqk=;
        b=rasZdmYcER5k2K/9gjXpyihRLyrVs1IGSp93gYPV6R0BOLg65IfjBdYRafeSYLB28C
         8kfe9IxBT9eNi9TbBIKrifrG/7R+dSOfO5GOD3Mf09AOZgc+WfgcWrmaRWsjGrhJotbH
         zrNNwKwLmqUxGQgDO8Hfg2vhF+Gv9niewJOkAdtLoZ0YPTtaf/eGNeJOfOhsdhyXTHsT
         2Ikf2x3fRsDHqIIZ50eLRUrq/PYEnfKLH7mBUGhHs7rET6JmecIZFORaSbQFZgIu3KRi
         JGKSeYro8PDw4CA7Sc7FTlFyEkF9uEkWNIS4V79hfOUYqceSOIp9RLCC+qx3iYlc/gdV
         ItlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gDQf3PA01qvbrGfvHZT0g5UE97POJa7dkmHX5dqDnqk=;
        b=Yj5Do+7qJK0hIUgdLGQzb9TY0ZdmKfaPsjBHwlfb33ODs9I4s7P2WMgI6TzTDam40f
         97aQ1qBHM3s17jMRpBhVsNGm3B1IeB3oBmFLhzjj1eiDiD8+q6A8hsWW6bQftcdvgSbI
         tVooagC1Hiw0eVeo+obNbJLIofIu3/LzlXlCovChfxWHfmv9X0G2nIReXl0/7IfUuJdj
         ZhNv465mnxOmLDYO+z76xFDUPzw92GfKCcl+QU4wrtAwy/c5WD2kZjw+z0ArqEcduurp
         GnRIhaNdxA+sojVU731EtC3i2GSqrE1yLszuaGwfB1Q/ezf2h9/5Cqx3N9Qkcn7uSiu8
         A6nw==
X-Gm-Message-State: APjAAAWsCW2FM1r0qMESPEqsOGPc6maT+nQlfQnJNtFjEQNLfbHdhSPM
        9Wo9qIE+Z1ecc5VAW5crzYA=
X-Google-Smtp-Source: APXvYqyP0OTdkc1BrI+oxtK0m0tKlxbmJ3TFaTRZeNbe3hpcRa1cFnyaU3/Xc2kYZp2cD9f+l4FjDw==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr1426287pgq.175.1555641944195;
        Thu, 18 Apr 2019 19:45:44 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id g67sm4633025pfg.94.2019.04.18.19.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 19:45:43 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V8 2/4] USB: serial: f81232: fix interrupt worker not stop
Date:   Fri, 19 Apr 2019 10:45:31 +0800
Message-Id: <1555641933-19336-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1555641933-19336-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 will use LSR/Interrupt worker to handle LSR error & MSR
change. This patch will fix the interrupt work should stop in close()
and suspend().

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v8:
	1: no change

v7:
	1: first introduce to this series patch.

 drivers/usb/serial/f81232.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 1f0dd4087d79..25ec47d7f318 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -576,6 +576,7 @@ static void f81232_close(struct usb_serial_port *port)
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
 	flush_work(&port_priv->lsr_work);
+	flush_work(&port_priv->interrupt_work);
 	port_priv->is_port_open = false;
 
 	mutex_unlock(&port_priv->lock);
@@ -679,8 +680,10 @@ static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 
 	usb_kill_urb(port->interrupt_in_urb);
 
-	if (port_priv)
+	if (port_priv) {
 		flush_work(&port_priv->lsr_work);
+		flush_work(&port_priv->interrupt_work);
+	}
 
 	return 0;
 }
-- 
2.7.4

