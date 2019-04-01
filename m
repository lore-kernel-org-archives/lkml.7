Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8592070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140130;
	bh=GDZ4zbeveFaHzomDRMQz+0B2CjiwOGOyQ/1tqgFTCQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvhXPFQPv/+SqfFDu/p2xHQSanJ0StlSb3NxZSJjhD3ZLJpcs+eYWfifUyTPxWEAg
	 V7BjjD+byu6T3U3YLboR2k50CjOmsSJtkkGfci8Xbmm/BPpR9gk1UDbn9LqdF07lfo
	 UJX8hqxa6sweob51w8I+Dw7RJzzJhdlHj8BAsbc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbfDARf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387894AbfDARfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7A6B2070B;
        Mon,  1 Apr 2019 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140125;
        bh=GDZ4zbeveFaHzomDRMQz+0B2CjiwOGOyQ/1tqgFTCQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfHb7I3kYf5Plsv34eJBwf7zgUI1Ng1ClSRDud0NsGYblfv7bF1jhbhxPjX+pYPhi
         vNnxSm+giI79pcVNf2Ru2jYiQBn60zZBPCd2E55zcyasavjrOhqVF+/r/fr8fbGNzC
         O/UIFhYrUor080xX1+CoRRy7UOLvg+dSSBhd92y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4.4 112/131] staging: vt6655: Remove vif check from vnt_interrupt
Date:   Mon,  1 Apr 2019 19:03:02 +0200
Message-Id: <20190401170101.090291328@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit cc26358f89c3e493b54766b1ca56cfc6b14db78a upstream.

A check for vif is made in vnt_interrupt_work.

There is a small chance of leaving interrupt disabled while vif
is NULL and the work hasn't been scheduled.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
CC: stable@vger.kernel.org # v4.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6655/device_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1079,8 +1079,7 @@ static irqreturn_t vnt_interrupt(int irq
 {
 	struct vnt_private *priv = arg;
 
-	if (priv->vif)
-		schedule_work(&priv->interrupt_work);
+	schedule_work(&priv->interrupt_work);
 
 	return IRQ_HANDLED;
 }


