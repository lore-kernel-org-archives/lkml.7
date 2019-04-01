Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC552084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141646;
	bh=i0MOLalflgdPeaFn95YXeEKANDXfCrcf9PL9UEevIgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kHF8TbTx8StJn34Yk2jheZyiZnIyR7BwQCALHYSY0vtP2zP1K1e/5/DjU76BlARgp
	 OR20+xiUvoKskQPLYigUKvWbsd0Qy971ympXzngxvC63p71ahalTuIYTOJpQuur2py
	 gTg54GnXlgIA0yYu5EAdBb5WCUwgv3aVtERv0QCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfDARQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfDARQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC2420856;
        Mon,  1 Apr 2019 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139001;
        bh=i0MOLalflgdPeaFn95YXeEKANDXfCrcf9PL9UEevIgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDBfPBWqNve9wnc/ztpKIP1wWTaeoQY99iFZtEUzyK3GUazpy/zC7Jmn5lbfgP2zG
         +/q/yncpvwMqVMW/psEkJMG1sMdlK2N4juBGrmx99cCD9P30vJICK/aG1cVoCSVEeA
         iXbVoxosbpthWe2OQK4vHc0bEN6rTZs2i7ccKpEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.19 084/134] staging: vt6655: Fix interrupt race condition on device start up.
Date:   Mon,  1 Apr 2019 19:02:00 +0200
Message-Id: <20190401170052.160457934@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1040,8 +1040,6 @@ static void vnt_interrupt_process(struct
 		return;
 	}
 
-	MACvIntDisable(priv->PortOffset);
-
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Read low level stats */
@@ -1129,8 +1127,6 @@ static void vnt_interrupt_process(struct
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-
-	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
 }
 
 static void vnt_interrupt_work(struct work_struct *work)
@@ -1140,6 +1136,8 @@ static void vnt_interrupt_work(struct wo
 
 	if (priv->vif)
 		vnt_interrupt_process(priv);
+
+	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
 }
 
 static irqreturn_t vnt_interrupt(int irq,  void *arg)
@@ -1148,6 +1146,8 @@ static irqreturn_t vnt_interrupt(int irq
 
 	schedule_work(&priv->interrupt_work);
 
+	MACvIntDisable(priv->PortOffset);
+
 	return IRQ_HANDLED;
 }
 


