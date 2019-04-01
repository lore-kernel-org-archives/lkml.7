Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89986C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5919121925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138637;
	bh=Eazvj+OMa9NIT2D7gbKfQjRsgo1sz/Rfubq0XNy6OdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLRAiPTgNBetIeYNNjFmISafvOM79Z7g70tz5vZo3sCnmfl17AcMOn6fVxf43KmHt
	 d6Evm+0vsUj38gJFe6Kv6IYWIgOEEbBt+ATKk10UbEfA1urVgYCnjKyqtcX5Rvw71G
	 Xh73Ufnq1WSgIT9xNTC66NYEfI7+c4ibqHKEpaY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfDARKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbfDARKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34571206B8;
        Mon,  1 Apr 2019 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138632;
        bh=Eazvj+OMa9NIT2D7gbKfQjRsgo1sz/Rfubq0XNy6OdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzPlx6VRFeWt9qjxvjPqkRK1g1emo4TDiRi7TG6ZUxbAKeMJLFJXZGnhdiJsbnpjr
         EkiitHh8GYsxyBf0YXfBQ3WxN/Fh+ANPfEEFbIvsj6rxa6vOFw9lXM6LCQImQa4ZvD
         xrv2cUMXb7ADWDStDGGD9YQ+3SKO5i/rLLkHDz1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.0 086/146] staging: vt6655: Fix interrupt race condition on device start up.
Date:   Mon,  1 Apr 2019 19:01:38 +0200
Message-Id: <20190401170056.107007569@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 3b9c2f2e0e99bb67c96abcb659b3465efe3bee1f upstream.

It appears on some slower systems that the driver can find its way
out of the workqueue while the interrupt is disabled by continuous polling
by it.

Move MACvIntEnable to vnt_interrupt_work so that it is always enabled
on all routes out of vnt_interrupt_process.

Move MACvIntDisable so that the device doesn't keep polling the system
while the workqueue is being processed.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
CC: stable@vger.kernel.org # v4.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6655/device_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1033,8 +1033,6 @@ static void vnt_interrupt_process(struct
 		return;
 	}
 
-	MACvIntDisable(priv->PortOffset);
-
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Read low level stats */
@@ -1122,8 +1120,6 @@ static void vnt_interrupt_process(struct
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-
-	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
 }
 
 static void vnt_interrupt_work(struct work_struct *work)
@@ -1133,6 +1129,8 @@ static void vnt_interrupt_work(struct wo
 
 	if (priv->vif)
 		vnt_interrupt_process(priv);
+
+	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
 }
 
 static irqreturn_t vnt_interrupt(int irq,  void *arg)
@@ -1141,6 +1139,8 @@ static irqreturn_t vnt_interrupt(int irq
 
 	schedule_work(&priv->interrupt_work);
 
+	MACvIntDisable(priv->PortOffset);
+
 	return IRQ_HANDLED;
 }
 


