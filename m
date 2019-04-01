Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D412520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139459;
	bh=GyUE/v4EMr99R0Lr2eEkWN/SmCtLTR29Tp54oE6lVNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MyD2JX5zbiqrjG2EEJD6I8dv8uzS2GNXLzlacRMnO2Rjj/7+NgfzlLfpi6Dqhdiip
	 yX4qhy7Ajr5bbsQsLmrL8cImnhRBZpKqwvXH5atCwFYKADGVbI2Olml7FSWihzDCcT
	 jb6BLzcmM7NKvlv23Hl46pnn4K6PtPSMAqSVZCtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfDARYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbfDARYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:24:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB2C2063F;
        Mon,  1 Apr 2019 17:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139454;
        bh=GyUE/v4EMr99R0Lr2eEkWN/SmCtLTR29Tp54oE6lVNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xd16/v8ur94BDe7bpjtUKwgrKYcvlDUzT0YcDjvsysomsQmmnGxfbQmb72xYvf+yj
         FdGfcbG8/CbbVcsPJHPNQ0nr4415zNOFYhMWAiar9zJlX5y7v3kUJ7ktkn8BYHpq+8
         8MSCFrZxJX2IQ6qsGBFRt1qzmv/xlTtEK2WNYG/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.14 079/107] staging: vt6655: Fix interrupt race condition on device start up.
Date:   Mon,  1 Apr 2019 19:02:34 +0200
Message-Id: <20190401170052.824119728@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -973,8 +973,6 @@ static void vnt_interrupt_process(struct
 		return;
 	}
 
-	MACvIntDisable(priv->PortOffset);
-
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Read low level stats */
@@ -1062,8 +1060,6 @@ static void vnt_interrupt_process(struct
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-
-	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
 }
 
 static void vnt_interrupt_work(struct work_struct *work)
@@ -1073,6 +1069,8 @@ static void vnt_interrupt_work(struct wo
 
 	if (priv->vif)
 		vnt_interrupt_process(priv);
+
+	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
 }
 
 static irqreturn_t vnt_interrupt(int irq,  void *arg)
@@ -1081,6 +1079,8 @@ static irqreturn_t vnt_interrupt(int irq
 
 	schedule_work(&priv->interrupt_work);
 
+	MACvIntDisable(priv->PortOffset);
+
 	return IRQ_HANDLED;
 }
 


